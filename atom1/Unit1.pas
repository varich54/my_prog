unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Image2: TImage;
    Image3: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Edit12: TEdit;
    Edit13: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Edit14: TEdit;
    Edit15: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Label22: TLabel;
    XPManifest1: TXPManifest;
    Tab1: TTabControl;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  DIMENTIONS = 2;

type
  Tstar = record
    v, vx, vy, v0x, v0y, x, y, x0, y0, fx, fy: real;
  end;

type
  Telectron = class
    x, y, z, vx, vy, vz, v0x, v0y, v0z, fx, fy, fz: real;
    size, x0, y0, z0: integer;
  end;

type
  Tatom = class
    x, y, z: real;
    charge, mass, vx, vy, vz, v0x, v0y, v0z, fx, fy, fz: real;
    size, x0, y0, z0: integer;
    els: array of Telectron; // array of electrons
    num_of_els: byte;
    procedure paint;
  end;

var
  Form1: TForm1;
  cx, cy, cx2, cy2, cx3, cy3, dt, fx, fy, fx_old, g, r_1, r_2, r_3, vx_old,
    Rkv_2_1, Rkv_3_2, Rkv_3_1, Rkv_4_1, Rkv_4_2, Rkv_4_3, dF: real;
  x, y, i: integer;
  star1, star2, star3, star4: Tstar;

  atom1, atom2: Tatom;
  x0, y0: integer;
  c: real; // const of electr power

implementation

{$R *.dfm}

procedure Tatom.paint;
var
  i: byte;
  rec: trect;
begin
  // painting nuclear//????
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

procedure rasstoyaniya_and_grav_sila;
begin
  // dF:=10000;
  Rkv_2_1 := sqr(star2.x - star1.x) + sqr(star2.y - star1.y);
  // квадраты расстояния
  Rkv_3_2 := sqr(star2.x - star3.x) + sqr(star2.y - star3.y);
  Rkv_3_1 := sqr(star3.x - star1.x) + sqr(star3.y - star1.y);
  Rkv_4_1 := sqr(star4.x - star1.x) + sqr(star4.y - star1.y);
  Rkv_4_2 := sqr(star4.x - star2.x) + sqr(star4.y - star2.y);
  Rkv_4_3 := sqr(star4.x - star3.x) + sqr(star4.y - star3.y);

  star1.fx := ((star2.x - star1.x) / (2 * sqrt(Rkv_2_1) * Rkv_2_1)) +
    ((star3.x - star1.x) / (2 * sqrt(Rkv_3_1) * Rkv_3_1)) +
    ((star4.x - star1.x) / (2 * sqrt(Rkv_4_1) * Rkv_4_1)); // считаем G=m1=m2=1`
  star1.fy := ((star2.y - star1.y) / (2 * sqrt(Rkv_2_1) * Rkv_2_1)) +
    ((star3.y - star1.y) / (2 * sqrt(Rkv_3_1) * Rkv_3_1)) +
    ((star4.y - star1.y) / (2 * sqrt(Rkv_4_1) * Rkv_4_1)); // считаем G=m1=m2=1`

  star2.fx := ((star1.x - star2.x) / (2 * sqrt(Rkv_2_1) * Rkv_2_1)) +
    ((star3.x - star2.x) / (2 * sqrt(Rkv_3_1) * Rkv_3_1)) +
    ((star4.x - star2.x) / (2 * sqrt(Rkv_4_2) * Rkv_4_2)); // считаем G=m1=m2=1`
  star2.fy := ((star1.y - star2.y) / (2 * sqrt(Rkv_2_1) * Rkv_2_1)) +
    ((star3.y - star2.y) / (2 * sqrt(Rkv_3_1) * Rkv_3_1)) +
    ((star4.y - star2.y) / (2 * sqrt(Rkv_4_2) * Rkv_4_2)); // считаем G=m1=m2=1`

  star3.fx := ((star1.x - star3.x) / (2 * sqrt(Rkv_3_1) * Rkv_3_1)) +
    ((star2.x - star3.x) / (2 * sqrt(Rkv_3_2) * Rkv_3_2)) +
    ((star4.x - star3.x) / (2 * sqrt(Rkv_4_3) * Rkv_4_3)); // считаем G=m1=m2=1`
  star3.fy := ((star1.y - star3.y) / (2 * sqrt(Rkv_3_1) * Rkv_3_1)) +
    ((star2.y - star3.y) / (2 * sqrt(Rkv_3_2) * Rkv_3_2)) +
    ((star4.y - star3.y) / (2 * sqrt(Rkv_4_3) * Rkv_4_3)); // считаем G=m1=m2=1`

  star4.fx := ((star1.x - star4.x) / (2 * sqrt(Rkv_4_1) * Rkv_4_1)) +
    ((star3.x - star4.x) / (2 * sqrt(Rkv_4_3) * Rkv_4_3)) +
    ((star2.x - star4.x) / (2 * sqrt(Rkv_4_2) * Rkv_4_2)); // считаем G=m1=m2=1`
  star4.fy := ((star1.y - star4.y) / (2 * sqrt(Rkv_4_1) * Rkv_4_1)) +
    ((star3.y - star4.y) / (2 * sqrt(Rkv_4_3) * Rkv_4_3)) +
    ((star2.y - star4.y) / (2 * sqrt(Rkv_4_2) * Rkv_4_2)); // считаем G=m1=m2=1`

  star1.fx := star1.fx * dF;
  star2.fx := star2.fx * dF;
  star3.fx := star3.fx * dF;
  star4.fx := star4.fx * dF;

  star1.fy := star1.fy * dF;
  star2.fy := star2.fy * dF;
  star3.fy := star3.fy * dF;
  star4.fy := star4.fy * dF;
end;

procedure electr_sila;
begin
  c := 1; // koef-t pri grav sile

end;

procedure find_maximum;
begin
  if star1.fx > fx_old then
  begin
    Form1.Label8.Caption := 'Fmax=' + floattostr(star1.fx);
    fx_old := star1.fx;
  end;
  if star1.vx > vx_old then
  begin
    Form1.Label9.Caption := 'Vmax=' + floattostr(vx_old);
    vx_old := star1.vx;
  end;
end;

procedure fizika;
begin

  rasstoyaniya_and_grav_sila;
  // рассчитываем расстояния и силы взаимодействия между объектами
  electr_sila;
  star1.vx := star1.v0x + star1.fx * dt;
  star1.vy := star1.v0y + star1.fy * dt;
  star1.x := star1.x0 + star1.vx * dt;
  star1.y := star1.y0 + star1.vy * dt;

  star2.vx := star2.v0x + star2.fx * dt;
  star2.vy := star2.v0y + star2.fy * dt;
  star2.x := star2.x0 + star2.vx * dt;
  star2.y := star2.y0 + star2.vy * dt;

  star3.vx := star3.v0x + star3.fx * dt;
  star3.vy := star3.v0y + star3.fy * dt;
  star3.x := star3.x0 + star3.vx * dt;
  star3.y := star3.y0 + star3.vy * dt;

  star4.vx := star4.v0x + star4.fx * dt;
  star4.vy := star4.v0y + star4.fy * dt;
  star4.x := star4.x0 + star4.vx * dt;
  star4.y := star4.y0 + star4.vy * dt;
  find_maximum;

  star1.v0x := star1.vx;
  star1.v0y := star1.vy;
  star2.v0x := star2.vx;
  star2.v0y := star2.vy;
  star3.v0x := star3.vx;
  star3.v0y := star3.vy;
  star4.v0x := star4.vx;
  star4.v0y := star4.vy;

  star1.x0 := star1.x;
  star1.y0 := star1.y;
  star2.x0 := star2.x;
  star2.y0 := star2.y;
  star3.x0 := star3.x;
  star3.y0 := star3.y;
  star4.x0 := star4.x;
  star4.y0 := star4.y;

  Form1.Label5.Caption := 'Fx=' + floattostr(star1.fx);
  Form1.Label6.Caption := 'Fy=' + floattostr(star1.fy);
  Form1.Label7.Caption := 'r^2=' + floattostr(Rkv_2_1);

  Form1.Image2.Canvas.Pixels[i, (Form1.Image2.Height div 2) -
    trunc(star1.fx / cx2)] := clred;
  Form1.Image3.Canvas.Pixels[i, (Form1.Image3.Height div 2) -
    trunc(star1.vx / cx3)] := clred;

end;

procedure risuem;
begin
  with Form1.Image1.Canvas do
  begin
    Brush.Color := clred;
    x := trunc(star1.x / cx);
    y := trunc(star1.y / cy);
    Ellipse(x + (Form1.Image1.Width div 2) + 4, (Form1.Image1.Height div 2) - y
      + 4, x + (Form1.Image1.Width div 2) - 4,
      (Form1.Image1.Height div 2) - y - 4);

    Brush.Color := clgreen;
    x := trunc(star2.x / cx);
    y := trunc(star2.y / cy);
    Ellipse(x + (Form1.Image1.Width div 2) + 4, (Form1.Image1.Height div 2) - y
      + 4, x + (Form1.Image1.Width div 2) - 4,
      (Form1.Image1.Height div 2) - y - 4);

    Brush.Color := clblue;
    x := trunc(star3.x / cx);
    y := trunc(star3.y / cy);
    Ellipse(x + (Form1.Image1.Width div 2) + 4, (Form1.Image1.Height div 2) - y
      + 4, x + (Form1.Image1.Width div 2) - 4,
      (Form1.Image1.Height div 2) - y - 4);

    Brush.Color := clyellow;
    x := trunc(star4.x / cx);
    y := trunc(star4.y / cy);
    Ellipse(x + (Form1.Image1.Width div 2) + 4, (Form1.Image1.Height div 2) - y
      + 4, x + (Form1.Image1.Width div 2) - 4,
      (Form1.Image1.Height div 2) - y - 4);
    inc(i);
  end;
end;

procedure init;
begin

  i := 0;
  star1.v0x := strtofloat(Form1.Edit2.Text);
  star1.v0y := strtofloat(Form1.Edit3.Text);
  star2.v0x := strtofloat(Form1.Edit4.Text);
  star2.v0y := strtofloat(Form1.Edit5.Text);
  star3.v0x := strtofloat(Form1.Edit6.Text);
  star3.v0y := strtofloat(Form1.Edit7.Text);
  star4.v0x := strtofloat(Form1.Edit8.Text);
  star4.v0y := strtofloat(Form1.Edit9.Text);

  star1.x0 := strtofloat(Form1.Edit10.Text);
  star1.y0 := strtofloat(Form1.Edit11.Text);
  star2.x0 := strtofloat(Form1.Edit12.Text);
  star2.y0 := strtofloat(Form1.Edit13.Text);
  star3.x0 := strtofloat(Form1.Edit14.Text);
  star3.y0 := strtofloat(Form1.Edit15.Text);
  star4.x0 := strtofloat(Form1.Edit16.Text);
  star4.y0 := strtofloat(Form1.Edit17.Text);

  star1.x := star1.x0;
  star1.y := star1.y0;
  star2.x := star2.x0;
  star2.y := star2.y0;
  star3.x := star3.x0;
  star3.y := star3.y0;
  star4.x := star4.x0;
  star4.y := star4.y0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  fizika;
  risuem;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label8.Caption := 'Fmax=0';
  Label9.Caption := 'Vmax=0';
  Image1.Canvas.Brush.Color := clwhite;
  Image1.Canvas.FillRect(rect(0, 0, Image1.Width, Image1.Height));
  // image1.Canvas.Ellipse(image1.Width div 2+5,image1.height div 2+5,image1.Width div 2-5,image1.height div 2-5);
  Image2.Canvas.FillRect(rect(0, 0, Image2.Width, Image2.Height));
  Image3.Canvas.FillRect(rect(0, 0, Image3.Width, Image3.Height));
  Image2.Canvas.MoveTo(0, Image2.Height div 2);
  Image2.Canvas.LineTo(Image2.Width, Image2.Height div 2);
  Image3.Canvas.MoveTo(0, Image3.Height div 2);
  Image3.Canvas.LineTo(Image3.Width, Image3.Height div 2);
  init;
  g := 10;
  dt := strtofloat(Form1.Edit1.Text);
  cx := 300 / Image1.Width;
  dF := 10000;
  cy := cx;
  cx2 := 11 / (Form1.Image2.Height div 2);
  cx3 := 11 / (Form1.Image3.Height div 2);
  // image1.Canvas.Pen.Mode:=pmNotXor;

  atom1 := Tatom.Create;
  atom2 := Tatom.Create;
  x0 := Image1.Width div 2;
  y0 := Image1.Height div 2;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Canvas.Pen.Color := clblack;
  Image1.Canvas.MoveTo(1, 1);
  Image1.Canvas.LineTo(1, Image1.Height - 1);
  Image1.Canvas.LineTo(Image1.Width - 1, Image1.Height - 1);
  Image1.Canvas.LineTo(Image1.Width - 1, 1);
  Image1.Canvas.LineTo(1, 1);

  Image2.Canvas.Pen.Width := 1;
  Image2.Canvas.Pen.Color := clblack;
  Image2.Canvas.MoveTo(1, 1);
  Image2.Canvas.LineTo(1, Image2.Height - 1);
  Image2.Canvas.LineTo(Image2.Width - 1, Image2.Height - 1);
  Image2.Canvas.LineTo(Image2.Width - 1, 1);
  Image2.Canvas.LineTo(1, 1);
  Image2.Canvas.Pen.Width := 2;

  Image3.Canvas.Pen.Width := 1;
  Image3.Canvas.Pen.Color := clblack;
  Image3.Canvas.MoveTo(1, 1);
  Image3.Canvas.LineTo(1, Image3.Height - 1);
  Image3.Canvas.LineTo(Image3.Width - 1, Image3.Height - 1);
  Image3.Canvas.LineTo(Image3.Width - 1, 1);
  Image3.Canvas.LineTo(1, 1);
  Image3.Canvas.Pen.Width := 2;

  Timer1.Enabled := not Timer1.Enabled;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  FormCreate(Form1);
end;

procedure TForm1.Button3Click(Sender: TObject);
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

procedure TForm1.Button4Click(Sender: TObject);
begin
  atom1.paint;
end;

end.
