unit uModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, Vcl.Dialogs,
  Vcl.StdCtrls, Winapi.WinSvc, System.IniFiles,   ShellApi,
  HddPhysic, UsbPhysic, Winapi.Windows, Vcl.Forms, Vcl.Controls,
  Winapi.Messages, UniProvider, InterBaseUniProvider, UniDacVcl, MemDS;

type
  TaxLicenseData = record
    HardwareID: ShortString;
    ActivationKey: ShortString;
    LastDate: TDateTime;
    Remain: Integer;
  end;

  TaxMainModule = class(TDataModule)
    cnLogin: TUniConnection;
    cnData: TUniConnection;
    intrbsnprvdr1: TInterBaseUniProvider;
    UniConnectDialog1: TUniConnectDialog;
    tblUser: TUniTable;
    dsUser: TUniDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnLoginAfterConnect(Sender: TObject);
    procedure cnLoginBeforeConnect(Sender: TObject);
    procedure cnLoginBeforeDisconnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const

  RegistryRoot: string = '\Software\GookSoft';
  LicenseName: string = 'axlicense.lic';
  CodeValue: string = 'AP';
  MsgBoxLine
    : string = '--------------------------------------------------------' +
    '--------';

var
  axMainModule: TaxMainModule;
  AxLicData: TaxLicenseData;
  AxLicFile: file of TaxLicenseData;
  cFile: TIniFile;
function IsUserAnAdmin(): BOOL; external shell32;
function SysMsgBox(const Header, Msg, Footer: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons = [mbOk]; UseLine: Boolean = True): Word;
// Database Service Functions
function ServiceGetStatus(sMachine, sService: string): DWord;
function ServiceRunning(sMachine, sService: string): Boolean;
function ServiceStopped(sMachine, sService: string): Boolean;
function ServiceInstalled(sMachine, sService: string): Boolean;
function CheckDBServer: Boolean;
function FBServerInstalled: Boolean;

implementation

{ %CLASSGROUP 'System.Classes.TPersistent' }

{$R *.dfm}

uses uVars, MD5Hash, uStarter;

function SysMsgBox(const Header, Msg, Footer: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons = [mbOk]; UseLine: Boolean = True): Word;
var
  vMsg: string;
begin
  if UseLine then
    vMsg := chr(13) + Header + chr(13) + MsgBoxLine + chr(13) + chr(13) + Msg +
      chr(13) + chr(13) + MsgBoxLine + chr(13) + Footer + chr(13)
  else
    vMsg := chr(13) + Header + chr(13) + chr(13) + chr(13) + Msg + chr(13) +
      chr(13) + Footer + chr(13);
  Result := MessageDlg(vMsg, DlgType, Buttons, 0);
end;

// ------------------------------------------------------------------------------
// Begin of Interbase Service
// ------------------------------------------------------------------------------

function ServiceGetStatus(sMachine, sService: string): DWord;
var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs: SC_Handle;
  //
  // service status
  ss: TServiceStatus;
  //
  // current service status
  dwStat: LongInt;
begin
  dwStat := -1;

  // connect to the service
  // control manager
  schm := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_CONNECT);

  // if successful...
  if (schm > 0) then
  begin
    // open a handle to
    // the specified service
    schs := OpenService(schm, PChar(sService),
      // we want to
      // query service status
      SERVICE_QUERY_STATUS);

    // if successful...
    if (schs > 0) then
    begin
      // retrieve the current status
      // of the specified service
      if (QueryServiceStatus(schs, ss)) then
      begin
        dwStat := ss.dwCurrentState;
      end;

      // close service handle
      CloseServiceHandle(schs);
    end;

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;

  Result := dwStat;
end;

// -------------------------------------
// return TRUE if the specified
// service is running, defined by
// the status code SERVICE_RUNNING.
// return FALSE if the service
// is in any other state, including
// any pending states
//

function ServiceRunning(sMachine, sService: string): Boolean;
begin
  Result := (SERVICE_RUNNING = ServiceGetStatus(sMachine, sService));
end;

function ServiceStopped(sMachine, sService: string): Boolean;
begin
  Result := (SERVICE_STOPPED = ServiceGetStatus(sMachine, sService));
end;

function ServiceInstalled(sMachine, sService: string): Boolean;
var
  B: DWord;
begin
  B := ServiceGetStatus(sMachine, sService);
  Result := (B = SERVICE_STOPPED) or (B = SERVICE_START_PENDING) or
    (B = SERVICE_STOP_PENDING) or (B = SERVICE_RUNNING) or
    (B = SERVICE_CONTINUE_PENDING) or (B = SERVICE_PAUSE_PENDING) or
    (B = SERVICE_PAUSED);
end;

function CheckDBServer: Boolean;
begin
  Result := (ServiceRunning('', AxplorerDBInstance));
end;

function FBServerInstalled: Boolean;
begin
  Result := (ServiceInstalled('', AxplorerDBInstance));
end;


// ------------------------------------------------------------------------------
// End of Interbase Service
// ------------------------------------------------------------------------------

function Windows_x64: Boolean;
var
  WinDir: string;
begin
  WinDir := GetEnvironmentVariable('windir');
  Result := DirectoryExists(WinDir + '\SysWOW64');
end;

procedure TaxMainModule.cnLoginAfterConnect(Sender: TObject);
begin
  if not cFile.SectionExists('Connection') then
  begin
    cFile.WriteString('Connection', 'Name', cnLogin.Database);
    cFile.WriteString('Connection', 'Provider', cnLogin.ProviderName);
    cFile.WriteString('Connection', 'Server', cnLogin.Server);
    cFile.WriteString('Connection', 'UserName', cnLogin.Username);
    cFile.WriteString('Connection', 'Password', cnLogin.Password);
    cFile.UpdateFile;
  end;
  tblUser.Open;
end;

procedure TaxMainModule.cnLoginBeforeConnect(Sender: TObject);
var
  Alias: TStrings;
  AliasFile: TFileName;
begin
  if (cnLogin.Server = '') or (cnLogin.Server = '/3058') then
  begin
    if not FBServerInstalled then
    begin
      SysMsgBox(Application.Title, 'ERROR : #103' + chr(13) +
        'FIREBIRD 2.5 SERVER IS NOT INSTALLED !.',
        'Contact to Administrator or Authors.', mtWarning);
      Application.Terminate;
      Halt(0);
    end
    else if not CheckDBServer then
    begin
      SysMsgBox(Application.Title, 'ERROR : #104' + chr(13) +
        'FIREBIRD 2.5 SERVER IS NOT STARTED !.',
        'Contact to Administrator or Authors.', mtWarning);
      Application.Terminate;
      Halt(0);
    end;
  end;
end;

procedure TaxMainModule.cnLoginBeforeDisconnect(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cnLogin.DataSetCount - 1 do
    cnLogin.DataSets[i].Close;
end;

procedure TaxMainModule.DataModuleCreate(Sender: TObject);
var
  iDiskNo, iReturn: Integer;
  cInfo: AnsiString;
  aDrive: string;
  aFaceForm: TForm;
  aFaceHWND: THandle;
  LabelComp: TComponent;
  LabelStatus: TLabel;
  lcCount: Integer;
  function RevertString(p:AnsiString):AnsiString;
    var j:integer; ps:AnsiString; pc: AnsiChar;
    begin
      ps:=p;
       for j := 1 to Length(p) do
          begin
            if j mod 2=0 then
              begin
                pc:= ps[j-1];
                ps[j-1]:=ps[j];
                ps[j]:=pc;
              end;
          end;
       Result:=ps;
    end;
begin

  AxplorerPath := ExtractFilePath(Application.ExeName);
  AxplorerID := '{85DAC626-70AE-4455-8FDF-DC1B578358AD}';
  AppType := 'ACCOUNTING';
  AxplorerDBInstance := 'FirebirdServerFB25GXServer';
  AxLicenseID := 0;

  aFaceHWND := FindWindow('TaxFaceForm', nil);
  if aFaceHWND > 0 then
  begin
    aFaceForm := (FindControl(aFaceHWND) as TForm);
    LabelComp := aFaceForm.FindComponent('Label1');
    if (LabelComp is TLabel) then
      LabelStatus := (LabelComp as TLabel);
  end;

  aDrive := ExtractFileDrive(Application.ExeName);
  //
  // USB Detection
  //
  LabelStatus.Caption := 'Loading Registration Information ...';
  iDiskNo := 0;
  cInfo := #0;
  SetLength(cInfo, 512);
  UsbPhysic.Init('U.Uuganbayar', '89BB-418A-018D');
  iReturn := UsbPhysic.GetUSBPhysicInfo(iDiskNo, 0, PAnsiChar(cInfo));
  HDSerial := trim(cInfo);
  HDKey := HDSerial;
  ActivationKey := HDKey;
  AxplorerRegistered := False;
  //
  // Fixed Hard Disk Detection
  //

  if trim(HDKey) = '' then
  begin
    LabelStatus.Caption := 'Loading Registration Parameters ...';
    cInfo := #0;
    SetLength(cInfo, 512);
    iDiskNo := 0;
    HddPhysic.Init('U.Uuganbayar', 'E53A-A013-9A50');
    iReturn := HddPhysic.GetPhysicInfo(iDiskNo, 0, PAnsiChar(cInfo));
    HDSerial := trim(cInfo);
    if Not IsUserAnAdmin() then
      HDSerial:=RevertString(HDSerial);
    HDKey2 := HDSerial;
    ActivationKey2 := HDKey2;
  end
  else
  begin
    HDKey2 := HDKey;
    ActivationKey2 := HDKey;
  end;
  AxplorerRegistered := False;
  LabelStatus.Caption := 'Checking License Information ...';
  AxplorerRegistered := False;
  if FileExists(AxplorerPath + LicenseName) then
  begin
    LabelStatus.Caption := 'Reloading License Information ...';
    AssignFile(AxLicFile, AxplorerPath + LicenseName);
    Reset(AxLicFile);
    while (not Eof(AxLicFile)) and (not AxplorerRegistered) do
    begin
      Read(AxLicFile, AxLicData);
      AxplorerRegistered := AxplorerRegistered or
        (AxLicData.ActivationKey = ActivationKey);
      AxplorerRegistered := AxplorerRegistered or
        (AxLicData.ActivationKey = ActivationKey2);
      Inc(AxLicenseID);
    end;
    CloseFile(AxLicFile);
  end;

  if not AxplorerRegistered then
  begin
    aFaceForm.Close;
    Dec(AxLicenseID);
    Application.ProcessMessages;
    if not Assigned(axStarterForm) then
      axStarterForm := TaxStarterForm.Create(Nil);
    if axStarterForm.ShowModal <> mrOk then
      Application.Terminate;
  end;

  cFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.cfg'));
  cnLogin.Database := 'default.ax4db';
  if not FileExists(ChangeFileExt(Application.ExeName, '.cfg')) then
  begin
    ConnectionName := 'Connection';
    cnLogin.ProviderName := cFile.ReadString(ConnectionName, 'Provider',
      'Interbase');
    cnLogin.LoginPrompt := True;
  end
  else
  begin
    ConnectionName := 'Connection';
    cnLogin.ProviderName := cFile.ReadString(ConnectionName, 'Provider',
      'Interbase');
    cnLogin.LoginPrompt := True;
    if cnLogin.ProviderName <> '' then
    begin
      cnLogin.LoginPrompt := False;
      cnLogin.Server := cFile.ReadString(ConnectionName, 'Server', '');
      cnLogin.Username := 'SYSDBA';
      if cnLogin.Username <> '' then
        cnLogin.Username := cnLogin.Username;
      cnLogin.Password := 'ax4admin';
      if cnLogin.Password <> '' then
        cnLogin.Password := cnLogin.Password;
      cnLogin.Database := cFile.ReadString(ConnectionName, 'Name',
        'DefaultAx4DB');
    end;
  end;

  if FileExists(AxplorerPath + 'fbclient.dll') then
    cnLogin.SpecificOptions.Values['ClientLibrary'] := 'fbclient.dll'
  else if FileExists(AxplorerPath + 'client.dll') then
    cnLogin.SpecificOptions.Values['ClientLibrary'] := 'client.dll'
  else if FileExists(AxplorerPath + 'embed.dll') then
    cnLogin.SpecificOptions.Values['ClientLibrary'] := 'embed.dll'
  else if FileExists(AxplorerPath + 'gds32.dll') then
    cnLogin.SpecificOptions.Values['ClientLibrary'] := 'gds32.dll';

  cnData.ProviderName := cnLogin.ProviderName;
  cnLogin.SpecificOptions.Values['UseUnicode'] := 'True';
  cnLogin.SpecificOptions.Values['Charset'] := 'UTF8';
  cnData.SpecificOptions.Values['UseUnicode'] := 'True';
  cnData.SpecificOptions.Values['Charset'] := 'UTF8';
  cnData.SpecificOptions.Values['ClientLibrary'] :=
    cnLogin.SpecificOptions.Values['ClientLibrary'];

  tblUser.TableName := 'AX$USERS';
  tblUser.SpecificOptions.Values['KeyGenerator'] := 'GEN_AX$USERS_ID';

  cnLogin.Connect;

end;

initialization

System.Classes.RegisterClass(TaxMainModule);

finalization

System.Classes.UnRegisterClass(TaxMainModule);

end.
