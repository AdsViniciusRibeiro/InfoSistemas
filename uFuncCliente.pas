unit uFuncCliente;

interface

uses
  Winapi.WinInet, System.JSON, System.SysUtils, Data.DB, Vcl.Mask, Vcl.Dialogs,
  System.Classes, vcl.forms, System.Variants, Vcl.DBCtrls, Vcl.StdCtrls, IniFiles,
  IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase, System.MaskUtils;

  procedure FiltrarDataSet(DataSet : TDataSet; Filtro : String);
  function BuscaCep(CEPPesquisa : String; var sMsg : String) : Boolean;
  function ValidaDados(Value: Variant; Mensagem: string; Sender: TObject): Variant;
  function EnviarEmail(const AAssunto, ADestino, sAnexo: String): Boolean;
  function DadosClienteEmail : Boolean;

var
  Cep, Logradouro, Complemento, Bairro, Localidade, UF, Unidade, Ibge, Gia : String;
  ListaBody : TStringList;

implementation

uses uDM, IdHTTP;

procedure FiltrarDataSet(DataSet : TDataSet; Filtro : String);
begin
  Dataset.FilterOptions := [foCaseInsensitive];
  DataSet.Filtered := False;
  DataSet.Filter   := Filtro;
  DataSet.Filtered := True;
end;

function BuscaCep(CEPPesquisa : String; var sMsg : String) : Boolean;
var
  HTTP       : TidHTTP;
  JSonString : String;
begin
  if InternetCheckConnection('https://viacep.com.br/', 1, 0) then
  begin
    HTTP := TIdHTTP.Create(nil);
    JSonString := HTTP.Get('http://viacep.com.br/ws/' + CEPPesquisa + '/json/');

    with TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSonString), 0) as TJSONObject do
    try
      if Count > 1 then
      begin
        Cep         := AnsiUpperCase(Get(0).JsonValue.Value);
        Logradouro  := AnsiUpperCase(Get(1).JsonValue.Value);
        Complemento := AnsiUpperCase(Get(2).JsonValue.Value);
        Bairro      := AnsiUpperCase(Get(3).JsonValue.Value);
        Localidade  := AnsiUpperCase(Get(4).JsonValue.Value);
        UF          := AnsiUpperCase(Get(5).JsonValue.Value);
        Unidade     := AnsiUpperCase(Get(6).JsonValue.Value);
        Ibge        := AnsiUpperCase(Get(7).JsonValue.Value);
        Gia         := AnsiUpperCase(Get(8).JsonValue.Value);

        Result := True;
      end
      else
        sMsg := 'Cep não encontrado.'
    finally
      Free;
    end;
  end
  else
    raise Exception.Create('Falha ao conectar com ViaCep');
end;

function ValidaDados(Value: Variant; Mensagem: string; Sender: TObject): Variant;
begin
  if Trim(VarToStr(Value)) = '' then
  begin
    if Sender is TDBEdit then
      (Sender as TDBEdit).SetFocus
    else
      if Sender is TEdit then
        (Sender as TEdit).SetFocus
      else
        if Sender is TMaskEdit then
          (Sender as TMaskEdit).SetFocus;

    raise Exception.Create(Mensagem);
  end;

  Result := Value;
end;

function EnviarEmail(const AAssunto, ADestino, sAnexo: String): Boolean;
var
  // variáveis e objetos necessários para o envio
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
begin
  // instanciação dos objetos
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  IdSMTP := TIdSMTP.Create(Application);
  IdMessage := TIdMessage.Create(Application);

  try
    // Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    // Configuração do servidor SMTP (TIdSMTP)
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseImplicitTLS;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := 465;
    IdSMTP.Host := 'smtp.gmail.com';
    IdSMTP.Username := 'DevEnvioEmail@gmail.com';
    IdSMTP.Password := '62111200';

    // Configuração da mensagem (TIdMessage)
    IdMessage.From.Address := 'DevEnvioEmail@gmail.com';
    IdMessage.From.Name := 'InfoSistemas';
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := ADestino;
    IdMessage.Subject := AAssunto;
    IdMessage.Encoding := meMIME;

    //Montando corpo email
    ListaBody := TStringList.Create;
    DadosClienteEmail;

    // Configuração do corpo do email (TIdText)
    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add(ListaBody.Text);
    IdText.ContentType := 'text/html; charset=iso-8859-1';

    // Opcional - Anexo da mensagem (TIdAttachmentFile)
    if FileExists(sAnexo) then
      TIdAttachmentFile.Create(IdMessage.MessageParts, sAnexo);

    // Conexão e autenticação
    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E:Exception do
      begin
        MessageDlg('Erro na conexão ou autenticação: ' +
          E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;

    // Envio da mensagem
    try
      IdSMTP.Send(IdMessage);
      MessageDlg('Email enviado com sucesso!', mtInformation, [mbOK], 0);
    except
      On E:Exception do
      begin
        MessageDlg('Erro ao enviar o Email: ' +
          E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    // desconecta do servidor
    IdSMTP.Disconnect;
    // liberação da DLL
    UnLoadOpenSSLLibrary;
    // liberação dos objetos da memória
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
    FreeAndNil(ListaBody);
  end;
end;

function DadosClienteEmail : Boolean;
begin
  try
    ListaBody.Add('<html><head><meta content=''text/html; charset=iso-8859-1'' http-equiv=''Content-Type'' />');
    ListaBody.Add('<title>EMAIL AUTOMATICO - Cliente ' + DM.mtClienteNome.AsString +'</title> </head>');
    ListaBody.Add('<body bgcolor=''#FFFFFF''>');
    ListaBody.Add('<p><b> Nome : </b>' +        DM.mtClienteNome.AsString);
    ListaBody.Add('<p><b> CPF : </b>' +         FormatMaskText('999.999.999-99;0;_', DM.mtClienteCPF.AsString));
    ListaBody.Add('<p><b> Identidade : </b>' +  DM.mtClienteIdentidade.AsString);
    ListaBody.Add('<p><b> Telefone : </b>' +    FormatMaskText('!\(##\)####\-####;0;_', DM.mtClienteTelefone.AsString));
    ListaBody.Add('<p><b> E-mail : </b>' +      DM.mtClienteEmail.AsString);
    ListaBody.Add('<p><b> CEP : </b>' +         FormatMaskText('#####\-###;0;_', DM.mtClienteCEP.AsString));
    ListaBody.Add('<p><b> Logradouro : </b>' +  DM.mtClienteLogradouro.AsString);
    ListaBody.Add('<p><b> Número : </b>' +      DM.mtClienteNumero.AsString);
    ListaBody.Add('<p><b> Complemento : </b>' + DM.mtClienteComplemento.AsString);
    ListaBody.Add('<p><b> Bairro : </b>' +      DM.mtClienteBairro.AsString);
    ListaBody.Add('<p><b> Cidade : </b>' +      DM.mtClienteCidade.AsString);
    ListaBody.Add('<p><b> Estado : </b>' +      DM.mtClienteEstado.AsString);
    ListaBody.Add('<p><b> País : </b>' +        DM.mtClientePais.AsString);
    ListaBody.Add('</body>');
    ListaBody.Add('</html>');
  except on E: Exception do
    ShowMessage('Erro ao montar corpo email.');
  end;
end;

end.
