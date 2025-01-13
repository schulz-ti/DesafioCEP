unit core.viacep.data;

interface

uses
  System.Generics.Collections;

type
  TTipoPesquisa = (tpJSON, tpXML);

  TTipoChave = (tcCEP, tcEnderecoCompleto);

  TViaCEPData = class
  private
    FLogradouro: string;
    FIBGE: string;
    FBairro: string;
    FUF: string;
    FCEP: string;
    FLocalidade: string;
    FComplemento: string;
    FGIA: string;
    FDDD: string;
  public
    property CEP: string read FCEP write FCEP;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Localidade: string read FLocalidade write FLocalidade;
    property UF: string read FUF write FUF;
    property IBGE: string read FIBGE write FIBGE;
    property GIA: string read FGIA write FGIA;
    property DDD: string read FDDD write FDDD;
  end;

  TListaViaCEPData = TList<TViaCEPData>;

implementation

end.
