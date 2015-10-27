program AxplorerX6;

uses
  Forms,
  Windows,
  Classes,
  SysUtils,
  Dialogs,
  Controls,
  uFace in 'Forms\uFace.pas' {axFaceForm} ,
  HddPhysic in 'Packages\HddPhysic.pas',
  UsbPhysic in 'Packages\UsbPhysic.pas';

{$R *.res}

var
  AComp: TPersistentClass;
  axMainForm: TForm;
  axLoginForm: TForm;
  hLib: THandle;
  v: string;
  i, pkg_count: Integer;
  PkgList: TStringList;
  slowed: boolean;
  _APP_PATH: string;

function GetFileVersion(const Filename: string; var Version: string): boolean;
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
    Version := Format('%d.%d.%d.%d', [VerBlk.dwFileVersionMS shr 16, VerBlk.dwFileVersionMS and 65535, VerBlk.dwFileVersionLS shr 16, VerBlk.dwFileVersionLS and 65535]);
    FreeMem(Pt);
    Result := True;
  end
  else
    Result := False;
end;

begin
  FormatSettings.ShortDateFormat := 'YY.MM.DD';
  GetFileVersion(Application.ExeName, v);
  axFaceForm := TaxFaceForm.Create(Nil);
  axFaceForm.lbl1.Caption := v;
  axFaceForm.Show;
  axFaceForm.Label1.Caption := 'Initializing Application ...';
  axFaceForm.Update;
  PkgList := TStringList.Create;
  Application.Title := 'Axplorer X6';
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  _APP_PATH := ExtractFilePath(Application.ExeName);
  slowed := False;

  if not FileExists(_APP_PATH + 'core\axpackage.lst') then
  begin
    Application.MessageBox('Axplorer X6 програмын системийн файлууд алга байна ..', 'Axplorer X6', MB_OK + MB_ICONSTOP);
    Halt(1);
  end;

  PkgList.LoadFromFile(_APP_PATH + 'core\axpackage.lst');
  pkg_count := PkgList.Count;

  // Loading RunTime packages ...
  for i := 0 to pkg_count - 1 do
  begin
    if FileExists(_APP_PATH + 'core\' + PkgList.Strings[i] + '.bpl') then
    begin
      GetFileVersion(_APP_PATH + 'core\' + PkgList.Strings[i] + '.bpl', v);
      axFaceForm.Label1.Caption := 'Loading ' + PkgList.Strings[i] + ' v' + v + ' ' + '...';
      axFaceForm.Update;
      Application.ProcessMessages;
      if slowed then
        Sleep(500);
      hLib := LoadPackage(_APP_PATH + 'core\' + PkgList.Strings[i] + '.bpl');
    end;
  end;

  GetFileVersion(_APP_PATH + 'lib\axdata.bpl', v);
  axFaceForm.Label1.Caption := 'Loading Data Module v' + v + '...';
  axFaceForm.Update;
  if slowed then
    Sleep(500);
  hLib := LoadPackage(_APP_PATH + 'lib\axdata.bpl');
  if True then

    GetFileVersion(_APP_PATH + 'lib\axlogin.bpl', v);
  axFaceForm.Label1.Caption := 'Loading Login Module v' + v + '...';
  axFaceForm.Update;
  if slowed then
    Sleep(500);
  hLib := LoadPackage(_APP_PATH + 'lib\axlogin.bpl');
  GetFileVersion(ExtractFilePath(Application.ExeName) + 'pkg\axmain.bpl', v);
  axFaceForm.Label1.Caption := 'Loading Main Module v' + v + '...';
  axFaceForm.Update;
  if slowed then
    Sleep(500);
  hLib := LoadPackage(_APP_PATH + 'lib\axmain.bpl');
  axFaceForm.Label1.Caption := 'Loading Main Form ...';
  axFaceForm.Update;
  if slowed then
    Sleep(500);

  axFaceForm.Label1.Caption := 'Loading Login Form ...';
  axFaceForm.Update;

  AComp := GetClass('TaxMainForm');
  Application.CreateForm(TComponentClass(AComp), axMainForm);
  axMainForm.Show;

  if slowed then
    Sleep(500);
  AComp := GetClass('TaxLoginForm');
  Application.CreateForm(TComponentClass(AComp), axLoginForm);
  if axLoginForm.ShowModal <> mrOk then
  begin
    axMainForm.Hide;
    axMainForm.Free;
    Application.Terminate;
  end;
  Application.Run;

end.

