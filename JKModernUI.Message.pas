unit JKModernUI.Message;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TModernMessageType = (
    mtPrimary,
    mtSuccess,
    mtWarning,
    mtDanger,
    mtInfo
  );

  TModernButtons = (
    mbOK,
    mbOKCancel,
    mbYesNo
  );

  TModernResult = (
    mrOK,
    mrCancel,
    mrYes,
    mrNo
  );

  TModernToastPosition = (
    tpCenter,
    tpCenterTop,
    tpCenterBottom,
    tpLeftCenter,
    tpLeftTop,
    tpLeftBottom,
    tpRight,
    tpRightTop,
    tpRightCenter,
    tpRightBottom
  );

function JKMUMessage(
  const ATitulo: string;
  const ATexto: string;
  ATipo: TModernMessageType = mtPrimary;
  ABotoes: TModernButtons = mbOK
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
