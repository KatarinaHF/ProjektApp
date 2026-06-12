unit NewEventUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.JSON, System.Net.HttpClient, System.Net.URLClient;

type
  TForm2 = class(TForm)
    PanelTitle: TPanel;
    TitleEdit: TEdit;
    LabelTitle: TLabel;
    PanelStartDate: TPanel;
    LabelStartDate: TLabel;
    EditStartDate: TEdit;
    PanelEndDate: TPanel;
    LabelEndDate: TLabel;
    EditEndDate: TEdit;
    PanelStartTime: TPanel;
    LabelStartTime: TLabel;
    EditStartTime: TEdit;
    PanelEndTime: TPanel;
    LabelEndTime: TLabel;
    EditEndTime: TEdit;
    PanelDescription: TPanel;
    LabelDescription: TLabel;
    EditDescription: TEdit;
    ButtonSave: TButton;
    procedure ButtonSaveClick(Sender: TObject); // Den rigtige klik-hændelse
  private
    FAccessToken: string;
    function CreateGraphEventJson: TJSONObject;
  public
    property AccessToken: string read FAccessToken write FAccessToken;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit4;

function TForm2.CreateGraphEventJson: TJSONObject;
var
  StartObj, EndObj, BodyObj: TJSONObject;
  FullStartIso, FullEndIso: string;
begin
  // Nu trækker vi data direkte ud af skærmens TEdits!
  FullStartIso := EditStartDate.Text + 'T' + EditStartTime.Text + ':00';
  FullEndIso := EditEndDate.Text + 'T' + EditEndTime.Text + ':00';

  Result := TJSONObject.Create;
  Result.AddPair('subject', TitleEdit.Text);

  // Start-objekt
  StartObj := TJSONObject.Create;
  StartObj.AddPair('dateTime', FullStartIso);
  StartObj.AddPair('timeZone', 'Romance Standard Time');
  Result.AddPair('start', StartObj);

  // Slut-objekt
  EndObj := TJSONObject.Create;
  EndObj.AddPair('dateTime', FullEndIso);
  EndObj.AddPair('timeZone', 'Romance Standard Time');
  Result.AddPair('end', EndObj);

  // Beskrivelse
  if (EditDescription <> nil) and (EditDescription.Text <> '') then
  begin
    BodyObj := TJSONObject.Create;
    BodyObj.AddPair('contentType', 'text');
    BodyObj.AddPair('content', EditDescription.Text);
    Result.AddPair('body', BodyObj);
  end;
end;

procedure TForm2.ButtonSaveClick(Sender: TObject);
var
  Client: THTTPClient;
  Response: IHTTPResponse;
  JsonPayload: TJSONObject;
  RequestBody: TStringStream;
begin
  if FAccessToken = '' then
  begin
    ShowMessage('Fejl: Ingen adgangstoken fundet.');
    Exit;
  end;

  // Enkel sikring, så man ikke sender tomme felter afsted
  if (TitleEdit.Text = '') or (EditStartDate.Text = '') or (EditEndDate.Text = '') then
  begin
    ShowMessage('Udfyld venligst som minimum: Titel, Startdato og Slutdato.');
    Exit;
  end;

  Client := THTTPClient.Create;
  JsonPayload := CreateGraphEventJson;
  RequestBody := TStringStream.Create(JsonPayload.ToString, TEncoding.UTF8);

  try
    Client.CustomHeaders['Authorization'] := 'Bearer ' + FAccessToken;
    Client.CustomHeaders['Content-Type'] := 'application/json';

    // POST til Microsoft Graph med indholdet fra dine TEdits
    Response := Client.Post('https://graph.microsoft.com/v1.0/me/events', RequestBody);

    if (Response.StatusCode = 201) or (Response.StatusCode = 200) then
    begin
      ShowMessage('Succes! Begivenheden blev oprettet hos Microsoft.');

      if Assigned(Form4) then
        Form4.RefreshCalendar; // Opdaterer hovedkalenderen med det samme

      Close; // Lukker Form2 ned automatisk
    end
    else
    begin
      ShowMessage('Fejl (' + IntToStr(Response.StatusCode) + '): ' + Response.ContentAsString);
    end;

  finally
    Client.Free;
    JsonPayload.Free;
    RequestBody.Free;
    // Ingen .Free af TEdits her! Delphi styrer dem.
  end;
end;

end.
