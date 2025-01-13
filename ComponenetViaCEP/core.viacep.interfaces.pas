unit core.viacep.interfaces;

interface

uses
  core.viacep.data;

type
  IViaCEPService = interface
    ['{47D65A6B-4D54-4893-8A7F-BF5216158480}']
    function TipoChave(value: TTipoChave):IViaCEPService;
    function Data(value : TListaViaCEPData):IViaCEPService;
    function CEP(Value: string):IViaCEPService;
    function UF(Value: string):IViaCEPService;
    function Localidade(Value: string):IViaCEPService;
    function Logradouro(Value: string):IViaCEPService;
    function Execute:Boolean;
  end;

implementation

end.
