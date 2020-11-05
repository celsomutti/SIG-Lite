unit Model.RESTLogin;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTLogin = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function UsuarioAtivo(sUsername: String): boolean;
    function CPFExiste(sCPF: String): Boolean;
    function ValidaLogin(sUsername: String; sPassword: String): Boolean;
    function CodigoUsuario(sCPF: String): Integer;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite, Global.Parametros;

{ TRESTLogin }

function TRESTLogin.CodigoUsuario(sCPF: String): Integer;
var
  jsonObj, jo: TJSONObject;
  jvID: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
begin
  Result  := 0;
  StartRestRequest('/sl_usuarios.php');
  dm_SIGLite.RESTRequest.AddParameter('cpf', sCPF, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Exit;
  end;
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    jsonObj := (ja.Get(0) as TJSONObject);
    jvID := jsonObj.Get(0).JsonValue;
    i := StrToIntDef(jvID.Value,0);
  end
  else
  begin
    Exit;
  end;
  Result := i;
end;

function TRESTLogin.CPFExiste(sCPF: String): Boolean;
var
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/sl_cpf_existe.php');
  dm_SIGLite.RESTRequest.AddParameter('cpf', sCPF, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Exit;
  end;
  Result := True;
end;

procedure TRESTLogin.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTLogin.StartRestRequest(sFile: String);
begin
  StartRestClient(sFile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTLogin.UsuarioAtivo(sUsername: String): boolean;
var
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/dc_usuario_ativo.php');
  dm_SIGLite.RESTRequest.AddParameter('cpf', sUserName, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Exit;
  end;
  Result := True;
end;

function TRESTLogin.ValidaLogin(sUsername, sPassword: String): Boolean;
var
  jsonObj, jo: TJSONObject;
  jvID, jvNome, jvLogin, jvEMail, jvSenha, jvAtivo: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/sl_login.php');
  dm_SIGLite.RESTRequest.AddParameter('username', sUserName, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('password', sPassword, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Exit;
  end;
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    jsonObj := (ja.Get(0) as TJSONObject);
    jvID := jsonObj.Get(0).JsonValue;
    jvNome := jsonObj.Get(1).JsonValue;
    jvLogin := jsonObj.Get(2).JsonValue;
    jvEMail := jsonObj.Get(3).JsonValue;
    jvSenha := jsonObj.Get(4).JsonValue;
    jvAtivo := jsonObj.Get(10).JsonValue;
    Global.Parametros.pUser_ID := StrToIntDef(jvID.Value,0);
    Global.Parametros.pNameUser := jvNome.Value;
    Common.Params.paramNameUser := jvNome.Value;
    Global.Parametros.pUser_Name := jvLogin.Value;
    Common.Params.paramUserName := jvNome.Value;
    Global.Parametros.pEmailUsuario := jvEMail.Value;
    Common.Params.paramEMailEntregador := jvEMail.Value;
    Global.Parametros.pPassword := jvSenha.Value;
    Common.Params.paramUsuarioAtivo := jvAtivo.Value;
  end
  else
  begin
    Exit;
  end;
  Result := True;
end;

end.
