unit Controller.RESTBases;

interface

uses Model.RESTBases;

type
  TRESTBasesController = class
  private
    FBase : TRESTBases;
  public
    constructor Create;
    destructor Destroy; override;
    function RetornaNomeBase(iAgente: Integer): boolean;
  end;

implementation

{ TTRESTBasesController }

constructor TRESTBasesController.Create;
begin
  FBase := TRESTBases.Create;
end;

destructor TRESTBasesController.Destroy;
begin
  FBase.Free;
  inherited;
end;

function TRESTBasesController.RetornaNomeBase(iAgente: Integer): boolean;
begin
  Result := FBase.RetornaNomeBase(iAgente);
end;

end.
