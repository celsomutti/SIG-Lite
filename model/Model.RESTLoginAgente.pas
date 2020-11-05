unit Model.RESTLoginAgente;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTLoginAgente = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function RetornaAgente(iUsuario: integer): boolean;
    function GravaUsuarioEntregador(sID, sCodigo: String): boolean;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite, Global.Parametros;

{ TRESTLoginAgente }

procedure TRESTLoginAgente.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTLoginAgente.StartRestRequest(sFile: String);
begin
  StartRestClient(sFile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTLoginAgente.GravaUsuarioEntregador(sID, sCodigo: String): boolean;
begin
  Result := False;
  StartRestRequest('/sl_cadastra_usuario_entregador.php');
  dm_SIGLite.RESTRequest.AddParameter('id', sID, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('codigo', sCodigo, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Active := False;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.RESTResponse.JSONText = 'false' then
  begin
    Exit;
  end;
  Result := True;
end;

function TRESTLoginAgente.RetornaAgente(iUsuario: integer): Boolean;
var
  jsonObj, jo: TJSONObject;
  jvAgente: TJSONValue;
  jvEntregador: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/sl_login_agente.php');
  dm_SIGLite.RESTRequest.AddParameter('usuario', iUsuario.toString, pkGETorPOST);
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
    jvAgente := jsonObj.Get(2).JsonValue;
    jvEntregador := jsonObj.Get(3).JsonValue;
    Common.Params.paramCodeDelivery := StrToIntDef(jvAgente.value,0);
    Common.Params.paramCodigoEntregador := StrToIntDef(jvEntregador.value,0);
  end
  else
  begin
    Exit;
  end;
  Result := True;
end;

end.
