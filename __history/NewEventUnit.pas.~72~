unit NewEventUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.JSON, System.Net.HttpClient, System.Net.URLClient, Vcl.ComCtrls,
  Vcl.WinXPickers;

type
  TForm2 = class(TForm)
    PanelTitle: TPanel;
    TitleEdit: TEdit;
    LabelTitle: TLabel;
    PanelStartDate: TPanel;
    LabelStartDate: TLabel;
    PanelEndDate: TPanel;
    LabelEndDate: TLabel;
    PanelTime: TPanel;
    LabelStartTime: TLabel;
    PanelCalendarType: TPanel;
    LabelEndTime: TLabel;
    PanelDescription: TPanel;
    LabelDescription: TLabel;
    ButtonSave: TButton;
    MemoDescription: TMemo;
    DateTimePickerStart: TDateTimePicker;
    DateTimePickerEnd: TDateTimePicker;
    TimePickerStart: TTimePicker;
    TimePickerEnd: TTimePicker;
    LabelCalendar: TLabel;
    ComboBoxCalendar: TComboBox;
    PanelTimeLabel: TPanel;
    PanelTimePicker: TPanel;
    ComboBoxSymbol: TComboBox;
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Resize(Sender: TObject);
    procedure MemoDescriptionEnter(Sender: TObject);
    procedure DateTimePickerStartChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimePickerStartChange(Sender: TObject);
    procedure MemoDescriptionExit(Sender: TObject);
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

uses CalendarUnit;

const DESC_PLACEHOLDER = 'Write description here...';

// Creates MemoDecription text, adds calendar types to ComboBoxCalendar and
// adds Segoe UI Symbols to ComboBoxSymbals
procedure TForm2.FormCreate(Sender: TObject);
begin
  MemoDescription.Lines.Text := DESC_PLACEHOLDER;
  MemoDescription.OnExit := MemoDescriptionExit;

  ComboBoxCalendar.Items.Clear;
  ComboBoxCalendar.Items.Add('Work');
  ComboBoxCalendar.Items.Add('Private');
  ComboBoxCalendar.Items.Add('Holiday');
  ComboBoxCalendar.ItemIndex := 0;

  ComboBoxSymbol.Style := csDropDownList;
  ComboBoxSymbol.Font.Name := 'Segoe UI Symbol';
  ComboBoxSymbol.Items.Clear;
  ComboBoxSymbol.Items.Add('(no symbol)');
  ComboBoxSymbol.Items.Add(#$2600);
  ComboBoxSymbol.Items.Add(#$2638);
  ComboBoxSymbol.Items.Add(#$2615);
  ComboBoxSymbol.Items.Add(#$2656);
  ComboBoxSymbol.Items.Add(#$26BD);
  ComboBoxSymbol.Items.Add(#$26F1);
  ComboBoxSymbol.Items.Add(#$23F0);
  ComboBoxSymbol.Items.Add(#$260F);
  ComboBoxSymbol.Items.Add(#$26F3);
  ComboBoxSymbol.Items.Add(#$E119);
  ComboBoxSymbol.Items.Add(#$E14D);
  ComboBoxSymbol.Items.Add(#$E1D0);
  ComboBoxSymbol.Items.Add(#$E2B1);
  ComboBoxSymbol.Items.Add(#$26F8);
  ComboBoxSymbol.Items.Add(#$E189);
  ComboBoxSymbol.Items.Add(#$2708);
  ComboBoxSymbol.Items.Add(#$2690);
  ComboBoxSymbol.ItemIndex := 0;

end;

// Collects the inbformation the user wrote in the form and creates the JSON object so
// Microsoft Graph can make the event
function TForm2.CreateGraphEventJson: TJSONObject;
var
  StartObj, EndObj, BodyObj: TJSONObject;
  FullStartIso: string;
  FullEndIso: string;
  StartDT: TDateTime;
  EndDT: TDateTime;
  SvepArr: TJSONArray;
  SvepObj: TJSONObject;
begin
  StartDT :=
    Trunc(DateTimePickerStart.Date) +
    Frac(TimePickerStart.Time);

  EndDT :=
    Trunc(DateTimePickerEnd.Date) +
    Frac(TimePickerEnd.Time);

  FullStartIso := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', StartDT);

  FullEndIso := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', EndDT);

  Result := TJSONObject.Create;
  Result.AddPair('subject', TitleEdit.Text);
  Result.AddPair(
  'categories',
  TJSONArray.Create.Add(ComboBoxCalendar.Text)
  );

  StartObj := TJSONObject.Create;
  StartObj.AddPair('dateTime', FullStartIso);
  StartObj.AddPair('timeZone', 'Romance Standard Time');
  Result.AddPair('start', StartObj);

  EndObj := TJSONObject.Create;
  EndObj.AddPair('dateTime', FullEndIso);
  EndObj.AddPair('timeZone', 'Romance Standard Time');
  Result.AddPair('end', EndObj);

  if (Trim(MemoDescription.Text) <> '') and
     (Trim(MemoDescription.Text) <> DESC_PLACEHOLDER) then
  begin
    BodyObj := TJSONObject.Create;
    BodyObj.AddPair('contentType', 'text');
    BodyObj.AddPair('content', MemoDescription.Text);
    Result.AddPair('body', BodyObj);
  end;

  if ComboBoxSymbol.ItemIndex > 0 then
  begin
    SvepArr := TJSONArray.Create;
    SvepObj := TJSONObject.Create;
    SvepObj.AddPair('id', SYMBOL_PROP_ID);
    SvepObj.AddPair('value', ComboBoxSymbol.Text);
    SvepArr.Add(SvepObj);
    Result.AddPair('singleValueExtendedProperties', SvepArr);
  end;

end;

// Make event end date the same as the start date, when chosen
procedure TForm2.DateTimePickerStartChange(Sender: TObject);
begin

  DateTimePickerEnd.Date := DateTimePickerStart.Date;

end;

// Make event end time the same as the start time, when chosen
procedure TForm2.TimePickerStartChange(Sender: TObject);
begin

  TimePickerEnd.Time := TimePickerStart.Time;

end;

// When Save is clicked, then userinput is validated, JSON for the event is created and
// is sent to Microsoft Graph and refresh the calendar if successful
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

  if (TitleEdit.Text = '') then
  begin
    ShowMessage('Udfyld venligst som minimum: Titel');
    Exit;
  end;

  if (Trunc(DateTimePickerEnd.Date) + Frac(TimePickerEnd.Time)) <
     (Trunc(DateTimePickerStart.Date) + Frac(TimePickerStart.Time)) then
  begin
    ShowMessage('Slutdatoen kan ikke være før startdatoen.');
    Exit;
  end;

  Client := THTTPClient.Create;
  JsonPayload := CreateGraphEventJson;
  RequestBody := TStringStream.Create(JsonPayload.ToString, TEncoding.UTF8);

  try
    Client.CustomHeaders['Authorization'] := 'Bearer ' + FAccessToken;
    Client.CustomHeaders['Content-Type'] := 'application/json';

    Response := Client.Post('https://graph.microsoft.com/v1.0/me/events', RequestBody);

    if (Response.StatusCode = 201) or (Response.StatusCode = 200) then
    begin
      ShowMessage('Succes! Begivenheden blev oprettet hos Microsoft.');

      if Assigned(Form4) then
        Form4.RefreshCalendar;

      Close;
    end
    else
    begin
      ShowMessage('Fejl (' + IntToStr(Response.StatusCode) + '): ' + Response.ContentAsString);
    end;

  finally
    Client.Free;
    JsonPayload.Free;
    RequestBody.Free;
  end;
end;

// Makes resizing of the form look nice
procedure TForm2.Resize(Sender: TObject);
begin
  TitleEdit.Width := PanelTitle.Width - LabelTitle.Width - 120;

  DateTimePickerStart.Width := PanelStartDate.Width - LabelStartDate.Width - 120;
  DateTimePickerEnd.Width := PanelEndDate.Width - LabelEndDate.Width - 120;

  TimePickerStart.Width := PanelTime.Width - LabelStartTime.Width - 120;

  ComboBoxCalendar.Width := PanelCalendarType.Width - LabelCalendar.Width - 120;

  MemoDescription.Width := PanelDescription.Width - LabelDescription.Width - 120;
end;

// Removes decription text when Memo is entered
procedure TForm2.MemoDescriptionEnter(Sender: TObject);
begin
  if Trim(MemoDescription.Text) = DESC_PLACEHOLDER then
    MemoDescription.Clear;
end;

// Adds back description text if Memo is exited without writing anything
procedure TForm2.MemoDescriptionExit(Sender: TObject);
begin
  if Trim(MemoDescription.Text) = '' then
    MemoDescription.Lines.Text := DESC_PLACEHOLDER;
end;

// The date and time will be the current date and time
procedure TForm2.FormShow(Sender: TObject);
begin
  DateTimePickerStart.Date := Date;
  DateTimePickerEnd.Date := Date;
  TimePickerStart.Time := Time;
  TimePickerEnd.Time := Time;

  if Trim(MemoDescription.Text) = '' then
  MemoDescription.Lines.Text := DESC_PLACEHOLDER;
end;

end.
