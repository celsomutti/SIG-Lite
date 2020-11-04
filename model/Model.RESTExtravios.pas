unit Model.RESTExtravios;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTExtravios = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest(sFile: String);
  public
    function SearchExtraviosExtrato(sextrato: String): Boolean;
  end;
const
  API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite;

{ TRESTExtravios }

function TRESTExtravios.SearchExtraviosExtrato(sextrato: String): Boolean;
var
  sResult : String;
begin
  Result  := False;
  StartRestRequest('/sl_extravios.php');
  dm_SIGLite.RESTResponseDataSetAdapter.Dataset := dm_SIGLite.memTableExtravios;
  dm_SIGLite.RESTRequest.AddParameter('extratos', sextrato, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Dataset := dm_SIGLite.memTableExtravios;
  dm_SIGLite.RESTResponseDataSetAdapter.Active := True;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.memTableExtravios.IsEmpty then Exit;
  sResult := dm_SIGLite.memTableExtravios.Fields[0].Value;
  if sResult = 'False' then
  begin
    Exit;
  end;
  Result := True;
end;

procedure TRESTExtravios.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTExtravios.StartRestRequest(sFile: String);
begin
  StartRestClient(sfile);
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

end.
