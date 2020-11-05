unit View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxClasses, dxLayoutContainer, dxLayoutControl, cxContainer, cxEdit, dxLayoutcxEditAdapters, cxLabel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, System.Actions, Vcl.ActnList, dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  Controller.RESTLogin, Controller.RESTLoginAgente, Common.Utils, Controller.RESTEntregadores, Controller.RESTCadastro;

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
    layoutGroupCadastro: TdxLayoutGroup;
    buttonEditCPF: TcxButtonEdit;
    layoutItemCPF: TdxLayoutItem;
    textEditNome: TcxTextEdit;
    layoutItemNome: TdxLayoutItem;
    textEditEMail: TcxTextEdit;
    layoutItemEMail: TdxLayoutItem;
    buttonEditNovaSenha: TcxButtonEdit;
    layoutItemNovaSenha: TdxLayoutItem;
    buttonEditConfirmaSenha: TcxButtonEdit;
    layoutItemConfirmacaoSenha: TdxLayoutItem;
    dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup;
    actionGravar: TAction;
    actionCancelarCadastro: TAction;
    buttonGravar: TcxButton;
    layoutItemButtonGravar: TdxLayoutItem;
    buttonCancelarUsuario: TcxButton;
    layoutItemButtonCancelarUsuario: TdxLayoutItem;
    dxLayoutAutoCreatedGroup3: TdxLayoutAutoCreatedGroup;
    labelCadastro: TcxLabel;
    layoutItemLabelCadastro: TdxLayoutItem;
    cxButton1: TcxButton;
    layoutItemCadastro: TdxLayoutItem;
    actionCadastro: TAction;
    procedure FormShow(Sender: TObject);
    procedure actionVisualizarSenhaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actionCancelarExecute(Sender: TObject);
    procedure actionEntrarExecute(Sender: TObject);
    procedure buttonEditCPFPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure actionCadastroExecute(Sender: TObject);
    procedure actionCancelarCadastroExecute(Sender: TObject);
    procedure actionGravarExecute(Sender: TObject);
    procedure buttonEditSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure buttonEditNovaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure buttonEditConfirmaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    function Login(sUsuario, sSenha: String): boolean;
    function LoginAgente(iUsuario: integer): Boolean;
    function ValidaCadastro(): Boolean;
    function ValidaCPF(sCPF: String): Boolean;
    function ValidaEntregadorAtivo(sCPF: String): boolean;
    function GravarUsuário(): Boolean;
  public
    { Public declarations }
  end;

var
  view_login: Tview_login;
  iConta: Integer;
implementation

{$R *.dfm}

uses dm.SIGLite, Common.Params, Global.Parametros;

procedure Tview_login.actionCadastroExecute(Sender: TObject);
begin
  layoutGroupCadastro.MakeVisible;
end;

procedure Tview_login.actionCancelarCadastroExecute(Sender: TObject);
begin
  layoutGroupLogin.MakeVisible;
end;

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
    buttonEditSenha.SetFocus;
    Inc(iConta);
    if iConta > 3 then
    begin
      ModalResult := mrCancel;
    end;
  end;
end;

procedure Tview_login.actionGravarExecute(Sender: TObject);
begin
  if not ValidaCadastro() then Exit;
  if Application.MessageBox('Confirma gravar os dados?','Gravar', MB_YESNO + MB_ICONQUESTION) = IDNO then Exit;
  if GravarUsuário() then
  begin
    Application.MessageBox('Cadastro realizado. Acesse com o seu CPF e senha.', 'Atenção', MB_OK + MB_ICONINFORMATION);
    layoutGroupLogin.MakeVisible;
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

procedure Tview_login.buttonEditConfirmaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if buttonEditConfirmaSenha.Properties.EchoMode = eemPassword then
  begin
    buttonEditConfirmaSenha.Properties.EchoMode := eemNormal;
  end
  else
  buttonEditConfirmaSenha.Properties.EchoMode := eemPassword;
end;

procedure Tview_login.buttonEditCPFPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if ValidaCPF(buttonEditCPF.Text) then
  begin
    Application.MessageBox('CPF já cadastrado!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
  end;
  if ValidaEntregadorAtivo(buttonEditCPF.Text) then
  begin
    Application.MessageBox('Entregador sem acesso ao sistema!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
  end;
end;

procedure Tview_login.buttonEditNovaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if buttonEditNovaSenha.Properties.EchoMode = eemPassword then
  begin
    buttonEditNovaSenha.Properties.EchoMode := eemNormal;
  end
  else
  buttonEditNovaSenha.Properties.EchoMode := eemPassword;
end;

procedure Tview_login.buttonEditSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if buttonEditSenha.Properties.EchoMode = eemPassword then
  begin
    buttonEditSenha.Properties.EchoMode := eemNormal;
  end
  else
  buttonEditSenha.Properties.EchoMode := eemPassword;
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

function Tview_login.GravarUsuário(): Boolean;
var
  FCadastro: TRESTCadastroController;
  FLogin: TRESTLoginController;
  FUsuarioAgente: TRESTLoginAgenteController;
  sCPF, sUsername, sName, sSenha, sEmail: String;
  iID: Integer;
begin
  try
    Result := False;
    FCadastro := TRESTCadastroController.Create;
    FLogin := TRESTLoginController.Create;
    FUsuarioAgente := TRESTLoginAgenteController.Create;
    sCPF := buttonEditCPF.Text;
    sUsername := buttonEditCPF.Text;
    sName := textEditNome.Text;
    sSenha := buttonEditNovaSenha.Text;
    sEmail := textEditEMail.Text;
    if not FCadastro.SalvaCadastro(sCPF,sUsername,sName,sSenha,sEmail) then
    begin
      Application.MessageBox('Ocorreu um problemna ao tentar gravar o usuário!', 'Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;
    iID := 0;
    iID := FLogin.CodigoUsuario(sCPF);
    if iID = 0 then
    begin
      Application.MessageBox('CPF de usuário não encontrado!', 'Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;
    if not FUsuarioAgente.GravaUsuarioEntregador(iID.ToString,Common.Params.paramCodigoEntregador.ToString) then
    begin
      Application.MessageBox('Ocorreu um problemna ao tentar vincular o usuário ao entregador!', 'Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;
    Result := True;
  finally
    FCadastro.Create;
  end;
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
      Application.MessageBox('Usuário e/ou senha inválidos!. Verifique.', 'Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;
    if Common.Params.paramUsuarioAtivo <> 'S' then
    begin
      Application.MessageBox('Usuário está inativo.', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
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
      Application.MessageBox('Usuário não está vinculado a uma base ou entregador.', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;
    Result := True;
  finally
    loginAgente.Free;
  end;
end;

function Tview_login.ValidaCadastro: Boolean;
begin
  Result := False;
  if buttonEditCPF.Text = '' then
  begin
    Application.MessageBox('Informe o seu CPF!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditCPF.SetFocus;
    Exit;
  end;
  if not Common.Utils.TUtils.CPF(buttonEditCPF.Text) then
  begin
    Application.MessageBox('CPF inválido!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditCPF.SetFocus;
    Exit;
  end;
  if ValidaEntregadorAtivo(buttonEditCPF.Text) then
  begin
    Application.MessageBox('Entregador sem acesso ao sistema!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditCPF.SetFocus;
    Exit;
  end;
  if ValidaCPF(buttonEditCPF.Text) then
  begin
    Application.MessageBox('CPF já cadastrado!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditCPF.SetFocus;
    Exit;
  end;
  if textEditNome.Text = '' then
  begin
    Application.MessageBox('Informe o seu Nome Completo!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    textEditNome.SetFocus;
    Exit;
  end;
  if textEditEMail.Text = '' then
  begin
    Application.MessageBox('Informe o seu Endereço de E-Mail!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    textEditEMail.SetFocus;
    Exit;
  end;
  if not Common.Utils.TUtils.ValidaEMail(PChar(textEditEMail.Text)) then
  begin
    Application.MessageBox('Endereço de E-Mail inválido!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    textEditEMail.SetFocus;
    Exit;
  end;
  if buttonEditNovaSenha.Text = '' then
  begin
    Application.MessageBox('Informe uma senha!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditNovaSenha.SetFocus;
    Exit;
  end;
    if buttonEditConfirmaSenha.Text = '' then
  begin
    Application.MessageBox('Confirme a senha!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditConfirmaSenha.SetFocus;
    Exit;
  end;
  if buttonEditNovaSenha.Text <> buttonEditConfirmaSenha.Text then
  begin
    Application.MessageBox('Senha e confirmação não conferem!', 'Atenção', MB_OK + MB_ICONEXCLAMATION);
    buttonEditNovaSenha.SetFocus;
    Exit;
  end;
  Result := True;
end;

function Tview_login.ValidaCPF(sCPF: String): Boolean;
var
  FLogin: TRESTLoginController;
begin
  try
    Result := False;
    FLogin := TRESTLoginController.Create;
    if not FLogin.CPFExiste(sCPF) then
    begin
      Exit;
    end;
    Result := True;
  finally
    FLogin.Free;
  end;
end;

function Tview_login.ValidaEntregadorAtivo(sCPF: String): boolean;
var
  FEntregador: TRESTEntregadoresController;
begin
  try
    Result := False;
    FEntregador := TRESTEntregadoresController.Create;
    if not FEntregador.CPFEntregador(sCPF) then
    begin
      Exit;
    end;
    Result := True;
  finally
    FEntregador.Free;
  end;
end;

end.
