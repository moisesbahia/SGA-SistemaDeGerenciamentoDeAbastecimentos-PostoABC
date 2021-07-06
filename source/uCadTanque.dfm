inherited fCadTanque: TfCadTanque
  Caption = 'Cadastro de Tanque(s)'
  ClientHeight = 228
  ClientWidth = 456
  OnShow = FormShow
  ExplicitWidth = 472
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
  inherited pBotoesPadrao: TPanel
    Height = 228
    TabOrder = 3
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
    Top = 89
    Width = 286
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    MaxLength = 100
    TabOrder = 1
  end
  object rgTipoCombustivel: TRadioGroup
    Left = 152
    Top = 122
    Width = 286
    Height = 67
    Caption = 'Tipo de Combust'#237'vel'
    Columns = 2
    Enabled = False
    Items.Strings = (
      'Gasolina'
      #211'leo Diesel')
    TabOrder = 2
  end
end
