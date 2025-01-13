unit conexao.config;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.Client;

type
  TConfigConexao = class(TDataModule)
    FDConexao: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Database(value: string);
    procedure Username(value: string);
    procedure Password(value: string);
  end;

var
  ConfigConexao: TConfigConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConfigConexao.Database(value: string);
begin
  FDConexao.Params.Database := value;
end;

procedure TConfigConexao.DataModuleCreate(Sender: TObject);
begin
  FDConexao.Connected := False;
end;

procedure TConfigConexao.Password(value: string);
begin
  FDConexao.Params.Password := value;
end;

procedure TConfigConexao.Username(value: string);
begin
  FDConexao.Params.UserName := value;
end;

end.
