object CepModelData: TCepModelData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 216
  Width = 537
  object qryPesquisarCep: TFDQuery
    SQL.Strings = (
      'SELECT'
      '  CODIGO,'
      '  CEP,'
      '  LOGRADOURO,'
      '  COMPLEMENTO,'
      '  BAIRRO,'
      '  LOCALIDADE,'
      '  UF'
      ''
      'FROM CEP'
      ''
      'WHERE CEP = :CEP')
    Left = 80
    Top = 16
    ParamData = <
      item
        Name = 'CEP'
        ParamType = ptInput
      end>
  end
  object qryPesquisarEnderecoCompleto: TFDQuery
    SQL.Strings = (
      'SELECT'
      '  CODIGO,'
      '  CEP,'
      '  LOGRADOURO,'
      '  COMPLEMENTO,'
      '  BAIRRO,'
      '  LOCALIDADE,'
      '  UF'
      ''
      'FROM CEP'
      ''
      'WHERE UF = :UF'
      '  AND LOCALIDADE = :LOCALIDADE'
      '  AND LOGRADOURO =  :LOGRADOURO'
      '')
    Left = 80
    Top = 72
    ParamData = <
      item
        Name = 'UF'
        ParamType = ptInput
      end
      item
        Name = 'LOCALIDADE'
        ParamType = ptInput
      end
      item
        Name = 'LOGRADOURO'
        ParamType = ptInput
      end>
  end
  object qryManutencao: TFDQuery
    SQL.Strings = (
      'SELECT'
      '  CODIGO,'
      '  CEP,'
      '  LOGRADOURO,'
      '  COMPLEMENTO,'
      '  BAIRRO,'
      '  LOCALIDADE,'
      '  UF'
      ''
      'FROM CEP'
      ''
      'WHERE CEP = :CEP')
    Left = 80
    Top = 128
    ParamData = <
      item
        Name = 'CEP'
        ParamType = ptInput
      end>
  end
  object tmpCep: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 16
    object tmpCepCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object tmpCepUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object tmpCepLOCALIDADE: TStringField
      FieldName = 'LOCALIDADE'
      Size = 60
    end
    object tmpCepLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 60
    end
    object tmpCepBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 40
    end
    object tmpCepCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
    end
    object tmpCepCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
end
