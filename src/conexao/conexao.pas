unit conexao;

interface

uses
  System.Classes,
  System.sysutils,
  FireDAC.Comp.Client,
  conexao.config;

type
  TConexao = class
  strict private
    class var FInstance : TConexao;
    constructor Create;
  private
    class var config : TConfigConexao;
    class procedure ReleaseInstance;
  public
    class function GetInstance: TConexao;
    function GetConexao: TFDConnection;
  end;

implementation

{ TConexao }

constructor TConexao.Create;
begin
  Config := TConfigConexao.Create(nil);
end;

function TConexao.GetConexao: TFDConnection;
begin
  config.FDConexao.Connected := True;
  Result := config.FDConexao;
end;

class function TConexao.GetInstance: TConexao;
begin
  if not Assigned(Self.FInstance) then
      self.FInstance := TConexao.Create;

  Result := Self.FInstance;
end;

class procedure TConexao.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
  begin
    config.Free;
    Self.FInstance.Free;
  end;
end;

initialization

finalization
  TConexao.ReleaseInstance();

end.
