inherited fCadComposicao: TfCadComposicao
  Caption = 'Composi'#231#227'o de Valores'
  ClientHeight = 241
  ClientWidth = 281
  OnShow = FormShow
  ExplicitWidth = 297
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 152
    Top = 24
    Width = 37
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lbValorLitroGasolina: TLabel [1]
    Left = 152
    Top = 76
    Width = 95
    Height = 13
    Caption = 'Valor Litro Gasolina:'
  end
  object lbValorDiesel: TLabel [2]
    Left = 152
    Top = 133
    Width = 83
    Height = 13
    Caption = 'Valor Litro Diesel:'
  end
  object lbPercImposto: TLabel [3]
    Left = 152
    Top = 185
    Width = 62
    Height = 13
    Caption = 'Imposto(%):'
  end
  inherited pBotoesPadrao: TPanel
    Height = 241
    ExplicitHeight = 241
    inherited sbCancelar: TSpeedButton
      OnClick = sbCancelarClick
    end
    inherited sbExcluir: TSpeedButton
      Visible = False
    end
    inherited sbPesquisar: TSpeedButton
      Top = 143
      Visible = False
      ExplicitTop = 143
    end
    inherited sbFechar: TSpeedButton
      Top = 212
      ExplicitTop = 212
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
    TabOrder = 1
    OnKeyDown = edCodigoKeyDown
  end
  object edValorLitroGasolina: TEdit
    Left = 152
    Top = 92
    Width = 113
    Height = 21
    Hint = 'Enter para inserir um novo registro'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnKeyPress = FormatoPadraoCampoNumero
  end
  object edValorDiesel: TEdit
    Left = 152
    Top = 149
    Width = 113
    Height = 21
    Hint = 'Enter para inserir um novo registro'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnKeyPress = FormatoPadraoCampoNumero
  end
  object edPercImposto: TEdit
    Left = 152
    Top = 201
    Width = 113
    Height = 21
    Hint = 'Enter para inserir um novo registro'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnKeyPress = FormatoPadraoCampoNumero
  end
end
