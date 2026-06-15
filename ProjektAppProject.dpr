program ProjektAppProject;

uses
  Vcl.Forms,
  ProjektAppUnit in 'ProjektAppUnit.pas' {Form1},
  CalendarUnit in 'CalendarUnit.pas' {Form4},
  NewEventUnit in 'NewEventUnit.pas' {Form2},
  EventDetailsUnit in 'EventDetailsUnit.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
