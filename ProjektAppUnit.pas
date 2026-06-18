unit ProjektAppUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, System.Net.HttpClient,
  System.NetEncoding, System.JSON, IdHTTPServer,IdCustomHTTPServer, IdContext, NewEventUnit,
  EventDetailsUnit, CalendarUnit, Vcl.ExtCtrls, Vcl.Imaging.pngimage, System.IniFiles;

type
  TForm1 = class(TForm)
    LogInButton: TButton;
    Image1: TImage;
    LabelSignIn: TLabel;
    procedure LogInClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnResize(Sender: TObject);
    procedure SaveLoginInfo(const AEmail, AAccessToken: string);
    procedure LoadLoginInfo;
    function IniFileName: string;
    procedure ShowCalendar;
    function CurrentMachineTag: string;
    private
    FAccessToken: string;
    FHttpServer: TIdHTTPServer;
    procedure MyGetCommand(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  public
    function LoginIniName: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// Function getting access token
function GetAccessToken(authCode: string): string;
var
  client: THTTPClient;
  response: IHTTPResponse;
  body: TStringList;
begin
  client := THTTPClient.Create;
  body := TStringList.Create;
  try
    body.Add('client_id=bda3be57-751a-40bb-b623-ab66bd19f2e4');
    body.Add('scope=openid profile offline_access User.Read');
    body.Add('code=' + authCode);
    body.Add('redirect_uri=http://localhost:5000/callback');
    body.Add('grant_type=authorization_code');

    response := client.Post(
      'https://login.microsoftonline.com/common/oauth2/v2.0/token',
      body
    );
    Result := response.ContentAsString;
  finally
    client.Free;
    body.Free;
  end;
end;

// Create a client and get their information
function GetMe(accessToken: string): string;
var
  client: THTTPClient;
  response: IHTTPResponse;
begin
  client := THTTPClient.Create;
  try
    client.CustomHeaders['Authorization'] := 'Bearer ' + accessToken;
    response := client.Get('https://graph.microsoft.com/v1.0/me');
    Result := response.ContentAsString;
  finally
    client.Free;
  end;
end;

// Function for decoding JWT, finding and translating the payload from the JWT
function DecodeJWT(const Token: string): string;
var
  Parts: TArray<string>;
  Payload: string;
begin
  Parts := Token.Split(['.']);
  if Length(Parts) > 1 then
  begin
    Payload := Parts[1];
    case Length(Payload) mod 4 of
      2: Payload := Payload + '==';
      3: Payload := Payload + '=';
    end;

    Result := TNetEncoding.Base64.Decode(Payload);
  end
  else
    Result := 'Invalid Token Format';
end;

// Procedure which logs the person in
// Catches the Microsoft login redirect and exchanges the auth code for an access token
// Runs on a background thread and opens the calendar via TThread.Queue on the main thread
procedure TForm1.MyGetCommand(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  CapturedCode: string;
  RawResponse: string;
  JsonObj: TJSONObject;
  LocalAccessToken: string; // Temporary safe local copy of the token for the queue
  UserInfo: string;
  Json: TJSONObject;
  Email: string;
begin
  CapturedCode := ARequestInfo.Params.Values['code'];

  if CapturedCode <> '' then
  begin
    AResponseInfo.ContentText := '<h1>Success</h1><p>You can return to the app.</p>';

    try
      RawResponse := GetAccessToken(CapturedCode);
      JsonObj := TJSONObject.ParseJSONValue(RawResponse) as TJSONObject;

      if not Assigned(JsonObj) then Exit;

      try
        // Check if we got a token from Microsoft
        if JsonObj.Values['access_token'] <> nil then
        begin
          FAccessToken := JsonObj.Values['access_token'].Value;
          LocalAccessToken := FAccessToken; // Saves the token to the thread

          UserInfo := GetMe(FAccessToken);
          Json := TJSONObject.ParseJSONValue(UserInfo) as TJSONObject;
          try
            Email := Json.GetValue<string>('mail');

          if Email = '' then
            Email := Json.GetValue<string>('userPrincipalName');

            SaveLoginInfo(Email, FAccessToken);
          finally
            Json.Free;
          end;
          // Now that all the text has been extracted and copied into LocalAccessToken,
          // it's safe to hand the UI work over to the main thread
          TThread.Queue(nil,
            procedure
            begin
              Form4 := TForm4.Create(nil);
              Form4.AccessToken := LocalAccessToken; // Uses the safe local copy
              Form4.RefreshCalendar;
              Form4.Show;
              Form1.Width := 1;
              Form1.Height := 1;
            end
          );
        end
        else
        begin
          // If Microsoft sent an error instead of a token
          TThread.Queue(nil,
            procedure
            begin
              ShowMessage('Kunne ikke logge ind. Microsoft svarede: ' + #13#10 + RawResponse);
            end
          );
        end;

      finally
        // Safe to free JsonObj now, the queue doesn't depend on it
        // it has its own independent copy in 'LocalAccessToken'.
        JsonObj.Free;
      end;
    except
      on E: Exception do
      begin
        TThread.Queue(nil,
          procedure
          begin
            ShowMessage('Fejl under login-håndtering: ' + E.Message);
          end
        );
      end;
    end;
  end;
end;

// Procedure for clicking the LogIn button
procedure TForm1.LogInClick(Sender: TObject);
var
  url: string;
begin
  if not Assigned(FHttpServer) then
  begin
    FHttpServer := TIdHTTPServer.Create(Self);
    FHttpServer.DefaultPort := 5000;
    FHttpServer.OnCommandGet := MyGetCommand;
  end;

  FHttpServer.Active := False;
  FHttpServer.Active := True;
  url :=
  'https://login.microsoftonline.com/common/oauth2/v2.0/authorize' +
  '?client_id=bda3be57-751a-40bb-b623-ab66bd19f2e4' +
  '&response_type=code' +
  '&redirect_uri=http://localhost:5000/callback' +
  '&response_mode=query' +
  '&scope=openid%20profile%20offline_access%20User.Read%20Calendars.Read%20Calendars.ReadWrite';
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);

  end;

// Procedure for showing the calendar
procedure TForm1.ShowCalendar;
begin
  if not Assigned(Form4) then
    Form4 := TForm4.Create(Application);

  Form4.AccessToken := FAccessToken;
  Form4.RefreshCalendar;
  Form4.Show;

  Hide;   // hide the login form
end;

// Procedure for creating the logIn background
procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Align := alClient;
  Image1.Stretch := True;
  Image1.Proportional := True;

  Image1.Picture.LoadFromFile(
  ExtractFilePath(Application.ExeName) + 'Loginbackground.png'
);

  LoadLoginInfo;

  if FAccessToken <> '' then
  begin
    Application.ShowMainForm := False;
    ShowCalendar;
  end;
end;

// Function which makes the path to the Ini file per user and per machine
function TForm1.LoginIniName: string;
var
  Dir: string;
begin
  Dir := GetEnvironmentVariable('LOCALAPPDATA'); // per-user, per-machine
  if Dir = '' then
    Dir := ExtractFilePath(Application.ExeName); // fallback, just in case
  Dir := IncludeTrailingPathDelimiter(Dir) + 'Kalender';
  ForceDirectories(Dir);
  Result := IncludeTrailingPathDelimiter(Dir) + 'login.ini';
end;

// Function that returns a tag for the current machine and user
function TForm1.CurrentMachineTag: string;
begin
  Result := GetEnvironmentVariable('COMPUTERNAME') + '\' +
            GetEnvironmentVariable('USERNAME');
end;

// Procedure with layout for the login screen when it is resized
procedure TForm1.OnResize(Sender: TObject);
begin
  Image1.Width := Form1.Width;
  LogInButton.Margins.Top := (Form1.Height div 8) * 3;
  LogInButton.Margins.Bottom := (Form1.Height div 8) * 3;

  LabelSignIn.Width := Form1.Width;
  LogInButton.Margins.Left := (Form1.Width div 8) * 3;
  LogInButton.Margins.Right := (Form1.Width div 8) * 3;
end;

// Function that returns the path to the Ini file that saves settings
// like where the window was last closed
function TForm1.IniFileName: string;
var
  AppIni: TIniFile;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

// Procedure which saves the login to the Ini file for next time the app is opened
procedure TForm1.SaveLoginInfo(const AEmail, AAccessToken: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(LoginIniName);
  try
    Ini.WriteString('Login', 'Token', FAccessToken);
    Ini.WriteString('Login', 'Email', AEmail);
    Ini.WriteString('Login', 'Machine', CurrentMachineTag);
  finally
    Ini.Free;
  end;
end;

// Procedure that loads the saved login
// but only accepts it if it was saved on the same machine and user
procedure TForm1.LoadLoginInfo;
var
  Ini: TIniFile;
  SavedTag: string;
begin
FAccessToken := ''; // Start logged out by default
  Ini := TIniFile.Create(LoginIniName);
  try
    SavedTag := Ini.ReadString('Login', 'Machine', '');
    if SameText(SavedTag, CurrentMachineTag) then
    FAccessToken :=
      Ini.ReadString('Login', 'Token', '');
  finally
    Ini.Free;
  end;
end;

end.

