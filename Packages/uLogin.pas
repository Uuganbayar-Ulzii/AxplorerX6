unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCheckBox;

type
  TaxLoginForm = class(TForm)
    img1: TImage;
    cxbtn1: TcxButton;
    cxbtn2: TcxButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cmb1: TcxLookupComboBox;
    edt1: TcxTextEdit;
    lbl5: TLabel;
    chk1: TcxCheckBox;
    lbl6: TLabel;
    chk2: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxbtn1Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  axLoginForm: TaxLoginForm;

implementation

{$R *.dfm}

uses uModule, uVars;

procedure TaxLoginForm.cxbtn1Click(Sender: TObject);
begin
 if trim(edt1.Text)=axMainModule.tblUser.FieldValues['PASSWD'] then
          ModalResult := mrOk
 else
    ShowMessage('Нууц код буруу байна !.');
end;

procedure TaxLoginForm.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
      cxbtn1Click(Sender);
end;

procedure TaxLoginForm.FormCreate(Sender: TObject);
var
  hLib: THandle;
  JPEGImage: TJPEGImage;
  ResourceStream: TResourceStream;
  v:string;
begin
if FileExists('gooklib.dll') then
  begin
    hLib := LoadLibrary(PWideChar('gooklib.dll'));
    if FindResource(hLib, 'AX4_LOGIN', RT_RCDATA) <> 0 then
    begin
      try
        JPEGImage := TJPEGImage.Create;
        try
          ResourceStream := TResourceStream.Create(hLib, 'AX4_LOGIN', RT_RCDATA);
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

  axGetFileVersion(Application.ExeName, v);
  lbl1.Caption := 'v' + v;
  if Not AxplorerRegistered then
    lbl6.Caption := 'Unregistered version'
  else
  begin
    lbl6.Caption := HDKey2;
    lbl6.Font.Color := clGray;
  end;
  cmb1.EditValue:=axMainModule.tblUser.FieldValues['ID'];
end;

procedure TaxLoginForm.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(wm_nclbuttondown, htcaption, 0);
end;

initialization

RegisterClass(TaxLoginForm);

finalization

UnRegisterClass(TaxLoginForm);

end.
