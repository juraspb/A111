object A111_Form: TA111_Form
  Left = 358
  Top = 153
  Width = 1088
  Height = 734
  Caption = #1058#1055#1042'-'#1042#1080#1076#1077#1086' 168x128'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000088888F88888F88888F88888F888800008
    8888F88888F88888F88888F8888000088888F88888F88888F88888F888800000
    8888F88888F88888F88888F8888000000888F88888F88888F88888F88880000F
    00FFFFFFFF000FFFFFFFFFFFFFF000088000F88800080008F88888F888800008
    8880088808F88808F8888800888000088888088808F88800F888800088800008
    8888008008F88880088880F0088000088888F00888F88888000080F80080000F
    FFFFFF0FFFFFFFFFFFF000FFF0F000098888F88888F88888F88800F880800009
    9888F88888F88888F88888F8800000089998F88889F88888F88888F888000008
    8898F98899988888F88899F8880000088899999998999988F88999F88880000F
    FFFFFFFFFFFFF999FF99899FFFF000088888F88888F888899998889999800008
    8888F88888F88888F99888F8899000088888F88888F88888F88888F888900008
    8888F88888F88888F88888F8888000088888F88888F88888F88888F88880000F
    FFFFFFFFFFFFFFFFFFFFFFFFFFF000088888F88888F88888F88888F888800008
    8888F88888F88888F88888F8888000088888F88888F88888F88888F888800008
    8888F88888F88888F88888F88880FFFFFFFFDF7DF7DFFFFFFFFF40000001C000
    0001C0000001C0000001C0000001C000000140000001C0000001C0000001C000
    0001C0000001C000000140000001C0000001C0000001C0000001C0000001C000
    000140000001C0000001C0000001C0000001C0000001C000000140000001C000
    0001C0000001C0000001C0000001280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    0000000000000088F88F88F88F880000F88F88F88F8800FF0FFFFFFFFFF00088
    000F00088F080088F80F08F08088009FFFF0FFFF00FF0089F88F98F880880088
    988989988F8800FF999FFFF9F99F0088F88F88F99F980088F88F88F88F8900FF
    FFFFFFFFFFFF0088F88F88F88F880088F88F88F88F88B6DB0000000000008000
    0000800000000000000080000000800000000000000080000000800000000000
    00008000000080000000000000008000000080000000}
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object oscImg: TImage
    Left = 0
    Top = 97
    Width = 1072
    Height = 367
    Align = alClient
    Stretch = True
    OnMouseMove = oscImgMouseMove
  end
  object SB: TStatusBar
    Left = 0
    Top = 676
    Width = 1072
    Height = 19
    Panels = <
      item
        Width = 90
      end
      item
        Width = 70
      end
      item
        Width = 200
      end
      item
        Width = 150
      end
      item
        Width = 300
      end
      item
        Width = 120
      end
      item
        Width = 120
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1072
    Height = 97
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 924
      Top = 73
      Width = 91
      Height = 20
      Caption = 'Port closed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object startBtn: TBitBtn
      Left = 184
      Top = 8
      Width = 73
      Height = 26
      Hint = #1050#1072#1083#1080#1073#1088#1086#1074#1072#1090#1100
      Caption = #1057#1090#1072#1088#1090
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = startBtnClick
    end
    object startSE: TSpinEdit
      Left = 80
      Top = 34
      Width = 70
      Height = 26
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1079#1072#1087#1080#1089#1080' '#1082#1072#1076#1088#1086#1074' ('#1084#1089')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxValue = 200
      MinValue = 0
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 200
    end
    object BitBtn15: TBitBtn
      Left = 834
      Top = 50
      Width = 33
      Height = 33
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1077#1093#1085#1086#1083#1086#1075#1080#1095#1077#1089#1082#1080#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BitBtn15Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
    end
    object BitBtn17: TBitBtn
      Left = 835
      Top = 8
      Width = 33
      Height = 33
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BitBtn17Click
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F0000000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777700007777777777777777777700007777700000000000007700007777
        8888888888880077000077778FB7B7B7B7B8007700007778FB7B7B7B7B708077
        00007778F7B7B7B7B78080770000778F7B7B7B7B7B0880770000778FFFFFFFFF
        F80780770000778888888888888B807700007778F7B7B7B7B7B7807700007778
        FB7B7B7FFFFF807700007778F7B7B7F888888777000077778FFFFF8777777777
        0000777778888877777777770000777777777777777777770000777777777777
        7777777700007777777777777777777700007777777777777777777700007777
        77777777777777770000}
    end
    object PB1: TProgressBar
      Left = 1048
      Top = 1
      Width = 23
      Height = 95
      Align = alRight
      Orientation = pbVertical
      TabOrder = 4
    end
    object ComboBox3: TComboBox
      Left = 80
      Top = 8
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 16
      ItemIndex = 0
      ParentFont = False
      TabOrder = 5
      Text = 'Envelope'
      Items.Strings = (
        'Envelope'
        'Powerbins')
    end
    object lenSE: TSpinEdit
      Left = 80
      Top = 58
      Width = 70
      Height = 26
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1079#1072#1087#1080#1089#1080' '#1082#1072#1076#1088#1086#1074' ('#1084#1089')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxValue = 1200
      MinValue = 0
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Value = 1200
    end
    object TrackBar2: TTrackBar
      Tag = 4
      Left = 584
      Top = 13
      Width = 201
      Height = 20
      Max = 4096
      Min = -4096
      PageSize = 256
      Frequency = 512
      TabOrder = 7
      ThumbLength = 8
      OnChange = soft_gainTBChange
    end
    object ComboBox1: TComboBox
      Left = 924
      Top = 8
      Width = 77
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 16
      ItemIndex = 0
      ParentFont = False
      TabOrder = 8
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4')
    end
    object ComboBox2: TComboBox
      Tag = 1
      Left = 924
      Top = 42
      Width = 77
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 16
      ParentFont = False
      TabOrder = 9
      Text = '115200'
      Items.Strings = (
        '115200'
        '57600'
        '28800'
        '9600')
    end
    object sectorEraseBtn: TBitBtn
      Left = 879
      Top = 49
      Width = 31
      Height = 32
      Hint = #1057#1095#1080#1090#1072#1090#1100' '#1089#1090#1088#1072#1085#1080#1094#1091' '#1087#1072#1084#1103#1090#1080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F0000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDD9D0000DD9DDDDDDDDDDDDDD9DD0000DD99
        DD77777777779DDD0000DD999000000000099DDD0000DDD990BFFFBFFF99DDDD
        0000DDDD99FCCCCCCF97DDDD0000DDDD999FBFFFB997DDDD0000DDDDD999CCC9
        9907DDDD0000DDDDD0999FB99F07DDDD0000DDDDD0FC9999CF07DDDD0000DDDD
        D0FF9999BF07DDDD0000DDDDD0FC99990007DDDD0000DDDDD0B99F099F07DDDD
        0000DDDDD0999F09999DDDDD0000DDDD999FBF0F0D99DDDD0000DD9999000000
        DDD99DDD0000DD999DDDDDDDDDDDD9DD0000DDDDDDDDDDDDDDDDDD9D0000DDDD
        DDDDDDDDDDDDDDDD0000}
    end
    object BitBtn13: TBitBtn
      Left = 877
      Top = 8
      Width = 31
      Height = 32
      Hint = #1057#1095#1080#1090#1072#1090#1100' '#1089#1090#1088#1072#1085#1080#1094#1091' '#1087#1072#1084#1103#1090#1080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object stopBtn: TBitBtn
      Tag = 1
      Left = 184
      Top = 34
      Width = 73
      Height = 26
      Hint = #1050#1072#1083#1080#1073#1088#1086#1074#1072#1090#1100
      Caption = #1057#1090#1086#1087
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = stopBtnClick
    end
    object BitBtn1: TBitBtn
      Tag = 1
      Left = 272
      Top = 34
      Width = 74
      Height = 26
      Hint = #1050#1072#1083#1080#1073#1088#1086#1074#1072#1090#1100
      Caption = #1063#1090#1077#1085#1080#1077
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = startBtnClick
    end
    object regSE: TSpinEdit
      Left = 272
      Top = 8
      Width = 74
      Height = 26
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1079#1072#1087#1080#1089#1080' '#1082#1072#1076#1088#1086#1074' ('#1084#1089')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxValue = 127
      MinValue = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      Value = 6
    end
    object btn1: TBitBtn
      Tag = 2
      Left = 346
      Top = 34
      Width = 73
      Height = 26
      Hint = #1050#1072#1083#1080#1073#1088#1086#1074#1072#1090#1100
      Caption = #1047#1072#1087#1080#1089#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      OnClick = startBtnClick
    end
    object edt1: TEdit
      Left = 346
      Top = 8
      Width = 74
      Height = 21
      TabOrder = 16
      Text = '0'
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 464
    Width = 1072
    Height = 212
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object SvDlg: TSaveDialog
    DefaultExt = 'dat'
    Filter = 'txt; dat; cof;|*.txt; *.dat; *.cof'
    Left = 144
    Top = 112
  end
  object OpDlg: TOpenDialog
    Left = 104
    Top = 112
  end
end
