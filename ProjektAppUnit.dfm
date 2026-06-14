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
  TextHeight = 15
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 704
    Height = 501
    Align = alClient
    ExplicitTop = 8
    ExplicitWidth = 601
    ExplicitHeight = 465
  end
  object LogInButton: TButton
    Left = 244
    Top = 168
    Width = 213
    Height = 124
    Caption = 'Log In'
    TabOrder = 0
    OnClick = LogInClick
  end
end
