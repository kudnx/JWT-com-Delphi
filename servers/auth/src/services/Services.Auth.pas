unit Services.Auth;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Json, JOSE.Core.JWT, System.DateUtils,
  JOSE.Core.Builder, JOSE.Core.JWK, System.NetEncoding;
type
  TServicesAuth = class(TDataModule)
    Connection: TFDConnection;
    qryUsuarios: TFDQuery;
    qryUsuariosid: TFDAutoIncField;
    qryUsuariosnome: TStringField;
    qryUsuarioslogin: TStringField;
    qryUsuariossenha: TStringField;
    qryKeys: TFDQuery;
    qryKeysid: TFDAutoIncField;
    qryKeyspublic_key: TStringField;
    qryKeysprivate_key: TStringField;
  private
    FToken: TJWT;
    FPublicKey: string;
    FPrivateKey: string;
    function GetToken: string;
    function GetPublicKey(const AToken: string): string;
  public
    function Login(const AUsuario: TJSONObject) : Boolean;
    function GenerateToken : TJSONObject;
    procedure GenerateKeys;
    procedure SaveKeys;
    function AssinaturaValida(const AToken: string): Boolean;
    function TokenExpirado: Boolean;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServicesAuth }

function TServicesAuth.AssinaturaValida(const AToken: string): Boolean;
var
  LKey: TJWK;
begin
  qryKeys.ParamByName('public_key').AsString := GetPublicKey(AToken);
  qryKeys.Open();
  if qryKeys.IsEmpty then
    Exit;
  LKey := TJWK.Create(qryKeysprivate_key.AsString);
  FToken := TJOSE.Verify(LKey, AToken);
  Result := Assigned(FToken) and FToken.Verified;
end;

procedure TServicesAuth.GenerateKeys;
var
  LTimestamp: Int64;
begin
  LTimestamp := DateTimeToUnix(Now);
  FPublicKey := Format('%d:%s', [LTimestamp, qryUsuariosnome.AsString]);
  FPrivateKey := Format('%d:%s:%s', [LTimestamp, qryUsuariosnome.AsString, qryUsuariossenha.AsString]);
end;

function TServicesAuth.GenerateToken: TJSONObject;
begin
  GenerateKeys;
  SaveKeys;
  Result := TJSONObject.Create.AddPair('acess_token', GetToken);
end;

function TServicesAuth.GetPublicKey(const AToken: string): string;
var
  LToken: TArray<string>;
  LPayload: TJSONObject;
begin
  LToken := AToken.Split(['.']);
  LPayload := TJSONObject.ParseJSONValue(TNetEncoding.Base64.Decode(LToken[1])) as TJSONObject;
  try
    Result := LPayload.GetValue<string>('public_key');
  finally
    LPayload.Free;
  end;
end;

function TServicesAuth.GetToken: string;
var
  LToken: TJWT;
begin
  LToken := TJWT.Create;
  try
    LToken.Claims.Issuer := 'F?cil Sistemas';
    LToken.Claims.Expiration := Now + (OneMinute * 15);
    LToken.Claims.IssuedAt := Now;
    LToken.Claims.Subject := qryUsuariosid.AsString;
    LToken.Claims.SetClaimOfType('public_key', FPublicKey);
    LToken.Claims.SetClaimOfType('nome', qryUsuariosnome.AsString);
    LToken.Claims.SetClaimOfType('login', qryUsuarioslogin.AsString);
    Result := TJOSE.SHA256CompactToken(FPrivateKey, LToken);
  finally
    LToken.Free;
  end;
end;

function TServicesAuth.Login(const AUsuario: TJSONObject): Boolean;
begin
   qryUsuarios.ParamByName('login').AsString := AUsuario.GetValue<string>('login');
   qryUsuarios.ParamByName('senha').AsString := AUsuario.GetValue<string>('senha');
   qryUsuarios.Open();
   Result := not qryUsuarios.IsEmpty;
end;

procedure TServicesAuth.SaveKeys;
var
  LQuery: TFDQuery;
  MyClass: TObject;
begin
  LQuery := TFDQuery.Create(Self);
  try
    LQuery.Connection := Connection;
    LQuery.SQL.Text := 'insert into usuario_key (public_key, private_key) values (:public_key, :private_key)';
    LQuery.ParamByName('public_key').AsString := FPublicKey;
    LQuery.ParamByName('private_key').AsString := FPrivateKey;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

function TServicesAuth.TokenExpirado: Boolean;
begin
  Result := FToken.Claims.Expiration < Now;
end;

end.
