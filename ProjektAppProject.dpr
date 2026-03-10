program ProjektAppProject;

uses
  Vcl.Forms,
  ProjektAppUnit in 'ProjektAppUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
