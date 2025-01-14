object frmViaCEPView: TfrmViaCEPView
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Lista de endere'#231'os encontrados'
  ClientHeight = 408
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 164
    Height = 16
    Caption = 'Selecione um dos endere'#231'os'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 46
    Width = 723
    Height = 323
    DataSource = dsListaEnderecos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CEP'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCALIDADE'
        Title.Caption = 'Localidade'
        Width = 167
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGRADOURO'
        Title.Caption = 'Logradouro'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPLEMENTO'
        Title.Caption = 'Complemento'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAIRRO'
        Title.Caption = 'Bairro'
        Width = 127
        Visible = True
      end>
  end
  object btSelecionarEndereco: TButton
    Left = 8
    Top = 375
    Width = 137
    Height = 25
    Caption = 'Selecionar Endere'#231'o'
    TabOrder = 1
    OnClick = btSelecionarEnderecoClick
  end
  object btCancelar: TButton
    Left = 151
    Top = 375
    Width = 137
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btCancelarClick
  end
  object dsListaEnderecos: TDataSource
    DataSet = tmpListaEnderecos
    Left = 56
    Top = 96
  end
  object tmpListaEnderecos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 168
    Top = 96
    object tmpListaEnderecosCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object tmpListaEnderecosUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object tmpListaEnderecosLOCALIDADE: TStringField
      FieldName = 'LOCALIDADE'
      Size = 60
    end
    object tmpListaEnderecosLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 60
    end
    object tmpListaEnderecosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 40
    end
    object tmpListaEnderecosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 40
    end
  end
end
