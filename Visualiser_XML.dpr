program Visualiser_XML;

uses
  Forms,
  VisuXml in 'VisuXml.pas' {FormVisuXml};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Visualiser_XML';
  Application.CreateForm(TFormVisuXml, FormVisuXml);
  Application.Run;
end.
