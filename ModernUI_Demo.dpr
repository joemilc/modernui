program ModernUI_Demo;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  JKModernUI.Message in 'JKModernUI.Message.pas',
  JKModernUI.Toast in 'JKModernUI.Toast.pas',
  JKModernUI.Message.Form in 'JKModernUI.Message.Form.pas' {ModernMessageForm},
  JKModernUI.Toast.Form in 'JKModernUI.Toast.Form.pas' {ModernToastForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
