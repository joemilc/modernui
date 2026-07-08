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
  JKMUMessage('Aviso', 'Esta é uma mensagem primária.', jk_mtPrimary, jk_mbOK);

  // Mensagem de sucesso com botão OK
  JKMUMessage('Sucesso', 'Operação concluída com sucesso!', jk_mtSuccess, jk_mbOK);

  // Mensagem de aviso com botão OK
  JKMUMessage('Aviso', 'Por favor, verifique os dados informados.', jk_mtWarning, jk_mbOK);

  // Mensagem de erro com botão OK
  JKMUMessage('Erro', 'Ocorreu um erro durante a operação.', jk_mtDanger, jk_mbOK);

  // Mensagem informativa com botão OK
  JKMUMessage('Informação', 'Esta é uma mensagem informativa.', jk_mtInfo, jk_mbOK);

  // Mensagem de confirmação com OK e Cancelar
  if JKMUMessage('Confirmação', 'Deseja continuar?', jk_mtPrimary, jk_mbOKCancel) = jk_mrOK then
  begin
    // Código se o usuário clicar em OK
  end;

  // Mensagem de confirmação Sim/Não
  case JKMUMessage('Pergunta', 'Deseja salvar as alteraçoes?', jk_mtPrimary, jk_mbYesNo) of
    jk_mrYes:
      begin
        // Código se o usuário clicar em Sim
      end;
    jk_mrNo:
      begin
        // Código se o usuário clicar em Não
      end;
  end;

  // Exemplo completo com combina��o de tipo e bot�es
  JKMUMessage('Confirmação', 'Deseja excluir este item?', jk_mtWarning, jk_mbYesNo);
  JKMUMessage('Confirmação', 'As alteraçães foram salvas.', jk_mtSuccess, jk_mbOK);
  JKMUMessage('Confirmação', 'O arquivo já existe. Deseja sobrescrever?', jk_mtDanger, jk_mbYesNo);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  JKMUToast('Primario', 'Toast padrao no canto superior direito.', jk_mtPrimary, 3500, jk_tpRightTop);
  JKMUToast('Sucesso', 'Toast centralizado no topo da tela.', jk_mtSuccess, 4000, jk_tpCenter);
  JKMUToast('Aviso', 'Toast no canto inferior esquerdo.', jk_mtWarning, 4500, jk_tpLeftBottom);
  JKMUToast('Erro', 'Toast alinhado ao centro da direita.', jk_mtDanger, 5000, jk_tpRightCenter);
  JKMUToast('Informacao', 'Toast centralizado na parte inferior.', jk_mtInfo, 5500, jk_tpCenterBottom);
end;

end.
