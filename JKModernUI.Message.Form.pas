unit JKModernUI.Message.Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  JKModernUI.Message, JKModernUI.Icons, JKModernUI.Colors;

const
  CORNER_RADIUS = 25;
  BORDER_SIZE = 3;
  // Bootstrap colors
  BS_DANGER  = $004535dc;  // #dc3545

type

  TModernMessageForm = class(TForm)
    lblTitle: TLabel;
    imgIcon: TImage;
    scrBody: TScrollBox;
    lblText: TLabel;
    shpOK: TShape;
    lblOK: TLabel;
    shpCancel: TShape;
    lblCancel: TLabel;
    shpYes: TShape;
    lblYes: TLabel;
    shpNo: TShape;
    lblNo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure shpOKClick(Sender: TObject);
    procedure shpCancelClick(Sender: TObject);
    procedure shpYesClick(Sender: TObject);
    procedure shpNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure shpOKMouseEnter(Sender: TObject);
    procedure shpOKMouseLeave(Sender: TObject);
    procedure shpCancelMouseEnter(Sender: TObject);
    procedure shpCancelMouseLeave(Sender: TObject);
    procedure shpYesMouseEnter(Sender: TObject);
    procedure shpYesMouseLeave(Sender: TObject);
    procedure shpNoMouseEnter(Sender: TObject);
    procedure shpNoMouseLeave(Sender: TObject);
    procedure shpOKMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpCancelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpYesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpNoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HeaderMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    FTitulo: string;
    FTexto: string;
    FTipo: TModernMessageType;
    FBotoes: TModernButtons;
    FResultado: TModernResult;
    procedure IniciarArrasteJanela;
    procedure AplicarCores;
    procedure AjustarLayout;
    procedure AjustarTamanho;
    procedure AplicarIcone;
    procedure AjustarControles;
    procedure AplicarCantosArredondados;
    function GetBackgroundColor: TColor;
    function GetBorderColor: TColor;
  public
    procedure Configurar(const ATitulo, ATexto: string; ATipo: TModernMessageType; ABotoes: TModernButtons);
    function Mostrar: TModernResult;
  end;

implementation

{$R *.dfm}

procedure TModernMessageForm.FormCreate(Sender: TObject);
var
  CorBorda: TColor;
begin
  BorderStyle := bsNone;
  Color := clWhite;
  Position := poScreenCenter;
  DoubleBuffered := True;
  lblTitle.Cursor := crSizeAll;
  imgIcon.Cursor := crSizeAll;
  
  // Set scrollbox color to white
  scrBody.Color := clWhite;

  CorBorda := GetBorderColor;

  // Set OK button (follows form border color)
  shpOK.Pen.Color := CorBorda;
  shpOK.Brush.Color := clWhite;
  shpOK.Cursor := crHandPoint;
  lblOK.Transparent := False;
  lblOK.Color := shpOK.Brush.Color;
  lblOK.Font.Color := CorBorda;
  lblOK.Font.Style := [fsBold];
  lblOK.Cursor := crHandPoint;

  // Set Cancel button (always Danger)
  shpCancel.Pen.Color := BS_DANGER;
  shpCancel.Brush.Color := clWhite;
  shpCancel.Cursor := crHandPoint;
  lblCancel.Transparent := False;
  lblCancel.Color := shpCancel.Brush.Color;
  lblCancel.Font.Color := BS_DANGER;
  lblCancel.Font.Style := [];
  lblCancel.Cursor := crHandPoint;

  // Set Yes button (follows form border color)
  shpYes.Pen.Color := CorBorda;
  shpYes.Brush.Color := clWhite;
  shpYes.Cursor := crHandPoint;
  lblYes.Transparent := False;
  lblYes.Color := shpYes.Brush.Color;
  lblYes.Font.Color := CorBorda;
  lblYes.Font.Style := [fsBold];
  lblYes.Cursor := crHandPoint;

  // Set No button (always Danger)
  shpNo.Pen.Color := BS_DANGER;
  shpNo.Brush.Color := clWhite;
  shpNo.Cursor := crHandPoint;
  lblNo.Transparent := False;
  lblNo.Color := shpNo.Brush.Color;
  lblNo.Font.Color := BS_DANGER;
  lblNo.Font.Style := [];
  lblNo.Cursor := crHandPoint;
end;

procedure TModernMessageForm.IniciarArrasteJanela;
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TModernMessageForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (Y <= (BORDER_SIZE + 60)) then
    IniciarArrasteJanela;
end;

procedure TModernMessageForm.HeaderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    IniciarArrasteJanela;
end;

procedure TModernMessageForm.FormPaint(Sender: TObject);
var
  CorBorda: TColor;
  CorFundo: TColor;
  R: TRect;
  SavedDC: Integer;
begin
  CorBorda := GetBorderColor;
  CorFundo := GetBackgroundColor;

  // Draw the outer rounded rectangle (border color)
  Canvas.Brush.Color := CorBorda;
  Canvas.Pen.Color := CorBorda;
  Canvas.Pen.Width := 1;
  Canvas.RoundRect(0, 0, Width, Height, CORNER_RADIUS, CORNER_RADIUS);

  // Draw the inner white area
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clWhite;
  Canvas.RoundRect(BORDER_SIZE, BORDER_SIZE, Width - BORDER_SIZE, Height - BORDER_SIZE, CORNER_RADIUS - BORDER_SIZE, CORNER_RADIUS - BORDER_SIZE);

  // Draw the header using the inner rounded shape clipped to the top area,
  // so both the upper and lower dialog corners remain intact.
  R.Left := BORDER_SIZE;
  R.Top := BORDER_SIZE;
  R.Right := Width - BORDER_SIZE;
  R.Bottom := BORDER_SIZE + 60;

  SavedDC := SaveDC(Canvas.Handle);
  try
    IntersectClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
    Canvas.Brush.Color := CorFundo;
    Canvas.Pen.Color := CorFundo;
    Canvas.RoundRect(
      BORDER_SIZE,
      BORDER_SIZE,
      Width - BORDER_SIZE,
      Height - BORDER_SIZE,
      CORNER_RADIUS - BORDER_SIZE,
      CORNER_RADIUS - BORDER_SIZE
    );
  finally
    RestoreDC(Canvas.Handle, SavedDC);
  end;
end;

procedure TModernMessageForm.FormResize(Sender: TObject);
begin
  AplicarCantosArredondados;
  AjustarControles;
  Invalidate;
end;

procedure TModernMessageForm.AplicarCantosArredondados;
var
  Rgn: HRGN;
begin
  Rgn := CreateRoundRectRgn(0, 0, Width, Height, CORNER_RADIUS, CORNER_RADIUS);
  SetWindowRgn(Handle, Rgn, True);
end;

procedure TModernMessageForm.AjustarControles;
var
  ContentRect: TRect;
begin
  ContentRect.Left := BORDER_SIZE;
  ContentRect.Top := BORDER_SIZE;
  ContentRect.Right := Width - BORDER_SIZE;
  ContentRect.Bottom := Height - BORDER_SIZE;

  // Position header controls
  imgIcon.Left := ContentRect.Left + 16;
  imgIcon.Top := ContentRect.Top + 16;

  lblTitle.Left := ContentRect.Left + 56;
  lblTitle.Top := ContentRect.Top + 20;

  // Position scroll box
  scrBody.Left := ContentRect.Left;
  scrBody.Top := ContentRect.Top + 60;
  scrBody.Width := ContentRect.Right - ContentRect.Left;
  scrBody.Height := (ContentRect.Bottom - 50) - (ContentRect.Top + 60);

  // Position OK button
  shpOK.Left := ContentRect.Right - 83;
  shpOK.Top := ContentRect.Bottom - 40;
  lblOK.Left := shpOK.Left + (shpOK.Width - lblOK.Width) div 2;
  lblOK.Top := shpOK.Top + (shpOK.Height - lblOK.Height) div 2;

  // Position Cancel button
  shpCancel.Left := ContentRect.Right - 83 - 82;
  shpCancel.Top := ContentRect.Bottom - 40;
  lblCancel.Left := shpCancel.Left + (shpCancel.Width - lblCancel.Width) div 2;
  lblCancel.Top := shpCancel.Top + (shpCancel.Height - lblCancel.Height) div 2;

  // Position Yes button
  shpYes.Left := ContentRect.Right - 83;
  shpYes.Top := ContentRect.Bottom - 40;
  lblYes.Left := shpYes.Left + (shpYes.Width - lblYes.Width) div 2;
  lblYes.Top := shpYes.Top + (shpYes.Height - lblYes.Height) div 2;

  // Position No button
  shpNo.Left := ContentRect.Right - 83 - 82;
  shpNo.Top := ContentRect.Bottom - 40;
  lblNo.Left := shpNo.Left + (shpNo.Width - lblNo.Width) div 2;
  lblNo.Top := shpNo.Top + (shpNo.Height - lblNo.Height) div 2;
end;

procedure TModernMessageForm.AplicarIcone;
var
  Bmp: TBitmap;
  CorFundo, CorTexto: TColor;
  X, Y: Integer;
  Radius: Integer;
  Simbolo: string;
begin
  if TryLoadModernIcon(imgIcon, FTipo) then
    Exit;

  case FTipo of
    jk_mtPrimary:
      begin
        CorFundo := $00FFFFFF;
        CorTexto := $00000000;
        Simbolo := 'i';
      end;
    jk_mtSuccess:
      begin
        CorFundo := $0000FF00;
        CorTexto := $00000000;
        Simbolo := 'ü';
      end;
    jk_mtWarning:
      begin
        CorFundo := $0000FFFF;
        CorTexto := $00000000;
        Simbolo := '!';
      end;
    jk_mtDanger:
      begin
        CorFundo := $000000FF;
        CorTexto := $00FFFFFF;
        Simbolo := '×';
      end;
    jk_mtInfo:
      begin
        CorFundo := $00FFFF00;
        CorTexto := $00000000;
        Simbolo := 'i';
      end;
  end;

  Bmp := TBitmap.Create;
  try
    Bmp.Width := 32;
    Bmp.Height := 32;
    Bmp.PixelFormat := pf32bit;
    Bmp.Canvas.Brush.Color := GetBorderColor;
    Bmp.Canvas.FillRect(Rect(0, 0, 32, 32));

    Bmp.Canvas.Brush.Color := CorFundo;
    Bmp.Canvas.Pen.Color := CorFundo;
    Radius := 14;
    X := 16;
    Y := 16;
    Bmp.Canvas.Ellipse(X - Radius, Y - Radius, X + Radius, Y + Radius);

    Bmp.Canvas.Font.Name := 'Tahoma';
    Bmp.Canvas.Font.Size := 16;
    Bmp.Canvas.Font.Color := CorTexto;
    Bmp.Canvas.Font.Style := [fsBold];
    Bmp.Canvas.TextOut(X - Bmp.Canvas.TextWidth(Simbolo) div 2, Y - Bmp.Canvas.TextHeight(Simbolo) div 2, Simbolo);

    imgIcon.Picture.Assign(Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TModernMessageForm.FormShow(Sender: TObject);
begin
  AjustarTamanho;
  AjustarLayout;
  AjustarControles;
  AplicarCantosArredondados;
  Invalidate;
end;

procedure TModernMessageForm.Configurar(const ATitulo, ATexto: string; ATipo: TModernMessageType; ABotoes: TModernButtons);
begin
  FTitulo := ATitulo;
  FTexto := ATexto;
  FTipo := ATipo;
  FBotoes := ABotoes;
end;

function TModernMessageForm.Mostrar: TModernResult;
begin
  AplicarCores;
  lblTitle.Caption := FTitulo;
  lblText.Caption := FTexto;
  AjustarTamanho;
  AjustarLayout;
  AplicarIcone;
  AjustarControles;
  AplicarCantosArredondados;
  Invalidate;
  ShowModal;
  Result := FResultado;
end;

procedure TModernMessageForm.AplicarCores;
var
  CorBorda: TColor;
  CorFundo: TColor;
begin
  CorBorda := GetBorderColor;
  CorFundo := GetBackgroundColor;

  lblTitle.Transparent := False;
  lblTitle.Color := CorFundo;
  lblTitle.Font.Color := CorBorda;

  // OK button follows form color
  shpOK.Pen.Color := CorBorda;
  shpOK.Brush.Color := clWhite;
  lblOK.Color := shpOK.Brush.Color;
  lblOK.Font.Color := CorBorda;

  // Cancel button always Danger
  shpCancel.Pen.Color := BS_DANGER;
  shpCancel.Brush.Color := clWhite;
  lblCancel.Color := shpCancel.Brush.Color;
  lblCancel.Font.Color := BS_DANGER;

  // Yes button follows form color
  shpYes.Pen.Color := CorBorda;
  shpYes.Brush.Color := clWhite;
  lblYes.Color := shpYes.Brush.Color;
  lblYes.Font.Color := CorBorda;

  // No button always Danger
  shpNo.Pen.Color := BS_DANGER;
  shpNo.Brush.Color := clWhite;
  lblNo.Color := shpNo.Brush.Color;
  lblNo.Font.Color := BS_DANGER;

  Invalidate; // Force repaint
end;

function TModernMessageForm.GetBackgroundColor: TColor;
begin
  Result := GetModernLightColor(FTipo);
end;

function TModernMessageForm.GetBorderColor: TColor;
begin
  Result := GetModernStrongColor(FTipo);
end;

procedure TModernMessageForm.AjustarLayout;
var
  LarguraTextoDisponivel: Integer;
begin
  shpOK.Visible := FBotoes in [jk_mbOK, jk_mbOKCancel];
  lblOK.Visible := FBotoes in [jk_mbOK, jk_mbOKCancel];

  shpCancel.Visible := FBotoes in [jk_mbOKCancel];
  lblCancel.Visible := FBotoes in [jk_mbOKCancel];

  shpYes.Visible := FBotoes in [jk_mbYesNo];
  lblYes.Visible := FBotoes in [jk_mbYesNo];

  shpNo.Visible := FBotoes in [jk_mbYesNo];
  lblNo.Visible := FBotoes in [jk_mbYesNo];

  LarguraTextoDisponivel := scrBody.ClientWidth - 32;
  lblText.Left := 16;
  lblText.Top := 16;
  lblText.Width := LarguraTextoDisponivel;
end;

procedure TModernMessageForm.AjustarTamanho;
var
  LarguraMinima, LarguraMaxima, LarguraFinal: Integer;
  AlturaMinima, AlturaMaxima, AlturaFinal, AlturaTexto: Integer;
  RectTexto: TRect;
  TelaAltura: Integer;
begin
  LarguraMinima := 400;
  LarguraMaxima := 400;
  LarguraFinal := LarguraMaxima;

  TelaAltura := Screen.Height;
  AlturaMinima := 200;
  AlturaMaxima := Trunc(TelaAltura * 0.8);

  Canvas.Font := lblText.Font;
  RectTexto.Left := 0;
  RectTexto.Top := 0;
  RectTexto.Right := LarguraFinal - 32 - (BORDER_SIZE * 2);
  RectTexto.Bottom := 0;
  DrawText(Canvas.Handle, PChar(FTexto), -1, RectTexto, DT_CALCRECT or DT_WORDBREAK or DT_LEFT or DT_TOP);
  AlturaTexto := RectTexto.Bottom - RectTexto.Top;

  lblText.Height := AlturaTexto;

  AlturaFinal := 60 + (AlturaTexto + 32) + 50 + (BORDER_SIZE * 2);

  if AlturaFinal < AlturaMinima then AlturaFinal := AlturaMinima;
  if AlturaFinal > AlturaMaxima then AlturaFinal := AlturaMaxima;

  Width := LarguraFinal + (BORDER_SIZE * 2);
  Height := AlturaFinal;
end;

procedure TModernMessageForm.shpOKClick(Sender: TObject);
begin
  FResultado := jk_mrOK;
  Close;
end;

procedure TModernMessageForm.shpOKMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  shpOKClick(Sender);
end;

procedure TModernMessageForm.shpCancelClick(Sender: TObject);
begin
  FResultado := jk_mrCancel;
  Close;
end;

procedure TModernMessageForm.shpCancelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  shpCancelClick(Sender);
end;

procedure TModernMessageForm.shpYesClick(Sender: TObject);
begin
  FResultado := jk_mrYes;
  Close;
end;

procedure TModernMessageForm.shpYesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  shpYesClick(Sender);
end;

procedure TModernMessageForm.shpNoClick(Sender: TObject);
begin
  FResultado := jk_mrNo;
  Close;
end;

procedure TModernMessageForm.shpNoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  shpNoClick(Sender);
end;

procedure TModernMessageForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if shpCancel.Visible then
      shpCancelClick(Self)
    else if shpNo.Visible then
      shpNoClick(Self)
    else if shpOK.Visible then
      shpOKClick(Self);
  end
  else if Key = VK_RETURN then
  begin
    if shpOK.Visible then
      shpOKClick(Self)
    else if shpYes.Visible then
      shpYesClick(Self);
  end;
end;

procedure TModernMessageForm.shpOKMouseEnter(Sender: TObject);
begin
  shpOK.Brush.Color := GetBorderColor;
  lblOK.Color := shpOK.Brush.Color;
  lblOK.Font.Color := clWhite;
end;

procedure TModernMessageForm.shpOKMouseLeave(Sender: TObject);
begin
  shpOK.Brush.Color := clWhite;
  lblOK.Color := shpOK.Brush.Color;
  lblOK.Font.Color := GetBorderColor;
end;

procedure TModernMessageForm.shpCancelMouseEnter(Sender: TObject);
begin
  shpCancel.Brush.Color := BS_DANGER;
  lblCancel.Color := shpCancel.Brush.Color;
  lblCancel.Font.Color := clWhite;
end;

procedure TModernMessageForm.shpCancelMouseLeave(Sender: TObject);
begin
  shpCancel.Brush.Color := clWhite;
  lblCancel.Color := shpCancel.Brush.Color;
  lblCancel.Font.Color := BS_DANGER;
end;

procedure TModernMessageForm.shpYesMouseEnter(Sender: TObject);
begin
  shpYes.Brush.Color := GetBorderColor;
  lblYes.Color := shpYes.Brush.Color;
  lblYes.Font.Color := clWhite;
end;

procedure TModernMessageForm.shpYesMouseLeave(Sender: TObject);
begin
  shpYes.Brush.Color := clWhite;
  lblYes.Color := shpYes.Brush.Color;
  lblYes.Font.Color := GetBorderColor;
end;

procedure TModernMessageForm.shpNoMouseEnter(Sender: TObject);
begin
  shpNo.Brush.Color := BS_DANGER;
  lblNo.Color := shpNo.Brush.Color;
  lblNo.Font.Color := clWhite;
end;

procedure TModernMessageForm.shpNoMouseLeave(Sender: TObject);
begin
  shpNo.Brush.Color := clWhite;
  lblNo.Color := shpNo.Brush.Color;
  lblNo.Font.Color := BS_DANGER;
end;

end.
