object ConfigConexao: TConfigConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 204
  Width = 443
  object FDConexao: TFDConnection
    Params.Strings = (
      'Server=LOCALHOST'
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 24
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorHome = 'C:\Fontes\Desafio T'#233'cnico Softplan'
    VendorLib = 'fbclient.dll'
    Embedded = True
    Left = 296
    Top = 24
  end
end
