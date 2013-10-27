unit VisuXml;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XMLDoc, xmldom, DB, StdCtrls, Grids, DBGrids, Menus, Provider;

type
  TFormVisuXml = class(TForm)
    menuPrinc: TMainMenu;
    printDlg: TPrintDialog;
    openDlg: TOpenDialog;
    MenuAide: TMenuItem;
    About: TMenuItem;
    cbTables: TComboBox;
    lbFileName: TLabel;
    miFichier: TMenuItem;
    miOuvrir: TMenuItem;
    miFermer: TMenuItem;
    miQuitter: TMenuItem;
    miRecharger: TMenuItem;
    Vue1: TMenuItem;
    miDataGrid: TMenuItem;
    miText: TMenuItem;
    MemoDoc: TMemo;
    sgLectureBase: TStringGrid;
    miEnregistrer: TMenuItem;
    Affichage1: TMenuItem;
    miFirstFront: TMenuItem;
    procedure miOuvrirClick(Sender: TObject);
    procedure miQuitterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChargerBase;
    procedure miDataGridClick(Sender: TObject);
    procedure miTextClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miRechargerClick(Sender: TObject);
    procedure miFermerClick(Sender: TObject);
    procedure CreerColonnes(nomTable: string);
    procedure ChargerTable(nomTable: string);
    procedure cbTablesChange(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure MemoDocKeyPress(Sender: TObject; var Key: Char);
    procedure miEnregistrerClick(Sender: TObject);
    procedure miFirstFrontClick(Sender: TObject);
  private
    { Déclarations privées }
    sNameFile: string;
    iNombreTables: integer;
    iNombreEnregistrements: integer;
    xmlDoc: TXMLDocument;
  public
    { Déclarations publiques }
  end;

var
  FormVisuXml: TFormVisuXml;

implementation

{$R *.dfm}

procedure TFormVisuXml.miOuvrirClick(Sender: TObject);
var
 initRep: string;
begin
  initRep := 'c:\Inetpub\wwwroot\rootftp\';
  if (not DirectoryExists(initRep)) then
    initRep := 'c:\';
  openDlg.InitialDir := initRep;
  openDlg.Filter := 'xml files (*.xml)|*.xml|All (*.*)|*.*';
  if openDlg.Execute then
  begin
    Self.miFermerClick(nil);
    sNameFile := openDlg.FileName;
  end;
  Self.ChargerBase;
  Self.Caption := 'Visualiser XML';
end;

procedure TFormVisuXml.miQuitterClick(Sender: TObject);
begin
  Close;
end;

procedure TFormVisuXml.FormCreate(Sender: TObject);
begin
  // ouvrir le fichier de la ligne de commande s'il existe
  if (ParamCount > 0) then
  begin
    Self.sNAmeFile := ParamStr(1);
    try
      Self.ChargerBase;
    except
    end;
  end
  else
    Self.sNAmeFile := '';
 end;

procedure TFormVisuXml.ChargerBase();
var
  i: integer;
  monNoeud: IDOMNode;
  table: IDOMNode;
  nomTableNoeud: string;
begin
  if (Self.sNameFile <> '') then
  begin
    // signaler le nom du fichier
    Self.lbFileName.Caption := Self.sNameFile;

    // chragement du fichier XML
    try
      xmlDoc := TXMLDocument.Create(Self.sNameFile);
    except
      MessageDlg('Le fichier n''est pas une base de données XML valide', mtInformation, [mbOK], 0);
      Exit;
    end;

    // copie du xml sur le mémo
    Self.MemoDoc.Lines.Clear;
    Self.MemoDoc.Lines.AddStrings(xmlDoc.XML);
    Self.MemoDoc.Update;

    // insertion du nom des tables dans la comboBox
    xmlDoc.DOMDocument.firstChild;
    monNoeud := xmlDoc.DOMDocument.firstChild.nextSibling;
    if (monNoeud = nil) then
      raise ERangeError(0);

    // gestion des tables
    iNombreTables := 0;
    Self.cbTables.Items.Clear;
    for i := 0 to monNoeud.childNodes.length - 1 do
    begin
      nomTableNoeud := monNoeud.childNodes[i].nodeName;
      // verifier que la table n'est pas dans la combo
      if (Self.cbTables.Items.IndexOf(nomTableNoeud) < 0 ) then
      begin
        // ajouter la table dans la combo
        Self.cbTables.Items.Add(nomTableNoeud);
        // compter le nombre de tables
        iNombreTables := iNombreTables + 1;
      end;
    end;

    // si la comboBox n'est pas vide, selectionner la premiere table
    if (iNombreTables > 0) then
      Self.cbTables.Text := Self.cbTables.Items[0];

    // creation des colonnes de la table choisie dans le dataGrid
    table := monNoeud;
    Self.CreerColonnes(Self.cbTables.Text);
    // insertion du fichier XML dans de dataGrid
    Self.ChargerTable(Self.cbTables.Text);
  end;
end;

procedure TFormVisuXml.CreerColonnes(nomTable: string);
var
  monNoeud: IDOMNode;
  table: IDOMNode;
  i: integer;
  j: integer;
begin
  // effacer les colonnes deja presentes
  for i := 0 to Self.sgLectureBase.ColCount - 1 do
    Self.sgLectureBase.Cols[i].Clear;
  // pas d'enregistrements affichés
  iNombreEnregistrements := 0;
  // recuperer les enregistrements au niveu des tables
  table := xmlDoc.DOMDocument.firstChild.nextSibling;
  for i := 0 to table.childNodes.length - 1 do
  begin
    // verifier que le nom de la table est le meme que la table pointe
    if (table.childNodes[i].nodeName = nomTable) then
    begin
      monNoeud := table.childNodes[i];
      // parcourir les fils de la table pour recuperer les colonnes
      Self.sgLectureBase.ColCount := monNoeud.childNodes.length;
      if (iNombreEnregistrements = 0) then
      begin
        for j := 0 to monNoeud.childNodes.length - 1 do
          // insertion des valeurs dans une nouvelle ligne
          Self.sgLectureBase.Cols[j].Append(monNoeud.childNodes[j].nodeName);
        Self.sgLectureBase.FixedRows := 1;
      end;
      // compter le nombre d'enregistrements
      iNombreEnregistrements := iNombreEnregistrements + 1;
    end;
  end;
end;

procedure TFormVisuXml.ChargerTable(nomTable: string);
var
  monNoeud: IDOMNode;
  table: IDOMNode;
  i: integer;
  j: integer;
  k: integer;
begin
  // recuperer les enregistrements au niveu des tables
  table := xmlDoc.DOMDocument.firstChild.nextSibling;
  Self.sgLectureBase.RowCount := iNombreEnregistrements + 1;
  k := 1;
  for i := 0 to table.childNodes.length - 1 do
  begin
    // verifier que le nom de la table est le meme que la table pointe
    if (table.childNodes[i].nodeName = nomTable) then
    begin
      monNoeud := table.childNodes[i];
      // parcourir les fils de la table pour recuperer les colonnes
      Self.sgLectureBase.ColCount := monNoeud.childNodes.length;
      for j := 0 to monNoeud.childNodes.length - 1 do
        // insertion des valeurs dans une nouvelle ligne
        if (monNoeud.childNodes[j].firstChild <> nil) then
          Self.sgLectureBase.Cells[j, k] := monNoeud.childNodes[j].firstChild.nodeValue;
      k := k + 1;
    end;
  end;
end;

procedure TFormVisuXml.miDataGridClick(Sender: TObject);
begin
  if (not Self.miDataGrid.Checked) then
  begin
    Self.miDataGrid.Checked := True;
    Self.miText.Checked := False;
    Self.MemoDoc.Visible := False;
    Self.sgLectureBase.Visible := True;
    Self.miEnregistrer.Enabled := False;
    Self.cbTables.SetFocus;
  end;
end;

procedure TFormVisuXml.miTextClick(Sender: TObject);
begin
  if (not Self.miText.Checked) then
  begin
    Self.miText.Checked := True;
    Self.miDataGrid.Checked := False;
    Self.sgLectureBase.Visible := False;
    Self.MemoDoc.Visible := True;
    Self.MemoDoc.SetFocus;
  end;
end;

procedure TFormVisuXml.FormDestroy(Sender: TObject);
begin
  if (xmlDoc <> nil) then
    FreeAndNil(xmlDoc);
  Self.MemoDoc.Lines.Clear;
end;

procedure TFormVisuXml.miRechargerClick(Sender: TObject);
var
  FileNameTmp: string;
begin
  if (Self.sNameFile <> '') then
  begin
    FileNameTmp := Self.sNameFile;
    Self.miFermerClick(nil);
    Self.sNameFile := FileNameTmp;
    Self.ChargerBase;
    Self.CreerColonnes(Self.cbTables.Text);
    Self.ChargerTable(Self.cbTables.Text);
    Self.Caption := 'Visualiser XML';
  end;
end;

procedure TFormVisuXml.miFermerClick(Sender: TObject);
var
  i: integer;
begin
  if (xmlDoc <> nil) then
    FreeAndNil(xmlDoc);

  Self.MemoDoc.Lines.Clear;
  Self.sNameFile := '';
  Self.lbFileName.Caption := 'Aucun fichier chargé';
  if (Self.sgLectureBase.RowCount > 2) then
    for i := 0 to Self.sgLectureBase.RowCount - 1 do
      Self.sgLectureBase.Rows[i].Clear;
  if (Self.sgLectureBase.ColCount > 1) then
    for i := 0 to Self.sgLectureBase.ColCount - 1 do
      Self.sgLectureBase.Cols[i].Clear;

  Self.sgLectureBase.ColCount := 1;
  Self.sgLectureBase.RowCount := 2;

  Self.cbTables.Items.Clear;
  Self.cbTables.Text := 'Aucune table chargée';
  Self.Caption := 'Visualiser XML';
end;

procedure TFormVisuXml.cbTablesChange(Sender: TObject);
begin
  Self.CreerColonnes(Self.cbTables.Text);
  Self.ChargerTable(Self.cbTables.Text);
end;

procedure TFormVisuXml.AboutClick(Sender: TObject);
begin
  MessageDlg('Visualisateur de bases de données XML sous Delphi 7'#13#10'Pierre Contri - Ariane Ingenierie'#13#10'Pour le compte de Cora Informatique'#13#10'Août 2005', mtInformation, [mbOK],0);
end;

procedure TFormVisuXml.MemoDocKeyPress(Sender: TObject; var Key: Char);
begin
  if (Self.sNameFile <> '') then
  begin
    Self.miEnregistrer.Enabled := True;
    Self.Caption := 'Visualiser XML  *';
  end;
end;

procedure TFormVisuXml.miEnregistrerClick(Sender: TObject);
begin
  if ((Self.sNameFile <> '') and (Self.xmlDoc <> nil)) then
  begin
    xmlDoc.XML := Self.MemoDoc.Lines;
    xmlDoc.XML.SaveToFile(Self.sNameFile);
    Self.miEnregistrer.Enabled := False;
    Self.Caption := 'Visualiser XML';
    Self.miRechargerClick(nil);
  end;
end;

procedure TFormVisuXml.miFirstFrontClick(Sender: TObject);
begin
  Self.miFirstFront.Checked := not Self.miFirstFront.Checked;
  if (Self.miFirstFront.Checked) then
    Self.FormStyle := fsStayOnTop
  else
    Self.FormStyle := fsNormal;
end;

end.
