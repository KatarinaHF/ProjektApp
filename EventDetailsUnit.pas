unit EventDetailsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Net.HttpClient,
  System.Net.URLClient;

type
  TForm3 = class(TForm)
    PanelDate: TPanel;
    PanelInfo: TPanel;
    ListBoxInfo: TListBox;
    PanelButtons: TPanel;
    ButtonDelete: TButton;
    ButtonEdit: TButton;
    procedure MemoInfoMouseLeave(Sender: TObject);
    procedure ListBoxInfoClick(Sender: TObject);
    procedure ListBoxInfoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
  private
    FSelectedEventID: string;
  public
    procedure ShowDetails(const ADate: string; const AData: string);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses CalendarUnit, NewEventUnit;

// Changes color of the event text depending on the calendar type
function CategoryColor(const Category: string): TColor;
begin
  if Category = 'Work' then
    Result := clBlue
  else if Category = 'Private' then
    Result := clGreen
  else if Category = 'Holiday' then
    Result := clRed
  else
    Result := clWindowText;
end;

procedure TForm3.ListBoxInfoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  FullLine, DisplayText, Cat: string;
  P1, P2: Integer;
begin
  ListBoxInfo.Canvas.FillRect(Rect);
  FullLine := ListBoxInfo.Items[Index];

  P1 := Pos(#1, FullLine);
  P2 := Pos(#2, FullLine);

  if (P1 > 0) and (P2 > 0) then
  begin
    Cat := Copy(FullLine, 1, P1 - 1);
    DisplayText := Copy(FullLine, P1 + 1, P2 - P1 - 1);

    // Set the brush text colors using the CategoryColor function
    ListBoxInfo.Canvas.Font.Color := CategoryColor(Cat);
  end;

  ListBoxInfo.Canvas.TextOut(Rect.Left + 4, Rect.Top + 2, DisplayText);
end;

// Show the chosen days date and event details
procedure TForm3.ShowDetails(const ADate: string; const AData: string);
var
  Lines: TStringList;
  I, P1, P2: Integer;
  DisplayLine: string;
  HiddenID: string;
  IDContainer: TStringList;
begin
  PanelDate.Caption := ADate;
  ListBoxInfo.Items.BeginUpdate;
  try
    // 1. Memory Clean-up: Prevent memory leaks by freeing old hidden TStringList containers
    for I := 0 to ListBoxInfo.Items.Count - 1 do
      if Assigned(ListBoxInfo.Items.Objects[I]) then
        ListBoxInfo.Items.Objects[I].Free;

    ListBoxInfo.Items.Clear;
    FSelectedEventID := ''; // Reset selection state

    Lines := TStringList.Create;
    try
      Lines.Text := AData;
      for I := 0 to Lines.Count - 1 do
      begin
        if Trim(Lines[I]) = '' then Continue;

        P1 := Pos(#1, Lines[I]); // Finds the square separator after 'Work/Private'
        P2 := Pos(#2, Lines[I]); // Finds the separator before the long ID string

        if P2 > 0 then
        begin
          // Isolate the Clean Text: Strip out 'Work#1' and '#2[LONG_ID]'
          if P1 > 0 then
            DisplayLine := Copy(Lines[I], P1 + 1, P2 - P1 - 1)
          else
            DisplayLine := Copy(Lines[I], 1, P2 - 1);

          // Isolate the Hidden ID string
          HiddenID := Copy(Lines[I], P2 + 1, MaxInt);

          // Create an invisible object slot to hold the ID safely in background memory
          IDContainer := TStringList.Create;
          IDContainer.Text := Trim(HiddenID);

          // Add the clean readable text to the list box items, while hiding the ID container object
          ListBoxInfo.Items.AddObject(DisplayLine, IDContainer);
        end;
      end;
    finally
      Lines.Free;
    end;
  finally
    ListBoxInfo.Items.EndUpdate;
  end;
end;


procedure TForm3.ButtonDeleteClick(Sender: TObject);
var
  Client: THTTPClient;
  Response: IHTTPResponse;
begin
  if FSelectedEventID = '' then
  begin
    ShowMessage('Vælg venligst en begivenhed fra listen først.');
    Exit;
  end;

  if MessageDlg('Vil du slette denne begivenhed?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Client := THTTPClient.Create;
  try
    // Use the AccessToken stored in Form4
    Client.CustomHeaders['Authorization'] := 'Bearer ' + Form4.AccessToken;

    // Send the DELETE request directly to the specific event's URL endpoint
    Response := Client.Delete('https://graph.microsoft.com/v1.0/me/events/' + FSelectedEventID);

    // Microsoft Graph returns status code 204 (No Content) when a delete succeeds
    if Response.StatusCode = 204 then
    begin
      ShowMessage('Begivenheden blev slettet!');
      Hide;
      Form4.RefreshCalendar; // Re-render the main calendar grid immediately
    end
    else
    begin
      ShowMessage('Fejl under sletning (' + IntToStr(Response.StatusCode) + '): ' + Response.ContentAsString);
    end;
  finally
    Client.Free;
  end;
end;

procedure TForm3.ButtonEditClick(Sender: TObject);
var
  CleanText: string;
  P: Integer;
begin
  if FSelectedEventID = '' then
  begin
    ShowMessage('Vælg venligst en begivenhed fra listen først.');
    Exit;
  end;

  // Pass along the token and the unique ID to Form2
  Form2.AccessToken := Form4.AccessToken;
  Form2.EditEventID := FSelectedEventID; // Toggles Form2 into "Edit Mode"

  // Grab the clean text currently highlighted in your listbox to prefill the title field
  if ListBoxInfo.ItemIndex >= 0 then
  begin
    CleanText := ListBoxInfo.Items[ListBoxInfo.ItemIndex];

    // Strip timestamps or symbols if they exist to isolate the raw subject title
    P := Pos(' ', CleanText);
    if P > 0 then CleanText := Copy(CleanText, P + 1, MaxInt);

    Form2.TitleEdit.Text := Trim(CleanText);
  end;

  Form2.Show;
  Hide; // Close the details popup while editing
end;

// Choose the event and be able to either delete or change it
procedure TForm3.ListBoxInfoClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := ListBoxInfo.ItemIndex;
  if Idx < 0 then Exit;

  // Hent det skjulte ID-objekt ud fra den valgte linje
  if Assigned(ListBoxInfo.Items.Objects[Idx]) then
  begin
    FSelectedEventID := Trim((ListBoxInfo.Items.Objects[Idx] as TStringList).Text);

    ButtonEdit.Enabled := True;
    ButtonDelete.Enabled := True;
  end
end;

// Hides the form when the mouse leaves it
procedure TForm3.MemoInfoMouseLeave(Sender: TObject);
var
  Pt: TPoint;
begin
  Pt := ScreenToClient(Mouse.CursorPos);

  if not PtInRect(ClientRect, Pt) then
    Hide;
end;


end.
