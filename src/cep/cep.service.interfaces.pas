unit cep.service.interfaces;

interface

uses
  cep.enumerator,
  cep.model.interfaces;

type

  ICEPServiceStrategy = interface
    ['{8310BB71-A2A3-4C3C-AC46-46192B32F342}']
    function Model(value : ICEPModel):ICEPServiceStrategy;
    function Cep(value: string):ICEPServiceStrategy;
    function UF(value: string):ICEPServiceStrategy;
    function Localidade(value: string):ICEPServiceStrategy;
    function Logradouro(value: string):ICEPServiceStrategy;
    function TipoPesquisa(value: TTipoPesquisaEnu):ICEPServiceStrategy;
    function Pesquisar:Boolean;
  end;

  ICEPServiceContext = interface
    ['{01FA5501-005E-4CDD-BD46-E1CCFB85BEA7}']
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

end.
