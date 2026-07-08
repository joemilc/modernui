unit JKModernUI.Message;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TModernMessageType = (
    jk_mtPrimary,
    jk_mtSuccess,
    jk_mtWarning,
    jk_mtDanger,
    jk_mtInfo
  );

  TModernButtons = (
    jk_mbOK,
    jk_mbOKCancel,
    jk_mbYesNo
  );

  TModernResult = (
    jk_mrOK,
    jk_mrCancel,
    jk_mrYes,
    jk_mrNo
  );

  TModernToastPosition = (
    jk_tpCenter,
    jk_tpCenterTop,
    jk_tpCenterBottom,
    jk_tpLeftCenter,
    jk_tpLeftTop,
    jk_tpLeftBottom,
    jk_tpRight,
    jk_tpRightTop,
    jk_tpRightCenter,
    jk_tpRightBottom
  );

function JKMUMessage(
  const ATitulo: string;
  const ATexto: string;
  ATipo: TModernMessageType = jk_mtPrimary;
  ABotoes: TModernButtons = jk_mbOK
): TModernResult;

implementation

uses
  JKModernUI.Message.Form;

function JKMUMessage(const ATitulo, ATexto: string; ATipo: TModernMessageType;
  ABotoes: TModernButtons): TModernResult;
var
  Form: TModernMessageForm;
begin
  Form := TModernMessageForm.Create(nil);
  try
    Form.Configurar(ATitulo, ATexto, ATipo, ABotoes);
    Result := Form.Mostrar;
  finally
    Form.Free;
  end;
end;

end.
