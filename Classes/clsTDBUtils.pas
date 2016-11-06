unit clsTDBUtils;

interface
{$M+}
uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Data.DBCommonTypes,
  Uni,
  DBAccess;

type
  TColDevQuery = class(TUniQuery);
  TColDevConnection = class(TUniConnection);

  TDBUtils = class(TObject)
  private
    FConexao: TColDevConnection;
    FOwner: TComponent;
    procedure SetConexao(const Value: TColDevConnection);
    procedure SetOwner(const Value: TComponent);
  public
    constructor Create(AOwner: TComponent; StringDeConexao: String);
    property Owner: TComponent read FOwner write SetOwner;
    property Conexao: TColDevConnection read FConexao write SetConexao;
  published
    function QueryFactory(Statement: String): TColDevQuery;
  end;

implementation

{ TDBUtils }


constructor TDBUtils.Create(AOwner: TComponent; StringDeConexao: String);
begin
  Self.FOwner := AOwner;
  // 'Provider Name=PostgreSQL;Login Prompt=False;Data Source=192.168.0.116;User ID=postgres;Password=bitnami;Database=WeBuy;Port=5432';
  Self.FConexao.ConnectString := StringDeConexao;
  Self.FConexao.Connect;
end;

function TDBUtils.QueryFactory(Statement: String): TColDevQuery;
begin
  Result := TColDevQuery(TUniQuery).Create(Self.Owner);
  Result.Connection := Self.Conexao;
  Result.SQL.Add(Statement);
end;

procedure TDBUtils.SetConexao(const Value: TColDevConnection);
begin
  FConexao := Value;
end;

procedure TDBUtils.SetOwner(const Value: TComponent);
begin
  FOwner := Value;
end;

end.
