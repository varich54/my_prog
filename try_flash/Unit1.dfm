object Form1: TForm1
  Left = 59
  Top = 176
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object flash1: TShockwaveFlash
    Left = 56
    Top = 16
    Width = 801
    Height = 241
    TabOrder = 0
    ControlData = {
      6755665500090000C9520000E818000008000200000000000800000000000800
      0000000008000E000000570069006E0064006F00770000000800060000002D00
      310000000800060000002D003100000008000A00000048006900670068000000
      08000200000000000800060000002D0031000000080000000000080002000000
      0000080010000000530068006F00770041006C006C0000000800040000003000
      0000080004000000300000000800020000000000080000000000080002000000
      00000D0000000000000000000000000000000000080004000000310000000800
      0400000030000000080000000000080004000000300000000800080000006100
      6C006C00000008000C000000660061006C0073006500000008000C0000006600
      61006C0073006500000008000400000030000000}
  end
  object Button1: TButton
    Left = 472
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object FLB1: TFileListBox
    Left = 80
    Top = 264
    Width = 353
    Height = 121
    ItemHeight = 13
    TabOrder = 2
  end
end