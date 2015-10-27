unit uNewCompany;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, DB,
  Vcl.StdCtrls, dxGDIPlusClasses, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxDBEdit, Vcl.Buttons;

type
  TaxNewCompany = class(TForm)
    img1: TImage;
    lbl1: TLabel;
    img2: TImage;
    lbl2: TLabel;
    lbl3: TLabel;
    edtName: TcxDBTextEdit;
    edtDBName: TcxDBTextEdit;
    img3: TImage;
    shp1: TShape;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    lbl4: TLabel;
    FileSaveDialog1: TFileSaveDialog;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure edtDBNameDblClick(Sender: TObject);
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  axNewCompany: TaxNewCompany;

implementation

{$R *.dfm}

Uses uModule;

procedure TaxNewCompany.btn1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TaxNewCompany.btn2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TaxNewCompany.edtDBNameDblClick(Sender: TObject);
begin
  FileSaveDialog1.Execute;
end;

procedure TaxNewCompany.FormCreate(Sender: TObject);
begin
  if not axMainModule.cnLogin.Connected then
      ShowMessage('DB not connected !.');
end;

procedure TaxNewCompany.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 Perform(wm_nclbuttondown, htcaption, 0);
end;

initialization

RegisterClass(TaxNewCompany);

finalization

UnRegisterClass(TaxNewCompany);
end.
