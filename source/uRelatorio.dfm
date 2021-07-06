object fRelatorio: TfRelatorio
  Left = 0
  Top = 0
  Caption = 'fRelatorio'
  ClientHeight = 659
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 40
    Top = 8
    Width = 794
    Height = 1123
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Title = 'Relat'#243'rio de empregados'
    BeforePrint = RLReport1BeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 59
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Color = clWhite
      ParentColor = False
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 291
        Top = 22
        Width = 177
        Height = 27
        Caption = 'Abastecimentos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 591
        Top = 0
        Width = 127
        Height = 16
        Align = faRightTop
        Info = itPageNumber
        Text = 'P'#225'gina'
        Transparent = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 97
      Width = 718
      Height = 16
      BandType = btHeader
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentColor = False
      ParentFont = False
      Transparent = False
      object RLLabel2: TRLLabel
        Left = 0
        Top = 0
        Width = 97
        Height = 16
        Align = faTopOnly
        Alignment = taCenter
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 95
        Top = 0
        Width = 129
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        Caption = 'Vlr Abastecimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 223
        Top = 0
        Width = 88
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        Caption = 'Qtde(litros)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 401
        Top = 0
        Width = 175
        Height = 16
        Align = faTopOnly
        Caption = 'Forma de Pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 576
        Top = 0
        Width = 139
        Height = 16
        Align = faTopOnly
        Alignment = taCenter
        Caption = 'C'#243'digo da Bomba'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 311
        Top = 0
        Width = 90
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        Caption = 'Vlr Imposto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 16
      BandType = btFooter
      object RLSystemInfo3: TRLSystemInfo
        Left = 472
        Top = 0
        Width = 246
        Height = 16
        Align = faRightTop
        Alignment = taRightJustify
        Text = 'Data:'
      end
      object RLSystemInfo4: TRLSystemInfo
        Left = 328
        Top = 0
        Width = 144
        Height = 16
        Align = faRightTop
        Info = itHour
        Text = 'Hora:'
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 16
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object RLDBText7: TRLDBText
        Left = 0
        Top = 0
        Width = 97
        Height = 16
        Align = faTopOnly
        Alignment = taCenter
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'DATA_CADASTRO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 97
        Top = 0
        Width = 127
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'VLR_ABASTECIMENTO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText9: TRLDBText
        Left = 224
        Top = 0
        Width = 87
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QTDE_LITROS'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText10: TRLDBText
        Left = 401
        Top = 0
        Width = 175
        Height = 16
        Align = faTopOnly
        AutoSize = False
        DataField = 'FORMA_PAGAMENTO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText11: TRLDBText
        Left = 576
        Top = 0
        Width = 139
        Height = 16
        Align = faTopOnly
        Alignment = taCenter
        AutoSize = False
        DataField = 'CODIGO_BOMBA'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText12: TRLDBText
        Left = 311
        Top = 0
        Width = 90
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VLR_IMPOSTO'
        DataSource = DataSource1
        Text = ''
      end
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = dmConexao.FDQueryControllerAbastecimentoRel
    Left = 876
    Top = 264
  end
end
