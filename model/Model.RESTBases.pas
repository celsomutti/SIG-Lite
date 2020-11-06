unit Model.RESTBases;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTBases = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function RetornaNomeBase(iAgente: Integer): boolean;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite, Global.Parametros;

{ TRESTLogin }

procedure TRESTBases.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTBases.StartRestRequest(sFile: String);
begin
  StartRestClient(sFile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTBases.RetornaNomeBase(iAgente: Integer): boolean;
var
  jsonObj, jo: TJSONObject;
  jvNome: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/sl_Bases.php');
  dm_SIGLite.RESTRequest.AddParameter('agente', iagente.ToString, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Common.Params.paramNomeBase := '';
    Exit;
  end;
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    jsonObj := (ja.Get(0) as TJSONObject);
    jvNome := jsonObj.Get(2).JsonValue;
    Common.Params.paramNomeBase := jvNome.Value;
  end
  else
  begin
    Exit;
  end;
  Result := True;
end;

end.
