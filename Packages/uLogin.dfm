object axLoginForm: TaxLoginForm
  Left = 0
  Top = 0
  ActiveControl = edt1
  AutoSize = True
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'axLoginForm'
  ClientHeight = 288
  ClientWidth = 458
  Color = 16384
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 0
    Top = 0
    Width = 458
    Height = 288
    AutoSize = True
    OnMouseDown = img1MouseDown
  end
  object lbl1: TLabel
    Left = 399
    Top = 69
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 99
    Top = 148
    Width = 103
    Height = 13
    Caption = #1061#1101#1088#1101#1075#1083#1101#1075#1095#1080#1081#1085' '#1085#1101#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 154
    Top = 179
    Width = 48
    Height = 13
    Caption = #1053#1091#1091#1094' '#1199#1075':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 315
    Top = 178
    Width = 99
    Height = 13
    Cursor = crHandPoint
    AutoSize = False
    Caption = #1053#1091#1091#1094' '#1199#1075' '#1089#1101#1088#1075#1101#1101#1093' ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 16
    Top = 256
    Width = 20
    Height = 13
    Caption = 'lbl6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cxbtn1: TcxButton
    Left = 321
    Top = 253
    Width = 59
    Height = 23
    Caption = 'OK'
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    TabOrder = 0
    OnClick = cxbtn1Click
  end
  object cxbtn2: TcxButton
    Left = 386
    Top = 253
    Width = 58
    Height = 23
    Cancel = True
    Caption = #1043#1072#1088#1072#1093
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    ModalResult = 2
    TabOrder = 1
  end
  object cmb1: TcxLookupComboBox
    Left = 208
    Top = 145
    AutoSize = False
    Properties.KeyFieldNames = 'ID'
    Properties.ListColumns = <
      item
        FieldName = 'NAME'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = axMainModule.dsUser
    TabOrder = 2
    Height = 23
    Width = 151
  end
  object edt1: TcxTextEdit
    Left = 208
    Top = 174
    AutoSize = False
    Properties.EchoMode = eemPassword
    TabOrder = 3
    OnKeyPress = edt1KeyPress
    Height = 23
    Width = 101
  end
  object chk1: TcxCheckBox
    Left = 206
    Top = 204
    Caption = ' '#1061#1072#1076#1075#1072#1083#1072#1093
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clGreen
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 4
    Width = 83
  end
  object chk2: TcxCheckBox
    Left = 206
    Top = 224
    Caption = ' '#1040#1074#1090#1086#1083#1086#1075#1080#1085' '
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clGreen
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.TextColor = clMaroon
    Style.IsFontAssigned = True
    TabOrder = 5
    Width = 83
  end
end
