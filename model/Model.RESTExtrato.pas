unit Model.RESTExtrato;

interface

uses Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

type
  TRESTExtrato = class
  private
    procedure StartRestClient(sFile: String);
    procedure StartRestRequest;
  public
    function SearchExtrato(sTipo, sCodigo, sAno, sMes, sQuinzena: String): Boolean;
  end;
const

 API = '/api/SIGLite';

implementation

uses Common.Params, dm.SIGLite;

{ TRESTExtrato }

procedure TRESTExtrato.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTExtrato.StartRestRequest;
begin
  StartRestClient('/sl_extrato.php');
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTExtrato.SearchExtrato(sTipo, sCodigo, sAno, sMes, sQuinzena: String): Boolean;
var
  sResult : String;
begin
  Result  := False;
  StartRestRequest;
  dm_SIGLite.RESTResponseDataSetAdapter.Dataset := dm_SIGLite.memTableExtrato;
  dm_SIGLite.RESTRequest.AddParameter('tipo', sTipo, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('codigo', sCodigo, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('ano', sAno, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('mes', sMes, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('quinzena', sQuinzena, pkGETorPOST);
  dm_SIGLite.RESTResponseDataSetAdapter.Dataset := dm_SIGLite.memTableExtrato;
  dm_SIGLite.RESTResponseDataSetAdapter.Active := True;
  dm_SIGLite.RESTRequest.Execute;
  if dm_SIGLite.memTableExtrato.IsEmpty then Exit;
  sResult := dm_SIGLite.memTableExtrato.Fields[0].Value;
  if sResult = 'False' then
  begin
    Exit;
  end;
  Result := True;
end;

end.
