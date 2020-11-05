unit Controller.RESTLogin;

interface

uses Model.RESTLogin;

type
  TRESTLoginController = class
  private
    FLogin: TRESTLogin;
  public
    constructor Create;
    destructor Destroy; override;
    function UsuarioAtivo(sUsername: String): boolean;
    function CPFExiste(sCPF: String): Boolean;
    function ValidaLogin(sUsername: String; sPassword: String): Boolean;
    function CodigoUsuario(sCPF: String): Integer;
  end;

implementation

{ TRESTLoginController }

function TRESTLoginController.CodigoUsuario(sCPF: String): Integer;
begin
  Result := FLogin.CodigoUsuario(sCPF);
end;

function TRESTLoginController.CPFExiste(sCPF: String): Boolean;
begin
  Result := FLogin.CPFExiste(sCPF);
end;

constructor TRESTLoginController.Create;
begin
  FLogin := TRESTLogin.Create;
end;

destructor TRESTLoginController.Destroy;
begin
  FLogin.Free;
  inherited;
end;

function TRESTLoginController.UsuarioAtivo(sUsername: String): boolean;
begin
  Result := FLogin.UsuarioAtivo(sUsername);
end;

function TRESTLoginController.ValidaLogin(sUsername, sPassword: String): Boolean;
begin
  Result := FLogin.ValidaLogin(sUsername, sPassword);
end;

end.
