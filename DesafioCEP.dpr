program DesafioCEP;

uses
  Vcl.Forms,
  main.view in 'src\main.view.pas' {frmDesafioCep},
  conexao.config in 'src\conexao\conexao.config.pas' {ConfigConexao: TDataModule},
  conexao in 'src\conexao\conexao.pas',
  cep.controller.interfaces in 'src\cep\cep.controller.interfaces.pas',
  cep.model.interfaces in 'src\cep\cep.model.interfaces.pas',
  cep.factory.interfaces in 'src\cep\cep.factory.interfaces.pas',
  cep.factory in 'src\cep\cep.factory.pas',
  cep.controller in 'src\cep\cep.controller.pas',
  cep.model in 'src\cep\cep.model.pas',
  cep.model.data in 'src\cep\cep.model.data.pas' {CepModelData: TDataModule},
  cep.enumerator in 'src\cep\cep.enumerator.pas',
  cep.service.interfaces in 'src\cep\cep.service.interfaces.pas',
  cep.service.pesquisarcep.ws in 'src\cep\cep.service.pesquisarcep.ws.pas',
  cep.service.context in 'src\cep\cep.service.context.pas',
  cep.service.pesquisarendereco.ws in 'src\cep\cep.service.pesquisarendereco.ws.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Desafio CEP - SOFTPLAN';
  Application.CreateForm(TfrmDesafioCep, frmDesafioCep);
  Application.CreateForm(TCepModelData, CepModelData);
  Application.Run;
end.
