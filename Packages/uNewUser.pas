unit uNewUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxDBEdit, Vcl.Buttons,
  cxHyperLinkEdit;

type
  TaxNewUser = class(TForm)
    img2: TImage;
    img1: TImage;
    lbl1: TLabel;
    btn2: TSpeedButton;
    btn1: TSpeedButton;
    lbl2: TLabel;
    edtName: TcxDBTextEdit;
    edtDBName: TcxDBTextEdit;
    lbl3: TLabel;
    shp1: TShape;
    img3: TImage;
    lbl4: TLabel;
    lbl5: TLabel;
    edt1: TcxTextEdit;
    lbl6: TLabel;
    cxDBHyperLinkEdit1: TcxDBHyperLinkEdit;
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  axNewUser: TaxNewUser;

implementation

{$R *.dfm}

Uses uModule;

procedure TaxNewUser.btn1Click(Sender: TObject);
begin
  if axMainModule.tblUser.State in dsEditModes then
    axMainModule.tblUser.Post;
  ModalResult := mrOk;
end;

procedure TaxNewUser.btn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TaxNewUser.FormCreate(Sender: TObject);
var
  hLib: THandle;
  JPEGImage: TJPEGImage;
  ResourceStream: TResourceStream;
begin
  if FileExists('gooklib.dll') then
  begin
    hLib := LoadLibrary(PWideChar('gooklib.dll'));
    try
      if FindResource(hLib, 'AX4_HEADER', RT_RCDATA) <> 0 then
      begin
        JPEGImage := TJPEGImage.Create;
        try
          ResourceStream := TResourceStream.Create(hLib, 'AX4_HEADER',
            RT_RCDATA);
          try
            JPEGImage.LoadFromStream(ResourceStream);
          finally
            ResourceStream.Free;
          end;
          img1.Picture.Graphic := JPEGImage;
        finally
          JPEGImage.Free
        end;
      end;

      if FindResource(hLib, 'USER_ADD3', RT_RCDATA) <> 0 then
      begin
        JPEGImage := TJPEGImage.Create;
        try
          ResourceStream := TResourceStream.Create(hLib, 'USER_ADD3',
            RT_RCDATA);
          try
            JPEGImage.LoadFromStream(ResourceStream);
          finally
            ResourceStream.Free;
          end;
          img2.Picture.Graphic := JPEGImage;
        finally
          JPEGImage.Free
        end;
      end;

    finally
      FreeLibrary(hLib);
    end;
  end;
end;

procedure TaxNewUser.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(wm_nclbuttondown, htcaption, 0);
end;

initialization

RegisterClass(TaxNewUser);

finalization

UnRegisterClass(TaxNewUser);

end.
