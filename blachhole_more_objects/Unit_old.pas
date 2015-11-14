
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
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Tstar = record
v,vx,vy,v0x,v0y,x,y,x0,y0,fx,fy:real;
  end;


var
Form1: TForm1;
cx,cy,cx2,cy2,cx3,cy3,dt,fx_old,g,r_1,r_2,r_3,vx_old,Rkv_2_1,Rkv_3_2,Rkv_3_1,Rkv_4_1,Rkv_4_2,Rkv_4_3,dF:real;
x1,y1,i1,n,k:integer;
star1,star2,star3,star4: Tstar;
Rx,Ry: array[1..100,1..100] of real;
Fx,Fy,x,y:array[1..100] of real;
implementation

{$R *.dfm}


procedure rasstoyaniya_and_sili;
var i,j:integer;
begin
dF:=10000;
for i:=1 to (n-1) do begin
    for j:=(i+1) to n do begin
        Rx[i,j]:=2*sqr(x[i]-x[j])*abs(x[i]-x[j]);
        Rx[j,i]:=Rx[i,j];
        inc(k);
        form1.label1.Caption:=inttostr(k)+floattostr(x[i])+floattostr(x[j]);
    end;
end;

{for i:=1 to n do begin
    for j:=1 to n do begin
    if i<>j then Fx[i]:=Fx[i]+dF*(x[j]-x[i])/Rx[i,j];
    end;
end;}

//Rkv_2_1:=sqr(star2.x-x[1])+sqr(star2.y-star1.y);//квадраты расстояния
//Rkv_3_2:=sqr(star2.x-star3.x)+sqr(star2.y-star3.y);
//Rkv_3_1:=sqr(star3.x-x[1])+sqr(star3.y-star1.y);
//Rkv_4_1:=sqr(star4.x-x[1])+sqr(star4.y-star1.y);
//Rkv_4_2:=sqr(star4.x-star2.x)+sqr(star4.y-star2.y);
//Rkv_4_3:=sqr(star4.x-star3.x)+sqr(star4.y-star3.y);

{star1.fx:=((star2.x-x[1])/(2*sqrt(Rkv_2_1)*Rkv_2_1))+((star3.x-x[1])/(2*sqrt(Rkv_3_1)*Rkv_3_1))+((star4.x-x[1])/(2*sqrt(Rkv_4_1)*Rkv_4_1));// считаем G=m1=m2=1`
star1.fy:=((star2.y-star1.y)/(2*sqrt(Rkv_2_1)*Rkv_2_1))+((star3.y-star1.y)/(2*sqrt(Rkv_3_1)*Rkv_3_1))+((star4.y-star1.y)/(2*sqrt(Rkv_4_1)*Rkv_4_1));// считаем G=m1=m2=1`

star2.fx:=((x[1]-star2.x)/(2*sqrt(Rkv_2_1)*Rkv_2_1))+((star3.x-star2.x)/(2*sqrt(Rkv_3_1)*Rkv_3_1))+((star4.x-star2.x)/(2*sqrt(Rkv_4_2)*Rkv_4_2));// считаем G=m1=m2=1`
star2.fy:=((star1.y-star2.y)/(2*sqrt(Rkv_2_1)*Rkv_2_1))+((star3.y-star2.y)/(2*sqrt(Rkv_3_1)*Rkv_3_1))+((star4.y-star2.y)/(2*sqrt(Rkv_4_2)*Rkv_4_2));// считаем G=m1=m2=1`

star3.fx:=((x[1]-star3.x)/(2*sqrt(Rkv_3_1)*Rkv_3_1))+((star2.x-star3.x)/(2*sqrt(Rkv_3_2)*Rkv_3_2))+((star4.x-star3.x)/(2*sqrt(Rkv_4_3)*Rkv_4_3));// считаем G=m1=m2=1`
star3.fy:=((star1.y-star3.y)/(2*sqrt(Rkv_3_1)*Rkv_3_1))+((star2.y-star3.y)/(2*sqrt(Rkv_3_2)*Rkv_3_2))+((star4.y-star3.y)/(2*sqrt(Rkv_4_3)*Rkv_4_3));// считаем G=m1=m2=1`

star4.fx:=((x[1]-star4.x)/(2*sqrt(Rkv_4_1)*Rkv_4_1))+((star3.x-star4.x)/(2*sqrt(Rkv_4_3)*Rkv_4_3))+((star2.x-star4.x)/(2*sqrt(Rkv_4_2)*Rkv_4_2));// считаем G=m1=m2=1`
star4.fy:=((star1.y-star4.y)/(2*sqrt(Rkv_4_1)*Rkv_4_1))+((star3.y-star4.y)/(2*sqrt(Rkv_4_3)*Rkv_4_3))+((star2.y-star4.y)/(2*sqrt(Rkv_4_2)*Rkv_4_2));// считаем G=m1=m2=1`

star1.fx:=star1.fx*dF;
star2.fx:=star2.fx*dF;
star3.fx:=star3.fx*dF;
star4.fx:=star4.fx*dF;

star1.fy:=star1.fy*dF;
star2.fy:=star2.fy*dF;
star3.fy:=star3.fy*dF;
star4.fy:=star4.fy*dF;}
end;

procedure find_maximum;
begin
if star1.fx>fx_old then begin form1.Label8.Caption:='Fmax='+floattostr(star1.fx); fx_old:=star1.fx; end;
if star1.vx>vx_old then begin form1.Label9.Caption:='Vmax='+floattostr(vx_old); vx_old:=star1.vx; end;
end;


procedure fizika;
begin

rasstoyaniya_and_sili;// рассчитываем расстояния и силы взаимодействия между объектами
//временные переходные формулы от record к массивам array:
star1.vx:=star1.v0x+Fx[1]*dt;
star2.vx:=star2.v0x+Fx[2]*dt;
star3.vx:=star3.v0x+Fx[3]*dt;
star4.vx:=star4.v0x+Fx[4]*dt;


//star1.vx:=star1.v0x+star1.fx*dt;
star1.vy:=star1.v0y+star1.fy*dt;
x[1]:=star1.x0+star1.vx*dt;
star1.y:=star1.y0+star1.vy*dt;

//star2.vx:=star2.v0x+star2.fx*dt;
star2.vy:=star2.v0y+star2.fy*dt;
star2.x:=star2.x0+star2.vx*dt;
star2.y:=star2.y0+star2.vy*dt;

//star3.vx:=star3.v0x+star3.fx*dt;
star3.vy:=star3.v0y+star3.fy*dt;
star3.x:=star3.x0+star3.vx*dt;
star3.y:=star3.y0+star3.vy*dt;

//star4.vx:=star4.v0x+star4.fx*dt;
star4.vy:=star4.v0y+star4.fy*dt;
star4.x:=star4.x0+star4.vx*dt;
star4.y:=star4.y0+star4.vy*dt;
//find_maximum;

star1.v0x:=star1.vx;
star1.v0y:=star1.vy;
star2.v0x:=star2.vx;
star2.v0y:=star2.vy;
star3.v0x:=star3.vx;
star3.v0y:=star3.vy;
star4.v0x:=star4.vx;
star4.v0y:=star4.vy;

star1.x0:=x[1];
star1.y0:=star1.y;
star2.x0:=star2.x;
star2.y0:=star2.y;
star3.x0:=star3.x;
star3.y0:=star3.y;
star4.x0:=star4.x;
star4.y0:=star4.y;

form1.Label5.Caption:='Fx='+floattostr(star1.fx);
form1.Label6.Caption:='Fy='+floattostr(star1.fy);
form1.Label7.Caption:='r^2='+floattostr(Rkv_2_1);

form1.Image2.Canvas.Pixels[i1,(form1.Image2.Height div 2)-trunc(fx[1]/cx2)]:=clred;
form1.Image3.Canvas.Pixels[i1,(form1.Image3.Height div 2)-trunc(star1.vx/cx3)]:=clred;

end;

procedure risuem;
begin
with form1.image1.Canvas do begin
Brush.Color:=clred;
x1:=trunc(x[1]/cx);
y1:=trunc(star1.y/cy);
Ellipse(x1+(form1.image1.Width div 2)+4,(form1.image1.Height div 2)-y1+4,x1+(form1.image1.Width div 2)-4,(form1.image1.Height div 2)-y1-4);


Brush.Color:=clgreen;
x1:=trunc(star2.x/cx);
y1:=trunc(star2.y/cy);
Ellipse(x1+(form1.image1.Width div 2)+4,(form1.image1.Height div 2)-y1+4,x1+(form1.image1.Width div 2)-4,(form1.image1.Height div 2)-y1-4);

Brush.Color:=clblue;
x1:=trunc(star3.x/cx);
y1:=trunc(star3.y/cy);
Ellipse(x1+(form1.image1.Width div 2)+4,(form1.image1.Height div 2)-y1+4,x1+(form1.image1.Width div 2)-4,(form1.image1.Height div 2)-y1-4);

Brush.Color:=clyellow;
x1:=trunc(star4.x/cx);
y1:=trunc(star4.y/cy);
Ellipse(x1+(form1.image1.Width div 2)+4,(form1.image1.Height div 2)-y1+4,x1+(form1.image1.Width div 2)-4,(form1.image1.Height div 2)-y1-4);
inc(i1);
end;
end;

procedure init;
begin
n:=4;
i1:=0;
star1.v0x:=strtofloat(form1.Edit2.Text);  //временно меняем начальные кооорды на рандом
star1.v0y:=strtofloat(form1.Edit3.Text);
star2.v0x:=strtofloat(form1.Edit4.Text);
star2.v0y:=strtofloat(form1.Edit5.Text);
star3.v0x:=strtofloat(form1.Edit6.Text);
star3.v0y:=strtofloat(form1.Edit7.Text);
star4.v0x:=strtofloat(form1.Edit8.Text);
star4.v0y:=strtofloat(form1.Edit9.Text);

star1.x0:=strtofloat(form1.Edit10.Text);
star1.y0:=strtofloat(form1.Edit11.Text);
star2.x0:=strtofloat(form1.Edit12.Text);
star2.y0:=strtofloat(form1.Edit13.Text);
star3.x0:=strtofloat(form1.Edit14.Text);
star3.y0:=strtofloat(form1.Edit15.Text);
star4.x0:=strtofloat(form1.Edit16.Text);
star4.y0:=strtofloat(form1.Edit17.Text);

x[1]:=star1.x0;
x[2]:=star2.x0;
x[3]:=star3.x0;
x[4]:=star4.x0;

star1.x:=star1.x0;
star1.y:=star1.y0;
star2.x:=star2.x0;
star2.y:=star2.y0;
star3.x:=star3.x0;
star3.y:=star3.y0;
star4.x:=star4.x0;
star4.y:=star4.y0;
end;




procedure TForm1.Timer1Timer(Sender: TObject);
begin
 fizika;
 risuem;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
label8.Caption:='Fmax=0';
label9.Caption:='Vmax=0';
image1.Canvas.Brush.Color:=clwhite;
image1.Canvas.FillRect(rect(0,0,image1.Width,image1.Height));
//image1.Canvas.Ellipse(image1.Width div 2+5,image1.height div 2+5,image1.Width div 2-5,image1.height div 2-5);
image2.Canvas.FillRect(rect(0,0,image2.Width,image2.Height));
image3.Canvas.FillRect(rect(0,0,image3.Width,image3.Height));
image2.Canvas.MoveTo(0,image2.Height div 2);
image2.Canvas.LineTo(image2.Width,image2.Height div 2);
image3.Canvas.MoveTo(0,image3.Height div 2);
image3.Canvas.LineTo(image3.Width,image3.Height div 2);
init;
g:=10;
dt:=strtofloat(form1.Edit1.Text);
cx:=300/image1.Width;
cy:=cx;//300/image1.Height;
cx2:=11/(form1.Image2.Height div 2);
cx3:=11/(form1.Image3.Height div 2);
//image1.Canvas.Pen.Mode:=pmNotXor;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
image1.Canvas.Pen.Color:=clblack;
image1.Canvas.MoveTo(1,1);
image1.Canvas.LineTo(1,image1.Height-1);
image1.Canvas.LineTo(image1.Width-1,image1.Height-1);
image1.Canvas.LineTo(image1.Width-1,1);
image1.Canvas.LineTo(1,1);

image2.Canvas.Pen.Width:=1;
image2.Canvas.Pen.Color:=clblack;
image2.Canvas.MoveTo(1,1);
image2.Canvas.LineTo(1,image2.Height-1);
image2.Canvas.LineTo(image2.Width-1,image2.Height-1);
image2.Canvas.LineTo(image2.Width-1,1);
image2.Canvas.LineTo(1,1);
image2.Canvas.Pen.Width:=2;

image3.Canvas.Pen.Width:=1;
image3.Canvas.Pen.Color:=clblack;
image3.Canvas.MoveTo(1,1);
image3.Canvas.LineTo(1,image3.Height-1);
image3.Canvas.LineTo(image3.Width-1,image3.Height-1);
image3.Canvas.LineTo(image3.Width-1,1);
image3.Canvas.LineTo(1,1);
image3.Canvas.Pen.Width:=2;

timer1.Enabled:=not timer1.Enabled;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
timer1.Enabled:=false;
FormCreate(Form1);
end;

end.

