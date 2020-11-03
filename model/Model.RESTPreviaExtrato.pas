unit Model.RESTPreviaExtrato;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTPreviaExtrato = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest;
  public
    function SearchEntregas(sTipo, scodigo, sdataini, sdatafim: String): Boolean;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite, Global.Parametros;

{ TRESTPreviaExtrato }

procedure TRESTPreviaExtrato.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTPreviaExtrato.StartRestRequest;
begin
  StartRestClient('/sl_extrato_previo.php');
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTPreviaExtrato.SearchEntregas(stipo, scodigo, sdataini, sdatafim: String): Boolean;
var
  sResult : String;
begin
  Result  := False;
  StartRestRequest;
  dm_SIGLite.RESTResponseDataSetAdapter.Dataset := dm_SIGLite.fdMemTabEntregas;
  dm_SIGLite.RESTRequest.AddParameter('tipo', stipo, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('codigo', scodigo, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('dataini', sdataini, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('datafim', sdatafim, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Dataset := dm_SIGLite.fdMemTableExtrato;
  dm_SIGLite.RESTResponseDataSetAdapter.Active := True;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.fdMemTableExtrato.IsEmpty then Exit;
  sResult := dm_SIGLite.fdMemTableExtrato.Fields[0].Value;
  if sResult = 'False' then
  begin
    Exit;
  end;
  Result := True;
end;

end.
