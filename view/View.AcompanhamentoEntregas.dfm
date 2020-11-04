object view_AcompanhamntoEntregas: Tview_AcompanhamntoEntregas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Acompanhamento de Entregas Realizadas'
  ClientHeight = 581
  ClientWidth = 1123
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
  object layoutControlMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 1123
    Height = 581
    Align = alClient
    TabOrder = 0
    object comboBoxMeses: TcxComboBox
      Left = 129
      Top = 59
      Hint = 'Selecione o m'#234's.'
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
      TabOrder = 1
      Text = 'Selecione ...'
      Width = 141
    end
    object comboBoxPeriodos: TcxComboBox
      Left = 278
      Top = 59
      Hint = 'Selecione a quinzena.'
      Properties.DropDownListStyle = lsEditFixedList
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 2
      Width = 208
    end
    object buttonPesquisar: TcxButton
      Left = 494
      Top = 59
      Width = 104
      Height = 25
      Cursor = crHandPoint
      Action = actionPesquisar
      TabOrder = 3
    end
    object comboBoxAno: TcxComboBox
      Left = 28
      Top = 59
      Hint = 'Selecione o ano'
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'Selecione ...'
        '2019'
        '2020'
        '2021'
        '2022')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 0
      Text = 'Selecione ...'
      Width = 93
    end
    object cxGrid: TcxGrid
      Left = 13
      Top = 130
      Width = 1097
      Height = 405
      TabOrder = 5
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsGrid
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object labelPeriodo: TcxLabel
      Left = 1087
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
    object buttonExportar: TcxButton
      Left = 13
      Top = 543
      Width = 92
      Height = 25
      Cursor = crHandPoint
      Action = actionExportar
      TabOrder = 6
    end
    object buttonFechar: TcxButton
      Left = 1016
      Top = 543
      Width = 94
      Height = 25
      Cursor = crHandPoint
      Action = actionFechar
      TabOrder = 7
    end
    object layoutControlMainGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ItemIndex = 2
      ShowBorder = False
      Index = -1
    end
    object layoutGroupCriterios: TdxLayoutGroup
      Parent = layoutControlMainGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Crit'#233'rios'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object bayoutItemComboBoxMeses: TdxLayoutItem
      Parent = layoutGroupCriterios
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'M'#234's:'
      CaptionOptions.Layout = clTop
      Control = comboBoxMeses
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 141
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object layoutItemComboBoxPeriodos: TdxLayoutItem
      Parent = layoutGroupCriterios
      AlignHorz = ahLeft
      AlignVert = avClient
      CaptionOptions.Text = 'Quinzenas:'
      CaptionOptions.Layout = clTop
      Control = comboBoxPeriodos
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 208
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object layoutItemButtonPesquisar: TdxLayoutItem
      Parent = layoutGroupCriterios
      AlignHorz = ahLeft
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = buttonPesquisar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 104
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object layoutItemComboBoxAno: TdxLayoutItem
      Parent = layoutGroupCriterios
      AlignVert = avClient
      CaptionOptions.Text = 'Ano:'
      CaptionOptions.Layout = clTop
      Control = comboBoxAno
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 93
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutItemGrid: TdxLayoutItem
      Parent = layoutControlMainGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Entregas'
      CaptionOptions.Layout = clTop
      Control = cxGrid
      ControlOptions.OriginalHeight = 200
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object layoutItemLabelPeriodo: TdxLayoutItem
      Parent = layoutGroupCriterios
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'cxLabel1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = labelPeriodo
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 8
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
      ControlOptions.OriginalWidth = 92
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutItemButtonFechar: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Control = buttonFechar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 94
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
      Parent = layoutControlMainGroup_Root
      AlignVert = avBottom
      LayoutDirection = ldHorizontal
      Index = 2
      AutoCreated = True
    end
  end
  object actionListEntregas: TActionList
    Images = dm_SIGLite.imageList16_16
    Left = 672
    Top = 16
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
    DataSet = dm_SIGLite.fdMemTabEntregas
    Left = 544
    Top = 24
  end
  object SaveDialog: TSaveDialog
    Left = 608
    Top = 32
  end
end
