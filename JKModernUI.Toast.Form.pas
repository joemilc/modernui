unit JKModernUI.Toast.Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  ExtCtrls, ModernUI.Message;

type

  TModernToastForm = class(TForm)
    shpBackground: TShape;
    imgIcon: TImage;
    lblTitle: TLabel;
    lblText: TLabel;
    tmrClose: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
  private
    FTitulo: string;
    FTexto: string;
    FTipo: TModernMessageType;
    FDuracaoMs: Integer;
    FPosicao: TModernToastPosition;
    procedure AjustarLayout;
    procedure AjustarTamanho;
    procedure AplicarCantosArredondados;
    procedure AplicarEstilo;
    procedure AplicarIcone;
    function GetBackgroundColor: TColor;
    function GetBorderColor: TColor;
    function GetSymbol: string;
  public
    procedure Configurar(const ATitulo, ATexto: string; ATipo: TModernMessageType;
      ADuracaoMs: Integer; APosicao: TModernToastPosition);
    procedure Mostrar;
  end;

procedure RepositionActiveToasts;

implementation

{$R *.dfm}

const
  TOAST_WIDTH = 360;
  TOAST_MIN_HEIGHT = 96;
  TOAST_MAX_HEIGHT = 180;
  TOAST_MARGIN = 16;
  TOAST_GAP = 12;
  TOAST_RADIUS = 18;
  ICON_SIZE = 40;

  BS_PRIMARY = $00D63384;
  BS_PRIMARY_BG = $00F8D7DA;
  BS_SUCCESS = $00198754;
  BS_SUCCESS_BG = $00D1E7DD;
  BS_WARNING = $00037BFF;
  BS_WARNING_BG = $00C7EFFF;
  BS_DANGER = $004535DC;
  BS_DANGER_BG = $00D7DAF8;
  BS_INFO = $00055D6F;
  BS_INFO_BG = $00CFF4FC;

var
  ActiveToasts: TList;

procedure EnsureToastList;
begin
  if ActiveToasts = nil then
    ActiveToasts := TList.Create;
end;

function IsToastFromPosition(AToast: TModernToastForm; APosicao: TModernToastPosition): Boolean;
begin
  Result := (AToast <> nil) and (AToast.FPosicao = APosicao);
end;

function GetToastLeft(const AWorkArea: TRect; AToast: TModernToastForm): Integer;
begin
  case AToast.FPosicao of
    tpLeftCenter, tpLeftTop, tpLeftBottom:
      Result := AWorkArea.Left + TOAST_MARGIN;
    tpCenter, tpCenterTop, tpCenterBottom:
      Result := AWorkArea.Left + ((AWorkArea.Right - AWorkArea.Left - AToast.Width) div 2);
    tpRight, tpRightTop, tpRightCenter, tpRightBottom:
      Result := AWorkArea.Right - AToast.Width - TOAST_MARGIN;
  else
    Result := AWorkArea.Right - AToast.Width - TOAST_MARGIN;
  end;
end;

procedure PositionToastGroup(APosicao: TModernToastPosition);
var
  I: Integer;
  TopPos: Integer;
  TotalHeight: Integer;
  GroupCount: Integer;
  WorkArea: TRect;
  Toast: TModernToastForm;
begin
  if ActiveToasts = nil then
    Exit;

  WorkArea := Screen.WorkAreaRect;
  TotalHeight := 0;
  GroupCount := 0;

  for I := 0 to ActiveToasts.Count - 1 do
  begin
    Toast := TModernToastForm(ActiveToasts[I]);
    if IsToastFromPosition(Toast, APosicao) and not (csDestroying in Toast.ComponentState) then
    begin
      Inc(GroupCount);
      Inc(TotalHeight, Toast.Height);
    end;
  end;

  if GroupCount = 0 then
    Exit;

  Inc(TotalHeight, TOAST_GAP * (GroupCount - 1));

  case APosicao of
    tpCenterTop, tpLeftTop, tpRight, tpRightTop:
      TopPos := WorkArea.Top + TOAST_MARGIN;
    tpCenterBottom, tpLeftBottom, tpRightBottom:
      TopPos := WorkArea.Bottom - TOAST_MARGIN - TotalHeight;
    tpCenter, tpLeftCenter, tpRightCenter:
      TopPos := WorkArea.Top + (((WorkArea.Bottom - WorkArea.Top) - TotalHeight) div 2);
  else
    TopPos := WorkArea.Top + TOAST_MARGIN;
  end;

  for I := 0 to ActiveToasts.Count - 1 do
  begin
    Toast := TModernToastForm(ActiveToasts[I]);
    if IsToastFromPosition(Toast, APosicao) and not (csDestroying in Toast.ComponentState) then
    begin
      Toast.Left := GetToastLeft(WorkArea, Toast);
      Toast.Top := TopPos;
      Inc(TopPos, Toast.Height + TOAST_GAP);
    end;
  end;
end;

procedure RepositionActiveToasts;
begin
  if ActiveToasts = nil then
    Exit;

  PositionToastGroup(tpLeftTop);
  PositionToastGroup(tpLeftCenter);
  PositionToastGroup(tpLeftBottom);
  PositionToastGroup(tpCenterTop);
  PositionToastGroup(tpCenter);
  PositionToastGroup(tpCenterBottom);
  PositionToastGroup(tpRight);
  PositionToastGroup(tpRightTop);
  PositionToastGroup(tpRightCenter);
  PositionToastGroup(tpRightBottom);
end;

procedure TModernToastForm.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  Position := poDesigned;
  Color := clFuchsia;
  DoubleBuffered := True;
  FormStyle := fsStayOnTop;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, ColorToRGB(clFuchsia), 0, LWA_COLORKEY);

  EnsureToastList;
  ActiveToasts.Add(Self);
end;

procedure TModernToastForm.FormShow(Sender: TObject);
begin
  AplicarCantosArredondados;
  RepositionActiveToasts;
end;

procedure TModernToastForm.FormResize(Sender: TObject);
begin
  AplicarCantosArredondados;
  AjustarLayout;
end;

procedure TModernToastForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrClose.Enabled := False;

  if ActiveToasts <> nil then
    ActiveToasts.Remove(Self);

  Action := caFree;
  RepositionActiveToasts;
end;

procedure TModernToastForm.tmrCloseTimer(Sender: TObject);
begin
  Close;
end;

procedure TModernToastForm.Configurar(const ATitulo, ATexto: string; ATipo: TModernMessageType;
  ADuracaoMs: Integer; APosicao: TModernToastPosition);
begin
  FTitulo := ATitulo;
  FTexto := ATexto;
  FTipo := ATipo;
  FPosicao := APosicao;

  if ADuracaoMs < 1000 then
    FDuracaoMs := 1000
  else
    FDuracaoMs := ADuracaoMs;
end;

procedure TModernToastForm.Mostrar;
begin
  lblTitle.Caption := FTitulo;
  lblText.Caption := FTexto;

  AplicarEstilo;
  AjustarTamanho;
  AjustarLayout;
  AplicarIcone;
  AplicarCantosArredondados;

  tmrClose.Interval := FDuracaoMs;
  tmrClose.Enabled := True;

  Show;
  RepositionActiveToasts;
end;

procedure TModernToastForm.AplicarEstilo;
begin
  shpBackground.Brush.Color := GetBackgroundColor;
  shpBackground.Pen.Color := GetBorderColor;
  shpBackground.Pen.Width := 2;
  shpBackground.Brush.Style := bsSolid;

  lblTitle.Font.Color := GetBorderColor;
  lblTitle.Font.Style := [fsBold];
  lblText.Font.Color := $00343A40;
end;

procedure TModernToastForm.AjustarTamanho;
var
  TextRect: TRect;
  TextHeight: Integer;
  FinalHeight: Integer;
begin
  Canvas.Font.Assign(lblText.Font);
  TextRect := Rect(0, 0, TOAST_WIDTH - 104, 0);
  DrawText(Canvas.Handle, PChar(FTexto), -1, TextRect, DT_CALCRECT or DT_LEFT or DT_TOP or DT_WORDBREAK);
  TextHeight := TextRect.Bottom - TextRect.Top;

  if TextHeight < 18 then
    TextHeight := 18;

  FinalHeight := 28 + 20 + 8 + TextHeight + 20;

  if FinalHeight < TOAST_MIN_HEIGHT then
    FinalHeight := TOAST_MIN_HEIGHT;

  if FinalHeight > TOAST_MAX_HEIGHT then
    FinalHeight := TOAST_MAX_HEIGHT;

  Width := TOAST_WIDTH;
  Height := FinalHeight;
  lblText.Height := TextHeight;
end;

procedure TModernToastForm.AjustarLayout;
var
  TextWidth: Integer;
  ContentLeft: Integer;
begin
  shpBackground.SetBounds(0, 0, ClientWidth, ClientHeight);

  imgIcon.SetBounds(16, 16, ICON_SIZE, ICON_SIZE);

  ContentLeft := imgIcon.Left + imgIcon.Width + 16;
  TextWidth := ClientWidth - ContentLeft - 16;

  lblTitle.Left := ContentLeft;
  lblTitle.Top := 16;
  lblTitle.Width := TextWidth;

  lblText.Left := ContentLeft;
  lblText.Top := lblTitle.Top + lblTitle.Height + 8;
  lblText.Width := TextWidth;
end;

procedure TModernToastForm.AplicarCantosArredondados;
var
  Rgn: HRGN;
begin
  Rgn := CreateRoundRectRgn(0, 0, Width, Height, TOAST_RADIUS, TOAST_RADIUS);
  SetWindowRgn(Handle, Rgn, True);
end;

procedure TModernToastForm.AplicarIcone;
var
  Bmp: TBitmap;
  X: Integer;
  Y: Integer;
  Radius: Integer;
  SymbolRect: TRect;
  SymbolText: string;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.SetSize(ICON_SIZE, ICON_SIZE);
    Bmp.PixelFormat := pf32bit;
    Bmp.Canvas.Brush.Color := GetBackgroundColor;
    Bmp.Canvas.FillRect(Rect(0, 0, ICON_SIZE, ICON_SIZE));

    Radius := (ICON_SIZE div 2) - 2;
    X := ICON_SIZE div 2;
    Y := ICON_SIZE div 2;

    Bmp.Canvas.Brush.Color := GetBorderColor;
    Bmp.Canvas.Pen.Color := GetBorderColor;
    Bmp.Canvas.Ellipse(X - Radius, Y - Radius, X + Radius, Y + Radius);

    Bmp.Canvas.Font.Name := 'Tahoma';
    Bmp.Canvas.Font.Size := 14;
    Bmp.Canvas.Font.Color := clWhite;
    Bmp.Canvas.Font.Style := [fsBold];

    SymbolText := GetSymbol;
    SymbolRect := Rect(0, 0, ICON_SIZE, ICON_SIZE);
    DrawText(Bmp.Canvas.Handle, PChar(SymbolText), -1, SymbolRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

    imgIcon.Picture.Assign(Bmp);
  finally
    Bmp.Free;
  end;
end;

function TModernToastForm.GetBackgroundColor: TColor;
begin
  case FTipo of
    mtPrimary: Result := BS_PRIMARY_BG;
    mtSuccess: Result := BS_SUCCESS_BG;
    mtWarning: Result := BS_WARNING_BG;
    mtDanger: Result := BS_DANGER_BG;
    mtInfo: Result := BS_INFO_BG;
  else
    Result := BS_PRIMARY_BG;
  end;
end;

function TModernToastForm.GetBorderColor: TColor;
begin
  case FTipo of
    mtPrimary: Result := BS_PRIMARY;
    mtSuccess: Result := BS_SUCCESS;
    mtWarning: Result := BS_WARNING;
    mtDanger: Result := BS_DANGER;
    mtInfo: Result := BS_INFO;
  else
    Result := BS_PRIMARY;
  end;
end;

function TModernToastForm.GetSymbol: string;
begin
  case FTipo of
    mtPrimary: Result := 'P';
    mtSuccess: Result := 'S';
    mtWarning: Result := '!';
    mtDanger: Result := 'X';
    mtInfo: Result := 'i';
  else
    Result := 'i';
  end;
end;

initialization
  ActiveToasts := nil;

finalization
  ActiveToasts.Free;

end.
