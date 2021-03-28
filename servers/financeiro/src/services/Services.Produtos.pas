unit Services.Produtos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDac.Stan.Option, FireDAC.Stan.Error,
  FireDac.Stan.Def, FireDac.Stan.Pool, FireDac.Stan.Async, FireDac.Phys,
  FireDac.Stan.ExprFuncs, FireDac.ConsoleUI.Wait, FireDac.Stan.Param, FireDac.DatS, DB,
  FireDaC.Comp.DataSet, FireDac.Comp.Client, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.DApt.Intf, FireDAC.DApt;

type
  TServicesProdutos = class(TDataModule)
    qryProdutos: TFDQuery;
    Connection: TFDConnection;
    qryProdutosid: TFDAutoIncField;
    qryProdutosdescricao: TStringField;
    qryProdutospreco: TWideStringField;
    qryProdutosgrupo: TStringField;
  private
    { Private declarations }
  public
    function ListAll: TFDQuery;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServicesProdutos }

function TServicesProdutos.ListAll: TFDQuery;
begin
  qryProdutos.Open();
  Result := qryProdutos;
end;

end.
