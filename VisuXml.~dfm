object FormVisuXml: TFormVisuXml
  Left = 561
  Top = -1
  Width = 462
  Height = 321
  Caption = 'Visualiser XML'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = menuPrinc
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    454
    272)
  PixelsPerInch = 96
  TextHeight = 13
  object lbFileName: TLabel
    Left = 256
    Top = 0
    Width = 193
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Aucun fichier charg'#233
  end
  object MemoDoc: TMemo
    Left = 0
    Top = 24
    Width = 455
    Height = 248
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    ScrollBars = ssBoth
    TabOrder = 1
    Visible = False
    WantTabs = True
    OnKeyPress = MemoDocKeyPress
  end
  object sgLectureBase: TStringGrid
    Left = 0
    Top = 24
    Width = 455
    Height = 246
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    ColCount = 1
    DefaultColWidth = 90
    DefaultRowHeight = 16
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 2
  end
  object cbTables: TComboBox
    Left = 0
    Top = 0
    Width = 249
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'Aucune Table charg'#233'e'
    OnChange = cbTablesChange
  end
  object menuPrinc: TMainMenu
    Left = 80
    Top = 72
    object miFichier: TMenuItem
      Caption = '&Fichier'
      object miOuvrir: TMenuItem
        Caption = '&Ouvrir'
        ShortCut = 16463
        OnClick = miOuvrirClick
      end
      object miEnregistrer: TMenuItem
        Caption = '&Enregistrer'
        Enabled = False
        ShortCut = 16467
        OnClick = miEnregistrerClick
      end
      object miRecharger: TMenuItem
        Caption = '&Recharger'
        ShortCut = 16466
        OnClick = miRechargerClick
      end
      object miFermer: TMenuItem
        Caption = '&Fermer'
        ShortCut = 16471
        OnClick = miFermerClick
      end
      object miQuitter: TMenuItem
        Caption = '&Quitter'
        ShortCut = 16465
        OnClick = miQuitterClick
      end
    end
    object Vue1: TMenuItem
      Caption = '&Vue'
      object miDataGrid: TMenuItem
        Caption = '&DataGrid'
        Checked = True
        ShortCut = 16455
        OnClick = miDataGridClick
      end
      object miText: TMenuItem
        Caption = '&Text'
        ShortCut = 16468
        OnClick = miTextClick
      end
    end
    object Affichage1: TMenuItem
      Caption = '&Affichage'
      object miFirstFront: TMenuItem
        Caption = '&Laisser au premier plan'
        OnClick = miFirstFrontClick
      end
    end
    object MenuAide: TMenuItem
      Caption = '&?'
      object About: TMenuItem
        Caption = 'A &propos'
        ShortCut = 16473
        OnClick = AboutClick
      end
    end
  end
  object printDlg: TPrintDialog
    Left = 160
    Top = 72
  end
  object openDlg: TOpenDialog
    InitialDir = 'c:\'
    Left = 120
    Top = 72
  end
end
