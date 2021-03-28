unit Services.Clientes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDac.Stan.Option, FireDAC.Stan.Error,
  FireDac.Stan.Def, FireDac.Stan.Pool, FireDac.Stan.Async, FireDac.Phys,
  FireDac.Stan.ExprFuncs, FireDac.ConsoleUI.Wait, FireDac.Stan.Param, FireDac.DatS, DB,
  FireDaC.Comp.DataSet, FireDac.Comp.Client, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.DApt.Intf, FireDAC.DApt;

type
  TServicesClientes = class(TDataModule)
    Connection: TFDConnection;
    qryClientes: TFDQuery;
    qryClientesid: TFDAutoIncField;
    qryClientesnome: TStringField;
    qryClientessobrenome: TStringField;
    qryClientesemail: TStringField;
    qryClientestelefone: TStringField;
    qryClienteslocalidade: TStringField;
  private
    { Private declarations }
  public
    function ListAll: TFDQuery;
  end;

var
  ServicesClientes: TServicesClientes;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TServicesClientes.ListAll: TFDQuery;
begin
  qryClientes.Open();
  Result := qryClientes;
end;

end.
