unit JKModernUI.Toast.Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  ExtCtrls, JKModernUI.Message, JKModernUI.Icons, JKModernUI.Colors;

type

  TModernToastForm = class(TForm)
    shpBackground: TShape;
    imgIcon: TImage;
    lblTitle: TLabel;
    lblText: TLabel;
    tmrClose: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HeaderMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure tmrCloseTimer(Sender: TObject);
  private
    FTitulo: string;
    FTexto: string;
    FTipo: TModernMessageType;
    FDuracaoMs: Integer;
    FPosicao: TModernToastPosition;
    procedure IniciarArrasteJanela;
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
  TOAST_BORDER_WIDTH = 2;
  TOAST_BORDER_INSET = TOAST_BORDER_WIDTH div 2;
  TOAST_RADIUS = 18;
  ICON_SIZE = 40;

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
    jk_tpLeftCenter, jk_tpLeftTop, jk_tpLeftBottom:
      Result := AWorkArea.Left + TOAST_MARGIN;
    jk_tpCenter, jk_tpCenterTop, jk_tpCenterBottom:
      Result := AWorkArea.Left + ((AWorkArea.Right - AWorkArea.Left - AToast.Width) div 2);
    jk_tpRight, jk_tpRightTop, jk_tpRightCenter, jk_tpRightBottom:
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
    jk_tpCenterTop, jk_tpLeftTop, jk_tpRight, jk_tpRightTop:
      TopPos := WorkArea.Top + TOAST_MARGIN;
    jk_tpCenterBottom, jk_tpLeftBottom, jk_tpRightBottom:
      TopPos := WorkArea.Bottom - TOAST_MARGIN - TotalHeight;
    jk_tpCenter, jk_tpLeftCenter, jk_tpRightCenter:
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

  PositionToastGroup(jk_tpLeftTop);
  PositionToastGroup(jk_tpLeftCenter);
  PositionToastGroup(jk_tpLeftBottom);
  PositionToastGroup(jk_tpCenterTop);
  PositionToastGroup(jk_tpCenter);
  PositionToastGroup(jk_tpCenterBottom);
  PositionToastGroup(jk_tpRight);
  PositionToastGroup(jk_tpRightTop);
  PositionToastGroup(jk_tpRightCenter);
  PositionToastGroup(jk_tpRightBottom);
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
  shpBackground.Cursor := crSizeAll;
  imgIcon.Cursor := crSizeAll;
  lblTitle.Cursor := crSizeAll;
  lblText.Cursor := crSizeAll;

  EnsureToastList;
  ActiveToasts.Add(Self);
end;

procedure TModernToastForm.IniciarArrasteJanela;
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TModernToastForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    IniciarArrasteJanela;
end;

procedure TModernToastForm.HeaderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    IniciarArrasteJanela;
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
  shpBackground.Pen.Width := TOAST_BORDER_WIDTH;
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
  shpBackground.SetBounds(
    TOAST_BORDER_INSET,
    TOAST_BORDER_INSET,
    ClientWidth - (TOAST_BORDER_INSET * 2),
    ClientHeight - (TOAST_BORDER_INSET * 2)
  );

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
  if TryLoadModernIcon(imgIcon, FTipo) then
    Exit;

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
  Result := GetModernLightColor(FTipo);
end;

function TModernToastForm.GetBorderColor: TColor;
begin
  Result := GetModernStrongColor(FTipo);
end;

function TModernToastForm.GetSymbol: string;
begin
  case FTipo of
    jk_mtPrimary: Result := 'P';
    jk_mtSuccess: Result := 'S';
    jk_mtWarning: Result := '!';
    jk_mtDanger: Result := 'X';
    jk_mtInfo: Result := 'i';
  else
    Result := 'i';
  end;
end;

initialization
  ActiveToasts := nil;

finalization
  ActiveToasts.Free;

end.
