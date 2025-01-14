unit cep.service.pesquisarendereco.ws;

interface

uses
  System.Classes,
  System.SysUtils,

  cep.enumerator,
  cep.factory.interfaces,
  cep.model.interfaces,
  cep.service.interfaces;

type
  TCEPServicePesquisarEnderecoWS = class(TInterfacedObject, ICEPServiceStrategy)
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

{ TCEPServicePesquisarEnderecoWS }

function TCEPServicePesquisarEnderecoWS.Cep(value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FCep := value;
end;

constructor TCEPServicePesquisarEnderecoWS.Create;
begin
  FCEPModel := TFactoryCEP.New.Model;

  FCep          := '';
  FUf           := '';
  FLocalidade   := '';
  FLogradouro   := '';
end;

destructor TCEPServicePesquisarEnderecoWS.Destroy;
begin

  inherited;
end;

function TCEPServicePesquisarEnderecoWS.Localidade(
  value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FLocalidade := value;
end;

function TCEPServicePesquisarEnderecoWS.Logradouro(
  value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FLogradouro := value;
end;

function TCEPServicePesquisarEnderecoWS.Model(
  value: ICEPModel): ICEPServiceStrategy;
begin
  Result := Self;
  FCEPModel := value;
end;

class function TCEPServicePesquisarEnderecoWS.New: ICEPServiceStrategy;
begin
  Result := Self.create;
end;

function TCEPServicePesquisarEnderecoWS.Pesquisar: Boolean;
var
  _viaCEP : TViaCEP;
  _posicao : Integer;
  _localidade, _logradouro : string;
begin
  Result := False;

  _localidade := removerAcentuacao( FLocalidade.Replace(' ', '%20') );
  _logradouro := removerAcentuacao( FLogradouro.Replace(' ', '%20') );

  try
    _viaCEP := TViaCEP.Create(nil);
    _viaCEP.TipoPesquisa := TTipoPesquisa(FTipoPesquisa.ToInteger);
    _viaCEP.TipoChave    := tcEnderecoCompleto;
    _viaCEP.UF           := FUf;
    _viaCEP.Localidade   := _localidade;
    _viaCEP.Logradouro   := _logradouro;

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

function TCEPServicePesquisarEnderecoWS.RemoverAcentuacao(str: string): string;
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

function TCEPServicePesquisarEnderecoWS.TipoPesquisa(
  value: TTipoPesquisaEnu): ICEPServiceStrategy;
begin
  Result := Self;
  FTipoPesquisa := value;
end;

function TCEPServicePesquisarEnderecoWS.UF(value: string): ICEPServiceStrategy;
begin
  Result := Self;
  FUf := value;
end;

end.

