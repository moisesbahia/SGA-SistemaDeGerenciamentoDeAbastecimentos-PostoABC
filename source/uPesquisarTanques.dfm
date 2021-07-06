object fPesquisarTanques: TfPesquisarTanques
  Left = 526
  Top = 207
  Caption = 'Pesquisa de Tanques'
  ClientHeight = 303
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbFiltro: TLabel
    Left = 8
    Top = 6
    Width = 29
    Height = 13
    Caption = 'Filtros'
  end
  object lbChavePesquisa: TLabel
    Left = 160
    Top = 6
    Width = 101
    Height = 13
    Caption = 'Chave para pesquisa'
  end
  object sgDadosTanques: TStringGrid
    Left = 8
    Top = 47
    Width = 441
    Height = 223
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    TabOrder = 1
    OnDblClick = sgDadosTanquesDblClick
    OnEnter = sgDadosTanquesEnter
  end
  object eChavePesquisa: TEdit
    Left = 160
    Top = 21
    Width = 289
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
    OnKeyDown = eChavePesquisaKeyDown
  end
  object cbFiltros: TComboBox
    Left = 8
    Top = 21
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 2
    Text = 'Nome do Tanque'
    Items.Strings = (
      'Nome do Tanque'
      'Tipo de Combust'#237'vel')
  end
  object pnBotoes: TPanel
    Left = 1
    Top = 276
    Width = 456
    Height = 27
    TabOrder = 3
    object sbSelecionar: TSpeedButton
      Left = -1
      Top = 0
      Width = 102
      Height = 26
      Caption = '&Selecionar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sbSelecionarClick
    end
    object sbCancelar: TSpeedButton
      Left = 353
      Top = 1
      Width = 102
      Height = 25
      Align = alRight
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sbCancelarClick
      ExplicitLeft = 229
      ExplicitTop = 0
      ExplicitHeight = 26
    end
  end
end
