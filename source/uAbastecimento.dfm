object fAbastecimento: TfAbastecimento
  Left = 0
  Top = 0
  Caption = 'Abastecimento'
  ClientHeight = 611
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 89
    Width = 981
    Height = 459
    Align = alClient
    BorderStyle = bsSingle
    Enabled = False
    TabOrder = 0
    object lbValorAbastecimento: TLabel
      Left = 16
      Top = 199
      Width = 418
      Height = 33
      Caption = 'Informe o Valor do Abastecimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 15
      Top = 374
      Width = 423
      Height = 33
      Caption = 'Informe a Condi'#231#227'o de Pagamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbQtdeLitrosAbastecimento: TLabel
      Left = 15
      Top = 285
      Width = 397
      Height = 33
      Caption = 'Qtde de Litros do Abastecimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edValorParaAbastecimento: TEdit
      Left = 15
      Top = 235
      Width = 419
      Height = 41
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = edValorParaAbastecimentoChange
      OnKeyPress = edValorParaAbastecimentoKeyPress
    end
    object cbCondicaoPagamento: TComboBox
      Left = 16
      Top = 410
      Width = 419
      Height = 41
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'DINHEIRO'
      Items.Strings = (
        'DINHEIRO'
        'CART'#195'O DE CR'#201'DITO'
        'CART'#195'O DE D'#201'BITO'
        'CHEQUE'
        'PIX'
        'DEP'#211'SITO')
    end
    object btConcluirAbastecimento: TButton
      Left = 595
      Top = 235
      Width = 334
      Height = 182
      Caption = 'FINALIZAR ABASTECIMENTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btConcluirAbastecimentoClick
    end
    object edQtdeLitrosAbastecimento: TEdit
      Left = 15
      Top = 321
      Width = 419
      Height = 41
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 975
      Height = 192
      Align = alTop
      Caption = 'Panel1'
      TabOrder = 4
      object sgDadosBombas: TStringGrid
        Left = 1
        Top = 1
        Width = 973
        Height = 190
        Align = alClient
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = sgDadosBombasClick
      end
    end
  end
  object btAtendimento: TButton
    Left = 0
    Top = 0
    Width = 981
    Height = 89
    Align = alTop
    Caption = 'INICIAR ABASTECIMENTO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btAtendimentoClick
  end
  object pnRodape: TPanel
    Left = 0
    Top = 548
    Width = 981
    Height = 63
    Align = alBottom
    TabOrder = 2
    object btFecharTela: TButton
      Left = 18
      Top = 6
      Width = 334
      Height = 49
      Caption = 'FECHAR TELA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btFecharTelaClick
    end
  end
end
