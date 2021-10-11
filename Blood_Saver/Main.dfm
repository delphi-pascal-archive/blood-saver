object MainForm: TMainForm
  Left = 224
  Top = 126
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Blood Saver'
  ClientHeight = 373
  ClientWidth = 554
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Img: TImage
    Left = 0
    Top = 0
    Width = 554
    Height = 373
    Align = alClient
    OnClick = ImgClick
  end
  object BloodTimer: TTimer
    Interval = 1
    OnTimer = BloodTimerTimer
    Left = 64
    Top = 96
  end
end
