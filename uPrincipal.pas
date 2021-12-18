unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CategoryButtons, Vcl.WinXCtrls,
  Vcl.ExtCtrls, dxGDIPlusClasses, uCliente;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SVMenu: TSplitView;
    Panel3: TPanel;
    TSMenu: TToggleSwitch;
    CategoryButtons1: TCategoryButtons;
    Image1: TImage;
    procedure TSMenuClick(Sender: TObject);
    procedure CategoryButtons1Categories0Items0Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items2Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.CategoryButtons1Categories0Items0Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCliente, frmCliente);
  frmCliente.ShowModal;
  FreeAndNil(frmCliente);
end;

procedure TfrmPrincipal.CategoryButtons1Categories0Items1Click(Sender: TObject);
begin
  Application.MessageBox(
    'Avaliação - InfoSistemas'+ #13 +
    'Versão: 1.0'+ #13 +
    'Desenvolvido por: Vinícius Ribeiro',
    'Avaliação InfoSistemas - Informação!', MB_ICONINFORMATION);
end;

procedure TfrmPrincipal.CategoryButtons1Categories0Items2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.TSMenuClick(Sender: TObject);
begin
  if TSMenu.State = tssOff then
  begin
    TSMenu.ThumbColor := clRed;
    SVMenu.Opened     := False;
  end
  else
  begin
    TSMenu.ThumbColor := clBlue;
    SVMenu.Opened     := True;
  end;
end;

end.
