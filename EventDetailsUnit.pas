unit EventDetailsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    PanelDate: TPanel;
    PanelInfo: TPanel;
    MemoInfo: TRichEdit;
    procedure MemoInfoMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowDetails(const ADate: string; const AData: string);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}


function CategoryColor(const Category: string): TColor;
begin
  if Category = 'Work' then
    Result := clBlue
  else if Category = 'Private' then
    Result := clGreen
  else if Category = 'Holiday' then
    Result := clRed
  else
    Result := clWindowText;   // no category = normal text
end;

procedure TForm3.ShowDetails(const ADate: string; const AData: string);
var
  Lines: TStringList;
  I, P: Integer;
  Cat, Txt: string;
begin
  PanelDate.Caption := ADate;
  MemoInfo.Lines.BeginUpdate;
  try
    MemoInfo.Clear;
    Lines := TStringList.Create;
    try
      Lines.Text := AData;
      for I := 0 to Lines.Count - 1 do
      begin
        P := Pos(#1, Lines[I]);
        if P > 0 then
        begin
          Cat := Copy(Lines[I], 1, P - 1);
          Txt := Copy(Lines[I], P + 1, MaxInt);
        end
        else
        begin
          Cat := '';
          Txt := Lines[I];
        end;

        MemoInfo.SelStart := MemoInfo.GetTextLen;
        MemoInfo.SelAttributes.Color := CategoryColor(Cat);
        MemoInfo.SelText := Txt + #13#10;
      end;
    finally
      Lines.Free;
    end;
  finally
    MemoInfo.Lines.EndUpdate;
  end;
end;

procedure TForm3.MemoInfoMouseLeave(Sender: TObject);
var
  Pt: TPoint;
begin
  Pt := ScreenToClient(Mouse.CursorPos);
  // Only hide if the mouse actually left the entire form
  if not PtInRect(ClientRect, Pt) then
    Hide;
end;

end.
