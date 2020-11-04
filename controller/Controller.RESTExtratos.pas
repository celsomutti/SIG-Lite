unit Controller.RESTExtratos;

interface

uses Model.RESTExtrato;

type
  TRESTExtratosController = class
  private
    FExtratos: TRESTExtrato;
  public
    constructor Create;
    destructor Destroy; override;
    function SearchExtrato(sTipo, sCodigo, sAno, sMes, sQuinzena: String): Boolean;
  end;

implementation

{ TRESTExtratosController }

constructor TRESTExtratosController.Create;
begin
  FExtratos := TRESTExtrato.Create;
end;

destructor TRESTExtratosController.Destroy;
begin
  FExtratos.Free;
  inherited;
end;

function TRESTExtratosController.SearchExtrato(sTipo, sCodigo, sAno, sMes, sQuinzena: String): Boolean;
begin
  Result := FExtratos.SearchExtrato(sTipo, sCodigo, sAno, sMes, sQuinzena);
end;

end.
