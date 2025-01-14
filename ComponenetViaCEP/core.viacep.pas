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
    FResultadoData : TViaCEPData;
    procedure CopiarDataLista(pLista: TListaViaCEPData; pResultado: TViaCEPData);
    procedure CopiarData(pOrigem: TViaCEPData; pResultado: TViaCEPData);
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
    property Resultado : TViaCEPData read FResultadoData write FResultadoData;
  end;

procedure Register;

implementation

uses
  core.viacep.json,
  core.viacep.xml,
  core.viacep.view;

procedure Register;
begin
  RegisterComponents('ViaCEP', [TViaCEP]);
end;

{ TViaCEP }

procedure TViaCEP.CopiarData(pOrigem, pResultado: TViaCEPData);
begin
  FResultadoData.CEP         := pOrigem.CEP;
  FResultadoData.UF          := pOrigem.UF;
  FResultadoData.Localidade  := pOrigem.Localidade;
  FResultadoData.Logradouro  := pOrigem.Logradouro;
  FResultadoData.Complemento := pOrigem.Complemento;
  FResultadoData.Bairro      := pOrigem.Bairro;
end;

procedure TViaCEP.CopiarDataLista(pLista: TListaViaCEPData;
  pResultado: TViaCEPData);
begin
  FResultadoData.CEP         := FListaViaCEPData[0].CEP;
  FResultadoData.UF          := FListaViaCEPData[0].UF;
  FResultadoData.Localidade  := FListaViaCEPData[0].Localidade;
  FResultadoData.Logradouro  := FListaViaCEPData[0].Logradouro;
  FResultadoData.Complemento := FListaViaCEPData[0].Complemento;
  FResultadoData.Bairro      := FListaViaCEPData[0].Bairro;
end;

constructor TViaCEP.Create(Aowner: TComponent);
begin
  inherited;
  FIdHTTP := TIdHTTP.Create;

  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;

  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  FListaViaCEPData := TList<TViaCEPData>.Create;

  FResultadoData := TViaCEPData.Create;

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
  FResultadoData.Free;
  inherited;
end;

function TViaCEP.Execute: Boolean;
var
  _service : IViaCEPService;
  _enderecoEncontrado : Boolean;
begin
  Result := False;

  _enderecoEncontrado := False;

  if FTipoPesquisa = tpJSON then
    _service := TViaCEPServiceJSON.New

  else if FTipoPesquisa = tpXML then
    _service := TViaCEPServiceXML.New;

  _enderecoEncontrado:=
    _service
      .TipoChave(FTipoChave)
      .Data(FListaViaCEPData)
      .CEP(FCep)
      .UF(FUf)
      .Localidade(FLocalidade)
      .Logradouro(FLogradouro)
      .Execute;

  if _enderecoEncontrado then
  begin
    if FListaViaCEPData.Count > 1 then
      begin
        try
          frmViaCEPView := TfrmViaCEPView.Create(nil);
          frmViaCEPView.Lista(FListaViaCEPData);

          if frmViaCEPView.Execute then
            CopiarData(frmViaCEPView.Data,  FResultadoData)
          else
            _enderecoEncontrado := False;
        finally
          frmViaCEPView.Free;
        end;
      end
    else
      begin
        CopiarDataLista(FListaViaCEPData, FResultadoData);
      end;
  end;

  Result := _enderecoEncontrado;

end;

end.
