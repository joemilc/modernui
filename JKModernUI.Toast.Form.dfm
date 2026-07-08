object ModernToastForm: TModernToastForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'ModernToastForm'
  ClientHeight = 96
  ClientWidth = 360
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object shpBackground: TShape
    Left = 0
    Top = 0
    Width = 360
    Height = 96
    Align = alNone
    Pen.Width = 2
    Shape = stRoundRect
    OnMouseDown = HeaderMouseDown
  end
  object imgIcon: TImage
    Left = 16
    Top = 16
    Width = 40
    Height = 40
    Transparent = True
    OnMouseDown = HeaderMouseDown
  end
  object lblTitle: TLabel
    Left = 72
    Top = 16
    Width = 28
    Height = 17
    Caption = 'Title'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    OnMouseDown = HeaderMouseDown
  end
  object lblText: TLabel
    Left = 72
    Top = 41
    Width = 21
    Height = 15
    Caption = 'Text'
    Transparent = True
    WordWrap = True
    OnMouseDown = HeaderMouseDown
  end
  object tmrClose: TTimer
    Enabled = False
    OnTimer = tmrCloseTimer
    Left = 312
    Top = 16
  end
end
