unit dmMainDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Comp.Client, MemDS, clsTDBUtils;

type
  TMainDM = class(TDataModule)
    conn: TUniConnection;
    usuarios: TUniQuery;
    usuariosid_usuario: TLargeintField;
    usuariosnome: TStringField;
    usuariosnasc: TDateField;
    usuariosemail: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FDBUtils: TDBUtils;
    FStringDeConexao: String;
    procedure SetDBUtils(const Value: TDBUtils);
    procedure SetStringDeConexao(const Value: String);
  public
    { Public declarations }
    property DBUtils: TDBUtils read FDBUtils write SetDBUtils;
    property StringDeConexao: String read FStringDeConexao write SetStringDeConexao;
  end;

var
  MainDM: TMainDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TMainDM }

procedure TMainDM.DataModuleCreate(Sender: TObject);
begin
  Self.DBUtils := TDBUtils.Create(TComponent(Self), Self.StringDeConexao);
end;

procedure TMainDM.SetDBUtils(const Value: TDBUtils);
begin
  FDBUtils := Value;
end;

procedure TMainDM.SetStringDeConexao(const Value: String);
begin
  FStringDeConexao := Value;
  Self.DBUtils.Conexao.Connected := False;
  Self.DBUtils.Conexao.ConnectString := Self.StringDeConexao;
  try
    Self.DBUtils.Conexao.Connect;
  except
    raise Exception.Create('Error Message');
    Self.StringDeConexao := '';
    Self.DBUtils.Conexao.Connected := False;
  end;
end;

end.
