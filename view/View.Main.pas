unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore,
  dxSkinsDefaultPainters, dxRibbonCustomizationForm, cxClasses, dxBar, dxStatusBar, dxRibbon, System.Actions, Vcl.ActnList, cxPC,
  dxBarBuiltInMenu, dxTabbedMDI, Vcl.ExtCtrls, Controller.RESTBases;

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
    timer: TTimer;
    dxTabbedMDIManager: TdxTabbedMDIManager;
    procedure FormShow(Sender: TObject);
    procedure actionFecharExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actionEntregasExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Login;
    procedure Resizeform;
    procedure NomeAgente(iAgente: integer);
  public
    { Public declarations }
  end;

var
  view_Main: Tview_Main;

implementation

{$R *.dfm}

uses dm.SIGLite, View.Login, Common.Params, Global.Parametros, View.AcompanhamentoEntregas;

procedure Tview_Main.actionEntregasExecute(Sender: TObject);
begin
  if not Assigned(view_AcompanhamntoEntregas) then
  begin
    view_AcompanhamntoEntregas := Tview_AcompanhamntoEntregas.Create(Application);
  end;
  view_AcompanhamntoEntregas.Show;
end;

procedure Tview_Main.actionFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure Tview_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_Main := nil;
end;

procedure Tview_Main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Application.MessageBox('Confirma sair do sistema ?', 'Sair', MB_YESNO + MB_ICONQUESTION) = ID_YES;
end;

procedure Tview_Main.FormShow(Sender: TObject);
begin
  Self.Caption := Application.Title;
  Login;
  Resizeform;
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
  NomeAgente(Common.Params.paramCodeDelivery);
  statusBarMain.Panels[1].Text := 'Usu�rio: ' + Global.Parametros.pUser_Name;
  statusBarMain.Panels[0].Text := 'Base: ' + Common.Params.paramCodeDelivery.ToString + ' - ' + Common.Params.paramNameUser;
end;

procedure Tview_Main.NomeAgente(iAgente: integer);
var
  FBase : TRESTBasesController;
begin
  try
    FBase := TRESTBasesController.Create;
    if FBase.RetornaNomeBase(Common.Params.paramCodeDelivery) then
    begin
      Application.MessageBox('Agente n�o encontrado.', 'Aten��o', MB_OK + MB_ICONEXCLAMATION);
    end;
  finally
    FBase.Free;
  end;
end;

procedure Tview_Main.Resizeform;
begin
  Self.Top := 0;
  Self.Left := 0;
  Self.Width := Screen.WorkAreaWidth;
  Self.Height := Screen.WorkAreaHeight;
end;

procedure Tview_Main.timerTimer(Sender: TObject);
begin
  statusBarMain.Panels[2].Text := FormatDateTime('dddd, dd "de" mmmm "de" yyyy hh:mm:ss', Now());
end;

end.
