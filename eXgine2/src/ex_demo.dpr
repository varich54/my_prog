program ex_demo;
//////////////////////////////
// Демонстрация работы движка
//////////////////////////////
uses
  Windows,sysutils, OpenGL, eXgine in '..\eXgine.pas';

// для компиляции всего приложения в один exe (не использовать eXgine.dll)
// объявите EX_STATIC в cfg.pas
const NUM_OF_PARTICLES=5;

  type
  Tparticle=class
obj3d:GLUquadricObj;
  Fx,Fy,Fz,x,y,z,x0,y0,z0,vx,vy,vz,v0x,v0y,voz,m,radius:extended;
  R_kv:array[1..NUM_OF_PARTICLES] of extended;
  stolkn:array[1..NUM_OF_PARTICLES] of boolean;//столкновение
  end;
var
  obj{,obj2]}   : GLUquadricObj;
  p_arr:array[1..NUM_OF_PARTICLES] of Tparticle;  //массив объектов-частиц
  Angle : Single;
  dF,dt:real;
  test,z,y:integer;
//////////////////////////////////////////////////////
procedure draw_obj(i:integer;size,x,y,z:double);
begin
  glPushMatrix();
  glTranslated(x,y,z);
  gluSphere(p_arr[i].obj3d,  size, 10, 10);
  glPopMatrix();
end;
//////////////////////////////////////////////////////
procedure rasstoyaniya_and_sili;
var i,j:integer;
begin
for i:=1 to NUM_OF_PARTICLES-1 do begin
    for j:=(i+1) to NUM_OF_PARTICLES do begin
      if i<>j then  p_arr[i].R_kv[j] :=sqr(p_arr[i].x-p_arr[j].x)+sqr(p_arr[i].y-p_arr[j].y); 
      p_arr[j].R_kv[i]:=p_arr[i].R_kv[j];
      if sqrt( p_arr[j].R_kv[i])<=(p_arr[j].radius+p_arr[i].radius)/2 then begin
              p_arr[j].stolkn[i]:=true;
              p_arr[i].stolkn[j]:=true;
              end
      else begin
              p_arr[j].stolkn[i]:=false;
              p_arr[i].stolkn[j]:=false;
      end;
   end;
end;
for i:=1 to NUM_OF_PARTICLES do begin
    p_arr[i].Fx:=0;
    p_arr[i].Fy:=0;
    for j:=1 to NUM_OF_PARTICLES do begin
    if i<>j then p_arr[i].Fx:=p_arr[i].Fx+(p_arr[i].m*p_arr[j].m*dF*(p_arr[j].x-p_arr[i].x)/(2*sqrt(p_arr[i].R_kv[j])*p_arr[i].R_kv[j]));
    if i<>j then p_arr[i].Fy:=p_arr[i].Fy+(p_arr[i].m*p_arr[j].m*dF*(p_arr[j].y-p_arr[i].y)/(2*sqrt(p_arr[i].R_kv[j])*p_arr[i].R_kv[j]));
    end;
end;

end;
//////////////////////////////////////////////////////

procedure fizika;
var i:integer;
begin

rasstoyaniya_and_sili;
for i:=1 to NUM_OF_PARTICLES do begin
p_arr[i].vx:=p_arr[i].v0x+p_arr[i].Fx*dt;
p_arr[i].x:=p_arr[i].x0+p_arr[i].vx*dt;
p_arr[i].vy:=p_arr[i].v0y+p_arr[i].Fy*dt;
p_arr[i].y:=p_arr[i].y0+p_arr[i].vy*dt;
p_arr[i].v0x:=p_arr[i].vx;
p_arr[i].v0y:=p_arr[i].vy;
p_arr[i].x0:=p_arr[i].x;
p_arr[i].y0:=p_arr[i].y;
end;
end;
//////////////////////////////////////////////////////
procedure Init;
var i:integer;

begin

// Инициализация ресурсов
dt:=0.001;
dF:=1000;
z:=-300;y:=0;
obj:=gluNewQuadric;
for i:=1 to NUM_OF_PARTICLES do begin
      p_arr[i]:=tparticle.Create;
     p_arr[i].obj3d := gluNewQuadric;
     gluQuadricNormals(p_arr[i].obj3d, GL_FLAT);
     end;

if NUM_OF_PARTICLES=5 then begin
  p_arr[5].x:=0;
  p_arr[5].y:=0;
  p_arr[5].z:=0;
  p_arr[5].x0:=0;
  p_arr[5].y0:=0;
  p_arr[5].z0:=0;
  p_arr[5].vx:=0;
  p_arr[5].vy:=0;
  p_arr[5].vz:=0;
  p_arr[5].v0x:=0;
  p_arr[5].v0y:=0;
  p_arr[5].m:=10;
  p_arr[5].radius:=3;
//  p_arr[5].v0z:=0;
end;
p_arr[1].radius:=0.5;
p_arr[2].radius:=0.5;
p_arr[3].radius:=0.5;
p_arr[4].radius:=0.5;
p_arr[1].m:=1;
p_arr[2].m:=1;
p_arr[3].m:=1;
p_arr[4].m:=1;
p_arr[1].z:=0;
p_arr[2].z:=0;
p_arr[3].z:=0;
p_arr[4].z:=0;
p_arr[1].x0:=15;
p_arr[2].x0:=-15;
p_arr[3].x0:=0;
p_arr[4].x0:=0 ;
p_arr[1].x:=p_arr[1].x0;
p_arr[2].x:=p_arr[2].x0;
p_arr[3].x:=p_arr[3].x0;
p_arr[4].x:=p_arr[4].x0;
p_arr[1].vx:=0;
p_arr[2].vx:=0;
p_arr[3].vx:=20;
p_arr[4].vx:=-20;
p_arr[1].v0x:=0;
p_arr[2].v0x:=0 ;
p_arr[3].v0x:=20;
p_arr[4].v0x:=-20;
p_arr[1].y0:=0;
p_arr[2].y0:=0;
p_arr[3].y0:=-15;
p_arr[4].y0:=15;
p_arr[1].y:=p_arr[1].y0;
p_arr[2].y:=p_arr[2].y0;
p_arr[3].y:=p_arr[3].y0;
p_arr[4].y:=p_arr[4].y0;
p_arr[1].vy:=20;
p_arr[2].vy:=-20;
p_arr[3].vy:=0;
p_arr[4].vy:=0 ;
p_arr[1].v0y:=20;
p_arr[2].v0y:=-20;
p_arr[3].v0y:=0;
p_arr[4].v0y:=0;
  glEnable(GL_CULL_FACE);
  ogl.Light.Enable(0);
// Установка полноэкранного режима
  wnd.Mode(True, 1024, 768, 32, 85);
end;

procedure Free;
begin
  gluDeleteQuadric(p_arr[1].obj3d);
end;

procedure Update;
begin
// Изменение угла поворота
//  Angle := Angle + 0.01;
// Выход по нажатии Escape (код клавиши 27)
  if inp.Down(27) then eX.Quit;
  if inp.LastKey=65 then angle:=angle+0.1;   //a-d
  if inp.LastKey=68 then angle:=angle-0.1;
  if inp.LastKey=83 then z:=z-2;   // s-w
  if inp.LastKey=87 then z:=z+2;    //
  if inp.LastKey=81 then y:=y-2;    // q-e
  if inp.LastKey=69 then y:=y+2;     //
end;

procedure Render;
var s:string;
  i : Integer;
begin glLoadIdentity ();
  ogl.Clear(True, True);
  ogl.Set3D(45, 0.1, 512); //чтот вроде настроек камеры
// Отрисовка
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);

  ogl.Blend(BT_ADD);
  gluQuadricDrawStyle(Obj, GLU_LINE);

  glTranslatef(0, y, z);
  glRotatef(Angle * rad2deg*2,0{sin(Angle)}, cos(Angle), 0{cos(Angle)});
  gluDisk(Obj, 10, 110, 10, 10);
    glColor3f(10, 1/16, cos(Angle));
fizika;
 for i:=1 to NUM_OF_PARTICLES do begin
    draw_obj(i,p_arr[i].radius,p_arr[i].x,p_arr[i].y,p_arr[i].z);
    end;
if NUM_OF_PARTICLES=5 then draw_obj(5,p_arr[5].radius,p_arr[5].x,p_arr[5].y,p_arr[5].z);

// Вывод статистики
  ogl.Set2D(0, 0, wnd.Width, wnd.Height);
  glColor3f(1, 0, 0);
  if inp.LastKey<>-1 then test:=inp.LastKey;

  s:=FloatToStr(trunc(p_arr[2].x))+' '+floattostr(trunc(p_arr[2].y))+' '+floattostr(p_arr[2].z);
  ogl.TextOut(0, 8, 16, PChar('FPS: ' + IntToStr(ogl.FPS)+' '+s+' pressed key='+inttostr(test)));

  s:='x4='+FloatToStr(p_arr[4].x)+' y4='+FloatToStr(p_arr[4].y)+' z4='+FloatToStr(p_arr[4].z);
  ogl.TextOut(0, 8, 76, PChar(s));

  s:='x1='+FloatToStr(p_arr[1].x)+' y1='+FloatToStr(p_arr[1].y)+' z1='+FloatToStr(p_arr[1].z);
  ogl.TextOut(0, 8, 40, PChar(s));

  s:='x2='+FloatToStr(p_arr[2].x)+' y2='+FloatToStr(p_arr[2].y)+' z2='+FloatToStr(p_arr[2].z);
  ogl.TextOut(0, 8, 52, PChar(s));

  s:='x3='+FloatToStr(p_arr[3].x)+' y3='+FloatToStr(p_arr[3].y)+' z3='+FloatToStr(p_arr[3].z);
  ogl.TextOut(0, 8, 64, PChar(s));

  s:='vx3='+FloatToStr(p_arr[3].vx)+' vy3='+FloatToStr(p_arr[3].vy)+' vz3='+FloatToStr(p_arr[3].vz);
  ogl.TextOut(0, 8, 88, PChar(s));
end;

begin
  wnd.Create(PChar(eX.Version + ' demo'), False);
  eX.SetProc(PROC_UPDATE, @Update);
  eX.SetProc(PROC_RENDER, @Render);
  eX.SetProc(PROC_INIT, @Init);
  eX.SetProc(PROC_FREE, @Free);
// Вход в главный цикл
  eX.MainLoop(50);
end.

