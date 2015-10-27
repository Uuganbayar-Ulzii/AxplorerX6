unit uVars;

interface

uses Windows, Classes, SysUtils;

var
  // Application Variables
  AxplorerBuild: integer;
  AxplorerVersion, AxplorerDescription, AxplorerPath, AxplorerDBInstance,
  AxplorerID, AxplorerUpdateServer: string;
  AxLangID, AxLicenseID: integer;

  ExcelApp: OleVariant;

  // String Variables

  UserDatabaseName, DatabasePatchVersion, ConnectionName, DBType, AppType,
    HDSerial, HDKey, HDKey2, ActivationCode, ActivationKey, ActivationKey2,

    SelectLang, Company_Name, Current_office_id, Current_Office_RegID,
    Current_user_Name, CurrentPath,

    Server_Name, UserName, LPassword, UseServerName,

    GetDir, Tsalin_Constant_Value, DataBasePath, TempBasePath,

    BServer, BPath, BackBasePath, RegistryPath,

    BackroundPicturePath, BackroundWhite, SkinsPath, Organization_Name,

    New_CompanyName, User_Name, User_Mail, ERROR_STRING, NEW_GUID, USER_PEN,
    Tsalin_Month_Value, UpdateURL, UpdateDir, starter, TeamViewerCmd,

    FORMAT_CURRENCY, ReportPath, ManagerName, AccountantName, DirectorName,

    PROJECT_OFFICE_NAME, PROJECT_DIRECTOR_NAME, PROJECT_OFFICER_NAME,
    PROJECT_ACCOUNTANT_NAME: string;
  CloseAppHWND: THandle;
  Cash_Boolean: integer;
  SentInfo: Boolean;
  Current_user_ID: integer;
  StartedDateTime: TDateTime;
  SelectedYear, OpenYear: integer;
  AllowSaveMassage, AxplorerRegistered: Boolean;

  USE_SUB_PROJECT: Boolean;
  USE_CASH_LINK: Boolean;
  USE_INVENTORY_CTT: Boolean;
  USE_ACCOUNT_CODE: Boolean;
  FaceStatusHWND: THandle;

function axGetFileVersion(const Filename: string; var Version: string): Boolean;

implementation

function axGetFileVersion(const Filename: string; var Version: string): Boolean;
var
  VerBlk: VS_FIXEDFILEINFO;
  InfoSize, puLen: DWord;
  Pt, InfoPtr: Pointer;
begin
  Version := '';
  InfoSize := GetFileVersionInfoSize(PChar(Filename), puLen);
  FillChar(VerBlk, SizeOf(VS_FIXEDFILEINFO), 0);
  if InfoSize > 0 then
  begin
    GetMem(Pt, InfoSize);
    GetFileVersionInfo(PChar(Filename), 0, InfoSize, Pt);
    VerQueryValue(Pt, '\', InfoPtr, puLen);
    move(InfoPtr^, VerBlk, SizeOf(VS_FIXEDFILEINFO));
    Version := Format('%d.%d.%d.%d', [VerBlk.dwFileVersionMS shr 16,
      VerBlk.dwFileVersionMS and 65535, VerBlk.dwFileVersionLS shr 16,
      VerBlk.dwFileVersionLS and 65535]);
    FreeMem(Pt);
    Result := True;
  end
  else
    Result := False;
end;



end.
