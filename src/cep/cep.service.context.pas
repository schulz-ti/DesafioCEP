unit cep.service.context;

interface

uses
  cep.enumerator,
  cep.model.interfaces,
  cep.service.interfaces;

type
  TCEPService = class(TInterfacedObject, ICEPServiceContext)
  strict private
    constructor create;
  private
    FStrategy : ICEPServiceStrategy;
    FModel : ICEPModel;
    FCep : string;
    FUf : string;
    FLocalidade : string;
    FLogradouro : string;
    FTipoPesquisa : TTipoPesquisaEnu;
    FTipoChave : TTipoChaveEnu;
  public
    class function New: ICEPServiceContext;

    function Model(value : ICEPModel):ICEPServiceContext;
    function Cep(value: string):ICEPServiceContext;
    function UF(value: string):ICEPServiceContext;
    function Localidade(value: string):ICEPServiceContext;
    function Logradouro(value: string):ICEPServiceContext;
    function TipoPesquisa(value: TTipoPesquisaEnu):ICEPServiceContext;
    function TipoChave(value: TTipoChaveEnu):ICEPServiceContext;
    function Execute: Boolean;
  end;

implementation

uses
  cep.service.pesquisarcep.ws,
  cep.service.pesquisarendereco.ws;

{ TCEPService }

function TCEPService.Cep(value: string): ICEPServiceContext;
begin
  Result := Self;
  FCep := value;
end;

constructor TCEPService.create;
begin

end;

function TCEPService.Execute: Boolean;
begin
  case FTipoChave of
    tCEP: FStrategy := TCEPServicePesquisarCEPWS.New;
    tEndereco: FStrategy := TCEPServicePesquisarEnderecoWS.New;
  end;

  Result :=
    FStrategy
      .Model(FModel)
      .TipoPesquisa(FTipoPesquisa)
      .Cep(FCep)
      .UF(FUf)
      .Localidade(FLocalidade)
      .Logradouro(FLogradouro)
      .Pesquisar;
end;

function TCEPService.Localidade(value: string): ICEPServiceContext;
begin
  Result := Self;
  FLocalidade := value;
end;

function TCEPService.Logradouro(value: string): ICEPServiceContext;
begin
  Result := Self;
  FLogradouro := value;
end;

function TCEPService.Model(value: ICEPModel): ICEPServiceContext;
begin
  Result := Self;
  FModel := value;
end;

class function TCEPService.New: ICEPServiceContext;
begin
  Result := Self.Create;
end;

function TCEPService.TipoChave(value: TTipoChaveEnu): ICEPServiceContext;
begin
  Result := self;
  FTipoChave := value;
end;

function TCEPService.TipoPesquisa(value: TTipoPesquisaEnu): ICEPServiceContext;
begin
  Result := Self;
  FTipoPesquisa := value;
end;

function TCEPService.UF(value: string): ICEPServiceContext;
begin
  Result := Self;
  FUf := value;
end;

end.
