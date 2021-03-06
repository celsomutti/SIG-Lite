unit Controller.RESTLancamentos;

interface

uses Model.RESTLancamentos;

type
  TRESTLancamentosController = class
  private
    FExtratos: TRESTLancamentos;
  public
    constructor Create;
    destructor Destroy; override;
    function SearchLancamentosExtrato(sextrato: String): Boolean;
  end;

implementation

{ TRESTLancamentosController }

constructor TRESTLancamentosController.Create;
begin
  FExtratos := TRESTLancamentos.Create;
end;

destructor TRESTLancamentosController.Destroy;
begin
  FExtratos.Free;
  inherited;
end;

function TRESTLancamentosController.SearchLancamentosExtrato(sextrato: String): Boolean;
begin
  Result := FExtratos.SearchLancamentosExtrato(sextrato);
end;

end.
