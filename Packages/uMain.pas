unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView, dxStatusBar,
  dxRibbonStatusBar;

type
  TaxMainForm = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxrbntbRibbon1Tab2: TdxRibbonTab;
    dxrbntbRibbon1Tab3: TdxRibbonTab;
    dxRibbonBackstageViewTabSheet2: TdxRibbonBackstageViewTabSheet;
    dxRibbonBackstageViewTabSheet3: TdxRibbonBackstageViewTabSheet;
    dxRibbonBackstageViewTabSheet4: TdxRibbonBackstageViewTabSheet;
    dxRibbon1Tab2: TdxRibbonTab;
    dxRibbon1Tab3: TdxRibbonTab;
    dxRibbon1Tab4: TdxRibbonTab;
    dxRibbon1Tab5: TdxRibbonTab;
    dxRibbon1Tab6: TdxRibbonTab;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  axMainForm: TaxMainForm;

implementation

{$R *.dfm}

Uses uModule, uNewUser;

procedure TaxMainForm.FormCreate(Sender: TObject);
begin
if not Assigned(axMainModule) then
    axMainModule := TaxMainModule.Create(Application);
  Caption:=Application.Title;
end;

procedure TaxMainForm.FormShow(Sender: TObject);
begin
  if axMainModule.tblUser.RecordCount=0 then
  begin
  if not Assigned(axNewUser) then
      axNewUser:=TaxNewUser.Create(Application);
   if axNewUser.ShowModal<>mrOk then
        Application.Terminate;
  end;
end;

initialization

RegisterClass(TaxMainForm);

finalization

UnRegisterClass(TaxMainForm);

end.
