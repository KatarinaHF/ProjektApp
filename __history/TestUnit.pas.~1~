unit TestUnit;

interface

uses
  DUnitX.TestFramework, CalendarUnit;

type
  [TestFixture]
  TestUnitTest = class
  public
    // Sample Methods
    // Simple single Test
    [Test]
    procedure FindGridCell_ReturnCorrectCell;
  end;

implementation

procedure TestUnitTest.FindGridCell_ReturnCorrectCell;
var
  Form: TForm4;
begin
  Form := TForm4.Create(nil);
  try
    Form.BuildCalendar(2025,5);

    Assert.AreNotEqual(-1, Form.FindGridCell(1));
  finally
    Form.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TestUnitTest);

end.

