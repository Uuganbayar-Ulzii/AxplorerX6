unit uFace;

interface

uses
  Windows, Forms, System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TaxFaceForm = class(TForm)
    Label1: TLabel;
    img1: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  axFaceForm: TaxFaceForm;

implementation

{$R *.dfm}

procedure TaxFaceForm.FormCreate(Sender: TObject);
var
  hLib: THandle;
  JPEGImage: TJPEGImage;
  ResourceStream: TResourceStream;
  _APP_PATH: string;
begin
  _APP_PATH := ExtractFilePath(Application.ExeName);
  if FileExists(_APP_PATH + 'libax.dll') then
  begin
    hLib := LoadLibrary(PWideChar(_APP_PATH + 'libax.dll'));
    if FindResource(hLib, 'AX4_FACE', RT_RCDATA) <> 0 then
    begin
      try
        JPEGImage := TJPEGImage.Create;
        try
          ResourceStream := TResourceStream.Create(hLib, 'AX4_FACE', RT_RCDATA);
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
end;

end.

