unit View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxClasses, dxLayoutContainer, dxLayoutControl, cxContainer, cxEdit, dxLayoutcxEditAdapters, cxLabel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, System.Actions, Vcl.ActnList, dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  Controller.RESTLogin, Controller.RESTLoginAgente;

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
    function Login(sUsuario, sSenha: String): boolean;
    function LoginAgente(iUsuario: integer): Boolean;
  public
    { Public declarations }
  end;

var
  view_login: Tview_login;
  iConta: Integer;
implementation

{$R *.dfm}

uses dm.SIGLite, Common.Params, Global.Parametros;

procedure Tview_login.actionCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tview_login.actionEntrarExecute(Sender: TObject);
begin
  if Login(textEditUsuario.Text,buttonEditSenha.EditText) then
  begin
    ModalResult := mrOk;
  end
  else
  begin
    Application.MessageBox('Usuário e/ou senha inválidos!. Verifique.', 'Atenção', MB_OK + MB_ICONWARNING);
    buttonEditSenha.SetFocus;
    Inc(iConta);
    if iConta > 3 then
    begin
      ModalResult := mrCancel;
    end;
  end;
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
  iConta := 1;
end;

function Tview_login.Login(sUsuario, sSenha: String): boolean;
var
  login: TRESTLoginController;
begin
  try
    Result := False;
    login := TRESTLoginController.Create;
    if not login.ValidaLogin(sUsuario, sSenha) then
    begin
      Exit;
    end;
    if not LoginAgente(Global.Parametros.pUser_ID) then
     begin
       Exit;
     end;
    Result := True;
  finally
    login.Free;
  end;
end;

function Tview_login.LoginAgente(iUsuario: integer): Boolean;
var
  loginAgente : TRESTLoginAgenteController;
begin
  try
    Result := False;
    loginAgente := TRESTLoginAgenteController.Create;
    if not loginAgente.RetornaAgente(iUsuario) then
    begin
      Application.MessageBox('Usuário não está vinculado a uma base.', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;
    Result := True;
  finally
    loginAgente.Free;
  end;
end;

end.
