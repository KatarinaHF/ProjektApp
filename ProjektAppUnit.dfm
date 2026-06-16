object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 501
  ClientWidth = 704
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
    Width = 704
    Height = 501
    Align = alClient
    ExplicitLeft = 8
  end
  object LabelSignIn: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 110
    Width = 704
    Height = 51
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
  object PanelLogIn: TPanel
    Left = 0
    Top = 208
    Width = 704
    Height = 124
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'PanelLogIn'
    ParentColor = True
    ShowCaption = False
    TabOrder = 0
    object LogInButton: TButton
      AlignWithMargins = True
      Left = 275
      Top = 3
      Width = 154
      Height = 118
      Margins.Left = 275
      Margins.Right = 275
      Align = alClient
      Caption = 'Log In'
      TabOrder = 0
      OnClick = LogInClick
      ExplicitLeft = 244
      ExplicitTop = 0
      ExplicitWidth = 213
      ExplicitHeight = 124
    end
  end
end
