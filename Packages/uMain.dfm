object axMainForm: TaxMainForm
  Left = 0
  Top = 0
  Caption = 'axMainForm'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 640
    Height = 160
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    ColorSchemeName = 'Silver'
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    Style = rs2010
    SupportNonClientDrawing = True
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Axplorer'
      Groups = <>
      Index = 0
    end
    object dxrbntbRibbon1Tab2: TdxRibbonTab
      Caption = #1052#1257#1085#1075#1257#1085' '#1093#1257#1088#1257#1085#1075#1257
      Groups = <>
      Index = 1
    end
    object dxrbntbRibbon1Tab3: TdxRibbonTab
      Caption = #1041#1072#1088#1072#1072' '#1084#1072#1090#1077#1088#1080#1072#1083
      Groups = <>
      Index = 2
    end
    object dxRibbon1Tab6: TdxRibbonTab
      Caption = #1062#1072#1083#1080#1085
      Groups = <>
      Index = 3
    end
    object dxRibbon1Tab2: TdxRibbonTab
      Caption = #1046#1091#1088#1085#1072#1083
      Groups = <>
      Index = 4
    end
    object dxRibbon1Tab3: TdxRibbonTab
      Caption = #1058#1072#1081#1083#1072#1085
      Groups = <>
      Index = 5
    end
    object dxRibbon1Tab5: TdxRibbonTab
      Caption = #1061#1101#1088#1101#1075#1089#1101#1083
      Groups = <>
      Index = 6
    end
    object dxRibbon1Tab4: TdxRibbonTab
      Caption = #1051#1072#1074#1083#1072#1093
      Groups = <>
      Index = 7
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Buttons = <>
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Left = 132
      Top = 0
      Caption = #1041#1072#1072#1079#1091#1091#1076
    end
    object dxRibbonBackstageViewTabSheet2: TdxRibbonBackstageViewTabSheet
      Left = 132
      Top = 0
      Caption = #1061#1101#1088#1101#1075#1083#1101#1075#1095#1080#1076
    end
    object dxRibbonBackstageViewTabSheet3: TdxRibbonBackstageViewTabSheet
      Left = 132
      Top = 0
      Caption = #1058#1086#1093#1080#1088#1075#1086#1086
    end
    object dxRibbonBackstageViewTabSheet4: TdxRibbonBackstageViewTabSheet
      Left = 132
      Top = 0
      Active = True
      Caption = #1055#1088#1086#1075#1088#1072#1084#1099#1085' '#1090#1091#1093#1072#1081
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Left = 0
    Top = 457
    Width = 640
    Height = 23
    Panels = <>
    Ribbon = dxRibbon1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 496
    Top = 216
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 0
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
  end
end
