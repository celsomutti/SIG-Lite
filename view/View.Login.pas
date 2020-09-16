unit View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxClasses, dxLayoutContainer, dxLayoutControl, cxContainer, cxEdit, dxLayoutcxEditAdapters, cxLabel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, System.Actions, Vcl.ActnList, dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons;

type
  Tview_login = class(TForm)
    layoutControlPadraoGroup_Root: TdxLayoutGroup;
    layoutControlPadrao: TdxLayoutControl;
    layoutGroupLogin: TdxLayoutGroup;
    labelTitle: TcxLabel;
    layoutItemTitle: TdxLayoutItem;
    textEditUsuario: TcxTextEdit;
    layoutItemUsuario: TdxLayoutItem;
    buttonEditSenha: TcxButtonEdit;
    layoutItemSenha: TdxLayoutItem;
    actionListLogin: TActionList;
    actionVisualizarSenha: TAction;
    actionEntrar: TAction;
    actionCancelar: TAction;
    buttonEntrar: TcxButton;
    layoutItemEntrar: TdxLayoutItem;
    buttonCancelar: TcxButton;
    layoutItemCancelar: TdxLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    procedure FormShow(Sender: TObject);
    procedure actionVisualizarSenhaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actionCancelarExecute(Sender: TObject);
    procedure actionEntrarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  view_login: Tview_login;

implementation

{$R *.dfm}

uses dm.SIGLite;

procedure Tview_login.actionCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tview_login.actionEntrarExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure Tview_login.actionVisualizarSenhaExecute(Sender: TObject);
begin
  if buttonEditSenha.Properties.EchoMode = eemNormal then
  begin
    buttonEditSenha.Properties.EchoMode := eemPassword;
  end
  else
  begin
    buttonEditSenha.Properties.EchoMode := eemNormal;
  end;
end;

procedure Tview_login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_login := nil;
end;

procedure Tview_login.FormShow(Sender: TObject);
begin
  labelTitle.Caption := Self.Caption;
end;

end.
