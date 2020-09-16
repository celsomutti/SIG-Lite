unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore,
  dxSkinsDefaultPainters, dxRibbonCustomizationForm, cxClasses, dxBar, dxStatusBar, dxRibbon, System.Actions, Vcl.ActnList, cxPC,
  dxBarBuiltInMenu, dxTabbedMDI;

type
  Tview_Main = class(TForm)
    ribbonMainTabExpressas: TdxRibbonTab;
    ribbonMain: TdxRibbon;
    statusBarMain: TdxStatusBar;
    barManagerMain: TdxBarManager;
    barManagerMainBarExpressas: TdxBar;
    actionListMain: TActionList;
    dxBarLargeButton2: TdxBarLargeButton;
    actionEntregas: TAction;
    dxBarLargeButton3: TdxBarLargeButton;
    actionExtrato: TAction;
    ribbonMainTabSistema: TdxRibbonTab;
    barManagerMainBarSistema: TdxBar;
    dxBarLargeButton4: TdxBarLargeButton;
    actionSenha: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    actionFechar: TAction;
    dxBarButton3: TdxBarButton;
    barManagerMainBarAplicacao: TdxBar;
    dxBarButton4: TdxBarButton;
    dxTabbedMDIManagerMain: TdxTabbedMDIManager;
    procedure FormShow(Sender: TObject);
    procedure actionFecharExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure Login;
  public
    { Public declarations }
  end;

var
  view_Main: Tview_Main;

implementation

{$R *.dfm}

uses dm.SIGLite, View.Login;

procedure Tview_Main.actionFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure Tview_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_Main := nil;
end;

procedure Tview_Main.FormShow(Sender: TObject);
begin
  Self.Caption := Application.Title;
  Login;
end;

procedure Tview_Main.Login;
begin
if not Assigned(view_login) then
  begin
    view_login := Tview_login.Create(Application);
  end;
  if view_login.ShowModal = mrCancel then
  begin
    Application.Terminate;
  end;
end;

end.
