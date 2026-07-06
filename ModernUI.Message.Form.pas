unit ModernUI.Message.Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  ModernUI.Message;

const
  WS_EX_LAYERED = $80000;
  LWA_COLORKEY = 1;
  LWA_ALPHA = 2;

type
  TModernMessageForm = class(TForm)
    pnlHeader: TPanel;
    lblTitle: TLabel;
    pnlBody: TPanel;
    scrBody: TScrollBox;
    lblText: TLabel;
    pnlButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    btnYes: TButton;
    btnNo: TButton;
    imgIcon: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
  private
    FTitulo: string;
    FTexto: string;
    FTipo: TModernMessageType;
    FBotoes: TModernButtons;
    FResultado: TModernResult;
    procedure AplicarCores;
    procedure AjustarLayout;
    procedure AjustarTamanho;
    procedure AplicarCantosArredondados;
    procedure AplicarIcone;
  public
    procedure Configurar(const ATitulo, ATexto: string; ATipo: TModernMessageType; ABotoes: TModernButtons);
    function Mostrar: TModernResult;
  end;

implementation

{$R *.dfm}

procedure TModernMessageForm.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  Color := clFuchsia; // Usamos uma cor magenta como chave de transparência
  Position := poScreenCenter;
  DoubleBuffered := True;
  
  // Configuramos a janela como layered e definimos a cor de transparência
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, Color, 255, LWA_COLORKEY);
end;

procedure TModernMessageForm.FormPaint(Sender: TObject);
var
  CorBorda: TColor;
begin
  // Primeiro, definimos a cor da borda
  case FTipo of
    mtPrimary: CorBorda := $007B2423;
    mtSuccess: CorBorda := $003C7634;
    mtWarning: CorBorda := $00138ED9;
    mtDanger: CorBorda := $002328D9;
    mtInfo: CorBorda := $00856404;
  end;
  
  // Primeiro limpamos todo o fundo com a cor de transparência
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  
  // Depois desenhamos o fundo branco com cantos arredondados
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clWhite;
  Canvas.RoundRect(0, 0, Width, Height, 10, 10);
  
  // Depois desenhamos a borda colorida com cantos arredondados
  Canvas.Pen.Color := CorBorda;
  Canvas.Pen.Width := 2;
  Canvas.Brush.Style := bsClear;
  Canvas.RoundRect(1, 1, Width - 1, Height - 1, 10, 10);
end;

procedure TModernMessageForm.AplicarCantosArredondados;
begin
  // A função foi movida para o evento OnPaint
end;

procedure TModernMessageForm.AplicarIcone;
var
  Bmp: TBitmap;
  CorFundo, CorTexto: TColor;
  X, Y: Integer;
  Radius: Integer;
  Simbolo: string;
begin
  case FTipo of
    mtPrimary:
      begin
        CorFundo := $00FFFFFF;
        CorTexto := $00000000;
        Simbolo := 'i';
      end;
    mtSuccess:
      begin
        CorFundo := $0000FF00;
        CorTexto := $00000000;
        Simbolo := 'ü';
      end;
    mtWarning:
      begin
        CorFundo := $0000FFFF;
        CorTexto := $00000000;
        Simbolo := '!';
      end;
    mtDanger:
      begin
        CorFundo := $000000FF;
        CorTexto := $00FFFFFF;
        Simbolo := '×';
      end;
    mtInfo:
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
    Bmp.Canvas.Brush.Color := Color;
    Bmp.Canvas.FillRect(Rect(0, 0, 32, 32));

    Bmp.Canvas.Brush.Color := CorFundo;
    Bmp.Canvas.Pen.Color := CorFundo;
    Radius := 14;
    X := 16;
    Y := 16;
    Bmp.Canvas.Ellipse(X - Radius, Y - Radius, X + Radius, Y + Radius);

    Bmp.Canvas.Font.Name := 'Arial';
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
  Invalidate;
  ShowModal;
  Result := FResultado;
end;

procedure TModernMessageForm.AplicarCores;
var
  CorHeader: TColor;
begin
  case FTipo of
    mtPrimary: CorHeader := $007B2423;
    mtSuccess: CorHeader := $003C7634;
    mtWarning: CorHeader := $00138ED9;
    mtDanger: CorHeader := $002328D9;
    mtInfo: CorHeader := $00856404;
  end;
  pnlHeader.Color := CorHeader;
end;

procedure TModernMessageForm.AjustarLayout;
var
  LarguraTextoDisponivel: Integer;
begin
  btnOK.Visible := FBotoes in [mbOK, mbOKCancel];
  btnCancel.Visible := FBotoes in [mbOKCancel];
  btnYes.Visible := FBotoes in [mbYesNo];
  btnNo.Visible := FBotoes in [mbYesNo];

  LarguraTextoDisponivel := ClientWidth - 32;
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
  RectTexto.Right := LarguraFinal - 32;
  RectTexto.Bottom := 0;
  DrawText(Canvas.Handle, PChar(FTexto), -1, RectTexto, DT_CALCRECT or DT_WORDBREAK or DT_LEFT or DT_TOP);
  AlturaTexto := RectTexto.Bottom - RectTexto.Top;

  lblText.Height := AlturaTexto;

  AlturaFinal := 60 + (AlturaTexto + 32) + 50;

  if AlturaFinal < AlturaMinima then AlturaFinal := AlturaMinima;
  if AlturaFinal > AlturaMaxima then AlturaFinal := AlturaMaxima;

  Width := LarguraFinal;
  Height := AlturaFinal;
end;

procedure TModernMessageForm.btnOKClick(Sender: TObject);
begin
  FResultado := mrOK;
  Close;
end;

procedure TModernMessageForm.btnCancelClick(Sender: TObject);
begin
  FResultado := mrCancel;
  Close;
end;

procedure TModernMessageForm.btnYesClick(Sender: TObject);
begin
  FResultado := mrYes;
  Close;
end;

procedure TModernMessageForm.btnNoClick(Sender: TObject);
begin
  FResultado := mrNo;
  Close;
end;

procedure TModernMessageForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if btnCancel.Visible then
      btnCancel.Click
    else if btnNo.Visible then
      btnNo.Click
    else if btnOK.Visible then
      btnOK.Click;
  end
  else if Key = VK_RETURN then
  begin
    if btnOK.Visible then
      btnOK.Click
    else if btnYes.Visible then
      btnYes.Click;
  end;
end;

end.
