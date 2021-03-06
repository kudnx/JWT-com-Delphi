object ServicesProdutos: TServicesProdutos
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryProdutos: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from produtos')
    Left = 56
    Top = 40
    object qryProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryProdutosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 100
    end
    object qryProdutospreco: TWideStringField
      FieldName = 'preco'
      Origin = 'preco'
      Size = 32767
    end
    object qryProdutosgrupo: TStringField
      FieldName = 'grupo'
      Origin = 'grupo'
      Size = 100
    end
  end
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\sqlite\database.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 144
    Top = 80
  end
end
