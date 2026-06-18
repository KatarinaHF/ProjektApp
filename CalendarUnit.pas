unit CalendarUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, DateUtils, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, System.IniFiles, System.StrUtils, System.NetEncoding;

type
  TForm4 = class(TForm)
    PanelTopButtons: TPanel;
    ButtonSearch: TButton;
    ButtonChangeView: TButton;
    ButtonNewEvent: TButton;
    PanelCalendar: TPanel;
    PanelCalendartypes: TPanel;
    PanelSøndag: TPanel;
    PanelLørdag: TPanel;
    PanelFredag: TPanel;
    PanelTorsdag: TPanel;
    PanelOnsdag: TPanel;
    PanelTirsdag: TPanel;
    PanelMandag: TPanel;
    LabelMonday: TLabel;
    PanelMondayName: TPanel;
    PanelSaturdayName: TPanel;
    LabelSaturday: TLabel;
    PanelFridayName: TPanel;
    LabelFriday: TLabel;
    PanelWednesdayName: TPanel;
    LabelWednesday: TLabel;
    PanelSundayName: TPanel;
    LabelSunday: TLabel;
    PanelTuesdayName: TPanel;
    LabelTuesday: TLabel;
    PanelThursdayName: TPanel;
    LabelThursday: TLabel;
    PanelTop: TPanel;
    LabelMonth: TLabel;
    PanelDay30: TPanel;
    LabelDay30: TLabel;
    MemoDay30: TMemo;
    PanelDay36: TPanel;
    LabelDay36: TLabel;
    MemoDay36: TMemo;
    PanelDay29: TPanel;
    LabelDay29: TLabel;
    MemoDay29: TMemo;
    PanelDay22: TPanel;
    LabelDay22: TLabel;
    MemoDay22: TMemo;
    PanelDay15: TPanel;
    LabelDay15: TLabel;
    MemoDay15: TMemo;
    PanelDay8: TPanel;
    LabelDay8: TLabel;
    MemoDay8: TMemo;
    PanelDay1: TPanel;
    LabelDay1: TLabel;
    MemoDay1: TMemo;
    PanelDay23: TPanel;
    LabelDay23: TLabel;
    MemoDay23: TMemo;
    PanelDay16: TPanel;
    LabelDay16: TLabel;
    MemoDay16: TMemo;
    PanelDay9: TPanel;
    LabelDay9: TLabel;
    MemoDay9: TMemo;
    PanelDay2: TPanel;
    LabelDay2: TLabel;
    MemoDay2: TMemo;
    PanelDay38: TPanel;
    LabelDay38: TLabel;
    MemoDay38: TMemo;
    PanelDay31: TPanel;
    LabelDay31: TLabel;
    MemoDay31: TMemo;
    PanelDay24: TPanel;
    LabelDay24: TLabel;
    MemoDay24: TMemo;
    PanelDay17: TPanel;
    LabelDay17: TLabel;
    MemoDay17: TMemo;
    PanelDay10: TPanel;
    LabelDay10: TLabel;
    MemoDay10: TMemo;
    PanelDay3: TPanel;
    LabelDay3: TLabel;
    MemoDay3: TMemo;
    PanelDay39: TPanel;
    LabelDay39: TLabel;
    MemoDay39: TMemo;
    PanelDay32: TPanel;
    LabelDay32: TLabel;
    MemoDay32: TMemo;
    PanelDay25: TPanel;
    LabelDay25: TLabel;
    MemoDay25: TMemo;
    PanelDay18: TPanel;
    LabelDay18: TLabel;
    MemoDay18: TMemo;
    PanelDay11: TPanel;
    LabelDay11: TLabel;
    MemoDay11: TMemo;
    PanelDay4: TPanel;
    LabelDay4: TLabel;
    MemoDay4: TMemo;
    PanelDay40: TPanel;
    LabelDay40: TLabel;
    MemoDay40: TMemo;
    PanelDay33: TPanel;
    LabelDay33: TLabel;
    MemoDay33: TMemo;
    PanelDay26: TPanel;
    LabelDay26: TLabel;
    MemoDay26: TMemo;
    PanelDay19: TPanel;
    LabelDay19: TLabel;
    MemoDay19: TMemo;
    PanelDay12: TPanel;
    LabelDay12: TLabel;
    MemoDay12: TMemo;
    PanelDay5: TPanel;
    LabelDay5: TLabel;
    MemoDay5: TMemo;
    PanelDay41: TPanel;
    LabelDay41: TLabel;
    MemoDay41: TMemo;
    PanelDay34: TPanel;
    LabelDay34: TLabel;
    MemoDay34: TMemo;
    PanelDay27: TPanel;
    LabelDay27: TLabel;
    MemoDay27: TMemo;
    PanelDay20: TPanel;
    LabelDay20: TLabel;
    MemoDay20: TMemo;
    PanelDay13: TPanel;
    LabelDay13: TLabel;
    MemoDay13: TMemo;
    PanelDay6: TPanel;
    LabelDay6: TLabel;
    MemoDay6: TMemo;
    PanelDay42: TPanel;
    LabelDay42: TLabel;
    MemoDay42: TMemo;
    PanelDay35: TPanel;
    LabelDay35: TLabel;
    MemoDay35: TMemo;
    PanelDay28: TPanel;
    LabelDay28: TLabel;
    MemoDay28: TMemo;
    PanelDay21: TPanel;
    LabelDay21: TLabel;
    MemoDay21: TMemo;
    PanelDay14: TPanel;
    LabelDay14: TLabel;
    MemoDay14: TMemo;
    PanelDay7: TPanel;
    LabelDay7: TLabel;
    MemoDay7: TMemo;
    PanelDay37: TPanel;
    LabelDay37: TLabel;
    MemoDay37: TMemo;
    LabelCalendars: TLabel;
    CheckBoxHolidays: TCheckBox;
    CheckBoxPrivate: TCheckBox;
    CheckBoxWork: TCheckBox;
    PreviousMonth: TButton;
    NextMonth: TButton;
    ShapeCalendarLine: TShape;
    PanelMonth: TPanel;
    PanelArrowButtons: TPanel;
    PanelFiller: TPanel;
    EditSearch: TEdit;
    ListBoxResults: TListBox;
    PanelRightFiller: TPanel;
    ButtonLogOut: TButton;
    procedure PanelCalendarResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreviousMonthClick(Sender: TObject);
    procedure NextMonthClick(Sender: TObject);
    procedure AddEvent(ADay: Integer; const AText: string; const ACategory: string);
    procedure LoadGraphEvents;
    procedure ButtonNewEventClick(Sender: TObject);
    procedure PanelDayMouseEnter(Sender: TObject);
    procedure PanelDayMouseLeave(Sender: TObject);
    procedure HoverTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonChangeViewClick(Sender: TObject);
    procedure ButtonLogOutClick(Sender: TObject);
    function FindGridCell(DayNumber: Integer): Integer;
    function GetCalendarEvents(const AccessToken: string): string;
  private
    DayPanels: array[1..42] of TPanel;
    DayMemos: array[1..42] of TMemo;
    DayLabels: array[1..42] of TLabel;
    DayDetails: array[1..42] of string;
    FCurrentYear  : Integer;
    FCurrentMonth : Integer;
    FAccessToken: string;
    HoverTimer: TTimer;
    FHoverCell: Integer;
    FRowCount: Integer;
    procedure PositionDayCells;
    procedure CategoryFilterClick(Sender: TObject);
    procedure SaveWindowPos;
    procedure LoadWindowPos;
    procedure ButtonSearchClick(Sender: TObject);
    procedure EditSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxResultsDblClick(Sender: TObject);
    function IsCategoryVisible(const Category: string): Boolean;
    function IniFileName: string;
    function SearchAllEvents(const Key: string): string;
  public
    property AccessToken: string read FAccessToken write FAccessToken;
    procedure BuildCalendar(AYear, AMonth: Integer);
    procedure RefreshCalendar;
    function IsDateHoliday(ADate: TDate): String;
    function EasterSunday(Year: Integer): TDate;
  end;

var
  Form4: TForm4;

const
  SYMBOL_PROP_ID = 'String {66f5a359-4659-4830-9070-00047ec6ac6e} Name EventSymbol';

implementation

{$R *.dfm}

uses NewEventUnit, EventDetailsUnit, ChangeViewUnit, ProjektAppUnit;

  type
  TCalendarEvent = record
    EventDate: TDate;
    Subject: string;
    Category: string;
  end;

  type
  TCalendarType = (
    ctWork,
    ctPrivate,
    ctHoliday
  );

// Generate the path and filename for the ini-file
function TForm4.IniFileName: string;
var
  AppIni: TIniFile;

begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

// Save window size and position and which days are being showed
procedure TForm4.SaveWindowPos;
var
  Ini: TIniFile;

begin
  Ini := TIniFile.Create(IniFileName);

  // If the window is not fullscreen
  try
    if WindowState = wsNormal then
    begin
      Ini.WriteInteger('Window', 'Left',   Left);
      Ini.WriteInteger('Window', 'Top',    Top);
      Ini.WriteInteger('Window', 'Width',  Width);
      Ini.WriteInteger('Window', 'Height', Height);
    end;

    Ini.WriteBool('Window', 'Maximized', WindowState = wsMaximized);

    Ini.WriteBool('Window', 'CheckBoxWork', CheckBoxWork.Checked);
    Ini.WriteBool('Window', 'CheckBoxPrivate', CheckBoxPrivate.Checked);
    Ini.WriteBool('Window', 'CheckBoxHolidays', CheckBoxHolidays.Checked);

    Ini.WriteBool('ViewDays', 'Monday', PanelMandag.Visible);
    Ini.WriteBool('ViewDays', 'Tuesday', PanelTirsdag.Visible);
    Ini.WriteBool('ViewDays', 'Wednesday', PanelOnsdag.Visible);
    Ini.WriteBool('ViewDays', 'Thursday', PanelTorsdag.Visible);
    Ini.WriteBool('ViewDays', 'Friday', PanelFredag.Visible);
    Ini.WriteBool('ViewDays', 'Saturday', PanelLørdag.Visible);
    Ini.WriteBool('ViewDays', 'Sunday', PanelSøndag.Visible);

  finally
    Ini.Free;
  end;
end;

// Load window size and position and which days are being showed
procedure TForm4.LoadWindowPos;
var
  Ini: TIniFile;

begin
  Ini := TIniFile.Create(IniFileName);

  try
    Left := Ini.ReadInteger('Window', 'Left', Left);
    Top := Ini.ReadInteger('Window', 'Top', Top);
    Width := Ini.ReadInteger('Window', 'Width', Width);
    Height := Ini.ReadInteger('Window', 'Height', Height);

    if Ini.ReadBool('Window', 'Maximized', False) then
      WindowState := wsMaximized;

    CheckBoxWork.Checked := Ini.ReadBool('Window', 'CheckBoxWork', True);
    CheckBoxPrivate.Checked := Ini.ReadBool('Window', 'CheckBoxPrivate', True);
    CheckBoxHolidays.Checked := Ini.ReadBool('Window', 'CheckBoxHolidays', True);

    PanelMandag.Visible  := Ini.ReadBool('ViewDays', 'Monday', True);
    PanelTirsdag.Visible := Ini.ReadBool('ViewDays', 'Tuesday', True);
    PanelOnsdag.Visible  := Ini.ReadBool('ViewDays', 'Wednesday', True);
    PanelTorsdag.Visible := Ini.ReadBool('ViewDays', 'Thursday', True);
    PanelFredag.Visible  := Ini.ReadBool('ViewDays', 'Friday', True);
    PanelLørdag.Visible  := Ini.ReadBool('ViewDays', 'Saturday', True);
    PanelSøndag.Visible  := Ini.ReadBool('ViewDays', 'Sunday', True);

    PanelCalendarResize(Self);

  finally
    Ini.Free;
  end;

end;

// Getting all calendar events from Microsoft Graph in the search
function TForm4.SearchAllEvents(const Key: string): string;
var
  Client: THTTPClient;
  Response: IHTTPResponse;
  StartISO, EndISO: string;

begin
  Client := THTTPClient.Create;

  try
    Client.CustomHeaders['Authorization'] := 'Bearer ' + FAccessToken;
    Client.CustomHeaders['Prefer'] := 'outlook.timezone="Romance Standard Time"';

    StartISO := FormatDateTime('yyyy-mm-dd"T"00:00:00', IncYear(Date, -2));
    EndISO   := FormatDateTime('yyyy-mm-dd"T"23:59:59', IncYear(Date,  2));

    Response := Client.Get(
      'https://graph.microsoft.com/v1.0/me/calendarView' +
      '?startDateTime=' + StartISO +
      '&endDateTime=' + EndISO +
      '&$select=subject,bodyPreview,start' +
      '&$top=1000'
    );

    Result := Response.ContentAsString;

  finally
    Client.Free;
  end;

end;

// Searching when the search button is clicked
procedure TForm4.ButtonSearchClick(Sender: TObject);
var
  RawJson, Key, Subject, RawDateStr, Line, HName: string;
  JsonObj: TJSONObject;
  EventsArray: TJSONArray;
  EventObj: TJSONObject;
  I: Integer;
  StartDate, HDate, HStart, HEnd: TDateTime;
  Body: String;

begin
  ListBoxResults.Items.Clear;
  ListBoxResults.Visible := False;

  Key := Trim(EditSearch.Text);
  if Key = '' then Exit;

  // Make sure the user is authenticated before searching
  if FAccessToken = '' then
  begin
    ShowMessage('Du er ikke logget ind.');
    Exit;
  end;

  // Error handling
  try
    RawJson := SearchAllEvents(Key);

    if RawJson.Contains('"error"') then
    begin
      ShowMessage('Microsoft Graph fejl:' + #13#10 + RawJson);
      Exit;
    end;

    JsonObj := TJSONObject.ParseJSONValue(RawJson) as TJSONObject;
    if not Assigned(JsonObj) then
    begin
      ShowMessage('Kunne ikke fortolke svaret fra Microsoft.');
      Exit;
    end;

    try
      if JsonObj.TryGetValue<TJSONArray>('value', EventsArray) then
      begin
        for I := 0 to EventsArray.Count - 1 do
        begin
          EventObj := EventsArray.Items[I] as TJSONObject;
          Subject := EventObj.GetValue<string>('subject');

          Body := '';
          EventObj.TryGetValue<string>('bodyPreview', Body);

          if not (ContainsText(Subject, Key) or ContainsText(Body, Key)) then
            Continue;

          RawDateStr := EventObj.GetValue<TJSONObject>('start').GetValue<string>('dateTime');
          StartDate := ISO8601ToDate(RawDateStr);

          Line := FormatDateTime('yyyy-mm-dd hh:nn', StartDate) + '  ' + Subject;
          ListBoxResults.Items.AddObject(Line, TObject(NativeInt(Trunc(StartDate))));
        end;

        // Include holidays in the search
        HStart := IncYear(Date, -2);
        HEnd   := IncYear(Date,  2);
        HDate  := HStart;

        while HDate <= HEnd do
        begin
          HName := IsDateHoliday(HDate);

          if (HName <> '') and ContainsText(HName, Key) then
          begin
            Line := FormatDateTime('yyyy-mm-dd', HDate) + '  ' + HName + ' (Helligdag)';
            ListBoxResults.Items.AddObject(Line, TObject(NativeInt(Trunc(HDate))));
          end;

          HDate := HDate + 1;
        end;

        ListBoxResults.Visible := ListBoxResults.Items.Count > 0;

        if ListBoxResults.Items.Count = 0 then
          ShowMessage('Ingen begivenheder fundet for: ' + Key);
      end;

    finally
      JsonObj.Free;
    end;

  except
    on E: Exception do
      ShowMessage('Fejl under søgning: ' + E.Message);
  end;

end;

// Trigger search when the Enter key is pressed in the search box
procedure TForm4.EditSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ButtonSearchClick(nil);
    Key := 0;
  end;
end;

// Double clicking the result will take you to that day
procedure TForm4.ListBoxResultsDblClick(Sender: TObject);
var
  idx, Cell: Integer;
  Dt: TDate;

begin
  idx := ListBoxResults.ItemIndex;

  if idx < 0 then Exit;

  Dt := TDate(NativeInt(ListBoxResults.Items.Objects[idx]));
  FCurrentYear  := YearOf(Dt);
  FCurrentMonth := MonthOf(Dt);
  BuildCalendar(FCurrentYear, FCurrentMonth);

  Cell := FindGridCell(DayOf(Dt));
  if Cell > 0 then
    DayPanels[Cell].Color := clSkyBlue;
end;

// Positioning and sizing the days correctly
procedure TForm4.PositionDayCells;
var
  Cols: array[1..7] of TPanel;
  r, c, idx, HeaderH, CellH: Integer;
  Col: TPanel;

begin
  if DayPanels[1] = nil then Exit;

  Cols[1] := PanelMandag;
  Cols[2] := PanelTirsdag;
  Cols[3] := PanelOnsdag;
  Cols[4] := PanelTorsdag;
  Cols[5] := PanelFredag;
  Cols[6] := PanelLørdag;
  Cols[7] := PanelSøndag;

  if FRowCount < 1 then FRowCount := 6;
  HeaderH := PanelMondayName.Height;

  for c := 1 to 7 do
  begin
    Col := Cols[c];

    // If column is not visible, hide the day cells
    if not Col.Visible then
    begin
      for r := 1 to 6 do
      begin
        idx := (r - 1) * 7 + c;
        DayPanels[idx].Visible := False;
      end;

      Continue;
    end;

    CellH := (Col.ClientHeight - HeaderH) div FRowCount;

    // Setting the properties of the day panels
    for r := 1 to 6 do
    begin
      idx := (r - 1) * 7 + c;
      DayPanels[idx].Align  := alNone;
      DayPanels[idx].Parent := Col;
      DayPanels[idx].Left   := 0;
      DayPanels[idx].Width  := Col.ClientWidth;
      DayPanels[idx].Top    := HeaderH + (r - 1) * CellH;
      DayPanels[idx].Height := CellH;
      DayPanels[idx].Visible := (r <= FRowCount);
    end;
  end;
end;

// Resizing the calendar
procedure TForm4.PanelCalendarResize(Sender: TObject);
var
  Cols: array[1..7] of TPanel;
  ColW: Integer;
  VisibleCols: Integer;
  I: Integer;
  CurrentLeft: Integer;

begin
  Cols[1] := PanelMandag;
  Cols[2] := PanelTirsdag;
  Cols[3] := PanelOnsdag;
  Cols[4] := PanelTorsdag;
  Cols[5] := PanelFredag;
  Cols[6] := PanelLørdag;
  Cols[7] := PanelSøndag;

  // Counting the visible columns
  VisibleCols := 0;
  for I := 1 to 7 do
    if Cols[I].Visible then
      Inc(VisibleCols);

  if VisibleCols = 0 then VisibleCols := 1;

  ColW := PanelCalendar.ClientWidth div VisibleCols;

  // Fix the placement of the columns
  CurrentLeft := 0;
  for I := 1 to 7 do
  begin
    if Cols[I].Visible then
    begin
      Cols[I].Left := CurrentLeft;
      Cols[I].Width := ColW;
      Cols[I].Height := PanelCalendar.ClientHeight;
      CurrentLeft := CurrentLeft + ColW;
    end;
  end;

  if Assigned(DayPanels[1]) then
    PositionDayCells;

  // Places the cells and hides the deactivated days
  for I := 1 to 7 do
  begin
    if not Cols[I].Visible then
    begin
      Cols[I].Width := 0;

      var
        r, idx: Integer;

      for r := 1 to 6 do
      begin
        idx := (r - 1) * 7 + I;

        if (idx >= 1) and (idx <= 42) and Assigned(DayPanels[idx]) then
        begin
          DayPanels[idx].Width := 0;
          DayPanels[idx].Left := -9999;
        end;
      end;
    end;
  end;

  PanelCalendar.Invalidate;

end;

// Checks which categories to show
function TForm4.IsCategoryVisible(const Category: string): Boolean;
begin
  if Category = 'Work' then
    Result := CheckBoxWork.Checked

  else if Category = 'Private' then
    Result := CheckBoxPrivate.Checked

  else if Category = 'Holiday' then
    Result := CheckBoxHolidays.Checked

  else
    Result := True;

end;

// Refreshes calendar when checking calendar types
procedure TForm4.CategoryFilterClick(Sender: TObject);
begin
  RefreshCalendar;
end;

// When hovering with mouse the pop up is shown with slight delay
procedure TForm4.PanelDayMouseEnter(Sender: TObject);
begin
  FHoverCell := (Sender as TControl).Tag;
  HoverTimer.Enabled := True;
end;

// Removing mouse from day cell hides pop up
procedure TForm4.PanelDayMouseLeave(Sender: TObject);
var
  Pt: TPoint;

begin
  HoverTimer.Enabled := False;

  Pt := Mouse.CursorPos;
  if Form3.Visible and PtInRect(Form3.BoundsRect, Pt) then
    Exit;

  Form3.Hide;
end;

// Shift calendar view to the previous month
procedure TForm4.PreviousMonthClick(Sender: TObject);
begin
  Dec(FCurrentMonth);

  if FCurrentMonth < 1 then
  begin
    FCurrentMonth := 12;
    Dec(FCurrentYear);
  end;

  BuildCalendar(FCurrentYear, FCurrentMonth);

end;

// Shift calendar view to the next month
procedure TForm4.NextMonthClick(Sender: TObject);
begin
  Inc(FCurrentMonth);

  if FCurrentMonth > 12 then
  begin
    FCurrentMonth := 1;
    Inc(FCurrentYear);
  end;

  BuildCalendar(FCurrentYear, FCurrentMonth);

end;

// When closing the calendar the whole program terminates and saves the window position
procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveWindowPos;

  Application.Terminate;
end;

// Creating the calendar form
procedure TForm4.FormCreate(Sender: TObject);
var
  I: Integer;
  Year, Month, Day: Word;

begin
  LoadWindowPos;

  // Initializing all day cells
  for I := 1 to 42 do
  begin
    DayPanels[I] := FindComponent('PanelDay' + IntToStr(I)) as TPanel;
    DayMemos[I]  := FindComponent('MemoDay' + IntToStr(I)) as TMemo;
    DayLabels[I] := FindComponent('LabelDay' + IntToStr(I)) as TLabel;

    if DayPanels[I] = nil then
      ShowMessage('Mangler PanelDay' + IntToStr(I));

    if DayMemos[I] = nil then
      ShowMessage('Mangler MemoDay' + IntToStr(I));

    if DayLabels[I] = nil then
      ShowMessage('Mangler LabelDay' + IntToStr(I));

    DayPanels[I].Tag := I;
    DayPanels[I].OnMouseEnter := PanelDayMouseEnter;
    DayPanels[I].OnMouseLeave := PanelDayMouseLeave;
    DayMemos[I].Tag := I;
    DayMemos[I].OnMouseEnter := PanelDayMouseEnter;
    DayMemos[I].OnMouseLeave := PanelDayMouseLeave;
    DayMemos[I].Font.Name := 'Segoe UI Symbol';
    DayMemos[I].Font.Size := 11;
  end;

  FRowCount   := 6;

  // Setting the hover timer for the pop ups
  HoverTimer := TTimer.Create(Self);
  HoverTimer.Enabled := False;
  HoverTimer.Interval := 1500;
  HoverTimer.OnTimer := HoverTimerTimer;

  // Setting the procedure for clicking the checkboxes
  CheckBoxWork.OnClick := CategoryFilterClick;
  CheckBoxPrivate.OnClick := CategoryFilterClick;
  CheckBoxHolidays.OnClick := CategoryFilterClick;

  // Finding the current date
  DecodeDate(Date, Year, Month, Day);
  FCurrentYear  := Year;
  FCurrentMonth := Month;

  // Setting some different procedures
  ButtonSearch.OnClick := ButtonSearchClick;
  EditSearch.OnKeyDown := EditSearchKeyDown;
  ListBoxResults.OnDblClick := ListBoxResultsDblClick;

  // Setting button captions
  PreviousMonth.Caption := '<';
  NextMonth.Caption := '>';

  // Building the calendar
  BuildCalendar(FCurrentYear, FCurrentMonth);

end;

// Creating the calendar
procedure TForm4.BuildCalendar(AYear, AMonth: Integer);
const
  MonthNames: array[1..12] of string = (
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  );

var
  FirstDate: TDate;
  StartPos: Integer;
  DaysInMonthCount: Integer;
  DayNum: Integer;
  GridIndex: Integer;
  I: Integer;
  LastIndex: Integer;
  CurrentDate: TDate;
  CheckDate: TDate;
  HolidayName: String;

begin
  LabelMonth.Caption := MonthNames[AMonth] + ' ' + IntToStr(AYear);

  // Clear the calendar
  for GridIndex := 1 to 42 do
  begin
    DayPanels[GridIndex].Visible := False;
    DayLabels[GridIndex].Caption := '';
    DayMemos[GridIndex].Clear;
    DayDetails[GridIndex] := '';
    DayPanels[GridIndex].Color := $F0FFF0;
  end;

  // Finding the first date and placing the dates in the right cells
  FirstDate := EncodeDate(AYear, AMonth, 1);
  DaysInMonthCount := DaysInAMonth(AYear, AMonth);

  StartPos := DayOfWeek(FirstDate);

  if StartPos = 1 then
    StartPos := 7
  else
    Dec(StartPos);

  LastIndex := StartPos + DaysInMonthCount - 1;
  FRowCount := (LastIndex + 6) div 7;
  GridIndex := StartPos;

  // Check if the week day is visible to see if the day cell should be visible
  for DayNum := 1 to DaysInMonthCount do
  begin
    case (GridIndex - 1) mod 7 of
      0: DayPanels[GridIndex].Visible := PanelMandag.Visible;
      1: DayPanels[GridIndex].Visible := PanelTirsdag.Visible;
      2: DayPanels[GridIndex].Visible := PanelOnsdag.Visible;
      3: DayPanels[GridIndex].Visible := PanelTorsdag.Visible;
      4: DayPanels[GridIndex].Visible := PanelFredag.Visible;
      5: DayPanels[GridIndex].Visible := PanelLørdag.Visible;
      6: DayPanels[GridIndex].Visible := PanelSøndag.Visible;

    else
      DayPanels[GridIndex].Visible := True;

    end;

    // If day cell should be visible we put data in it
    if DayPanels[GridIndex].Visible then
    begin
      DayLabels[GridIndex].Caption := IntToStr(DayNum);
      DayPanels[GridIndex].Color := clWhite;
      DayLabels[GridIndex].Font.Style := [];

      // Mark todays date
      if (AYear = YearOf(Date)) and
         (AMonth = MonthOf(Date)) and
         (DayNum = DayOf(Date)) then
      begin
        DayPanels[GridIndex].Color := $D3F0D3;
        DayLabels[GridIndex].Font.Style := [fsBold];
      end;

      CheckDate := EncodeDate(AYear, AMonth, DayNum);
      DayLabels[GridIndex].Font.Color := clBlack;

      CurrentDate := EncodeDate(AYear, AMonth, DayNum);
      HolidayName := IsDateHoliday(CurrentDate);

      // Set the date font color to red if it is a holiday
      if HolidayName <> '' then
      begin
        DayLabels[GridIndex].Font.Color := clRed;

        if CheckBoxHolidays.Checked then
        begin
          AddEvent(DayNum, HolidayName, 'Holiday');

          DayDetails[GridIndex] :=
            DayDetails[GridIndex] +
            'Holiday' + #1 + HolidayName + sLineBreak;
        end;
      end;
    end;

    Inc(GridIndex);

  end;

  PositionDayCells;

  if FAccessToken <> '' then
    LoadGraphEvents;

end;

// Changing the view when clicking the button
procedure TForm4.ButtonChangeViewClick(Sender: TObject);
begin
  // Checks off the boxes based on how the current view is
  Form5.CheckBoxMonday.Checked    := PanelMandag.Visible;
  Form5.CheckBoxTuesday.Checked   := PanelTirsdag.Visible;
  Form5.CheckBoxWednesday.Checked := PanelOnsdag.Visible;
  Form5.CheckBoxThursday.Checked  := PanelTorsdag.Visible;
  Form5.CheckBoxFriday.Checked    := PanelFredag.Visible;
  Form5.CheckBoxSaturday.Checked  := PanelLørdag.Visible;
  Form5.CheckBoxSunday.Checked    := PanelSøndag.Visible;

  // Change which days to be seen and only save when clicking the save button
  if Form5.ShowModal = mrOk then
  begin
    PanelMandag.Visible  := Form5.CheckBoxMonday.Checked;
    PanelTirsdag.Visible := Form5.CheckBoxTuesday.Checked;
    PanelOnsdag.Visible  := Form5.CheckBoxWednesday.Checked;
    PanelTorsdag.Visible := Form5.CheckBoxThursday.Checked;
    PanelFredag.Visible  := Form5.CheckBoxFriday.Checked;
    PanelLørdag.Visible  := Form5.CheckBoxSaturday.Checked;
    PanelSøndag.Visible  := Form5.CheckBoxSunday.Checked;

    PanelCalendarResize(Self);
    BuildCalendar(FCurrentYear, FCurrentMonth);
  end;
end;

// Log out the active user, delete stored ini token, and switch to login screen
procedure TForm4.ButtonLogOutClick(Sender: TObject);
var
  Ini: TIniFile;

begin
  Ini := TIniFile.Create(Form1.LoginIniName);

  try
    Ini.DeleteKey('Login', 'Token');

  finally
    Ini.Free;
  end;

  Form4.Hide;
  Form1.WindowState := wsMaximized;

end;

// Open the event creation window
procedure TForm4.ButtonNewEventClick(Sender: TObject);
begin
  Form2.AccessToken := FAccessToken;
  Form2.Show;
end;

// Add a new event
procedure TForm4.AddEvent(ADay: Integer; const AText: string; const ACategory: string);
var
  Cell: Integer;

begin
  Cell := FindGridCell(ADay);

  if Cell > 0 then
  begin
    DayMemos[Cell].Lines.Add(AText);
  end;
end;

// Find which specific index array matches a calendar day value
function TForm4.FindGridCell(DayNumber: Integer): Integer;
var
  I: Integer;

begin
  Result := -1;

  for I := 1 to 42 do
    if DayLabels[I].Caption = IntToStr(DayNumber) then
    begin
      Result := I;
      Exit;
    end
end;

// Get calendar events from Microsoft account
function TForm4.GetCalendarEvents(const AccessToken: string): string;
var
  Client: THTTPClient;
  Response: IHTTPResponse;
  StartISO, EndISO: string;
  DaysCount: Integer;
  SymFilter: string;

begin
  Client := THTTPClient.Create;

  try
    Client.CustomHeaders['Authorization'] := 'Bearer ' + AccessToken;
    Client.CustomHeaders['Prefer'] := 'outlook.timezone="Romance Standard Time"';

    DaysCount := DaysInAMonth(FCurrentYear, FCurrentMonth);

    StartISO := Format('%0.4d-%0.2d-01T00:00:00', [FCurrentYear, FCurrentMonth]);
    EndISO := Format('%0.4d-%0.2d-%0.2dT23:59:59', [FCurrentYear, FCurrentMonth, DaysCount]);

    SymFilter := 'id eq ''' + SYMBOL_PROP_ID + '''';
    SymFilter := StringReplace(SymFilter, ' ',  '%20', [rfReplaceAll]);
    SymFilter := StringReplace(SymFilter, '{',  '%7B', [rfReplaceAll]);
    SymFilter := StringReplace(SymFilter, '}',  '%7D', [rfReplaceAll]);
    SymFilter := StringReplace(SymFilter, '''', '%27', [rfReplaceAll]);

    Response := Client.Get(
      'https://graph.microsoft.com/v1.0/me/calendarView' +
      '?startDateTime=' + StartISO +
      '&endDateTime=' + EndISO +
      '&$top=100' + '&$expand=singleValueExtendedProperties($filter=' + SymFilter + ')'
    );

    Result := Response.ContentAsString;

  finally
    Client.Free;

  end;
end;

// Creating the hover timer
procedure TForm4.HoverTimerTimer(Sender: TObject);
begin
  HoverTimer.Enabled := False;

  if (FHoverCell < 1) or (FHoverCell > 42) then Exit;
  if DayLabels[FHoverCell].Caption = '' then Exit;
  if DayMemos[FHoverCell].Lines.Count = 0 then Exit;

  Form3.ShowDetails(DayLabels[FHoverCell].Caption + '. ' + LabelMonth.Caption,
  DayDetails[FHoverCell]);

  // Position next to the mouse and inside the screen
  Form3.Left := Mouse.CursorPos.X + 12;
  Form3.Top  := Mouse.CursorPos.Y + 12;

  if Form3.Top < Self.Top then
    Form3.Top := Self.Top;

  if Form3.Top + Form3.Height > Self.Top + Self.Height then
    Form3.Top := (Self.Top + Self.Height) - Form3.Height;

  if Form3.Left + Form3.Width > Screen.WorkAreaWidth then
    Form3.Left := Mouse.CursorPos.X - Form3.Width - 12;

  Form3.Visible := True;

end;

// Loading all events from the account's calendar
procedure TForm4.LoadGraphEvents;
var
  JsonObj: TJSONObject;
  EventsArray: TJSONArray;
  EventObj: TJSONObject;
  I: Integer;
  Subject: string;
  RawDateStr: string;
  StartDate: TDateTime;
  DayNumber: Integer;
  RawJson: string;
  Description: string;
  Cell: Integer;
  TimeStr: string;
  TimeStr2 : string;
  Category: string;
  Cats: TJSONArray;
  EndRawStr: string;
  EndDate: TDateTime;
  IsAllDay: Boolean;
  FirstDay, LastDay, D: TDateTime;
  J: Integer;
  SvepArr: TJSONArray;
  SvepObj: TJSONObject;
  Symbol, GridText, DetailText: string;

begin
  if FAccessToken = '' then Exit;

  // Error handling
  try
    RawJson := GetCalendarEvents(FAccessToken);

    if RawJson.Contains('"error"') then
    begin
      ShowMessage('Microsoft Graph returnerede en fejl: ' + #13#10 + RawJson);
      Exit;
    end;

    JsonObj := TJSONObject.ParseJSONValue(RawJson) as TJSONObject;
    if not Assigned(JsonObj) then
    begin
      ShowMessage('Kunne ikke fortolke JSON-data fra Microsoft.');
      Exit;
    end;

    try
      if JsonObj.TryGetValue<TJSONArray>('value', EventsArray) then
      begin
        // If there is connection but the calendar is empty
        if EventsArray.Count = 0 then
        begin
          Exit;
        end;

        // Getting information about events
        for I := 0 to EventsArray.Count - 1 do
        begin
          EventObj := EventsArray.Items[I] as TJSONObject;
          Subject := EventObj.GetValue<string>('subject');

          RawDateStr := EventObj.GetValue<TJSONObject>('start').GetValue<string>('dateTime');

          StartDate := ISO8601ToDate(RawDateStr);

          RawDateStr := EventObj.GetValue<TJSONObject>('start').GetValue<string>('dateTime');
          StartDate  := ISO8601ToDate(RawDateStr);

          EndRawStr := EventObj.GetValue<TJSONObject>('end').GetValue<string>('dateTime');
          EndDate   := ISO8601ToDate(EndRawStr);

          IsAllDay := False;
          EventObj.TryGetValue<Boolean>('isAllDay', IsAllDay);

          Category := '';
          if EventObj.TryGetValue<TJSONArray>('categories', Cats) and (Cats.Count > 0) then
            Category := Cats.Items[0].Value;

          // Skip processing if the current event category filter is disabled
          if not IsCategoryVisible(Category) then
            Continue;

          Description := '';
          EventObj.TryGetValue<string>('bodyPreview', Description);

          TimeStr := FormatDateTime('hh:nn', StartDate);
          TimeStr2 := FormatDateTime('hh:nn', EndDate);

          // Get single value extended property for custom event symbols
          Symbol := '';
          if EventObj.TryGetValue<TJSONArray>('singleValueExtendedProperties', SvepArr) then
            for J := 0 to SvepArr.Count - 1 do
            begin
              SvepObj := SvepArr.Items[J] as TJSONObject;

              if SvepObj.GetValue<string>('id').Contains('EventSymbol') then
              begin
                Symbol := SvepObj.GetValue<string>('value');
                Break;
              end;
            end;

          if Symbol <> '' then
            GridText := TimeStr + ' ' + Symbol
          else
            GridText := TimeStr + ' ' + Subject;

          if Symbol <> '' then
            DetailText := Symbol + '  ' + TimeStr + '-' + TimeStr2 + ' ' + Subject
          else
            DetailText := TimeStr + '-' + TimeStr2 + ' ' + Subject;

          // Finding the span of whole days the event covers
          FirstDay := DateOf(StartDate);
          LastDay  := DateOf(EndDate);
          if IsAllDay and (LastDay > FirstDay) then
            LastDay := LastDay - 1;

          D := FirstDay;

          // Add the event to every covered day that falls in the shown month
          while D <= LastDay do
          begin
            if (YearOf(D) = FCurrentYear) and (MonthOf(D) = FCurrentMonth) then
            begin
              DayNumber := DayOf(D);
              AddEvent(DayNumber, GridText, '');

              Cell := FindGridCell(DayNumber);

              if Cell > 0 then
              begin
                DayDetails[Cell] := DayDetails[Cell] + Category + #1 + DetailText + sLineBreak;

                if Trim(Description) <> '' then
                  DayDetails[Cell] := DayDetails[Cell] + Category + #1 + '    ' + Description + sLineBreak;
                DayDetails[Cell] := DayDetails[Cell] + sLineBreak;

              end;
            end;

            D := D + 1;

          end;
        end;
      end;

      finally
        JsonObj.Free;
      end;

      except
      on E: Exception do
      ShowMessage('Fejl under indlæsning af Microsoft Graph Events: ' + E.Message);

  end;
end;

// Finding out when easter falls
function TForm4.EasterSunday(Year: Integer): TDate;
var
  A, B, C, D, E, F, G, H, I, K, L, M: Integer;
  Month, Day: Integer;

begin
  A := Year mod 19;
  B := Year div 100;
  C := Year mod 100;
  D := B div 4;
  E := B mod 4;
  F := (B + 8) div 25;
  G := (B - F + 1) div 3;
  H := (19 * A + B - D - G + 15) mod 30;
  I := C div 4;
  K := C mod 4;
  L := (32 + 2 * E + 2 * I - H - K) mod 7;
  M := (A + 11 * H + 22 * L) div 451;

  Month := (H + L - 7 * M + 114) div 31;
  Day := ((H + L - 7 * M + 114) mod 31) + 1;

  Result := EncodeDate(Year, Month, Day);

end;

// Refresh the calendar
procedure TForm4.RefreshCalendar;
begin
  BuildCalendar(FCurrentYear, FCurrentMonth);
end;

// Setting the font color of the different categories
function GetCategoryColor(const Category: string): TColor;
begin
  if Category = 'Work' then
    Result := clSkyBlue

  else if Category = 'Private' then
    Result := clMoneyGreen

  else if Category = 'Holiday' then
    Result := clYellow

  else
    Result := clWhite;

end;

// Finding other holidays calculated from easter
function TForm4.IsDateHoliday(ADate: TDate): String;
var
  Easter: TDate;

begin
  Result := '';

  Easter := EasterSunday(YearOf(ADate));

  if Trunc(ADate) = Trunc(EncodeDate(YearOf(ADate),1,1)) then
    Result := 'Nytårsdag'

  else if Trunc(ADate) = Trunc(Easter-3) then
    Result := 'Skærtorsdag'

  else if Trunc(ADate) = Trunc(Easter-2) then
    Result := 'Langfredag'

  else if Trunc(ADate) = Trunc(Easter) then
    Result := 'Påskedag'

  else if Trunc(ADate) = Trunc(Easter+1) then
    Result := '2. Påskedag'

  else if Trunc(ADate) = Trunc(Easter+26) then
    Result := 'Store Bededag'

  else if Trunc(ADate) = Trunc(Easter+39) then
    Result := 'Kristi Himmelfartsdag'

  else if Trunc(ADate) = Trunc(Easter+49) then
    Result := 'Pinsedag'

  else if Trunc(ADate) = Trunc(Easter+50) then
    Result := '2. Pinsedag'

  else if Trunc(ADate) = Trunc(EncodeDate(YearOf(ADate),6,5)) then
    Result := 'Grundlovsdag'

  else if Trunc(ADate) = Trunc(EncodeDate(YearOf(ADate),12,25)) then
    Result := 'Juledag'

  else if Trunc(ADate) = Trunc(EncodeDate(YearOf(ADate),12,26)) then
    Result := '2. Juledag';

end;
end.
