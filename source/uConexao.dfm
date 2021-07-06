object dmConexao: TdmConexao
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 253
  Width = 353
  object FDConnection: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=C:\Temp\Fortes Tecnologia\database\DADOS.FDB'
      'DriverID=FB'
      'User_Name=SYSDBA'
      'Password=masterkey')
    LoginPrompt = False
    Left = 42
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 128
    Top = 17
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 232
    Top = 16
  end
  object FDQueryControllerTanque: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '')
    Left = 64
    Top = 80
  end
  object FDQueryControllerBomba: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '')
    Left = 200
    Top = 80
  end
  object FDQueryControllerComposicao: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '')
    Left = 70
    Top = 137
  end
  object FDQueryControllerAbastecimento: TFDQuery
    Connection = FDConnection
    Left = 248
    Top = 137
  end
  object FDQueryControllerAbastecimentoRel: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM ABASTECIMENTO')
    Left = 128
    Top = 193
    object FDQueryControllerAbastecimentoRelCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQueryControllerAbastecimentoRelQTDE_LITROS: TBCDField
      FieldName = 'QTDE_LITROS'
      Origin = 'QTDE_LITROS'
      Required = True
      Precision = 18
      Size = 2
    end
    object FDQueryControllerAbastecimentoRelVLR_ABASTECIMENTO: TBCDField
      FieldName = 'VLR_ABASTECIMENTO'
      Origin = 'VLR_ABASTECIMENTO'
      Required = True
      Precision = 18
      Size = 2
    end
    object FDQueryControllerAbastecimentoRelVLR_IMPOSTO: TBCDField
      FieldName = 'VLR_IMPOSTO'
      Origin = 'VLR_IMPOSTO'
      Required = True
      Precision = 18
      Size = 2
    end
    object FDQueryControllerAbastecimentoRelDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
      Origin = 'DATA_CADASTRO'
      Required = True
    end
    object FDQueryControllerAbastecimentoRelCODIGO_BOMBA: TIntegerField
      FieldName = 'CODIGO_BOMBA'
      Origin = 'CODIGO_BOMBA'
      Required = True
    end
    object FDQueryControllerAbastecimentoRelFORMA_PAGAMENTO: TStringField
      FieldName = 'FORMA_PAGAMENTO'
      Origin = 'FORMA_PAGAMENTO'
      Required = True
      Size = 50
    end
  end
end
