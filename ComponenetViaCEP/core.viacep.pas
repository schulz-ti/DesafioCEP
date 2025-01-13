unit core.viacep;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,

  System.JSON,
  REST.Json,

  IdHTTP,
  IdSSLOpenSSL,

  core.viacep.data,
  core.viacep.interfaces;

const
  URL_CEP = 'https://viacep.com.br/ws/%s/';
  URL_ENDERECO_COMPLETO = 'https://viacep.com.br/ws/%s/%s/%s/';

type
  TViaCEP = class(TComponent)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FLogradouro: string;
    FUf: string;
    FCep: String;
    FLocalidade: string;
    FListaViaCEPData: TListaViaCEPData;
    FTipoPesquisa: TTipoPesquisa;
    FTipoChave: TTipoChave;
  public
    constructor Create(Aowner : TComponent); override;
    destructor Destroy; override;

    function Execute: Boolean;
  published
    property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write FTipoPesquisa;
    property TipoChave : TTipoChave read FTipoChave write FTipoChave;
    property CEP : String read FCep write FCep;
    property UF : string read FUf write FUf;
    property Localidade : string read FLocalidade write FLocalidade;
    property Logradouro : string read FLogradouro write FLogradouro;

    function Lista:TListaViaCEPData;
  end;

procedure Register;

implementation

uses
  core.viacep.json,
  core.viacep.xml;

procedure Register;
begin
  RegisterComponents('ViaCEP', [TViaCEP]);
end;

{ TViaCEP }

constructor TViaCEP.Create(Aowner: TComponent);
begin
  inherited;
  FIdHTTP := TIdHTTP.Create;

  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;

  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  FListaViaCEPData := TList<TViaCEPData>.Create;

  FTipoPesquisa := tpJSON;

  FTipoChave := tcCEP;

  FLogradouro := '';
  FUf         := '';
  FCep        := '';
  FLocalidade := '';

end;

destructor TViaCEP.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  FListaViaCEPData.Free;
  inherited;
end;

function TViaCEP.Execute: Boolean;
var
  _service : IViaCEPService;
begin
  Result := False;

  if FTipoPesquisa = tpJSON then
    _service := TViaCEPServiceJSON.New

  else if FTipoPesquisa = tpXML then
    _service := TViaCEPServiceXML.New;

  Result :=
    _service
      .TipoChave(FTipoChave)
      .Data(FListaViaCEPData)
      .CEP(FCep)
      .UF(FUf)
      .Localidade(FLocalidade)
      .Logradouro(FLogradouro)
      .Execute;
end;

function TViaCEP.Lista: TListaViaCEPData;
begin
  Result := FListaViaCEPData;
end;

end.
