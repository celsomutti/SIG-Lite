unit Controller.RESTPreviaExtrato;

interface

uses Model.RESTPreviaExtrato;

type
  TRESTPreviaExtratoController = class
  private
    FExtratos: TRESTPreviaExtrato;
  public
    constructor Create;
    destructor Destroy; override;
    function SearchEntregas(stipo, scodigo, sdataini, sdatafim: String): Boolean;
  end;

implementation

{ TRESTEntregassController }

constructor TRESTPreviaExtratoController.Create;
begin
  FExtratos := TRESTPreviaExtrato.Create;
end;

destructor TRESTPreviaExtratoController.Destroy;
begin
  FExtratos.Free;
  inherited;
end;

function TRESTPreviaExtratoController.SearchEntregas(stipo, scodigo, sdataini, sdatafim: String): Boolean;
begin
  Result := FExtratos.SearchEntregas(stipo, scodigo, sdataini, sdatafim);
end;

end.
