unit cep.model;

interface

uses
  System.Classes,
  System.SysUtils,
  DB,
  cep.model.interfaces,
  cep.model.data;

type
  TCEPModel = class(TInterfacedObject, ICEPModel)
  private
    FDataSource : TObject;
    FModelData : TCepModelData;
    FCodigo : string;
    FCep : string;
    FUf : string;
    FLocalidade : string;
    FLogradouro : string;
    FComplemento : string;
    FBairro : string;
    FFound : Boolean;
    FHasError : Boolean;
    FErrorMessage : String;
  strict private
    constructor Create;
  private
    procedure LimparCampos;
    procedure GravarCEPTemp;

    function PesquisarCEPData:Boolean;
    function PesquisarEnderecoCompletoData:Boolean;
  public
    destructor Destroy; override;

    class function New : ICEPModel;

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

{ TCEPModel }

function TCEPModel.Cep(value: string): ICEPModel;
begin
  Result := Self;
  FCep := Value;
end;

function TCEPModel.Bairro(value: string): ICEPModel;
begin
  Result := Self;
  FBairro := Value;
end;

function TCEPModel.Cep: string;
begin
  Result := FCep;
end;

function TCEPModel.Codigo: string;
begin
  Result := FCodigo;
end;

function TCEPModel.Codigo(value: string): ICEPModel;
begin
  Result := Self;
  FCodigo := Value;
end;

function TCEPModel.Complemento(value: string): ICEPModel;
begin
  Result := Self;
  FComplemento := Value;
end;

function TCEPModel.Complemento: string;
begin
  Result := FComplemento;
end;

constructor TCEPModel.Create;
begin
  FModelData := TCepModelData.Create(nil);

  FCep         := '';
  FUf          := '';
  FLocalidade  := '';
  FLogradouro  := '';

  FFound := False;
end;

function TCEPModel.DataSource(value: TObject): ICEPModel;
begin
  Result := Self;
  FDataSource := Value;
  TDataSource( FDataSource ).DataSet := FModelData.tmpCep;
end;

destructor TCEPModel.Destroy;
begin
  FModelData.Free;
  inherited;
end;

function TCEPModel.Found: Boolean;
begin
  Result := FFound;
end;

function TCEPModel.Gravar: Boolean;
begin
  Result := False;
  with FModelData do
  begin
    qryManutencao.Close;
    qryManutencao.Params.ParamValues['CEP'] := FCep;
    qryManutencao.Open;

    if not qryManutencao.IsEmpty then
      qryManutencao.Edit
    else
      qryManutencao.Insert;

    qryManutencao.FieldByName('Cep').AsString         := FCep;
    qryManutencao.FieldByName('UF').AsString          := FUf;
    qryManutencao.FieldByName('Localidade').AsString  := FLocalidade;
    qryManutencao.FieldByName('Logradouro').AsString  := FLogradouro;
    qryManutencao.FieldByName('Complemento').AsString := FComplemento;
    qryManutencao.FieldByName('Bairro').AsString      := FBairro;
    qryManutencao.Post;

    qryManutencao.Close;

    GravarCEPTemp;
  end;

end;

procedure TCEPModel.GravarCEPTemp;
begin
  with FModelData do
  begin
    tmpCep.Insert;
    tmpCep.FieldByName('Codigo').AsString      := FCodigo;
    tmpCep.FieldByName('Cep').AsString         := FCep;
    tmpCep.FieldByName('UF').AsString          := FUf;
    tmpCep.FieldByName('Localidade').AsString  := FLocalidade;
    tmpCep.FieldByName('Logradouro').AsString  := FLogradouro;
    tmpCep.FieldByName('Complemento').AsString := FComplemento;
    tmpCep.FieldByName('Bairro').AsString      := FBairro;
    tmpCep.Post;

    tmpCep.First;
  end;

end;

function TCEPModel.Localidade(value: string): ICEPModel;
begin
  Result := Self;
  FLocalidade := Value;
end;

function TCEPModel.Logradouro(value: string): ICEPModel;
begin
  Result := Self;
  FLogradouro := Value;
end;

class function TCEPModel.New: ICEPModel;
begin
  Result := Self.Create;
end;

function TCEPModel.PesquisarCEP: ICEPModel;
begin
  Result := Self;

  LImparTmp;

  FFound := PesquisarCEPData;

end;


function TCEPModel.PesquisarCEPData: Boolean;
begin
  with FModelData do
  begin
    qryPesquisarCep.Close;
    qryPesquisarCep.Params.ParamValues['CEP'] := FCep;
    qryPesquisarCep.Open;

    Result := not qryPesquisarCep.IsEmpty;

    LimparCampos;

    if Result then
    begin
      while not qryPesquisarCep.Eof do
      begin
        FCodigo      := qryPesquisarCep.FieldByName('Codigo').AsString;
        FCep         := qryPesquisarCep.FieldByName('Cep').AsString;
        FUf          := qryPesquisarCep.FieldByName('UF').AsString;
        FLocalidade  := qryPesquisarCep.FieldByName('Localidade').AsString;
        FLogradouro  := qryPesquisarCep.FieldByName('Logradouro').AsString;
        FComplemento := qryPesquisarCep.FieldByName('Complemento').AsString;
        FBairro      := qryPesquisarCep.FieldByName('Bairro').AsString;

        GravarCEPTemp;

        qryPesquisarCep.Next;
      end;
    end;

    qryPesquisarCep.Close;
  end;
end;

function TCEPModel.PesquisarEnderecoCompleto: ICEPModel;
begin
  Result := Self;

  LImparTmp;

  FFound := PesquisarEnderecoCompletoData;

end;

function TCEPModel.PesquisarEnderecoCompletoData: Boolean;
begin
  with FModelData do
  begin
    qryPesquisarEnderecoCompleto.Close;
    qryPesquisarEnderecoCompleto.Params.ParamValues['UF'] := FUf;
    qryPesquisarEnderecoCompleto.Params.ParamValues['LOCALIDADE'] := FLocalidade;
    qryPesquisarEnderecoCompleto.Params.ParamValues['LOGRADOURO'] := FLogradouro;
    qryPesquisarEnderecoCompleto.Open;

    Result := not qryPesquisarEnderecoCompleto.IsEmpty;

    LimparCampos;

    if Result then
    begin
      while not qryPesquisarEnderecoCompleto.Eof do
      begin
        FCodigo      := qryPesquisarEnderecoCompleto.FieldByName('Codigo').AsString;
        FCep         := qryPesquisarEnderecoCompleto.FieldByName('Cep').AsString;
        FUf          := qryPesquisarEnderecoCompleto.FieldByName('UF').AsString;
        FLocalidade  := qryPesquisarEnderecoCompleto.FieldByName('Localidade').AsString;
        FLogradouro  := qryPesquisarEnderecoCompleto.FieldByName('Logradouro').AsString;
        FComplemento := qryPesquisarEnderecoCompleto.FieldByName('Complemento').AsString;
        FBairro      := qryPesquisarEnderecoCompleto.FieldByName('Bairro').AsString;

        GravarCEPTemp;

        qryPesquisarEnderecoCompleto.Next;
      end;
    end;

    qryPesquisarEnderecoCompleto.Close;
  end;

end;

function TCEPModel.UF: string;
begin
  Result := FUf;
end;

function TCEPModel.UF(value: string): ICEPModel;
begin
  Result := Self;
  FUf := Value;
end;

function TCEPModel.Bairro: string;
begin
  Result := FBairro;
end;

procedure TCEPModel.LimparCampos;
begin
  FCodigo      := '';
  FCep         := '';
  FUf          := '';
  FLocalidade  := '';
  FLogradouro  := '';
  FComplemento := '';
  FBairro      := '';
end;

function TCEPModel.LImparTmp: ICEPModel;
begin
  Result := Self;

  with FModelData do
  begin
    tmpCep.Close;
    tmpCep.CreateDataSet;
    tmpCep.Open;
  end;
end;

function TCEPModel.Localidade: string;
begin
  Result := FLocalidade;
end;

function TCEPModel.Logradouro: string;
begin
  Result := FLogradouro;
end;

end.
