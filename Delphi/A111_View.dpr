program A111_View;

uses
  Forms,
  SerialLink in 'SerialLink.pas',
  A111Form in 'A111Form.pas' {A111_Form},
  A111THread in 'A111THread.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA111_Form, A111_Form);
  Application.Run;
end.
