object view_AlteraSenha: Tview_AlteraSenha
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Alterar Senha'
  ClientHeight = 242
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ScreenSnap = True
  PixelsPerInch = 96
  TextHeight = 17
  object layoutControlPadrao: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 469
    Height = 242
    Align = alClient
    TabOrder = 0
    object buttonEditNovaSenha: TcxButtonEdit
      Left = 33
      Top = 56
      Hint = 'Informe a nova senha'
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 5
          Kind = bkGlyph
        end>
      Properties.EchoMode = eemPassword
      Properties.Images = dm_SIGLite.imageList16_16
      Properties.OnButtonClick = buttonEditNovaSenhaPropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      TabOrder = 0
      Width = 403
    end
    object buttonEditConfirmaSenha: TcxButtonEdit
      Left = 33
      Top = 112
      Hint = 'Confirme a nova senha'
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 5
          Kind = bkGlyph
        end>
      Properties.EchoMode = eemPassword
      Properties.Images = dm_SIGLite.imageList16_16
      Properties.OnButtonClick = buttonEditConfirmaSenhaPropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      TabOrder = 1
      Width = 403
    end
    object buttonGravar: TcxButton
      Left = 33
      Top = 184
      Width = 84
      Height = 25
      Cursor = crHandPoint
      Action = actionGravar
      Default = True
      TabOrder = 2
    end
    object buttonCancelar: TcxButton
      Left = 352
      Top = 184
      Width = 84
      Height = 25
      Cursor = crHandPoint
      Action = actionCancelar
      Cancel = True
      TabOrder = 3
    end
    object layoutControlPadraoGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ItemIndex = 2
      Padding.Bottom = 20
      Padding.Left = 20
      Padding.Right = 20
      Padding.Top = 20
      Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
      ShowBorder = False
      Index = -1
    end
    object layoutItemButtonEditNovaSenha: TdxLayoutItem
      Parent = layoutControlPadraoGroup_Root
      CaptionOptions.Text = 'Nova senha:'
      CaptionOptions.Layout = clTop
      Control = buttonEditNovaSenha
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutItemConfirmaSenha: TdxLayoutItem
      Parent = layoutControlPadraoGroup_Root
      CaptionOptions.Text = 'Confirme a nova senha:'
      CaptionOptions.Layout = clTop
      Control = buttonEditConfirmaSenha
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object layoutItemButtonGravar: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahLeft
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = buttonGravar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 84
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutItemButtonCancelar: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = buttonCancelar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 84
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
  end
  object actionListAlteraSenha: TActionList
    Images = dm_SIGLite.imageList16_16
    Left = 416
    Top = 8
    object actionGravar: TAction
      Caption = 'Gravar'
      Hint = 'Gravar nova senha'
      ImageIndex = 8
      OnExecute = actionGravarExecute
    end
    object actionCancelar: TAction
      Caption = 'Cancelar'
      Hint = 'Cancelar altera'#231#227'o de senha'
      ImageIndex = 1
      OnExecute = actionCancelarExecute
    end
  end
end
