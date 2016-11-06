unit clsTUsuario;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  REST.JSON,
  DBXJSON,
  DBXJSONReflect;

type
  TUsuarioDTO = class(TPersistent)
  private
    FNasc: TDateTime;
    FNome: String;
    FID: Integer;
    FEmail: String;
    FAlterado: Boolean;
    procedure SetNasc(const Value: TDateTime);
    procedure SetNome(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetEmail(const Value: String);
    function GetAlterado: Boolean;
    procedure SetAlterado(const Value: Boolean);
  published
    constructor Create;
    property ID: Integer read FID write SetID;
    property Nome: String read FNome write SetNome;
    property Nasc: TDateTime read FNasc write SetNasc;
    property Email: String read FEmail write SetEmail;
    property Alterado: Boolean read GetAlterado write SetAlterado;
  end;

  TUsuario = class(TPersistent)
  private
    FMarshal: TJSONMarshal;
    FUnMarshal: TJSONUnMarshal;
    FDTO: TUsuarioDTO;
    procedure RegisterConverters;
    procedure RegisterReverters;
    procedure SetDTO(const Value: TUsuarioDTO);
    function GetDTO: TUsuarioDTO;
  public
    constructor Create; overload;
    constructor Create(pNome, pEmail: String; pNasc: TDateTIme); overload;
    constructor Create(pID: Integer; pNome, pEmail: String; pNasc: TDateTIme); overload;
    constructor Create(JSON: String); overload;
  published
    destructor Destroy; override;
    property DTO: TUsuarioDTO read GetDTO write SetDTO;
    function ToJSON: String;
  end;

implementation

{ TUsuarioDTO }

constructor TUsuarioDTO.Create;
begin
  Self.FAlterado := False;
end;

function TUsuarioDTO.GetAlterado: Boolean;
begin
  Result := Self.FAlterado;
end;

procedure TUsuarioDTO.SetAlterado(const Value: Boolean);
begin

end;

procedure TUsuarioDTO.SetEmail(const Value: String);
begin
  if Self.FEmail <> Value then
    Self.FAlterado := True;
  Self.FEmail := Value;
end;

procedure TUsuarioDTO.SetID(const Value: Integer);
begin
  if Self.FID <> Value then
    Self.FAlterado := True;
  Self.FID := Value;
end;

procedure TUsuarioDTO.SetNasc(const Value: TDateTime);
begin
  if Self.FNasc <> Value then
    Self.FAlterado := True;
  Self.FNasc := Value;
end;

procedure TUsuarioDTO.SetNome(const Value: String);
begin
  if Self.FNome <> Value then
    Self.FAlterado := True;
  Self.FNome := Value;
end;

{ TUsuario }

procedure TUsuario.RegisterConverters;
begin

end;

procedure TUsuario.RegisterReverters;
begin
  Self.FMarshal.RegisterConverter(TUsuarioDTO, function());

end;

constructor TUsuario.Create(pNome, pEmail: String; pNasc: TDateTIme);
begin
  Self.FDTO.Nome := pNome;
  Self.FDTO.Nasc := pNasc;
  Self.FDTO.Email := pEmail;
end;

constructor TUsuario.Create;
begin
  Self.FDTO.Create;
  Self.FMarshal := TJSONMarshal.Create;
  Self.FUnMarshal := TJSONUnMarshal.Create;
  Self.RegisterConverters;
  Self.RegisterReverters;
end;

constructor TUsuario.Create(JSON: String);
begin
  Self.FMarshal := TJSONMarshal.Create;
  Self.FUnMarshal := TJSONUnMarshal.Create;
  Self.RegisterConverters;
  Self.RegisterReverters;
  Self.FDTO := Self.FUnMarshal.Unmarshal(TJSONObject.ParseJSONValue(JSON)) as TUsuarioDTO;
end;

destructor TUsuario.Destroy;
begin
  Self.FDTO.Destroy;
  Self.FMarshal.Destroy;
  Self.FUnMarshal.Destroy;
  inherited;
end;

procedure TUsuario.SetDTO(const Value: TUsuarioDTO);
begin
  Self.FDTO := Value;
end;

constructor TUsuario.Create(pID: Integer; pNome, pEmail: String; pNasc: TDateTIme);
begin
  Self.FDTO := TUsuarioDTO.Create;
  Self.FDTO.Nome := pNome;
  Self.FDTO.Nasc := pNasc;
  Self.FDTO.Email := pEmail;
  Self.FDTO.ID := pID;
end;

function TUsuario.GetDTO: TUsuarioDTO;
begin
  Result := Self.FDTO;
end;

function TUsuario.ToJSON: String;
begin
  Result := Self.FMarshal.Marshal(Self).ToJSON;
end;

end.
