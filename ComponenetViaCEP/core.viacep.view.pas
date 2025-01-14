unit core.viacep.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,

  core.viacep.data;

type
  TfrmViaCEPView = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    dsListaEnderecos: TDataSource;
    tmpListaEnderecos: TFDMemTable;
    tmpListaEnderecosUF: TStringField;
    tmpListaEnderecosCEP: TStringField;
    tmpListaEnderecosLOCALIDADE: TStringField;
    tmpListaEnderecosLOGRADOURO: TStringField;
    tmpListaEnderecosCOMPLEMENTO: TStringField;
    tmpListaEnderecosBAIRRO: TStringField;
    btSelecionarEndereco: TButton;
    btCancelar: TButton;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btSelecionarEnderecoClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    FLista : TListaViaCEPData;
    FData : TViaCEPData;
    procedure CarregarLista;
    procedure SelecionarEndereco;
    procedure Cancelar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Lista(value : TListaViaCEPData);

    function Execute:Boolean;
    function Data: TViaCEPData;
  end;

var
  frmViaCEPView: TfrmViaCEPView;

implementation

{$R *.dfm}

{ TfrmViaCEPView }

procedure TfrmViaCEPView.btSelecionarEnderecoClick(Sender: TObject);
begin
  SelecionarEndereco;
end;

procedure TfrmViaCEPView.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmViaCEPView.Cancelar;
begin
  ModalResult := mrCancel;
end;

procedure TfrmViaCEPView.CarregarLista;
var
  _posicao : Integer;
  _data : TViaCEPData;
begin
  tmpListaEnderecos.Close;
  tmpListaEnderecos.CreateDataSet;
  tmpListaEnderecos.Open;

  for _posicao := 0 to Pred(FLista.Count) do
  begin
    _data := FLista[_posicao];

    tmpListaEnderecos.Insert;
    tmpListaEnderecos.FieldByName('CEP').AsString         := _data.CEP;
    tmpListaEnderecos.FieldByName('UF').AsString          := _data.UF;
    tmpListaEnderecos.FieldByName('LOCALIDADE').AsString  := _data.Localidade;
    tmpListaEnderecos.FieldByName('LOGRADOURO').AsString  := _data.Logradouro;
    tmpListaEnderecos.FieldByName('COMPLEMENTO').AsString := _data.Complemento;
    tmpListaEnderecos.FieldByName('BAIRRO').AsString      := _data.Bairro;
    tmpListaEnderecos.Post;
  end;

  tmpListaEnderecos.First;
end;

constructor TfrmViaCEPView.Create(AOwner: TComponent);
begin
  inherited;
  FData := TViaCEPData.Create;
end;

function TfrmViaCEPView.Data: TViaCEPData;
begin
  Result := FData;
end;

procedure TfrmViaCEPView.DBGrid1DblClick(Sender: TObject);
begin
  SelecionarEndereco;
end;

destructor TfrmViaCEPView.Destroy;
begin
  FData.Free;
  inherited;
end;

function TfrmViaCEPView.Execute: Boolean;
begin
  Result := False;

  CarregarLista;

  if ShowModal = mrOk then
    begin
      FData.CEP         := tmpListaEnderecos.FieldByName('CEP').AsString;
      FData.UF          := tmpListaEnderecos.FieldByName('UF').AsString;
      FData.Localidade  := tmpListaEnderecos.FieldByName('LOCALIDADE').AsString;
      FData.Logradouro  := tmpListaEnderecos.FieldByName('LOGRADOURO').AsString;
      FData.Complemento := tmpListaEnderecos.FieldByName('COMPLEMENTO').AsString;
      FData.Bairro      := tmpListaEnderecos.FieldByName('BAIRRO').AsString;

      Result := True;
    end;

end;

procedure TfrmViaCEPView.Lista(value: TListaViaCEPData);
begin
  FLista := value;
end;

procedure TfrmViaCEPView.SelecionarEndereco;
begin
  ModalResult := mrOk;
end;

end.
