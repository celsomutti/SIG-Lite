unit Model.RESTPeriodos;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTPeriodos = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function RetornaPeriodos(): TStringList;
    function RetornaDias(iQuinzena: Integer): TStringList;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite, Global.Parametros;

{ TRESTPeriodos }

procedure TRESTPeriodos.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTPeriodos.StartRestRequest(sFile: String);
begin
  StartRestClient(sFile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTPeriodos.RetornaDias(iQuinzena: Integer): TStringList;
var
  jsonObj, jo: TJSONObject;
  jvInicio: TJSONValue;
  jvFinal: TJSONValue;
  ja: TJSONArray;
  sretorno: string;
  lLista: TStringList;
begin
  StartRestRequest('/sl_lista_quinzenas.php');
  dm_SIGLite.RESTRequest.AddParameter('quinzena', iQuinzena.toString, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  lLista := TStringList.Create;
  if sretorno = 'false' then
  begin
    lLista.Add(sretorno);
    Exit;
  end;
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    jsonObj := (ja.Get(0) as TJSONObject);
    jvInicio := jsonObj.Get(2).JsonValue;
    jvFinal := jsonObj.Get(3).JsonValue;
    lLista.Add(jvInicio.Value);
    lLista.Add(jvFinal.Value);
  end
  else
  begin
    Exit;
  end;
  Result := lLista;
end;

function TRESTPeriodos.RetornaPeriodos(): TStringList;
var
  jsonObj, jo: TJSONObject;
  jvID: TJSONValue;
  jvQuinzena: TJSONValue;
  jvInicio: TJSONValue;
  jvFinal: TJSONValue;
  jvRaio: TJSONValue;
  ja: TJSONArray;
  i: integer;
  sretorno: string;
  lLista: TStringList;
  sLinha: String;
begin
  StartRestRequest('/sl_lista_quinzenas.php');
  dm_SIGLite.RESTRequest.AddParameter('quinzena', '0', pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  lLista := TStringList.Create;
  if sretorno = 'false' then
  begin
    lLista.Add('Quinzenas não encontradas!');
    Exit;
  end;
  lLista.Add('Selecione ...');
  if dm_SIGLite.RESTResponse.JSONValue is TJSONArray then
  begin
    ja := dm_SIGLite.RESTResponse.JSONValue as TJSONArray;
    for i := 0 to ja.Count - 1 do
    begin
      jsonObj := (ja.Get(i) as TJSONObject);
      jvID := jsonObj.Get(0).JsonValue;
      jvQuinzena := jsonObj.Get(1).JsonValue;
      jvInicio := jsonObj.Get(2).JsonValue;
      jvFinal := jsonObj.Get(3).JsonValue;
      jvRaio := jsonObj.Get(4).JsonValue;
      sLinha := jvQuinzena.Value +  ' - De dia ' + jvInicio.Value + ' até o dia ' + jvFinal.Value;
      lLista.Add(sLinha)
    end;
  end
  else
  begin
    Exit;
  end;
  Result := lLista;
end;


end.
