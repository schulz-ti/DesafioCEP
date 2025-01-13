unit cep.controller;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Controls,

  cep.enumerator,
  cep.factory.interfaces,
  cep.controller.interfaces,
  cep.model.interfaces,
  cep.service.interfaces;

type
  TCEPController = class(TInterfacedObject, ICEPController)
  private
    FDataSource : TObject;
    FCEPModel : ICEPModel;
    FCep : string;
    FUf : string;
    FLocalidade : string;
    FLogradouro : string;
    FTipoPesquisa : TTipoPesquisaEnu;
    FTipoChave : TTipoChaveEnu;
  strict private
    constructor Create;
  private
    function RemoverAcentuacao(str: string): string;
  public
    destructor Destroy; override;

    class function New : ICEPController;

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

uses
  cep.factory;

{ TCEPController }

function TCEPController.Cep(value: string): ICEPController;
begin
  Result := Self;
  FCep := value;
end;

constructor TCEPController.Create;
begin
  FCEPModel := TFactoryCEP.New.Model;

  FCep          := '';
  FUf           := '';
  FLocalidade   := '';
  FLogradouro   := '';
  FTipoPesquisa := ctpJson;
  FTipoChave    := tCEP;
end;

function TCEPController.DataSource(value: TObject): ICEPController;
begin
  Result := Self;
  FDataSource := value;
  FCEPModel.DataSource( FDataSource );
end;

destructor TCEPController.Destroy;
begin

  inherited;
end;

function TCEPController.Localidade(value: string): ICEPController;
begin
  Result := Self;
  FLocalidade := value;
end;

function TCEPController.Logradouro(value: string): ICEPController;
begin
  Result := Self;
  FLogradouro := value;
end;

class function TCEPController.New: ICEPController;
begin
  Result := Self.create;
end;

function TCEPController.Pesquisar: Boolean;
var
  _service : ICEPServiceContext;
  _possuiNaBase, _pesquisarWS : Boolean;
  _mensagemConfirmacao : string;
begin
  _possuiNaBase := False;
  _pesquisarWS  := True;

  Result := False;

  _mensagemConfirmacao := 'Encontrado o endereÁo na base de dados. Deseja exibi-lo ou atualizar os dados atravÈs do WS?'
    + #13 + 'Click em Sim para atualizar e N„o para utilizar o endereÁo da base de dados.';

  _service := TFactoryCep.New.Service;

  if FTipoChave = tCEP then
    _possuiNaBase :=
      FCEPModel
        .Cep(FCep)
        .PesquisarCEP
        .Found

  else if FTipoChave = tEndereco then
    _possuiNaBase :=
      FCEPModel
        .UF(FUf)
        .Localidade(FLocalidade)
        .Logradouro(FLogradouro)
        .PesquisarEnderecoCompleto
        .Found;

  Result := _possuiNaBase;

  if _possuiNaBase then
    _pesquisarWS := (MessageDlg(_mensagemConfirmacao, mtConfirmation, [mbYes, mbNo], 0) = mrYes);

  if _pesquisarWS then
    begin
      Result :=
        _service
          .Model(FCEPModel)
          .TipoPesquisa(FTipoPesquisa)
          .TipoChave(FTipoChave)
          .Cep(FCep)
          .UF(FUf)
          .Localidade(FLocalidade)
          .Logradouro(FLogradouro)
          .Execute;
    end;
end;

function TCEPController.RemoverAcentuacao(str: string): string;
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

function TCEPController.TipoChave(value: TTipoChaveEnu): ICEPController;
begin
  Result := self;
  FTipoChave := value;
end;

function TCEPController.TipoPesquisa(value: TTipoPesquisaEnu): ICEPController;
begin
  Result := Self;
  FTipoPesquisa := value;
end;

function TCEPController.UF(value: string): ICEPController;
begin
  Result := Self;
  FUf := value;
end;

end.
