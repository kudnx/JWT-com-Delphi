object ServicesAuth: TServicesAuth
  OldCreateOrder = False
  Height = 150
  Width = 524
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\sqlite\database.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 144
    Top = 80
  end
  object qryUsuarios: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from usuarios'
      'where login = :login and senha = :senha')
    Left = 56
    Top = 40
    ParamData = <
      item
        Name = 'LOGIN'
        ParamType = ptInput
      end
      item
        Name = 'SENHA'
        ParamType = ptInput
      end>
    object qryUsuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryUsuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object qryUsuarioslogin: TStringField
      FieldName = 'login'
      Origin = 'login'
      Size = 100
    end
    object qryUsuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 100
    end
  end
  object qryKeys: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from usuario_key'
      'where public_key = :public_key')
    Left = 328
    Top = 40
    ParamData = <
      item
        Name = 'PUBLIC_KEY'
        ParamType = ptInput
      end>
    object qryKeysid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryKeyspublic_key: TStringField
      FieldName = 'public_key'
      Origin = 'public_key'
      Size = 200
    end
    object qryKeysprivate_key: TStringField
      FieldName = 'private_key'
      Origin = 'private_key'
      Size = 200
    end
  end
end
