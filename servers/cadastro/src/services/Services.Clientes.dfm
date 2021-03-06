object ServicesClientes: TServicesClientes
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\sqlite\database.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 144
    Top = 80
  end
  object qryClientes: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from clientes')
    Left = 56
    Top = 40
    object qryClientesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryClientesnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object qryClientessobrenome: TStringField
      FieldName = 'sobrenome'
      Origin = 'sobrenome'
      Size = 100
    end
    object qryClientesemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 100
    end
    object qryClientestelefone: TStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 100
    end
    object qryClienteslocalidade: TStringField
      FieldName = 'localidade'
      Origin = 'localidade'
      Size = 100
    end
  end
end
