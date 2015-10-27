object axMainModule: TaxMainModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 270
  Width = 527
  object cnLogin: TUniConnection
    ProviderName = 'InterBase'
    Database = 'D:\Debug\Axplorer4a\default.ax4db'
    SpecificOptions.Strings = (
      'InterBase.Charset=UTF8'
      'InterBase.UseUnicode=True')
    Username = 'sysdba'
    Password = 'ax4admin'
    LoginPrompt = False
    AfterConnect = cnLoginAfterConnect
    BeforeConnect = cnLoginBeforeConnect
    BeforeDisconnect = cnLoginBeforeDisconnect
    Left = 104
    Top = 32
  end
  object cnData: TUniConnection
    LoginPrompt = False
    Left = 32
    Top = 32
  end
  object intrbsnprvdr1: TInterBaseUniProvider
    Left = 272
    Top = 16
  end
  object UniConnectDialog1: TUniConnectDialog
    DatabaseLabel = 'Database'
    PortLabel = 'Port'
    ProviderLabel = 'Provider'
    Caption = 'Connect'
    UsernameLabel = 'User Name'
    PasswordLabel = 'Password'
    ServerLabel = 'Server'
    ConnectButton = 'Connect'
    CancelButton = 'Cancel'
    Left = 376
    Top = 16
  end
  object tblUser: TUniTable
    TableName = 'AX$USERS'
    Connection = cnLogin
    KeyFields = 'ID'
    Left = 376
    Top = 136
  end
  object dsUser: TUniDataSource
    DataSet = tblUser
    Left = 312
    Top = 136
  end
end
