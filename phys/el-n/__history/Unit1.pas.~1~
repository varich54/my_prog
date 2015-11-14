unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    img: TImage;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var x0,y0,x,y,i,r:integer;
begin
x0:=img.Width div 2;
y0:=img.Height div 2;
img.Canvas.Ellipse(x0-10,y0-10,x0+10,y0+10);
for i:= 0 to 100 do begin
    x:=trunc(x0+25*sin(i*pi/50));
    if i<=50 then   y:=y0+i-25
    else y:=y0-i+75;
    img.Canvas.Pixels[x,y]:=clred;
    r:= trunc(1.1*sqrt(sqr(x)+sqr(y)))-300;
    image1.Canvas.Pixels[i,r]:=clred;
    end;
end;

end.
