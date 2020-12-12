unit A111Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Buttons, ComCtrls, Spin, ExtDlgs, JPEG, A111THread,
  DateUtils, Math, FileCtrl;

const
 cmd_message = WM_USER+100;
 stream_message = WM_USER+101;

type
  TINT64 = packed record
    case Integer of
      0: (int64: Int64);
      1: (c:array[0..1]of Cardinal);
      2: (w:array[0..3]of Word);
      3: (b:array[0..7]of Byte);
 end;

type
  TCardinals = packed record
    case Integer of
      0: (Cardinal: Cardinal);
      1: (w:array[0..1]of Word);
      2: (b:array[0..3]of Byte);
 end;

type
  TDWORD = packed record
    case Integer of
      0: (dw: Cardinal);
      1: (w:array[0..1]of Word);
      2: (b:array[0..3]of Byte);
 end;

type
  TWords = packed record
    case Integer of
      0: (Words: Word);
      1: (lo,hi: Byte);
 end;

type
  TA111_Form = class(TForm)
    SB: TStatusBar;
    Panel1: TPanel;
    startBtn: TBitBtn;
    startSE: TSpinEdit;
    SvDlg: TSaveDialog;
    OpDlg: TOpenDialog;
    BitBtn15: TBitBtn;
    BitBtn17: TBitBtn;
    PB1: TProgressBar;
    ComboBox3: TComboBox;
    lenSE: TSpinEdit;
    TrackBar2: TTrackBar;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    oscImg: TImage;
    Memo1: TMemo;
    sectorEraseBtn: TBitBtn;
    BitBtn13: TBitBtn;
    stopBtn: TBitBtn;
    BitBtn1: TBitBtn;
    regSE: TSpinEdit;
    btn1: TBitBtn;
    edt1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure OSCMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure soft_gainTBChange(Sender: TObject);
    procedure oscImgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure startBtnClick(Sender: TObject);
    procedure stopBtnClick(Sender: TObject);
  private
    { Private declarations }
    CurrentDir,storeDir : string;
    bmp:TBitMap;
    JPEGImg: TJPEGImage;
    fileName: TFileName;
    Gain,Scale,mx,my:Integer;
    procedure median_filter(var inData: TByteArray);
  public
    { Public declarations }
    A111AnswBuff : TByteArray;
    A111SteamBuff : TByteArray;
    A111SendBuff : TByteArray;
    CommunicPortName: string;
    CommunicPortSpeed: integer;
    procedure cmdMessage(var Msg: Tmessage);message cmd_message;
    procedure streamMessage(var Msg: Tmessage);message stream_message;
    procedure incs(var i: integer);
    procedure read_reg(reg:byte);
    function write_reg(reg:byte;data:DWord):boolean;
    procedure read_packet(reg:byte;len:Word);
    procedure cmdRun;
    function stop_service:boolean;
  end;

const
  cmdEnvelope=$01;
  cmdPowerbins=$02;

var
  A111_Form : TA111_Form;
  A111TH: TTHA111;
  procedure Delay(tiks : longint);

implementation
uses IniFiles;

{$R *.DFM}

procedure Delay(tiks : longint);
var  TCount,T1Count: longint;
begin
  TCount:=GetTickCount;
  Repeat
   T1Count:=GetTickCount;
   if TCount > T1Count then
   Begin
    TCount:=GetTickCount;
    T1Count:=GetTickCount;
   End;
  Until ((T1Count-TCount) > tiks);
end;

procedure TA111_Form.incs(var i: integer);
begin
  inc(i);
  if i>32767 then i:=0;
end;

procedure TA111_Form.streamMessage(var Msg: TMessage);
var ptr,i,len: integer;
    ptrData: PByteArray;
    data: TWordArray;
    max,avrg,ll:Integer;
    bmp:TBitmap;
begin
  if A111SteamBuff[0]=$FD then
   begin
    ptr:=A111SteamBuff[1]+A111SteamBuff[2]*256+3;
    if A111SteamBuff[ptr]=$FE then
     begin
      inc(ptr);
      len:=A111SteamBuff[ptr];
      inc(ptr);
      len:=len+A111SteamBuff[ptr] shl 8;
      inc(ptr);
      max:=0;
      avrg:=0;
      len:=len div 2;
      for i:=0 to len-1 do
       begin
        data[i]:=A111SteamBuff[ptr]+A111SteamBuff[ptr+1] shl 8;
        if max<data[i] then
         begin
          max:=data[i];
          ll:=i;
         end;
        avrg:=avrg+data[i];
        ptr:=ptr+2;
       end;
      avrg:=avrg div len;
      max:=max+8;
      bmp:=TBitmap.Create;
      bmp.Width:=len div 4;
      bmp.Height:=256;
      bmp.Canvas.Pen.Color:=clRed;
      bmp.Canvas.Pen.Width:=4;
      bmp.Canvas.MoveTo(0,256-256*data[0]div max);
      for i:=1 to len div 4-1 do bmp.Canvas.LineTo(i,256-256*data[i*4]div max);
      bmp.Canvas.TextOut(20,20,IntToStr(max-8));
      bmp.Canvas.TextOut(20,40,IntToStr(avrg));
      if max>avrg*3 then bmp.Canvas.TextOut(20,60,floatToStrf(ll*484/1000+200,ffFixed,7,2)+'mm');
      oscImg.Picture.Bitmap.Assign(bmp);
      oscImg.Repaint;
      bmp.Free;
     end;
   end;
end;

procedure TA111_Form.cmdRun;
begin
   case A111TH.regchange of
    $06 : Memo1.Lines.Add('Состояние=0x'+inttohex(A111TH.A111.reg[A111TH.regchange].dw,8));
    $07 : Memo1.Lines.Add('baudrate='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $10 : begin
     if A111TH.A111.reg[A111TH.regchange].b[2]=$AC then
      begin
       case A111TH.A111.reg[A111TH.regchange].b[1] of
        $C0: A111_Form.Memo1.Lines.Add('Модуль XM112');
        $C1: A111_Form.Memo1.Lines.Add('Модуль XM122');
        else  A111_Form.SB.Panels[0].Text:='Модуль не распознан';
       end;
      end else A111_Form.SB.Panels[0].Text:='Модуль не распознан';
    end;
    $11 : Memo1.Lines.Add('Версия:'+inttostr(A111TH.A111.reg[A111TH.regchange].b[2])+'.'+inttostr(A111TH.A111.reg[A111TH.regchange].b[1])+'.'+inttostr(A111TH.A111.reg[A111TH.regchange].b[0]));
    $12 : Memo1.Lines.Add('baudrateMAX='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $20 : Memo1.Lines.Add('Старт(мм)='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $21 : Memo1.Lines.Add('Дальность(мм)='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $22 : Memo1.Lines.Add('Mode='+inttohex(A111TH.A111.reg[A111TH.regchange].dw,8));
    $23 : Memo1.Lines.Add('Update='+floattostrf(A111TH.A111.reg[A111TH.regchange].dw/1000,fffixed,5,3));
    $24 : Memo1.Lines.Add('Gain='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $25 : Memo1.Lines.Add('PowerMode='+inttohex(A111TH.A111.reg[A111TH.regchange].dw,8));
    $81 : Memo1.Lines.Add('Старт(мм)='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $82 : Memo1.Lines.Add('Дальность(мм)='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $83 : Memo1.Lines.Add('Length='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $84 : Memo1.Lines.Add('Stitch='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    $85 : Memo1.Lines.Add('Тик(мкм)='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
    else  Memo1.Lines.Add('Reg::0x'+inttohex(A111TH.regchange,2)+'='+inttostr(A111TH.A111.reg[A111TH.regchange].dw));
   end;
end;

procedure TA111_Form.cmdMessage(var Msg: TMessage);
begin
//  cmdRun;
end;

procedure TA111_Form.median_filter(var inData: TByteArray);
var median:array[0..5]of integer;
    x,mv: integer;
begin
     for x:=1 to 166 do
      begin
       if inData[x]>inData[x-1] then
        begin
         median[0]:=inData[x-1];
         median[1]:=inData[x];
        end else
        begin
         median[0]:=inData[x];
         median[1]:=inData[x-1];
        end;
       if median[0]>inData[x+1] then mv:=median[0]
        else begin
         if median[1]<inData[x+1] then mv:=median[1]
                                  else mv:=inData[x+1];
        end;
//       mData[x]:=mv;
      end;
{
     for x:=2 to 165 do
      begin
       if inData[x-2]<inData[x-1] then
        begin
         median[0]:=inData[x-2];
         median[1]:=inData[x-1];
         if outData[x]<inData[x+11] then
          begin
           median[2]:=inData[x];
           median[3]:=inData[x+1];
          end else
          begin
           median[3]:=inData[x];
           median[2]:=inData[x+1];
          end;
        end else
        begin
         median[0]:=outData[x-1];
         median[1]:=outData[x-2];
         if outData[y,x]<outData[x+11] then
          begin
           median[2]:=inData[x];
           median[3]:=inData[x+1];
          end else
          begin
           median[3]:=inData[x];
           median[2]:=inData[x+1];
          end;
        end;
       if median[2]>median[1] then
        begin
         mv:=median[2];
         median[2]:=median[1];
         median[1]:=mv;
         if median[1]<median[0] then
          begin
           mv:=median[1];
           median[1]:=median[0];
           median[0]:=mv;
          end;
         if median[3]<median[2] then
          begin
           mv:=median[3];
           median[3]:=median[2];
           median[2]:=mv;
          end;
        end;
       if inData[x-2]>median[1] then
        begin
         if outData[y,x-2]>median[2] then mv:=median[2]
                                     else mv:=inData[x-2];
        end else mv:=median[1];
       mData[x]:=mv;
      end;
}
end;

procedure TA111_Form.FormCreate(Sender: TObject);
var i,j: integer;
begin
  GetDir(0,CurrentDir);
  ChDir(CurrentDir);
  CommunicPortName:= 'COM4';
  CommunicPortSpeed:= 115200;
end;

procedure TA111_Form.FormDestroy(Sender: TObject);
begin
  stop_service;
  A111TH.Terminate;
  if A111TH<>nil then A111TH.Destroy;
end;

procedure TA111_Form.OSCMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 WITH Sender AS TImage DO
  begin
   mx := X;
   my := 255 - Y;
   SB.Panels[0].Text:='X,Y::'+inttostr(mx)+','+inttostr(my);
  end;
end;

procedure TA111_Form.soft_gainTBChange(Sender: TObject);
begin
  with Sender as TTrackBar do
   begin
    case tag of
     0: begin
         Gain:=Position;
         SB.Panels[2].Text:='Gain = '+floattostrf(Gain/100,fffixed,8,4);
        end;
     1: begin
         Scale:=Position;
         SB.Panels[2].Text:='Scale = '+floattostrf(Scale/100,fffixed,7,4);
        end;
     end;
   end;
end;

procedure TA111_Form.oscImgMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var mx :integer;
begin
  mx:=X;
//  my:=Y;
//  SB.Panels[0].Text:='x='+inttostr(mx)+' :: N'+inttostr(gist[mx]);
end;

procedure TA111_Form.FormKeyPress(Sender: TObject; var Key: Char);
var offset:integer;
    i:integer;
begin
  if key=#13 then
   begin

   end;
end;

procedure TA111_Form.BitBtn15Click(Sender: TObject);
var fl : file of DWORD;
    n: DWORD;
begin
  with SvDlg do
   begin
    Title:='Сохранить коэффициенты в BIN файл';
    DefaultExt:='bin';
    FileName:='cbt5.bin';
    Filter:='Coeff BIN files (*.bin)|*.bin';
    if Execute then
     begin
      AssignFile(fl,FileName);
      Rewrite(fl);
//      n:=clbr_frame;
//      write(fl,n);
//      BlockWrite(fl,clbrData,128*168);
      CloseFile(fl);
     end;
   end;
end;

procedure TA111_Form.BitBtn17Click(Sender: TObject);
var y,x,frameNum :DWORD;
    fi : File of DWORD;
begin
  with OpDlg do
   begin
    Filter:='Data files (*.bin)|*.bin; Data files (*.dat)|*.dat; All files (*.*)|*.*';
    if Execute then
     begin
      try
       AssignFile(fi,FileName);
       Reset(fi);
       Read(fi,frameNum);
//       BlockRead(fi,clbrData,128*168);
//       for y:=0 to 127 do for x:=0 to 167 do cb[y,x]:=clbrData[y,x] div frameNum;
      finally
       CloseFile(fi);
      end;
     end;
   end;
end;

procedure TA111_Form.read_reg(reg:byte);
begin
   A111SendBuff[0]:=$CC;
   A111SendBuff[1]:=$01;
   A111SendBuff[2]:=$00;
   A111SendBuff[3]:=$F8;
   A111SendBuff[4]:=reg;
   A111SendBuff[5]:=$CD;
   A111TH.answReady:=False;
   A111TH.byteToSend:=6;
   while not A111TH.answReady do ;
   cmdRun;
end;

procedure TA111_Form.read_packet(reg:byte;len:Word);
begin
   A111SendBuff[0]:=$CC;
   A111SendBuff[1]:=$03;
   A111SendBuff[2]:=$00;
   A111SendBuff[3]:=$FA;
   A111SendBuff[4]:=reg;
   A111SendBuff[5]:=lo(len);
   A111SendBuff[6]:=hi(len);
   A111SendBuff[7]:=$CD;
   A111TH.answReady:=False;
   A111TH.byteToSend:=8;
   while not A111TH.answReady do ;
end;

function TA111_Form.write_reg(reg:byte;data:DWord):boolean;
var pdata:^TDWORD;
    stm,ctm:Cardinal;
begin
   pdata:=@data;
   A111SendBuff[0]:=$CC;
   A111SendBuff[1]:=$05;
   A111SendBuff[2]:=$00;
   A111SendBuff[3]:=$F9;
   A111SendBuff[4]:=reg;
   A111SendBuff[5]:=pdata^.b[0];
   A111SendBuff[6]:=pdata^.b[1];
   A111SendBuff[7]:=pdata^.b[2];
   A111SendBuff[8]:=pdata^.b[3];
   A111SendBuff[9]:=$CD;
   A111TH.answReady:=False;
   A111TH.byteToSend:=10;
   stm:=GetTickCount;
   while not A111TH.answReady do ;
    begin
     ctm:=GetTickCount;
     if ctm-stm > 500 then
      Begin
       write_reg:=False;
       Exit;
      End;
    end;
   cmdRun;
   write_reg:=True;
end;

function TA111_Form.stop_service:boolean;
begin
  if A111TH=nil then Exit;
  if not write_reg($03,$00) then
   begin
    if CommunicPortSpeed=$2dc6c0 then CommunicPortSpeed:=$2dc6c0
                                 else CommunicPortSpeed:=115200;
    A111TH.reconnect:=true;
    while A111TH.reconnect do ;
   end;
  read_reg($12);
  write_reg($07,Cardinal(A111TH.A111.reg[$12])); // $2dc6c0 = 3Mbit
  CommunicPortSpeed:=Cardinal(A111TH.A111.reg[$12]);
  A111TH.reconnect:=true;
  while A111TH.reconnect do ;
  stop_service:=write_reg($03,$00);
end;

procedure TA111_Form.startBtnClick(Sender: TObject);
begin
  with Sender as TBitBtn do
   begin
     if A111TH=nil then
       begin
         A111TH:=TTHA111.Create(false);
         A111TH.Priority:=tpTimeCritical;
         Delay(500);
       end;
     case Tag of
      0: begin
          while not stop_service do;
          write_reg($03,$00);
          read_packet($E8,$00);
          write_reg($03,$00);

          write_reg($02,$02);
          write_reg($23,$00);
          write_reg($28,$02);
          write_reg($22,$02);
          write_reg($23,$7530); //30000
          write_reg($20,startSE.Value); //$c8
          write_reg($21,lenSE.Value);   //$640
          write_reg($24,$1f4);  //500
          write_reg($29,$01);
          write_reg($30,$0f);
          write_reg($40,$2bc);  //$2bc 700
          write_reg($31,$01);
          write_reg($32,$00);
          write_reg($25,$03);
          write_reg($05,$01);
          write_reg($03,$01);
          repeat
           read_reg($06);
          until (A111TH.A111.reg[$06].b[0]=1);
          read_reg($81);
          read_reg($82);
          read_reg($83);
          read_reg($84);
          read_reg($85);
          write_reg($03,$02);
         end;
      1: read_reg(regSE.Value);
      2: write_reg(regSE.Value,strtoint(edt1.Text));
      end;
   end;
end;

procedure TA111_Form.stopBtnClick(Sender: TObject);
begin
 if not stop_service then ShowMessage('Нет связи с модулем');
// if A111TH<>nil then A111TH.Destroy;
end;

end.

