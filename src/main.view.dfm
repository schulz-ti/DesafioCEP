object frmDesafioCep: TfrmDesafioCep
  Left = 0
  Top = 0
  Caption = 'Desafio CEP - SOFTPLAN'
  ClientHeight = 473
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnPesquisaEnderecoCompleto: TPanel
    Left = 0
    Top = 96
    Width = 785
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 17
      Height = 13
      Caption = 'UF:'
    end
    object Label3: TLabel
      Left = 63
      Top = 8
      Width = 54
      Height = 13
      Caption = 'Localidade:'
    end
    object Label4: TLabel
      Left = 335
      Top = 8
      Width = 59
      Height = 13
      Caption = 'Logradouro:'
    end
    object Uf: TEdit
      Left = 16
      Top = 27
      Width = 41
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object Localidade: TEdit
      Left = 63
      Top = 27
      Width = 266
      Height = 21
      TabOrder = 1
    end
    object Logradouro: TEdit
      Left = 335
      Top = 27
      Width = 266
      Height = 21
      TabOrder = 2
    end
    object btPesquisarEnderecoCompleto: TBitBtn
      Left = 622
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 3
      OnClick = btPesquisarEnderecoCompletoClick
    end
  end
  object pnPesquisaCEP: TPanel
    Left = 0
    Top = 48
    Width = 785
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 72
      Height = 13
      Caption = 'Pesquisar CEP:'
    end
    object btPesquisarCep: TBitBtn
      Left = 152
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btPesquisarCepClick
    end
    object Cep: TMaskEdit
      Left = 16
      Top = 27
      Width = 120
      Height = 21
      EditMask = '99999-999;1; '
      MaxLength = 9
      TabOrder = 0
      Text = '     -   '
    end
  end
  object pnOpcaoRetorno: TPanel
    Left = 0
    Top = 144
    Width = 785
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    object rgTipoRetorno: TRadioGroup
      Left = 0
      Top = 0
      Width = 785
      Height = 48
      Align = alClient
      Caption = ' '
      Columns = 3
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Retorno por JSON'
        'Retorno por XML')
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object pnFormaPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 785
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    object rbPesquisarCEP: TRadioButton
      Left = 16
      Top = 16
      Width = 161
      Height = 17
      Caption = 'Realizar pesquisa por CEP'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbPesquisarCEPClick
    end
    object rbPesquisarEnderecoCompleto: TRadioButton
      Left = 236
      Top = 16
      Width = 249
      Height = 17
      Caption = 'Realizar pesquisa por endere'#231'o completo'
      TabOrder = 1
      OnClick = rbPesquisarCEPClick
    end
  end
  object pnMessage: TPanel
    Left = 0
    Top = 192
    Width = 785
    Height = 281
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 4
    object Label5: TLabel
      Left = 16
      Top = 6
      Width = 103
      Height = 13
      Caption = 'Retorno da Pesquisa:'
    end
    object DBGrid1: TDBGrid
      Left = 16
      Top = 25
      Width = 753
      Height = 240
      TabStop = False
      DataSource = dsCep
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CEP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Width = 31
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOCALIDADE'
          Title.Caption = 'Localidade'
          Width = 165
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGRADOURO'
          Title.Caption = 'Logradouro'
          Width = 167
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPLEMENTO'
          Title.Caption = 'Complemento'
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Title.Caption = 'Bairro'
          Width = 149
          Visible = True
        end>
    end
  end
  object dsCep: TDataSource
    Left = 40
    Top = 272
  end
end
