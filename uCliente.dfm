object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cliente'
  ClientHeight = 488
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 900
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object btnSalvar: TSpeedButton
      Left = 681
      Top = 0
      Width = 73
      Height = 29
      Align = alRight
      Caption = '&Salvar'
      OnClick = btnSalvarClick
      ExplicitLeft = 680
    end
    object btnEditar: TSpeedButton
      Left = 535
      Top = 0
      Width = 73
      Height = 29
      Align = alRight
      Caption = '&Editar'
      OnClick = btnEditarClick
      ExplicitLeft = 534
    end
    object btnSair: TSpeedButton
      Left = 827
      Top = 0
      Width = 73
      Height = 29
      Align = alRight
      Caption = 'Sair'
      OnClick = btnSairClick
      ExplicitLeft = 826
    end
    object btnExcluir: TSpeedButton
      Left = 608
      Top = 0
      Width = 73
      Height = 29
      Align = alRight
      Caption = 'E&xcluir'
      OnClick = btnExcluirClick
      ExplicitLeft = 607
    end
    object btnNovo: TSpeedButton
      Left = 462
      Top = 0
      Width = 73
      Height = 29
      Align = alRight
      Caption = '&Novo'
      OnClick = btnNovoClick
      ExplicitLeft = 461
    end
    object btnCancelar: TSpeedButton
      Left = 754
      Top = 0
      Width = 73
      Height = 29
      Align = alRight
      Caption = '&Cancelar'
      OnClick = btnCancelarClick
      ExplicitLeft = 753
    end
  end
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 900
    Height = 440
    ActivePage = tsGrid
    Align = alClient
    TabOrder = 1
    object tsGrid: TTabSheet
      Caption = 'tsGrid'
      OnShow = tsGridShow
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          892
          32)
        object SBPesquisar: TSearchBox
          Left = 5
          Top = 5
          Width = 883
          Height = 21
          Anchors = [akLeft, akRight]
          TabOrder = 0
          TextHint = 'Pesquisar do nome Cliente'
          OnChange = SBPesquisarChange
        end
      end
      object dbgListagem: TDBGrid
        Left = 0
        Top = 32
        Width = 892
        Height = 380
        Align = alClient
        DataSource = DM.dscCliente
        DrawingStyle = gdsGradient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'CPF'
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 320
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Identidade'
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Telefone'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Email'
            Width = 254
            Visible = True
          end>
      end
    end
    object tsCadastro: TTabSheet
      Caption = 'tsCadastro'
      ImageIndex = 1
      OnShow = tsCadastroShow
      DesignSize = (
        892
        412)
      object Label8: TLabel
        Left = 8
        Top = 10
        Width = 27
        Height = 13
        Caption = 'Nome'
        FocusControl = edtNome
      end
      object Label9: TLabel
        Left = 322
        Top = 10
        Width = 52
        Height = 13
        Caption = 'Identidade'
        FocusControl = edtIdentidade
      end
      object Label10: TLabel
        Left = 8
        Top = 59
        Width = 19
        Height = 13
        Caption = 'CPF'
        FocusControl = edtCPF
      end
      object Label11: TLabel
        Left = 168
        Top = 58
        Width = 42
        Height = 13
        Caption = 'Telefone'
        FocusControl = edtTelefone
      end
      object Label12: TLabel
        Left = 316
        Top = 59
        Width = 24
        Height = 13
        Caption = 'Email'
        FocusControl = edtEmail
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 101
        Width = 880
        Height = 193
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Endere'#231'o'
        TabOrder = 5
        object Label1: TLabel
          Left = 7
          Top = 18
          Width = 19
          Height = 13
          Caption = 'CEP'
        end
        object Label2: TLabel
          Left = 7
          Top = 60
          Width = 55
          Height = 13
          Caption = 'Logradouro'
        end
        object Label3: TLabel
          Left = 134
          Top = 143
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object Label4: TLabel
          Left = 240
          Top = 102
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object Label5: TLabel
          Left = 473
          Top = 102
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object Label6: TLabel
          Left = 7
          Top = 102
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object Label7: TLabel
          Left = 7
          Top = 143
          Width = 37
          Height = 13
          Caption = 'Numero'
        end
        object Label13: TLabel
          Left = 475
          Top = 143
          Width = 19
          Height = 13
          Caption = 'Pa'#237's'
        end
        object edtLogradouro: TEdit
          Left = 7
          Top = 74
          Width = 545
          Height = 21
          Enabled = False
          TabOrder = 2
        end
        object edtComplemento: TEdit
          Left = 134
          Top = 157
          Width = 337
          Height = 21
          TabOrder = 7
        end
        object edtCidade: TEdit
          Left = 240
          Top = 116
          Width = 230
          Height = 21
          Enabled = False
          TabOrder = 4
        end
        object edtUF: TEdit
          Left = 473
          Top = 116
          Width = 79
          Height = 21
          Enabled = False
          TabOrder = 5
        end
        object edtBairro: TEdit
          Left = 7
          Top = 116
          Width = 230
          Height = 21
          Enabled = False
          TabOrder = 3
        end
        object edtNumero: TEdit
          Left = 7
          Top = 157
          Width = 121
          Height = 21
          NumbersOnly = True
          TabOrder = 6
        end
        object edtPais: TEdit
          Left = 475
          Top = 157
          Width = 77
          Height = 21
          TabOrder = 8
        end
        object edtCEP: TMaskEdit
          Left = 7
          Top = 33
          Width = 162
          Height = 21
          EditMask = '#####\-###;0;_'
          MaxLength = 9
          TabOrder = 0
          Text = ''
          OnKeyDown = edtCEPKeyDown
        end
        object btnPesquisarCep: TBitBtn
          Left = 175
          Top = 31
          Width = 75
          Height = 25
          Caption = 'Pesquisar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnPesquisarCepClick
        end
      end
      object edtNome: TDBEdit
        Left = 8
        Top = 25
        Width = 300
        Height = 21
        DataField = 'Nome'
        DataSource = DM.dscCliente
        TabOrder = 0
      end
      object edtIdentidade: TDBEdit
        Left = 322
        Top = 25
        Width = 264
        Height = 21
        DataField = 'Identidade'
        DataSource = DM.dscCliente
        TabOrder = 1
      end
      object edtCPF: TDBEdit
        Left = 8
        Top = 74
        Width = 147
        Height = 21
        DataField = 'CPF'
        DataSource = DM.dscCliente
        TabOrder = 2
      end
      object edtTelefone: TDBEdit
        Left = 168
        Top = 74
        Width = 134
        Height = 21
        DataField = 'Telefone'
        DataSource = DM.dscCliente
        TabOrder = 3
      end
      object edtEmail: TDBEdit
        Left = 316
        Top = 74
        Width = 400
        Height = 21
        DataField = 'Email'
        DataSource = DM.dscCliente
        TabOrder = 4
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 469
    Width = 900
    Height = 19
    Panels = <>
  end
end
