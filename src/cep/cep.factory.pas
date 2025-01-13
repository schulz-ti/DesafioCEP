unit cep.factory;

interface

uses
  System.Classes,
  System.SysUtils,

  cep.factory.interfaces,
  cep.controller.interfaces,
  cep.model.interfaces,
  cep.service.interfaces;

type
  TFactoryCep = class(TInterfacedObject, IFactoryCep)
  strict private
    constructor Create;
  public
    destructor Destroy; override;

    class function New : IFactoryCep;

    function Controller: ICEPController;
    function Model: ICEPModel;
    function Service: ICEPServiceContext;
  end;

implementation

uses
  cep.controller,
  cep.model,
  cep.service.context;

{ TFactoryCep }

function TFactoryCep.Controller: ICEPController;
begin
  Result := TCEPController.New;
end;

constructor TFactoryCep.Create;
begin

end;

destructor TFactoryCep.Destroy;
begin

  inherited;
end;

function TFactoryCep.Model: ICEPModel;
begin
  Result := TCEPModel.New;
end;

class function TFactoryCep.New: IFactoryCep;
begin
  Result := Self.Create;
end;

function TFactoryCep.Service: ICEPServiceContext;
begin
  Result := TCEPService.New;
end;

end.
