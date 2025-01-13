unit cep.model.data;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  conexao;

type
  TCepModelData = class(TDataModule)
    qryPesquisarCep: TFDQuery;
    qryPesquisarEnderecoCompleto: TFDQuery;
    qryManutencao: TFDQuery;
    tmpCep: TFDMemTable;
    tmpCepCEP: TStringField;
    tmpCepUF: TStringField;
    tmpCepLOCALIDADE: TStringField;
    tmpCepLOGRADOURO: TStringField;
    tmpCepBAIRRO: TStringField;
    tmpCepCOMPLEMENTO: TStringField;
    tmpCepCODIGO: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CepModelData: TCepModelData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TCepModelData.DataModuleCreate(Sender: TObject);
begin
  qryPesquisarCep.Connection              := TConexao.GetInstance.GetConexao;
  qryPesquisarEnderecoCompleto.Connection := TConexao.GetInstance.GetConexao;
  qryManutencao.Connection                := TConexao.GetInstance.GetConexao;
end;

end.
