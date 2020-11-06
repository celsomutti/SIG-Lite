unit Model.RESTEntregadores;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTEntregadores = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function RetornaNomeEntregador(iEntregador: Integer): boolean;
    function CPFEntregador(sCPF: String): boolean;
    function RetornaCodigoEntregador(sCPF: String): Integer;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite, Global.Parametros;

{ TRESTLogin }

procedure TRESTEntregadores.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTEntregadores.StartRestRequest(sFile: String);
begin
  StartRestClient(sFile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTEntregadores.CPFEntregador(sCPF: String): boolean;
var
  jsonObj, jo: TJSONObject;
  jvAtivo: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/sl_cpf_entregador.php');
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
    jvAtivo := jsonObj.Get(9).JsonValue;
    sretorno := jvAtivo.Value;
    if StrToIntDef(sretorno,0) <> 1 then
    begin
      Exit;
    end;
  end
  else
  begin
    Exit;
  end;
  Result := True;
end;

function TRESTEntregadores.RetornaCodigoEntregador(sCPF: String): Integer;
var
  jsonObj, jo: TJSONObject;
  jvCodigo: TJSONValue;
  ja: TJSONArray;
  sretorno: string;
  iRetorno : integer;
begin
  Result  := 0;
  StartRestRequest('/sl_cpf_entregador.php');
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
    jvCodigo := jsonObj.Get(1).JsonValue;
    iRetorno := StrToIntDef(jvCodigo.Value,0);
  end
  else
  begin
    Exit;
  end;
  Result := iRetorno;
end;

function TRESTEntregadores.RetornaNomeEntregador(iEntregador: Integer): boolean;
var
  jsonObj, jo: TJSONObject;
  jvNome: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
begin
  Result  := False;
  StartRestRequest('/sl_entregadores.php');
  dm_SIGLite.RESTRequest.AddParameter('entregador', iEntregador.ToString, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Common.Params.paramNameUser := '';
    Exit;
  end;
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    jsonObj := (ja.Get(0) as TJSONObject);
    jvNome := jsonObj.Get(2).JsonValue;
    Common.Params.paramNameUser := jvNome.Value;
  end
  else
  begin
    Exit;
  end;
  Result := True;
end;

end.
