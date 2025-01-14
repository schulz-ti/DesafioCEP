unit cep.service.pesquisarcep.ws;

interface

uses
  System.Classes,
  System.SysUtils,

  cep.enumerator,
  cep.factory.interfaces,
  cep.model.interfaces,
  cep.service.interfaces;

type
  TCEPServicePesquisarCEPWS = class(TInterfacedObject, ICEPServiceStrategy)
  private
    FDataSource : TObject;
    FCEPModel : ICEPModel;
    FCep : string;
    FUf : string;
    FLocalidade : string;
    FLogradouro : string;
    FTipoPesquisa : TTipoPesquisaEnu;
  strict private
    constructor Create;
  private
    function RemoverAcentuacao(str: string): string;
  public
    destructor Destroy; override;

    class function New : ICEPServiceStrategy;

    function Model(value : ICEPModel):ICEPServiceStrategy;
    function Cep(value: string):ICEPServiceStrategy;
    function UF(value: string):ICEPServiceStrategy;
    function Localidade(value: string):ICEPServiceStrategy;
    function Logradouro(value: string):ICEPServiceStrategy;
    function TipoPesquisa(value: TTipoPesquisaEnu):ICEPServiceStrategy;
    function Pesquisar:Boolean;
  end;


implementation

uses
  cep.factory,
  core.viacep,
  core.viacep.data;

{ TCEPServicePesquisarCEPWS }

function TCEPServicePesquisarCEPWS.Cep(value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FCep := value;
end;

constructor TCEPServicePesquisarCEPWS.Create;
begin
  FCEPModel := TFactoryCEP.New.Model;

  FCep          := '';
  FUf           := '';
  FLocalidade   := '';
  FLogradouro   := '';
end;

destructor TCEPServicePesquisarCEPWS.Destroy;
begin

  inherited;
end;

function TCEPServicePesquisarCEPWS.Localidade(
  value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FLocalidade := value;
end;

function TCEPServicePesquisarCEPWS.Logradouro(
  value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FLogradouro := value;
end;

function TCEPServicePesquisarCEPWS.Model(
  value: ICEPModel): ICEPServiceStrategy;
begin
  Result := Self;
  FCEPModel := value;
end;

class function TCEPServicePesquisarCEPWS.New: ICEPServiceStrategy;
begin
  Result := Self.create;
end;

function TCEPServicePesquisarCEPWS.Pesquisar: Boolean;
var
  _viaCEP : TViaCEP;
  _posicao : Integer;
begin
  Result := False;

  try
    _viaCEP := TViaCEP.Create(nil);
    _viaCEP.TipoPesquisa := TTipoPesquisa(FTipoPesquisa.ToInteger);
    _viaCEP.TipoChave    := tcCEP;
    _viaCEP.CEP          := FCep.Replace('-', '');

    FCEPModel
      .Clear;

    if _viaCEP.Execute then
    begin
      Result := (not _viaCEP.Resultado.Cep.IsEmpty);

      FCEPModel
        .Cep( _viaCEP.Resultado.Cep )
        .UF( _viaCEP.Resultado.Uf )
        .Localidade( _viaCEP.Resultado.Localidade )
        .Logradouro( _viaCEP.Resultado.Logradouro )
        .Bairro( _viaCEP.Resultado.Bairro )
        .Complemento( _viaCEP.Resultado.Complemento )
        .Gravar;
    end;
  finally
    _viaCEP.Free;
  end;

end;

function TCEPServicePesquisarCEPWS.RemoverAcentuacao(str: string): string;
var
  x: Integer;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
begin
  for x := 1 to Length(Str) do
  begin
    if Pos(Str[x], ComAcento) <> 0 then
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  end;

  Result := Str;
end;

function TCEPServicePesquisarCEPWS.TipoPesquisa(
  value: TTipoPesquisaEnu): ICEPServiceStrategy;
begin
  Result := Self;
  FTipoPesquisa := value;
end;

function TCEPServicePesquisarCEPWS.UF(value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FUf := value;
end;

end.
