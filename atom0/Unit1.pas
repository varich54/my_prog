unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Telectron = class
    x, y, z, vx, vy, vz: real;
    size: integer;
  end;

type
  Tatom = class
    x, y, z: real;
    charge, mass, vx, vy, vz: real;
    size: integer;
    els: array of Telectron; // array of electrons
    num_of_els: byte;
    procedure paint;
  end;

var
  Form1: TForm1;
  atom1, atom2: Tatom;
  x0, y0: integer;

implementation

{$R *.dfm}

procedure Tatom.paint;
var
  i: byte;
  rec: trect;
begin
  // painting nuclear//ядро
  Form1.Image1.Canvas.Ellipse(x0 - trunc(x - size), y0 - trunc(y - size),
    x0 - trunc(x + size), y0 - trunc(y + size));
  // painting electrons
  for i := 0 to num_of_els - 1 do
  begin
    rec := rect(x0 + trunc(els[i].x - els[i].size),
      y0 - trunc(els[i].y - els[i].size), x0 + trunc(els[i].x + els[i].size),
      y0 - trunc(els[i].y + els[i].size));
    Form1.Image1.Canvas.Ellipse(rec);

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  atom1 := Tatom.Create;
  atom2 := Tatom.Create;
  x0 := Image1.Width div 2;
  y0 := Image1.Height div 2;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with atom1 do
  begin
    x := 0;
    y := 0;
    z := 0;
    size := 20;
    charge := 1;
    mass := 1;
    num_of_els := 2;
    setlength(atom1.els, num_of_els);
    els[0] := Telectron.Create;
    els[0].x := 40;
    els[0].y := 0;
    els[0].z := 0;
    els[0].size := 5;
    els[1] := Telectron.Create;
    els[1].x := -80;
    els[1].y := 0;
    els[1].z := 0;
    els[1].size := 5;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  atom1.paint;
end;

end.
