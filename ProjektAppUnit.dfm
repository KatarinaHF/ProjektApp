object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 761
  ClientWidth = 1022
  Color = clHoneydew
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnResize = OnResize
  TextHeight = 15
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 1022
    Height = 761
    Align = alClient
    ExplicitWidth = 704
    ExplicitHeight = 505
  end
  object LabelSignIn: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 200
    Width = 450
    Height = 40
    Alignment = taCenter
    Caption = 'Sign in with your Microsoft account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object LogInButton: TButton
    AlignWithMargins = True
    Left = 0
    Top = 3
    Width = 1022
    Height = 755
    Margins.Left = 0
    Margins.Right = 0
    Align = alClient
    Caption = 'Log In'
    TabOrder = 0
    OnClick = LogInClick
    ExplicitWidth = 214
    ExplicitHeight = 118
  end
end
