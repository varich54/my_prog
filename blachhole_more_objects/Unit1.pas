unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, Buttons;

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
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Edit18: TEdit;
    Label23: TLabel;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  cx, cy, cx2, cy2, cx3, cy3, dt, g, dF: real;
  x1, y1, i1, n, k: integer;

  R: array [1 .. 100, 1 .. 100] of real;
  Fx, Fy, x, y, x0, y0, vx, vy, v0x, v0y: array [1 .. 100] of real;

implementation

{$R *.dfm}

procedure rasstoyaniya_and_sili;
var
  i, j: integer;
begin
  dF := 10000;
  for i := 1 to n - 1 do
  begin
    for j := (i + 1) to n do
    begin
      R[i, j] := sqr(x[i] - x[j]) + sqr(y[i] - y[j]);
      R[j, i] := R[i, j];
      // if R[j,i]=0 then form1.Memo3.Lines.Add(floattostr(x[i])+' '+floattostr(x[j])+'  '+floattostr(y[i])+' '+floattostr(y[j]));
      // if R[j,i]=0 then form1.Memo3.Lines.Add(floattostr(i)+' '+floattostr(j));
      // form1.Memo1.Lines.Add('R['+floattostr(i)+','+floattostr(j)+']='+floattostr(R[i,j])+'  R['+floattostr(j)+','+floattostr(i)+']='+floattostr(R[j,i]));
    end;
  end;

  for i := 1 to n do
  begin
    Fx[i] := 0;
    Fy[i] := 0;
    for j := 1 to n do
    begin
      if i <> j then
        Fx[i] := Fx[i] + (dF * (x[j] - x[i]) / (2 * sqrt(R[i, j]) * R[i, j]));
      if i <> j then
        Fy[i] := Fy[i] + (dF * (y[j] - y[i]) / (2 * sqrt(R[i, j]) * R[i, j]));
      // if i<>j then form1.Memo2.Lines.Add('Fx['+floattostr(i)+','+floattostr(j)+']='+floattostr(trunc(Fx[i]))+'  Fy['+floattostr(i)+','+floattostr(j)+']='+floattostr(trunc(Fy[i])));
    end;
    // form1.Memo3.Lines.Add('Fx['+floattostr(i)+']='+floattostr(trunc(Fx[i]))+'  Fy['+floattostr(i)+']='+floattostr(trunc(Fy[i])));
  end;

end;

procedure fizika;
var
  i: integer;
begin

  rasstoyaniya_and_sili;
  // рассчитываем расстояния и силы взаимодействия между объектами
  // временные переходные формулы от record к массивам array:
  for i := 1 to n do
  begin
    vx[i] := v0x[i] + Fx[i] * dt;
    x[i] := x0[i] + vx[i] * dt;
    vy[i] := v0y[i] + Fy[i] * dt;
    y[i] := y0[i] + vy[i] * dt;
    v0x[i] := vx[i];
    v0y[i] := vy[i];
    x0[i] := x[i];
    y0[i] := y[i];
  end;

  Form1.Label5.Caption := 'Fx=' + floattostr(Fx[1]);
  Form1.Label6.Caption := 'Fy=' + floattostr(Fy[1]);
  Form1.Label7.Caption := 'r^2=' + floattostr(R[1, 2]);
  { form1.Image2.Canvas.Pixels[i1,(form1.Image2.Height div 2)-trunc(fx[1]/cx2)]:=clred;
    form1.Image3.Canvas.Pixels[i1,(form1.Image3.Height div 2)-trunc(star1.vx/cx3)]:=clred;
  }
end;

procedure risuem;
var
  i: integer;
begin
  with Form1.Image1.Canvas do
  begin
    for i := 1 to n do
    begin
      Brush.Color := i * 50;
      x1 := trunc(x[i] / cx);
      y1 := trunc(y[i] / cy);
      Ellipse(x1 + (Form1.Image1.Width div 2) + 4, (Form1.Image1.Height div 2) -
        y1 + 4, x1 + (Form1.Image1.Width div 2) - 4,
        (Form1.Image1.Height div 2) - y1 - 4);
    end;

    inc(i1);
  end;
end;

procedure init;
var
  i: integer;
begin
  n := 50;
  i1 := 0;
  { star1.v0x:=strtofloat(form1.Edit2.Text);  //временно меняем начальные кооорды на рандом
  }
  x0[1] := strtofloat(Form1.Edit10.Text);
  x0[2] := strtofloat(Form1.Edit12.Text);
  x0[3] := strtofloat(Form1.Edit14.Text);
  x0[4] := strtofloat(Form1.Edit16.Text);
  x[1] := x0[1];
  x[2] := x0[2];
  x[3] := x0[3];
  x[4] := x0[4];
  vx[1] := strtofloat(Form1.Edit2.Text);
  vx[2] := strtofloat(Form1.Edit4.Text);
  vx[3] := strtofloat(Form1.Edit6.Text);
  vx[4] := strtofloat(Form1.Edit8.Text);
  v0x[1] := strtofloat(Form1.Edit2.Text);
  v0x[2] := strtofloat(Form1.Edit4.Text);
  v0x[3] := strtofloat(Form1.Edit6.Text);
  v0x[4] := strtofloat(Form1.Edit8.Text);

  y0[1] := strtofloat(Form1.Edit11.Text);
  y0[2] := strtofloat(Form1.Edit13.Text);
  y0[3] := strtofloat(Form1.Edit15.Text);
  y0[4] := strtofloat(Form1.Edit17.Text);
  y[1] := y0[1];
  y[2] := y0[2];
  y[3] := y0[3];
  y[4] := y0[4];
  vy[1] := strtofloat(Form1.Edit3.Text);
  vy[2] := strtofloat(Form1.Edit5.Text);
  vy[3] := strtofloat(Form1.Edit7.Text);
  vy[4] := strtofloat(Form1.Edit9.Text);
  v0y[1] := strtofloat(Form1.Edit3.Text);
  v0y[2] := strtofloat(Form1.Edit5.Text);
  v0y[3] := strtofloat(Form1.Edit7.Text);
  v0y[4] := strtofloat(Form1.Edit9.Text);
  if n > 4 then
  begin
    for i := 5 to n do
    begin
      x[i] := -50 + random(100);
      y[i] := -50 + random(100);
      vx[i] := 2 + random(20);
      vy[i] := 2 + random(20);
      x0[i] := x[i];
      y0[i] := y[i];
      v0x[i] := vx[i];
      v0y[i] := vy[i];
    end;
  end;
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
  cy := cx;
  cx2 := 11 / (Form1.Image2.Height div 2);
  cx3 := 11 / (Form1.Image3.Height div 2);
  // image1.Canvas.Pen.Mode:=pmNotXor;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  n := strtoint(Form1.Edit18.Text);
  x0[1] := strtofloat(Form1.Edit10.Text);
  x0[2] := strtofloat(Form1.Edit12.Text);
  x0[3] := strtofloat(Form1.Edit14.Text);
  x0[4] := strtofloat(Form1.Edit16.Text);
  x[1] := x0[1];
  x[2] := x0[2];
  x[3] := x0[3];
  x[4] := x0[4];
  vx[1] := strtofloat(Form1.Edit2.Text);
  vx[2] := strtofloat(Form1.Edit4.Text);
  vx[3] := strtofloat(Form1.Edit6.Text);
  vx[4] := strtofloat(Form1.Edit8.Text);
  v0x[1] := strtofloat(Form1.Edit2.Text);
  v0x[2] := strtofloat(Form1.Edit4.Text);
  v0x[3] := strtofloat(Form1.Edit6.Text);
  v0x[4] := strtofloat(Form1.Edit8.Text);

  y0[1] := strtofloat(Form1.Edit11.Text);
  y0[2] := strtofloat(Form1.Edit13.Text);
  y0[3] := strtofloat(Form1.Edit15.Text);
  y0[4] := strtofloat(Form1.Edit17.Text);
  y[1] := y0[1];
  y[2] := y0[2];
  y[3] := y0[3];
  y[4] := y0[4];
  vy[1] := strtofloat(Form1.Edit3.Text);
  vy[2] := strtofloat(Form1.Edit5.Text);
  vy[3] := strtofloat(Form1.Edit7.Text);
  vy[4] := strtofloat(Form1.Edit9.Text);
  v0y[1] := strtofloat(Form1.Edit3.Text);
  v0y[2] := strtofloat(Form1.Edit5.Text);
  v0y[3] := strtofloat(Form1.Edit7.Text);
  v0y[4] := strtofloat(Form1.Edit9.Text);

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

  Timer1.Enabled := true;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  init;
  Image1.Canvas.Brush.Color := clwhite;
  Image1.Canvas.FillRect(rect(0, 0, Image1.Width, Image1.Height));
  Timer1.Enabled := false;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
end;

end.
