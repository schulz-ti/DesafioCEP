unit core.viacep.json;

interface

uses
  System.Classes,
  System.SysUtils,

  System.JSON,
  REST.Json,

  IdHTTP,
  IdSSLOpenSSL,

  core.viacep.interfaces,
  core.viacep.data;

const
  URL_CEP = 'https://viacep.com.br/ws/%s/json';
  URL_ENDERECO_COMPLETO = 'https://viacep.com.br/ws/%s/%s/%s/json';

type
  TViaCEPServiceJSON = class(TInterfacedObject, IViaCEPService)
  strict private
    constructor Create;
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FTipoChave : TTipoChave;
    FListaData : TListaViaCEPData;
    FCEP : string;
    FUF : string;
    FLocalidade : string;
    FLogradouro : string;
    function PesquisarCEP:Boolean;
    function PesquisarEnderecoComppleto:Boolean;
  public
    destructor Destroy; override;

    class function New : IViaCEPService;

    function TipoChave(value: TTipoChave):IViaCEPService;
    function Data(value : TListaViaCEPData):IViaCEPService;
    function CEP(Value: string):IViaCEPService;
    function UF(Value: string):IViaCEPService;
    function Localidade(Value: string):IViaCEPService;
    function Logradouro(Value: string):IViaCEPService;
    function Execute:Boolean;
  end;


implementation

{ TViaCEPServiceJSON }

function TViaCEPServiceJSON.CEP(Value: string): IViaCEPService;
begin
  Result := Self;
  FCEP := value;
end;

constructor TViaCEPServiceJSON.Create;
begin
  FIdHTTP := TIdHTTP.Create;

  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;

  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  FTipoChave := tcCEP;
  FCEP := '';
  FUF := '';
  FLocalidade := '';
  FLogradouro := '';
end;

function TViaCEPServiceJSON.Data(value: TListaViaCEPData): IViaCEPService;
begin
  Result := Self;
  FListaData := value;
end;

destructor TViaCEPServiceJSON.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

function TViaCEPServiceJSON.Execute: Boolean;
begin
  Result := False;

  if FTipoChave = tcCEP then
    Result := PesquisarCEP

  else if FTipoChave = tcEnderecoCompleto then
    Result := PesquisarEnderecoComppleto;

end;

function TViaCEPServiceJSON.Localidade(Value: string): IViaCEPService;
begin
  Result := Self;
  FLocalidade := value;
end;

function TViaCEPServiceJSON.Logradouro(Value: string): IViaCEPService;
begin
  Result := Self;
  FLogradouro := value;
end;

class function TViaCEPServiceJSON.New: IViaCEPService;
begin
  Result := Self.create;
end;

function TViaCEPServiceJSON.PesquisarCEP: Boolean;
var
  _response: TStringStream;
  _cepData : TViaCEPData;
begin
  _response := TStringStream.Create;

  Result := False;

  try
    FIdHTTP.Get(Format(URL_CEP, [FCep]), _response);

    if FIdHTTP.ResponseCode = 200 then
      begin
        if _response.DataString.Contains('"erro": true') then
          raise Exception.Create('O CEP informado não foi encontrado.')
        else
          begin
            _cepData := TViaCEPData.Create;
            _cepData := TJson.JsonToObject<TViaCEPData>(UTF8ToString(PAnsiChar(AnsiString(_response.DataString))));

            FListaData.Add(_cepData);

            Result := True;
          end;
      end
    else
      raise Exception.Create('Erro ao consultar o CEP. HTTP erro: ' + FIdHTTP.ResponseCode.ToString);
  finally
    _response.Free;
  end;
end;

function TViaCEPServiceJSON.PesquisarEnderecoComppleto: Boolean;
var
  _response: TStringStream;
  _tipoPesquisa : string;
  _jsonArray: TJSONArray;
  _posicao:integer;
  _cepData : TViaCEPData;
begin
  _response := TStringStream.Create;

  Result := False;

  try
    FIdHTTP.Get(Format(URL_ENDERECO_COMPLETO, [FUf, FLocalidade, FLogradouro]), _response);

    if FIdHTTP.ResponseCode = 200 then
      begin
        if _response.DataString.Contains('"erro": true') then
          raise Exception.Create('O CEP informado não foi encontrado.')
        else
          begin
            _jsonArray := TJSONObject.ParseJSONValue(UTF8ToString(PAnsiChar(AnsiString(_response.DataString)))) as TJSONArray;

            for _posicao := 0 to _jsonArray.Size - 1 do
            begin
              _cepData := TViaCEPData.Create;

              _cepData.Logradouro  := TJSONObject(_jsonArray.Get(_posicao)).Get('logradouro').JsonValue.Value;
              _cepData.CEP         := TJSONObject(_jsonArray.Get(_posicao)).Get('cep').JsonValue.Value;
              _cepData.Localidade  := TJSONObject(_jsonArray.Get(_posicao)).Get('localidade').JsonValue.Value;
              _cepData.Bairro      := TJSONObject(_jsonArray.Get(_posicao)).Get('bairro').JsonValue.Value;
              _cepData.UF          := TJSONObject(_jsonArray.Get(_posicao)).Get('uf').JsonValue.Value;
              _cepData.Complemento := TJSONObject(_jsonArray.Get(_posicao)).Get('complemento').JsonValue.Value;

              FListaData.Add(_cepData);

              Result := True;
            end;
          end;
      end
    else
      raise Exception.Create('Erro ao consultar o CEP. HTTP erro: ' + FIdHTTP.ResponseCode.ToString);
  finally
    _response.Free;
  end;

end;

function TViaCEPServiceJSON.TipoChave(value: TTipoChave): IViaCEPService;
begin
  Result := Self;
  FTipoChave := Value;
end;

function TViaCEPServiceJSON.UF(Value: string): IViaCEPService;
begin
  Result := Self;
  FUF := value;
end;

end.
