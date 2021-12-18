unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXCtrls, Vcl.ComCtrls,
  Vcl.DBCtrls, Vcl.Mask, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.ExtCtrls, uFuncCliente, FireDAC.Stan.Intf, FireDAC.Stan.StorageXML;

type
  TCrud = (cInsert, cEditar, cVisualizar, cDeletar);

  TfrmCliente = class(TForm)
    Panel1: TPanel;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnNovo: TSpeedButton;
    btnCancelar: TSpeedButton;
    pcPrincipal: TPageControl;
    tsGrid: TTabSheet;
    Panel3: TPanel;
    dbgListagem: TDBGrid;
    tsCadastro: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    edtLogradouro: TEdit;
    edtComplemento: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtBairro: TEdit;
    edtNumero: TEdit;
    edtPais: TEdit;
    edtCEP: TMaskEdit;
    edtNome: TDBEdit;
    edtIdentidade: TDBEdit;
    edtCPF: TDBEdit;
    edtTelefone: TDBEdit;
    edtEmail: TDBEdit;
    StatusBar1: TStatusBar;
    SBPesquisar: TSearchBox;
    btnPesquisarCep: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure SBPesquisarChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtCEPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarCepClick(Sender: TObject);
    procedure ControlaBotoes;
    procedure tsGridShow(Sender: TObject);
    procedure tsCadastroShow(Sender: TObject);
  private
    { Private declarations }
    Crud : TCrud;
  public
    { Public declarations }
  end;

var
  frmCliente: TfrmCliente;

implementation

uses
  uDM, Datasnap.DBClient;

{$R *.dfm}

procedure TfrmCliente.btnPesquisarCepClick(Sender: TObject);
var
  Msg : String;
begin
  if BuscaCep(edtCEP.Text, Msg) then
  begin
    edtLogradouro.Text  := Logradouro;
    edtComplemento.Text := Complemento;
    edtBairro.Text      := Bairro;
    edtCidade.Text      := Localidade;
    edtUF.Text          := UF;

    edtNumero.SetFocus;
  end
  else
    ShowMessage(Msg);
end;

procedure TfrmCliente.btnCancelarClick(Sender: TObject);
begin
  DM.mtCliente.Cancel;
  pcPrincipal.ActivePage := tsGrid;
end;

procedure TfrmCliente.btnEditarClick(Sender: TObject);
begin
  DM.mtCliente.Edit;
  pcPrincipal.ActivePage := tsCadastro;
  Crud := cEditar;
end;

procedure TfrmCliente.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Deseja excluir o registro?'),
    'Confirmação - InfoSistemas', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) <> idYes then
    Exit;

  if not DM.mtCliente.IsEmpty then
    DM.mtCliente.Delete
  else
    ShowMessage('Não existe cliente para ser excluído.');
end;

procedure TfrmCliente.btnNovoClick(Sender: TObject);
begin
  DM.mtCliente.Append;
  pcPrincipal.ActivePage := tsCadastro;
  edtNome.SetFocus;
  Crud := cInsert;
end;

procedure TfrmCliente.btnSairClick(Sender: TObject);
begin
  if pcPrincipal.ActivePage = tsCadastro then
  begin
    if Crud in [cInsert, cEditar] then
      if Application.MessageBox(PChar('Os dados do cliente serão perdidos, deseja sair?'),
         'Confirmação - InfoSistemas', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) <> idYes then
        Exit;

    DM.mtCliente.Cancel;
    pcPrincipal.ActivePage := tsGrid;
  end
  else
    Close;
end;

procedure TfrmCliente.btnSalvarClick(Sender: TObject);
begin
  try
    ValidaDados(edtNome.Text, 'Informe o nome.', edtNome);
    ValidaDados(edtIdentidade.Text, 'Informe a Identidade.', edtIdentidade);
    ValidaDados(edtCPF.Text, 'Informe o CPF.', edtCPF);
    ValidaDados(edtCPF.Text, 'Informe o Telefone.', edtCPF);
    ValidaDados(edtEmail.Text, 'Informe o Email.', edtEmail);

    DM.mtCliente.FieldByName('CEP').Value         := ValidaDados(edtCEP.Text, 'Informe o CEP', edtCEP);
    DM.mtCliente.FieldByName('Logradouro').Value  := ValidaDados(edtLogradouro.Text, 'Informe o Logradouro', edtLogradouro);
    DM.mtCliente.FieldByName('Numero').Value      := ValidaDados(edtNumero.Text, 'Informe o Número', edtNumero);
    DM.mtCliente.FieldByName('Complemento').Value := Trim(edtComplemento.Text);
    DM.mtCliente.FieldByName('Bairro').Value      := ValidaDados(edtBairro.Text, 'Informe o bairro', edtBairro);
    DM.mtCliente.FieldByName('Cidade').Value      := ValidaDados(edtCidade.Text, 'Informe a Cidade', edtCidade);
    DM.mtCliente.FieldByName('Estado').Value      := ValidaDados(edtUF.Text, 'Informe o Estado', edtUF);
    DM.mtCliente.FieldByName('Pais').Value        := ValidaDados(edtPais.Text, 'Informe o País', edtPais);
    DM.mtCliente.Post;

    if Crud = cInsert then
    begin
      DM.mtCliente.SaveToFile(ExtractFileDir(ParamStr(0))+'\cliente.xml', sfXML);
      EnviarEmail('Cadastro InfoSistemas', edtEmail.Text, ExtractFileDir(ParamStr(0))+'\cliente.xml');
    end;

    pcPrincipal.ActivePage := tsGrid;
  except
    on E: Exception do
      Application.MessageBox(PChar(E.Message), 'TesteInfo - Informação!', MB_ICONINFORMATION);
  end;
end;

procedure TfrmCliente.ControlaBotoes;
begin
  btnNovo.Enabled     := DM.mtCliente.State in [dsBrowse, dsInactive];
  btnEditar.Enabled   := (DM.mtCliente.State in [dsBrowse]) and (not DM.mtCliente.IsEmpty);
  btnExcluir.Enabled  := (DM.mtCliente.State in [dsBrowse]) and (not DM.mtCliente.IsEmpty);
  btnSalvar.Enabled   := (DM.mtCliente.State in [dsInsert, dsEdit]) and (not DM.mtCliente.IsEmpty);
  btnCancelar.Enabled := (DM.mtCliente.State in [dsInsert, dsEdit]) and (not DM.mtCliente.IsEmpty);
end;

procedure TfrmCliente.edtCEPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    btnPesquisarCepClick(Sender);
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.mtCliente.Close;
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  tsGrid.TabVisible      := False;
  tsCadastro.TabVisible  := False;
  pcPrincipal.ActivePage := tsGrid;

  DM.mtCliente.Open;
end;

procedure TfrmCliente.SBPesquisarChange(Sender: TObject);
begin
  FiltrarDataSet(DM.mtCliente, 'Nome like '+ QuotedStr('%' + SBPesquisar.Text + '%'));
end;

procedure TfrmCliente.tsCadastroShow(Sender: TObject);
begin
  ControlaBotoes;
end;

procedure TfrmCliente.tsGridShow(Sender: TObject);
begin
  ControlaBotoes;
end;

end.
