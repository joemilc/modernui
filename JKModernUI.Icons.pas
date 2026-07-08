unit JKModernUI.Icons;

interface

uses
  SysUtils, ExtCtrls, Vcl.Imaging.pngimage,
  JKModernUI.Message;

function GetModernIconPath(ATipo: TModernMessageType): string;
function TryLoadModernIcon(AImage: TImage; ATipo: TModernMessageType): Boolean;

implementation

function GetModernIconPath(ATipo: TModernMessageType): string;
var
  IconFileName: string;
begin
  case ATipo of
    jk_mtPrimary: IconFileName := 'primary.png';
    jk_mtSuccess: IconFileName := 'success.png';
    jk_mtWarning: IconFileName := 'warning.png';
    jk_mtDanger: IconFileName := 'danger.png';
    jk_mtInfo: IconFileName := 'info.png';
  else
    IconFileName := 'info.png';
  end;

  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'assets\icons\' + IconFileName;
end;

function TryLoadModernIcon(AImage: TImage; ATipo: TModernMessageType): Boolean;
var
  IconPath: string;
  Png: TPngImage;
begin
  Result := False;
  IconPath := GetModernIconPath(ATipo);

  if (AImage = nil) or not FileExists(IconPath) then
    Exit;

  Png := TPngImage.Create;
  try
    Png.LoadFromFile(IconPath);
    AImage.Picture.Assign(Png);
    AImage.Center := True;
    AImage.Proportional := True;
    AImage.Stretch := True;
    Result := not AImage.Picture.Graphic.Empty;
  finally
    Png.Free;
  end;
end;

end.
