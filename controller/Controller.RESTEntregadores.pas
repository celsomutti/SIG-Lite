unit Controller.RESTEntregadores;

interface

uses Model.RESTEntregadores;

type
  TRESTEntregadoresController = class
  private
    FEntregadores : TRESTEntregadores;
  public
    constructor Create;
    destructor Destroy; override;
    function RetornaNomeEntregador(iEntregador: Integer): boolean;
    function CPFEntregador(sCPF: String): boolean;
    function RetornaCodigoEntregador(sCPF: String): Integer;
  end;

implementation

{ TTRESTBasesController }

function TRESTEntregadoresController.CPFEntregador(sCPF: String): boolean;
begin
    Result := FEntregadores.CPFEntregador(sCPF);
end;

constructor TRESTEntregadoresController.Create;
begin
  FEntregadores := TRESTEntregadores.Create;
end;

destructor TRESTEntregadoresController.Destroy;
begin
  FEntregadores.Free;
  inherited;
end;

function TRESTEntregadoresController.RetornaCodigoEntregador(sCPF: String): Integer;
begin
  Result := FEntregadores.RetornaCodigoEntregador(sCPF);
end;

function TRESTEntregadoresController.RetornaNomeEntregador(iEntregador: Integer): boolean;
begin
  Result := FEntregadores.RetornaNomeEntregador(iEntregador);
end;
end.
