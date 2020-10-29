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
  end;

implementation

{ TTRESTBasesController }

constructor TRESTEntregadoresController.Create;
begin
  FEntregadores := TRESTEntregadores.Create;
end;

destructor TRESTEntregadoresController.Destroy;
begin
  FEntregadores.Free;
  inherited;
end;

function TRESTEntregadoresController.RetornaNomeEntregador(iEntregador: Integer): boolean;
begin
  Result := FEntregadores.RetornaNomeEntregador(iEntregador);
end;
end.
