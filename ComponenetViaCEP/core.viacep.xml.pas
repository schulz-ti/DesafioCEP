unit core.viacep.xml;

interface

uses
  System.Classes,
  System.SysUtils,

  System.JSON,
  REST.Json,

  XMLDoc,
  XMLIntf,

  IdHTTP,
  IdSSLOpenSSL,

  core.viacep.interfaces,
  core.viacep.data;

const
  URL_CEP = 'https://viacep.com.br/ws/%s/xml';
  URL_ENDERECO_COMPLETO = 'https://viacep.com.br/ws/%s/%s/%s/xml';

type
  TViaCEPServiceXML = class(TInterfacedObject, IViaCEPService)
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
    function ProcessarXML(pXml : string):Boolean;
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

{ TViaCEPServiceXML }

function TViaCEPServiceXML.CEP(Value: string): IViaCEPService;
begin
  Result := Self;
  FCEP := value;
end;

constructor TViaCEPServiceXML.Create;
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

function TViaCEPServiceXML.Data(value: TListaViaCEPData): IViaCEPService;
begin
  Result := Self;
  FListaData := value;
end;

destructor TViaCEPServiceXML.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

function TViaCEPServiceXML.Execute: Boolean;
begin
  Result := False;

  if FTipoChave = tcCEP then
    Result := PesquisarCEP

  else if FTipoChave = tcEnderecoCompleto then
    Result := PesquisarEnderecoComppleto;

end;

function TViaCEPServiceXML.Localidade(Value: string): IViaCEPService;
begin
  Result := Self;
  FLocalidade := value;
end;

function TViaCEPServiceXML.Logradouro(Value: string): IViaCEPService;
begin
  Result := Self;
  FLogradouro := value;
end;

class function TViaCEPServiceXML.New: IViaCEPService;
begin
  Result := Self.create;
end;

function TViaCEPServiceXML.PesquisarCEP: Boolean;
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
            Result := ProcessarXML( UTF8ToString(PAnsiChar(AnsiString(_response.DataString))) );
          end;
      end
    else
      raise Exception.Create('Erro ao consultar o CEP. HTTP erro: ' + FIdHTTP.ResponseCode.ToString);
  finally
    _response.Free;
  end;
end;

function TViaCEPServiceXML.PesquisarEnderecoComppleto: Boolean;
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
            Result := ProcessarXML( UTF8ToString(PAnsiChar(AnsiString(_response.DataString))) );
          end;
      end
    else
      raise Exception.Create('Erro ao consultar o CEP. HTTP erro: ' + FIdHTTP.ResponseCode.ToString);
  finally
    _response.Free;
  end;

end;

function TViaCEPServiceXML.ProcessarXML(pXml: string): Boolean;
var
  _xmlDoc: IXMLDocument;
  _rootNode, _listaEnderecoNode, _enderecoNode : IXMLNode;
  _posicao, _posicao2, _posicao3: Integer;
  _data : TViaCEPData;
  _teste : string;
  _xml : string;
begin
  _xmlDoc := TXMLDocument.Create(nil);

  Result := False;

  _xml := pXml.Replace(#$A, '');

  try
    _xmlDoc.LoadFromXML(_xml);
    _xmlDoc.Options := _xmlDoc.Options + [doNodeAutoCreate, doNodeAutoIndent];
    _xmlDoc.Active := True;

    _rootNode := _xmlDoc.DocumentElement;

    if Assigned( _rootNode.ChildNodes.FindNode('enderecos') ) then
      begin
        _listaEnderecoNode := _rootNode.ChildNodes.Nodes['enderecos'];

        if Assigned( _listaEnderecoNode.ChildNodes.FindNode('endereco') ) then
        begin
          for _posicao := 0 to _listaEnderecoNode.ChildNodes.Count-1 do
          begin
            _enderecoNode := _listaEnderecoNode.ChildNodes.Nodes[_posicao];

            _data := TViaCEPData.Create;

            _data.UF          := _enderecoNode.ChildNodes['uf'].Text;
            _data.CEP         := _enderecoNode.ChildNodes['cep'].Text;
            _data.Localidade  := _enderecoNode.ChildNodes['localidade'].Text;
            _data.Logradouro  := _enderecoNode.ChildNodes['logradouro'].Text;
            _data.Complemento := _enderecoNode.ChildNodes['complemento'].Text;
            _data.Bairro      := _enderecoNode.ChildNodes['bairro'].Text;

            FListaData.Add( _data );

            Result:=true;
          end;
        end;
      end
    else
      begin
        _data := TViaCEPData.Create;

        _data.UF          := _rootNode.ChildNodes['uf'].Text;
        _data.CEP         := _rootNode.ChildNodes['cep'].Text;
        _data.Localidade  := _rootNode.ChildNodes['localidade'].Text;
        _data.Logradouro  := _rootNode.ChildNodes['logradouro'].Text;
        _data.Complemento := _rootNode.ChildNodes['complemento'].Text;
        _data.Bairro      := _rootNode.ChildNodes['bairro'].Text;

        FListaData.Add( _data );

        Result:=true;
      end;

  finally
    _xmlDoc := nil;
  end;
end;

function TViaCEPServiceXML.TipoChave(value: TTipoChave): IViaCEPService;
begin
  Result := Self;
  FTipoChave := Value;
end;

function TViaCEPServiceXML.UF(Value: string): IViaCEPService;
begin
  Result := Self;
  FUF := value;
end;

end.

