unit main.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,

  cep.factory.interfaces,
  cep.controller.interfaces;

type
  TfrmDesafioCep = class(TForm)
    pnPesquisaEnderecoCompleto: TPanel;
    pnPesquisaCEP: TPanel;
    Label1: TLabel;
    btPesquisarCep: TBitBtn;
    pnOpcaoRetorno: TPanel;
    Uf: TEdit;
    Label2: TLabel;
    Localidade: TEdit;
    Label3: TLabel;
    Logradouro: TEdit;
    Label4: TLabel;
    btPesquisarEnderecoCompleto: TBitBtn;
    pnFormaPesquisa: TPanel;
    rbPesquisarCEP: TRadioButton;
    rbPesquisarEnderecoCompleto: TRadioButton;
    pnMessage: TPanel;
    Label5: TLabel;
    rgTipoRetorno: TRadioGroup;
    DBGrid1: TDBGrid;
    dsCep: TDataSource;
    Cep: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbPesquisarCEPClick(Sender: TObject);
    procedure btPesquisarCepClick(Sender: TObject);
    procedure btPesquisarEnderecoCompletoClick(Sender: TObject);
  private
    FCepController : ICEPController;

    procedure ConfigurarPesquisa(pPesquisarPorCep : Boolean);
  public
    procedure PesquisarCEP;
    procedure PesquisarEnderecoCompleto;
  end;

var
  frmDesafioCep: TfrmDesafioCep;

implementation

uses
  cep.enumerator,
  cep.factory;


{$R *.dfm}

procedure TfrmDesafioCep.btPesquisarCepClick(Sender: TObject);
begin
  PesquisarCEP;
end;

procedure TfrmDesafioCep.btPesquisarEnderecoCompletoClick(Sender: TObject);
begin
  PesquisarEnderecoCompleto;
end;

procedure TfrmDesafioCep.ConfigurarPesquisa(pPesquisarPorCep: Boolean);
begin
  pnOpcaoRetorno.Visible             := False;
  pnPesquisaCEP.Visible              := pPesquisarPorCep;
  pnPesquisaEnderecoCompleto.Visible := not pPesquisarPorCep;
  pnOpcaoRetorno.Visible             := True;
end;

procedure TfrmDesafioCep.FormCreate(Sender: TObject);
begin
  FCepController := TFactoryCep.New.Controller;
  FCepController.DataSource( dsCep );
end;

procedure TfrmDesafioCep.FormShow(Sender: TObject);
begin
  ConfigurarPesquisa(rbPesquisarCEP.Checked);
end;

procedure TfrmDesafioCep.PesquisarCEP;
begin
  if not
    FCepController
      .TipoPesquisa( TTipoPesquisaEnu(rgTipoRetorno.ItemIndex) )
      .TipoChave( tCEP )
      .Cep( Cep.Text )
      .Pesquisar then
    ShowMessage('CEP não foi encontrado.');

end;

procedure TfrmDesafioCep.PesquisarEnderecoCompleto;
begin
  if not
    FCepController
      .TipoPesquisa( TTipoPesquisaEnu(rgTipoRetorno.ItemIndex) )
      .TipoChave( tEndereco )
      .UF(Uf.Text)
      .Localidade(Localidade.Text)
      .Logradouro(Logradouro.Text)
      .Pesquisar then
    ShowMessage('CEP não foi encontrado.');

end;

procedure TfrmDesafioCep.rbPesquisarCEPClick(Sender: TObject);
begin
  ConfigurarPesquisa(rbPesquisarCEP.Checked);
end;

end.
