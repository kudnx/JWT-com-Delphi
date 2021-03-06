unit Controllers.Auth;

interface

uses Horse, Services.Auth, System.JSON, System.SysUtils;

procedure Registry(App: THorse);

implementation

procedure DoLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServicesAuth;
begin
  LService := TServicesAuth.Create(nil);
  try
    if LService.Login(Req.Body<TJSONObject>) then
      Res.Send<TJSONObject>(LService.GenerateToken)
    else
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('error', 'Usu?rio ou senha inv?lidos!')).Status(404);
  finally
    LService.Free;
  end;
end;

procedure DoAutorize(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServicesAuth;
  LAutorization: string;
begin
  LService := TServicesAuth.Create(nil);
  try
    LAutorization := Req.Headers['Authorization'].Replace('Bearer ', '', [rfIgnoreCase]);
    if LAutorization.Trim.IsEmpty then
    begin
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('error', 'Token Inv?lido!!')).Status(401);
      Exit;
    end;
    if not LService.AssinaturaValida(LAutorization) then
    begin
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('error', 'Token Inv?lido!!')).Status(401);
      Exit;
    end;
    if LService.TokenExpirado then
    begin
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('error', 'Token expirado!!')).Status(401);
      Exit;
    end;
    Res.Status(204);
  finally
    LService.Free;
  end;
end;

procedure Registry(App: THorse);
begin
  App.Post('/login', DoLogin);
  App.Get('/authorize', DoAutorize);
end;
end.
