unit cep.controller.interfaces;

interface

uses
  cep.enumerator;

type
  ICEPController = interface
    ['{BE3E1510-4A94-4890-B017-50CAB658E961}']
    function DataSource(value : TObject):ICEPController;
    function Cep(value: string):ICEPController;
    function UF(value: string):ICEPController;
    function Localidade(value: string):ICEPController;
    function Logradouro(value: string):ICEPController;
    function TipoPesquisa(value: TTipoPesquisaEnu):ICEPController;
    function TipoChave(value: TTipoChaveEnu):ICEPController;
    function Pesquisar:Boolean;
  end;

implementation

end.
