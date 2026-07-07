unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ModernUI.Message, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  // Mensagem primária com botão OK
  MUMessage('Aviso', 'Esta é uma mensagem primária.', mtPrimary, mbOK);

  // Mensagem de sucesso com botão OK
  MUMessage('Sucesso', 'Operação concluída com sucesso!', mtSuccess, mbOK);

  // Mensagem de aviso com botão OK
  MUMessage('Aviso', 'Por favor, verifique os dados informados.', mtWarning, mbOK);

  // Mensagem de erro com botão OK
  MUMessage('Erro', 'Ocorreu um erro durante a operação.', mtDanger, mbOK);

  // Mensagem informativa com botão OK
  MUMessage('Informação', 'Esta é uma mensagem informativa.', mtInfo, mbOK);

  // Mensagem de confirmação com OK e Cancelar
  if MUMessage('Confirmação', 'Deseja continuar?', mtPrimary, mbOKCancel) = mrOK then
  begin
    // Código se o usuário clicar em OK
  end;

  // Mensagem de confirmação Sim/Não
  case MUMessage('Pergunta', 'Deseja salvar as alterações?', mtPrimary, mbYesNo) of
    mrYes:
      begin
        // Código se o usuário clicar em Sim
      end;
    mrNo:
      begin
        // Código se o usuário clicar em Não
      end;
  end;

  // Exemplo completo com combinação de tipo e botões
  MUMessage('Confirmação', 'Deseja excluir este item?', mtWarning, mbYesNo);
  MUMessage('Confirmação', 'As alterações foram salvas.', mtSuccess, mbOK);
  MUMessage('Confirmação', 'O arquivo já existe. Deseja sobrescrever?', mtDanger, mbYesNo);
end;

end.
