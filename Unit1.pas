unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JKModernUI.Message, JKModernUI.Toast, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  JKMUMessage('Aviso', 'Esta é uma mensagem primária.', mtPrimary, mbOK);

  // Mensagem de sucesso com botão OK
  JKMUMessage('Sucesso', 'Operação concluída com sucesso!', mtSuccess, mbOK);

  // Mensagem de aviso com botão OK
  JKMUMessage('Aviso', 'Por favor, verifique os dados informados.', mtWarning, mbOK);

  // Mensagem de erro com botão OK
  JKMUMessage('Erro', 'Ocorreu um erro durante a operação.', mtDanger, mbOK);

  // Mensagem informativa com botão OK
  JKMUMessage('Informação', 'Esta é uma mensagem informativa.', mtInfo, mbOK);

  // Mensagem de confirmação com OK e Cancelar
  if JKMUMessage('Confirmação', 'Deseja continuar?', mtPrimary, mbOKCancel) = mrOK then
  begin
    // Código se o usuário clicar em OK
  end;

  // Mensagem de confirmação Sim/Não
  case JKMUMessage('Pergunta', 'Deseja salvar as alteraçoes?', mtPrimary, mbYesNo) of
    mrYes:
      begin
        // Código se o usuário clicar em Sim
      end;
    mrNo:
      begin
        // Código se o usuário clicar em Não
      end;
  end;

  // Exemplo completo com combina��o de tipo e bot�es
  JKMUMessage('Confirmação', 'Deseja excluir este item?', mtWarning, mbYesNo);
  JKMUMessage('Confirmação', 'As alteraçães foram salvas.', mtSuccess, mbOK);
  JKMUMessage('Confirmação', 'O arquivo já existe. Deseja sobrescrever?', mtDanger, mbYesNo);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  JKMUToast('Primario', 'Toast padrao no canto superior direito.', mtPrimary, 3500, tpRightTop);
  JKMUToast('Sucesso', 'Toast centralizado no topo da tela.', mtSuccess, 4000, tpCenter);
  JKMUToast('Aviso', 'Toast no canto inferior esquerdo.', mtWarning, 4500, tpLeftBottom);
  JKMUToast('Erro', 'Toast alinhado ao centro da direita.', mtDanger, 5000, tpRightCenter);
  JKMUToast('Informacao', 'Toast centralizado na parte inferior.', mtInfo, 5500, tpCenterBottom);
end;

end.
