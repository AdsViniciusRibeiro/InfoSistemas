unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageXML;

type
  TDM = class(TDataModule)
    mtCliente: TFDMemTable;
    mtClienteNome: TStringField;
    mtClienteIdentidade: TStringField;
    mtClienteCPF: TStringField;
    mtClienteTelefone: TStringField;
    mtClienteEmail: TStringField;
    mtClienteCEP: TStringField;
    mtClienteLogradouro: TStringField;
    mtClienteNumero: TIntegerField;
    mtClienteComplemento: TStringField;
    mtClienteBairro: TStringField;
    mtClienteCidade: TStringField;
    mtClienteEstado: TStringField;
    mtClientePais: TStringField;
    dscCliente: TDataSource;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
