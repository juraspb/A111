unit A111THread;

interface

uses
  SysUtils, Classes, Windows, Dialogs, WinSock, SerialLink;

type
  TDWORD = packed record
    case Integer of
      0: (dw: Cardinal);
      1: (w:array[0..1]of Word);
      2: (b:array[0..3]of Byte);
 end;

type
  TA111 =record
   cmd:Byte;
   reg:array[0..127]of TDWORD;
 end;
{
0x02 mode_selection,    (r/w)
0x03 main_control,      (w)
0x05 streaming_control, (r/w)
0x06 status             (r)
0x07 baudrate,          (r/w)
0x0a module_power_mode, (r/w)

0x10 product_id,        (r)
0x11 version,           (r)
0x12 max_uart_baudrate, (r)
0xE9 output_buffer_length,  (r)

0x20 range_start,       (r/w)
0x21 range_length,      (r/w)
0x22 repetition_mode    (r/w)
0x23 update_rate,       (r/w)
0x24 gain
0x25 sensor_power_mode, (r/w)
0x26 tx_disable,        (r/w)
}

type
  TTHA111 = class(TThread)
  private
    { Private declarations }
    FActiv: boolean;
    bufferWrite,bufferRead: Cardinal;
  public
    cmdMessage,streamMessage : integer;
    streamError,reconnect : boolean;
    byteToSend: Cardinal;
    regchange:Byte;
    buffSize:DWORD;
    answReady: boolean;
    FLink: TSerialLink;
    A111:TA111;
    A111ZBuff:array[0..15] of byte;
    A111InBuff:TByteArray;
    property Activ: boolean read FActiv;
    procedure execCmd(cmd: integer;pd:TByteArray);
  protected
    procedure Execute; override;

  end;

implementation

uses A111Form;

procedure TTHA111.execCmd(cmd: integer;pd:TByteArray);
var dw:TDWord;
begin
     case cmd of
      $F5: begin
        regchange:=pd[0];
        A111.reg[regchange].b[0]:=pd[1];
        A111.reg[regchange].b[1]:=pd[2];
        A111.reg[regchange].b[2]:=pd[3];
        A111.reg[regchange].b[3]:=pd[4];
      end;
      $F7: begin
        regchange:=pd[0];
        Move(A111InBuff,A111_Form.A111AnswBuff,buffSize)
      end;
      $F6: begin
       regchange:=pd[0];
       A111.reg[regchange].b[0]:=pd[1];
       A111.reg[regchange].b[1]:=pd[2];
       A111.reg[regchange].b[2]:=pd[3];
       A111.reg[regchange].b[3]:=pd[4];
      end;
     end;
end;


procedure TTHA111.Execute;
var n,cmd:Integer;
    len:TWords;
    pd:PByteArray;
begin
  cmdMessage:=cmd_message;
  streamMessage:=stream_message;
  reconnect:=False;
  answReady:=False;
  try
    FLink:=TSerialLink.Create(nil);
    FLink.Port:= A111_Form.CommunicPortName;
    FLink.Speed:= A111_Form.CommunicPortSpeed;
    FLink.Open;
  finally
    if not FLink.Active then ShowMessage('Нет связи с радаром');
  end;
  FActiv:=true;
  while not terminated do
    begin
     if reconnect then
      begin
        try
          FLink.Speed:=A111_Form.CommunicPortSpeed;
//          FLink.Close;
//          FLink.Open;
        finally
          if not FLink.Active then ShowMessage('Нет связи с радаром');
        end;
       Delay(100);
       reconnect:=False;
      end;
     if byteToSend<>0 then
      begin
       FLink.SendBuffer(A111_Form.A111SendBuff,byteToSend);
       byteToSend:=0;
      end;
     if FLink.GetBytesReceived then
      begin
       n:=FLink.BytesReceived;
       if n>0 then
         begin
           FLink.ReceiveBuffer(A111ZBuff,4);
           if A111ZBuff[0]=$CC then
            begin
             len.lo:=A111ZBuff[1];
             len.hi:=A111ZBuff[2];
             cmd:=A111ZBuff[3];
            end;
           if cmd=$FE then
            begin
             FLink.ReceiveBuffer(A111InBuff,len.Words+1);
             Move(A111InBuff,A111_Form.A111SteamBuff,len.Words);
             postmessage(A111_Form.Handle,streamMessage,0,0);
            end else
            begin
             FLink.ReceiveBuffer(A111InBuff,len.Words+1);
             buffSize:=len.Words;
             execCmd(cmd,A111InBuff);
             answReady:=true;
            end;
         end;
      end;
    end;
  FLink.Destroy;
  FActiv:=false;
end;

end.
