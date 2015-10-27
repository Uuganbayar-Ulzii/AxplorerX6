unit uStarter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, Vcl.StdCtrls, cxButtons, Vcl.Menus, Vcl.Imaging.jpeg;

type
  TaxStarterForm = class(TForm)
    img1: TImage;
    lbl1: TLabel;
    Edit_HWID: TcxTextEdit;
    lbl2: TLabel;
    Edit_Serial: TcxTextEdit;
    cxbtn2: TcxButton;
    cxbtn1: TcxButton;
    lbl3: TLabel;
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure cxbtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  axStarterForm: TaxStarterForm;

implementation

{$R *.dfm}

uses uModule, MD5Hash, uVars;

procedure TaxStarterForm.cxbtn1Click(Sender: TObject);
Var
  lcCount: Integer;
begin
  if ActivationKey2 = Edit_Serial.Text then
  begin
    AssignFile(AxLicFile, AxplorerPath + LicenseName);
    if FileExists(AxplorerPath + LicenseName) then
    begin
      Reset(AxLicFile);
      lcCount := FileSize(AxLicFile);
      Seek(AxLicFile, lcCount);
    end
    else
      Rewrite(AxLicFile);
    AxLicData.LastDate := Now;
    AxLicData.HardwareID := HDKey2;
    AxLicData.ActivationKey := ActivationKey2;
    AxLicData.Remain := -1;
    Write(AxLicFile, AxLicData);
    CloseFile(AxLicFile);
    AxplorerRegistered := True;
    ModalResult := mrOk;
  end
  else
    ShowMessage('Invalid Serial Number !.');
end;

procedure TaxStarterForm.FormCreate(Sender: TObject);
var
  hLib: THandle;
  JPEGImage: TJPEGImage;
  ResourceStream: TResourceStream;
begin
if FileExists('gooklib.dll') then
  begin
    hLib := LoadLibrary(PWideChar('gooklib.dll'));
    if FindResource(hLib, 'AX4_TOP', RT_RCDATA) <> 0 then
    begin
      try
        JPEGImage := TJPEGImage.Create;
        try
          ResourceStream := TResourceStream.Create(hLib, 'AX4_TOP', RT_RCDATA);
          try
            JPEGImage.LoadFromStream(ResourceStream);
          finally
            ResourceStream.Free;
          end;
          img1.Picture.Graphic := JPEGImage;
        finally
          JPEGImage.Free
        end;
      finally
        FreeLibrary(hLib);
      end;
    end;
  end;
  Edit_HWID.Text := HDKey2;
  if FindWindow('TAppBuilder', nil) > 0 then
    Edit_Serial.Text := ActivationKey2;
  if not AxplorerRegistered then
    if FileExists(AxplorerPath + LicenseName) then
    begin
      AssignFile(AxLicFile, AxplorerPath + LicenseName);
      Reset(AxLicFile);
      Seek(AxLicFile,AxLicenseID);
      if FormatDateTime('YYYY-MM-DD', AxLicData.LastDate) <>
        FormatDateTime('YYYY-MM-DD', Now) then
      begin
        AxLicData.Remain := AxLicData.Remain + 1;
        AxLicData.LastDate := Now;
      end;
      AxLicData.HardwareID := HDKey;
      lbl3.Caption := Format('ТУРШИЛТЫН ХУГАЦАА ДУУСАХАД %d ӨДӨР ҮЛДЛЭЭ',
        [28 - AxLicData.Remain]);
      Write(AxLicFile, AxLicData);
      CloseFile(AxLicFile);
    end;
end;

procedure TaxStarterForm.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(wm_nclbuttondown, htcaption, 0);
end;

initialization

RegisterClass(TaxStarterForm);

finalization

UnRegisterClass(TaxStarterForm);

end.
