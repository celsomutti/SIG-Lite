unit Controller.RESTLoginAgente;

interface

uses Model.RESTLoginAgente;

type
  TRESTLoginAgenteController = class
  private
    FLogin: TRESTLoginAgente;
  public
    constructor Create;
    destructor Destroy; override;
    function RetornaAgente(iUsuario: integer): Boolean;
  end;

implementation

{ TRESTLoginAgenteController }

constructor TRESTLoginAgenteController.Create;
begin
  FLogin := TRESTLoginAgente.Create;
end;

destructor TRESTLoginAgenteController.Destroy;
begin
  FLogin.Free;
  inherited;
end;

function TRESTLoginAgenteController.RetornaAgente(iUsuario: integer): Boolean;
begin
  Result := FLogin.RetornaAgente(iUsuario);
end;

end.
