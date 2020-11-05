unit Model.RESTUsuarios;

interface

uses
  Web.HTTPApp, System.JSON, REST.Types, System.SysUtils, System.Classes;

  type
    TRESTUsuarios = class
    private
      FEMail: String;
      FAtivo: String;
      FExecutor: String;
      FCodigo: integer;
      FDiasExpira: Integer;
      FDataSenha: TDate;
      FNivel: Integer;
      FPrivilegio: String;
      FSenha: String;
      FManutencao: TDateTime;
      FPrimeiroAcesso: String;
      FLogin: String;
      FExpira: String;
      FNome: String;
      FGrupo: Integer;
      procedure StartRestClient(sFile: String);
      procedure StartRestRequest;
      procedure PopuleUsersModel(orow: TJSONObject);
    public
      property Codigo: integer read FCodigo write FCodigo;
      property Nome: String read FNome write FNome;
      property Login: String read FLogin write FLogin;
      property EMail: String read FEMail write FEMail;
      property Senha: String read FSenha write FSenha;
      property Grupo: Integer read FGrupo write FGrupo;
      property Privilegio: String read FPrivilegio write FPrivilegio;
      property Expira: String read FExpira write FExpira;
      property DiasExpira: Integer read FDiasExpira write FDiasExpira;
      property PrimeiroAcesso: String read FPrimeiroAcesso write FPrimeiroAcesso;
      property Ativo: String read FAtivo write FAtivo;
      property DataSenha: TDate read FDataSenha write FDataSenha;
      property Nivel: Integer read FNivel write FNivel;
      property Executor: String read FExecutor write FExecutor;
      property Manutencao: TDateTime read FManutencao write FManutencao;
      function ValidaLogin(sUsername: String; sPassword: String): Boolean;
    end;
const
  API = '/api/SIGLite';

implementation

{ TRESTUsuarios }

uses Common.Params, dm.SIGLite;

procedure TRESTUsuarios.PopuleUsersModel(orow: TJSONObject);
begin
  FCodigo := orow.GetValue('COD_USUARIO').Value.ToInteger;
  FNome := orow.GetValue('NOM_USUARIO').Value;
  FLogin := orow.GetValue('DES_LOGIN').Value;
  FEMail := orow.GetValue('DES_EMAIL').Value;
  FSenha := orow.GetValue('DES_SENHA').Value;
  FGrupo := orow.GetValue('COD_GRUPO').Value.ToInteger;
  FPrivilegio := orow.GetValue('DOM_PRIVILEGIO').Value;
  FExpira := orow.GetValue('DOM_EXPIRA').Value;
  FDiasExpira := orow.GetValue('QTD_DIAS_EXPIRA').Value.ToInteger;
  FPrimeiroAcesso := orow.GetValue('DOM_PRIMEIRO_ACESSO').Value;
  FAtivo :=  orow.GetValue('DOM_ATIVO').Value;
  FDataSenha := StrToDate(orow.GetValue('DAT_SENHA').Value);
  FNivel := orow.GetValue('COD_NIVEL').Value.ToInteger;
  FExecutor := orow.GetValue('NOM_EXECUTOR').Value;
  FManutencao := StrToDateTime(orow.GetValue('DAT_MANUTENCAO').Value);
end;

procedure TRESTUsuarios.StartRestClient(sFile: String);
begin
  dm_SIGLite.RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  dm_SIGLite.RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
  dm_SIGLite.RESTClient.BaseURL := Common.Params.paramBaseURL + API + sFile;
  dm_SIGLite.RESTClient.RaiseExceptionOn500 := False;
end;

procedure TRESTUsuarios.StartRestRequest;
begin
  StartRestClient('/sl_cadastra_usuario.php');
  dm_SIGLite.RESTRequest.Client := dm_SIGLite.RESTClient;
  dm_SIGLite.RESTRequest.Accept := dm_SIGLite.RESTClient.Accept;
  dm_SIGLite.RESTRequest.AcceptCharset := dm_SIGLite.RESTClient.AcceptCharset;
  dm_SIGLite.RESTRequest.Method := rmPOST;
end;

function TRESTUsuarios.ValidaLogin(sUsername, sPassword: String): Boolean;
var
  oretorno: TJSONArray;
  sretorno: string;
  orow : TJSONObject;
begin
  Result  := False;
  StartRestRequest;
  dm_SIGLite.RESTRequest.AddParameter('username', sUserName, pkGETorPOST);
  dm_SIGLite.RESTRequest.AddParameter('password', sPassword, pkGETorPOST);
  dm_SIGLite.RESTRequest.Execute;
  sretorno := dm_SIGLite.RESTRequest.Response.JSONText;
  if sretorno = 'false' then
  begin
    Exit;
  end;
  oretorno := dm_SIGLite.RESTRequest.Response.JSONValue as TJSONArray;
  orow := oretorno.Items[0] as TJSONObject;
  PopuleUsersModel(orow);
  Result := True;
end;

end.
