object DM: TDM
  OldCreateOrder = False
  Height = 245
  Width = 360
  object mtCliente: TFDMemTable
    FilterOptions = [foCaseInsensitive]
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 31
    Top = 22
    object mtClienteNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object mtClienteIdentidade: TStringField
      FieldName = 'Identidade'
    end
    object mtClienteCPF: TStringField
      FieldName = 'CPF'
      EditMask = '###\.###\.###\-##;0;_'
      Size = 11
    end
    object mtClienteTelefone: TStringField
      FieldName = 'Telefone'
      EditMask = '!\(##\)####\-####;0;_'
      Size = 10
    end
    object mtClienteEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object mtClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object mtClienteLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 200
    end
    object mtClienteNumero: TIntegerField
      FieldName = 'Numero'
    end
    object mtClienteComplemento: TStringField
      FieldName = 'Complemento'
      Size = 50
    end
    object mtClienteBairro: TStringField
      FieldName = 'Bairro'
    end
    object mtClienteCidade: TStringField
      FieldName = 'Cidade'
      Size = 50
    end
    object mtClienteEstado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object mtClientePais: TStringField
      FieldName = 'Pais'
    end
  end
  object dscCliente: TDataSource
    DataSet = mtCliente
    Left = 93
    Top = 23
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 187
    Top = 23
  end
end
