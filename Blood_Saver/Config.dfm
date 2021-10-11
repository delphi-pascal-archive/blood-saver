object ConfigForm: TConfigForm
  Left = 198
  Top = 114
  BorderStyle = bsSingle
  Caption = 'Configuration du BloodSaver'
  ClientHeight = 145
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ConfigGrpBox: TGroupBox
    Left = 8
    Top = 8
    Width = 441
    Height = 129
    Caption = 'Configuration globale'
    TabOrder = 0
    object NbBlood: TLabel
      Left = 8
      Top = 24
      Width = 137
      Height = 13
      Caption = 'Nombre de gouttes de sang :'
    end
    object Grav: TLabel
      Left = 8
      Top = 56
      Width = 40
      Height = 13
      Caption = 'Gravit'#233' :'
    end
    object Blood: TLabel
      Left = 8
      Top = 88
      Width = 83
      Height = 13
      Caption = 'Couleur du sang :'
    end
    object SepBevel1: TBevel
      Left = 208
      Top = 16
      Width = 2
      Height = 105
    end
    object Speed: TLabel
      Left = 224
      Top = 24
      Width = 40
      Height = 13
      Caption = 'Vitesse :'
    end
    object Length: TLabel
      Left = 224
      Top = 48
      Width = 37
      Height = 13
      Caption = 'Port'#233'e :'
    end
    object Size: TLabel
      Left = 224
      Top = 72
      Width = 31
      Height = 13
      Caption = 'Taille :'
    end
    object NbBloodEdit: TSpinEdit
      Left = 148
      Top = 21
      Width = 53
      Height = 22
      MaxValue = 255
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
    object GravEdit: TComboBox
      Left = 52
      Top = 53
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Gravit'#233' terrestre'
      Items.Strings = (
        'Gravit'#233' terrestre'
        'Gravit'#233' lunaire'
        'Forte gravit'#233
        'Faible gravit'#233
        'Pas de gravit'#233)
    end
    object BloodEdit: TComboBox
      Left = 96
      Top = 86
      Width = 96
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'Rouge'
      Items.Strings = (
        'Rouge'
        'Vert'
        'Bleu'
        'Blanc'
        'Al'#233'atoire')
    end
    object SpeedEdit: TComboBox
      Left = 272
      Top = 21
      Width = 157
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 3
      Text = 'Normale'
      Items.Strings = (
        'Faible'
        'Normale'
        'Haute')
    end
    object LengthEdit: TComboBox
      Left = 272
      Top = 45
      Width = 157
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 4
      Text = 'Normale'
      Items.Strings = (
        'Faible'
        'Normale'
        'Haute')
    end
    object SizeEdit: TComboBox
      Left = 272
      Top = 69
      Width = 157
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 5
      Text = 'Normale'
      Items.Strings = (
        'Faible'
        'Normale'
        'Haute')
    end
    object ApplyBtn: TButton
      Left = 224
      Top = 96
      Width = 105
      Height = 25
      Caption = 'Appliquer'
      TabOrder = 6
      OnClick = ApplyBtnClick
    end
    object CloseBtn: TButton
      Left = 336
      Top = 96
      Width = 97
      Height = 25
      Caption = 'Fermer'
      TabOrder = 7
      OnClick = CloseBtnClick
    end
  end
end
