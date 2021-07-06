inherited fCadBomba: TfCadBomba
  Caption = 'Cadastro de Bomba(s)'
  ClientHeight = 228
  ClientWidth = 479
  OnShow = FormShow
  ExplicitWidth = 495
  ExplicitHeight = 267
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 152
    Top = 24
    Width = 37
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lbNome: TLabel [1]
    Left = 152
    Top = 73
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object lbCodigoTanque: TLabel [2]
    Left = 152
    Top = 127
    Width = 76
    Height = 13
    Caption = 'C'#243'digo Tanque:'
  end
  object lbNomeTanque: TLabel [3]
    Left = 236
    Top = 127
    Width = 85
    Height = 13
    Caption = 'Nome do Tanque:'
  end
  inherited pBotoesPadrao: TPanel
    Height = 228
    TabOrder = 4
    ExplicitHeight = 228
    inherited sbCancelar: TSpeedButton
      OnClick = sbCancelarClick
    end
    inherited sbExcluir: TSpeedButton
      OnClick = sbExcluirClick
    end
    inherited sbPesquisar: TSpeedButton
      Top = 133
      OnClick = sbPesquisarClick
      ExplicitTop = 133
    end
    inherited sbFechar: TSpeedButton
      Top = 199
      ExplicitTop = 199
    end
  end
  object edCodigo: TEdit
    Left = 152
    Top = 40
    Width = 78
    Height = 21
    Hint = 'Enter para inserir um novo registro'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyDown = edCodigoKeyDown
  end
  object edNome: TEdit
    Left = 152
    Top = 92
    Width = 313
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    MaxLength = 100
    TabOrder = 1
  end
  object edCodigoTanque: TEdit
    Left = 152
    Top = 143
    Width = 78
    Height = 21
    Hint = 'Enter para inserir um novo registro'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnExit = edCodigoTanqueExit
    OnKeyDown = edCodigoTanqueKeyDown
  end
  object edNomeTanque: TEdit
    Left = 236
    Top = 143
    Width = 229
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    MaxLength = 100
    TabOrder = 3
  end
end
