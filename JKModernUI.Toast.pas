unit JKModernUI.Toast;

interface

uses
  JKModernUI.Message;

procedure JKMUToast(
  const ATitulo: string;
  const ATexto: string;
  ATipo: TModernMessageType = mtPrimary;
  ADuracaoMs: Integer = 4000;
  APosicao: TModernToastPosition = tpRightTop
);

implementation

uses
  Forms,
  JKModernUI.Toast.Form;

procedure JKMUToast(const ATitulo, ATexto: string; ATipo: TModernMessageType; ADuracaoMs: Integer; APosicao: TModernToastPosition);
var
  Toast: TModernToastForm;
begin
  Toast := TModernToastForm.Create(Application);
  Toast.Configurar(ATitulo, ATexto, ATipo, ADuracaoMs, APosicao);
  Toast.Mostrar;
end;

end.
