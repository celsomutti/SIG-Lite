unit Model.RESTCadastro;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTCadastro = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function SalvaCadastro(sCpfCnpj, sUserName, sName, sPassword, sEmail: String): boolean;
    function UsuarioExiste(sCPF: String): Boolean;
    function CPFValido(sCPF: string): boolean;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite;

{ TRESTCadastro }

procedure TRESTCadastro.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTCadastro.StartRestRequest(sFile: String);
begin
  StartRestClient(sFile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTCadastro.UsuarioExiste(sCPF: String): Boolean;
begin
  Result := False;
  StartRestRequest('/sl_cpf_existe.php');
  dm_SIGLite.RESTRequest.AddParameter('cpf', sCpf, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Active := False;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.RESTResponse.JSONText = 'false' then
  begin
    Exit;
  end;
  Result := True;
end;

function TRESTCadastro.CPFValido(sCPF: string): boolean;
var
  jsonObj, jo: TJSONObject;
  jvCodigo, jvNome, jvAtivo, jvCadastro: TJSONValue;
  ja: TJSONArray;
  i: integer;
begin
  Result := False;
  StartRestRequest('/sl_cpf_entregador.php');
  dm_SIGLite.RESTRequest.AddParameter('cpf', sCpf, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Active := False;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.RESTResponse.JSONText = 'false' then
  begin
    Exit;
  end;
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    jsonObj := (ja.Get(0) as TJSONObject);
    jvCodigo := jsonObj.Get(1).JsonValue;
    jvNome := jsonObj.Get(2).JsonValue;
    jvAtivo := jsonObj.Get(9).JsonValue;
    jvCadastro := jsonObj.Get(0).JsonValue;
    Common.Params.paramCodeDelivery := StrToIntDef(jvCodigo.Value, 0);
    Common.Params.paramCodigoCadastro := StrToIntDef(jvCadastro.Value, 0);
    Common.Params.paramNameUser := jvnome.Value;
    Common.Params.paramEntregadorAtivo := StrToIntDef(jvAtivo.Value, 0);
  end
  else
  begin
    Exit;
  end;
  Result := True;
end;

function TRESTCadastro.SalvaCadastro(sCpfCnpj, sUserName, sName, sPassword, sEmail: String): boolean;
begin
  Result := False;
  StartRestRequest('/sl_cadastra_usuario.php');
  dm_SIGLite.RESTRequest.AddParameter('cpf', sCpfCnpj, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('username', sUserName, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('name', sName, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('password', sPassword, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('email', sEmail, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Active := False;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.RESTResponse.JSONText = 'false' then
  begin
    Exit;
  end;
  Result := True;
end;

end.
