object view_Extrato: Tview_Extrato
  Left = 0
  Top = 0
  Caption = 'Extrato'
  ClientHeight = 489
  ClientWidth = 959
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object layoutControlPadrao: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 959
    Height = 489
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 800
    ExplicitHeight = 461
    object comboBoxTipo: TcxComboBox
      Left = 28
      Top = 59
      Hint = 'Tipo de Extrato'
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'Selecione ...'
        'Pr'#233'vio'
        'Fechado')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 0
      Text = 'Selecione ...'
      Width = 98
    end
    object comboBoxAno: TcxComboBox
      Left = 134
      Top = 59
      Hint = 'Selecione o ano'
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'Selecione ...'
        '2019'
        '2020'
        '2021')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 1
      Text = 'Selecione ...'
      Width = 91
    end
    object comboBoxMeses: TcxComboBox
      Left = 233
      Top = 59
      Hint = 'Selecione o m'#234's'
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'Selecione ...'
        'Janeiro'
        'Fevereiro'
        'Mar'#231'o'
        'Abril'
        'Maio'
        'Junho'
        'Julho'
        'Agosto'
        'Setembro'
        'Outubro'
        'Novembro'
        'Dezembro')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 2
      Text = 'Selecione ...'
      Width = 121
    end
    object comboBoxPeriodos: TcxComboBox
      Left = 362
      Top = 59
      Hint = 'Selecione a quinzena'
      Properties.DropDownListStyle = lsEditFixedList
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 3
      Width = 121
    end
    object cxGrid: TcxGrid
      Left = 13
      Top = 130
      Width = 933
      Height = 135
      TabOrder = 6
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsGrid
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = cxGridDBTableView1val_producao
          end
          item
            Format = ',0;-,0'
            Kind = skSum
            Column = cxGridDBTableView1qtd_entrega
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxGridDBTableView1cod_entregador: TcxGridDBColumn
          DataBinding.FieldName = 'cod_entregador'
          Width = 87
        end
        object cxGridDBTableView1nom_entregador: TcxGridDBColumn
          DataBinding.FieldName = 'nom_entregador'
          Width = 237
        end
        object cxGridDBTableView1val_verba: TcxGridDBColumn
          DataBinding.FieldName = 'val_verba'
          Width = 204
        end
        object cxGridDBTableView1qtd_entrega: TcxGridDBColumn
          DataBinding.FieldName = 'qtd_entrega'
          Width = 201
        end
        object cxGridDBTableView1val_producao: TcxGridDBColumn
          DataBinding.FieldName = 'val_producao'
          Width = 202
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object buttonPesquisar: TcxButton
      Left = 491
      Top = 59
      Width = 94
      Height = 25
      Cursor = crHandPoint
      Action = actionPesquisar
      TabOrder = 4
    end
    object buttonExportar: TcxButton
      Left = 13
      Top = 451
      Width = 94
      Height = 25
      Cursor = crHandPoint
      Action = actionExportar
      TabOrder = 7
    end
    object buttonFechar: TcxButton
      Left = 852
      Top = 451
      Width = 94
      Height = 25
      Cursor = crHandPoint
      Action = actionFechar
      TabOrder = 8
    end
    object labelPeriodo: TcxLabel
      Left = 923
      Top = 63
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI Semibold'
      Style.Font.Style = [fsBold]
      Style.HotTrack = False
      Style.IsFontAssigned = True
      Transparent = True
    end
    object layoutControlPadraoGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ItemIndex = 2
      ShowBorder = False
      Index = -1
    end
    object layoutGroupHeader: TdxLayoutGroup
      Parent = layoutControlPadraoGroup_Root
      CaptionOptions.Text = 'Crit'#233'rios'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object layoutItemComboBoxTipo: TdxLayoutItem
      Parent = layoutGroupHeader
      AlignHorz = ahLeft
      AlignVert = avBottom
      CaptionOptions.Text = 'Tipo:'
      CaptionOptions.Layout = clTop
      Control = comboBoxTipo
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 98
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutItemComboBoxAno: TdxLayoutItem
      Parent = layoutGroupHeader
      CaptionOptions.Text = 'Ano:'
      CaptionOptions.Layout = clTop
      Control = comboBoxAno
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 91
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object layoutItemComboBoxMeses: TdxLayoutItem
      Parent = layoutGroupHeader
      CaptionOptions.Text = 'M'#234's:'
      CaptionOptions.Layout = clTop
      Control = comboBoxMeses
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object layoutItemComboBoxPeriodos: TdxLayoutItem
      Parent = layoutGroupHeader
      CaptionOptions.Text = 'Quinzena:'
      CaptionOptions.Layout = clTop
      Control = comboBoxPeriodos
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object layoutItemGrid: TdxLayoutItem
      Parent = layoutControlPadraoGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Extrato'
      CaptionOptions.Layout = clTop
      Control = cxGrid
      ControlOptions.OriginalHeight = 135
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object layoutItemButtonPesquisar: TdxLayoutItem
      Parent = layoutGroupHeader
      AlignHorz = ahLeft
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = buttonPesquisar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 94
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object layoutItemButtonExportar: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahLeft
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = buttonExportar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 94
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutItemButtonFechar: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = buttonFechar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 94
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
      Parent = layoutControlPadraoGroup_Root
      AlignVert = avBottom
      LayoutDirection = ldHorizontal
      Index = 2
      AutoCreated = True
    end
    object layoutItemLabelPeriodo: TdxLayoutItem
      Parent = layoutGroupHeader
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'cxLabel1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = labelPeriodo
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 8
      ControlOptions.ShowBorder = False
      Index = 5
    end
  end
  object SaveDialog: TSaveDialog
    Left = 440
  end
  object actionListEntregas: TActionList
    Images = dm_SIGLite.imageList16_16
    Left = 492
    object actionPesquisar: TAction
      Caption = 'Pesquisar'
      Hint = 'Pesquisar Periodo'
      ImageIndex = 7
      OnExecute = actionPesquisarExecute
    end
    object actionExportar: TAction
      Caption = 'Exportar'
      Hint = 'Exportar dados'
      ImageIndex = 4
      OnExecute = actionExportarExecute
    end
    object actionFechar: TAction
      Caption = 'Fechar'
      Hint = 'Fechar a tela'
      ImageIndex = 2
      OnExecute = actionFecharExecute
    end
  end
  object dsGrid: TDataSource
    AutoEdit = False
    DataSet = fdMemTablePrevia
    Left = 600
  end
  object fdMemTablePrevia: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 696
    Top = 8
    object fdMemTablePreviacod_entregador: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cod_entregador'
    end
    object fdMemTablePrevianom_entregador: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nom_entregador'
      Size = 70
    end
    object fdMemTablePreviaval_verba: TFloatField
      DisplayLabel = 'Verba'
      FieldName = 'val_verba'
      DisplayFormat = ',0.00;-,0,00'
    end
    object fdMemTablePreviaqtd_entrega: TIntegerField
      DisplayLabel = 'Qtde.'
      FieldName = 'qtd_entrega'
      DisplayFormat = ',0;-,0'
    end
    object fdMemTablePreviaval_producao: TFloatField
      DisplayLabel = 'Produ'#231#227'o'
      FieldName = 'val_producao'
      DisplayFormat = ',0.00;-,0.00'
    end
  end
end
