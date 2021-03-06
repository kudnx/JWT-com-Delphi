program Servers.Financeiro;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  Services.Produtos in 'src\services\Services.Produtos.pas' {ServicesProdutos: TDataModule},
  Controllers.Produtos in 'src\controllers\Controllers.Produtos.pas',
  Commons.Middleware.Auth in '..\commons\Commons.Middleware.Auth.pas';

var
  App: THorse;
begin
  App := THorse.Create;
  App.Use(Jhonson);
  App.Use(HandleException);
  App.Use(AuthHandler);

  Controllers.Produtos.Registry(App);

  App.Listen(9002);
end.
