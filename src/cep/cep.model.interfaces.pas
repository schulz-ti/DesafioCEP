unit cep.model.interfaces;

interface

type
  ICEPModel = interface
    ['{8FFDB3F6-8ABE-4DC3-9591-383549BCD97C}']
    function DataSource(value : TObject):ICEPModel;
    function Cep(value: string):ICEPModel; overload;
    function UF(value: string):ICEPModel; overload;
    function Localidade(value: string):ICEPModel; overload;
    function Logradouro(value: string):ICEPModel; overload;
    function Codigo(value: string): ICEPModel; overload;
    function Complemento(value: string): ICEPModel; overload;
    function Bairro(value: string): ICEPModel; overload;
    function Codigo: string; overload;
    function Complemento: string; overload;
    function Bairro: string; overload;
    function Cep:string; overload;
    function UF:string; overload;
    function Localidade:string; overload;
    function Logradouro:string; overload;
    function PesquisarCEP:ICEPModel;
    function PesquisarEnderecoCompleto:ICEPModel;
    function Found: Boolean;
    function Gravar: Boolean;
    function LImparTmp:ICEPModel;
  end;

implementation

end.
