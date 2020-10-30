unit Controller.RESTPeriodos;

interface

uses Model.RESTPeriodos,System.Classes;

type
  TRESTPeriodosController = class
  private
    FPeriodo : TRESTPeriodos;
  public
    constructor Create;
    destructor Destroy; override;
    function RetornaPeriodos(): TStringList;
    function RetornaDias(iQuinzena: Integer): TStringList;
  end;

implementation

{ TRESTPeriodosController }

constructor TRESTPeriodosController.Create;
begin
  FPeriodo := TRESTPeriodos.Create;
end;

destructor TRESTPeriodosController.Destroy;
begin
  FPeriodo.Free;
  inherited;
end;

function TRESTPeriodosController.RetornaDias(iQuinzena: Integer): TStringList;
begin
  Result := FPeriodo.RetornaDias(iQuinzena);
end;

function TRESTPeriodosController.RetornaPeriodos(): TStringList;
begin
  Result := FPeriodo.RetornaPeriodos();
end;

end.
