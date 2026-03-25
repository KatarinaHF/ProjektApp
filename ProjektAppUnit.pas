unit ProjektAppUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, System.Net.HttpClient,
  System.NetEncoding, System.JSON;

type
  TForm1 = class(TForm)
    LogInButton: TButton;
    Memo1: TMemo;
    procedure LogInClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

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
    body.Add('scope=openid%20profile%20offline_access%20User.Read');
    body.Add('code=' + 'M.C544_BAY.2.U.Dm4vIh7jT8rJDomiB2yAGLRFYda3yz81F6wn*mP1FTbrQ6f6oS0se1TRC7W7acSKttV*0hJzh5GDDLQvgP!rKLkiNwnrqK9W8QIInjwUNp4aJMQeMVuPZG!ZXQ1B3YDWdqQIN3X2CWhxGH0tjBClYi!duzN6amlDCIYukJndIF7ntdvSmVo076xEbMEnSQmN5Sc!5VaYarqL0HlL3imkVZIrqRJnSAUJIOtvFnHj!upRdsVfYMFstXZesT6cMqaMLmy*yCIo5thrQqOssAThg*SWR1zkKyvhHDxCIHqAvTkRyu5dI!9NuctXKOf!DRYIAEPSGt8f5iEuh5ILtIiRUlL1XvONQK!fDpySyUGEN2JstTSdAy3ruuGjBlEx1bEY7O*01CATGtnuM6de3J6vQPy5eqcEj8WHdFHwyRcE0eKdFMgBhjjJObSCYqZ9pHElXRzlPtLWDEEuTFeDf*HC*eVNtP3ZrElTeWfEX3SMg24h1UeU6x5YvOcjGPiwNQy6l4iAzfBr1Qa42AHnK2JRSZWZd6ZmYW*aH1sLGJaPP8ZrUgPOsOZ1NbGzRRzTDD8tZp6xwvb9u8KrNBCeGyDiaQY%24');
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

procedure TForm1.LogInClick(Sender: TObject);
var
  url: string;
begin
  url :=
  'https://login.microsoftonline.com/common/oauth2/v2.0/authorize' +
  '?client_id=bda3be57-751a-40bb-b623-ab66bd19f2e4' +
  '&response_type=code' +
  '&redirect_uri=http://localhost:5000/callback' +
  '&response_mode=query' +
  '&scope=openid%20profile%20offline_access%20User.Read';

  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);

end;


end.
