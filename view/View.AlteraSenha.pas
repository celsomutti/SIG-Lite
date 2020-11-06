unit View.AlteraSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxClasses, dxLayoutContainer, dxLayoutControl, System.Actions, Vcl.ActnList, cxContainer, cxEdit,
  dxLayoutcxEditAdapters, cxTextEdit, cxMaskEdit, cxButtonEdit, dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  Controller.RESTCadastro;

type
  Tview_AlteraSenha = class(TForm)
    layoutControlPadraoGroup_Root: TdxLayoutGroup;
    layoutControlPadrao: TdxLayoutControl;
    actionListAlteraSenha: TActionList;
    buttonEditNovaSenha: TcxButtonEdit;
    layoutItemButtonEditNovaSenha: TdxLayoutItem;
    buttonEditConfirmaSenha: TcxButtonEdit;
    layoutItemConfirmaSenha: TdxLayoutItem;
    actionGravar: TAction;
    actionCancelar: TAction;
    buttonGravar: TcxButton;
    layoutItemButtonGravar: TdxLayoutItem;
    buttonCancelar: TcxButton;
    layoutItemButtonCancelar: TdxLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    procedure buttonEditNovaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure buttonEditConfirmaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure actionGravarExecute(Sender: TObject);
    procedure actionCancelarExecute(Sender: TObject);
  private
    { Private declarations }
    function GravaSenha(): boolean;
    function ValidaSenha(): boolean;
  public
    { Public declarations }
  end;

var
  view_AlteraSenha: Tview_AlteraSenha;

implementation

{$R *.dfm}

uses dm.SIGLite, Global.Parametros;

procedure Tview_AlteraSenha.actionCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tview_AlteraSenha.actionGravarExecute(Sender: TObject);
begin
  if not ValidaSenha() then Exit;

  if Application.MessageBox('Confirma a alteração da senha ?', 'Alterar a senha', MB_YESNO + MB_ICONQUESTION) = IDNO then Exit;

  if GravaSenha() then
  begin
    Application.MessageBox('Senha alterada com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);
    ModalResult := mrOk;
  end;
end;

procedure Tview_AlteraSenha.buttonEditConfirmaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
if buttonEditConfirmaSenha.Properties.EchoMode = eemNormal then
  begin
    buttonEditConfirmaSenha.Properties.EchoMode := eemPassword;
  end
  else
  begin
    buttonEditConfirmaSenha.Properties.EchoMode := eemNormal
  end;
end;

procedure Tview_AlteraSenha.buttonEditNovaSenhaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if buttonEditNovaSenha.Properties.EchoMode = eemNormal then
  begin
    buttonEditNovaSenha.Properties.EchoMode := eemPassword;
  end
  else
  begin
    buttonEditNovaSenha.Properties.EchoMode := eemNormal
  end;
end;

function Tview_AlteraSenha.GravaSenha: boolean;
var
  FCadastro : TRESTCadastroController;
begin
  try
    Result := False;
    FCadastro := TRESTCadastroController.Create;
    if not FCadastro.AlteraSenha(buttonEditNovaSenha.Text, Global.Parametros.pUser_ID.ToString) then
    begin
      Application.MessageBox('Ocorreu um problema na alteração da senha!', 'Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;
    Result := True;
  finally
    FCadastro.Free;
  end;
end;

function Tview_AlteraSenha.ValidaSenha: boolean;
begin
  Result := False;
  if buttonEditNovaSenha.Text = '' then
  begin
      Application.MessageBox('Informe a nova senha!', 'Atenção', MB_OK + MB_ICONWARNING);
      buttonEditNovaSenha.SetFocus;
      Exit;
  end;
    if buttonEditConfirmaSenha.Text = '' then
  begin
      Application.MessageBox('Confirme a nova senha!', 'Atenção', MB_OK + MB_ICONWARNING);
      buttonEditConfirmaSenha.SetFocus;
      Exit;
  end;

  if buttonEditConfirmaSenha.Text <> buttonEditNovaSenha.Text then
  begin
      Application.MessageBox('Nova senha e confirmação não conferem!', 'Atenção', MB_OK + MB_ICONWARNING);
      buttonEditConfirmaSenha.SetFocus;
      Exit;
  end;
  Result := True;
end;

end.
