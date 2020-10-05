unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls;

type
  p=array[1..8,1..3] of real;
  projection=array[1..3,1..3] of real;
  rotation=array[1..3,1..3] of real;
  a= array[1..8,1..8] of real;
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure drawpoint(Sender: TObject);
    procedure clear(Sender: TObject);
    procedure initPoint();
    procedure project();
    procedure matRot(angle: real);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public
    point,rotated1,rotated2,rotated3,temp,result: p;
    arah: a;
    p3D:projection;
    rotY,rotX,rotZ: rotation;
    angle:real;
    animated:boolean;
    kx,ky,kz: integer;

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.initPoint();
begin
  //titik kubus
  point[1,1]:=-50;
  point[1,2]:=-50;
  point[1,3]:=-50;
  point[2,1]:=50;
  point[2,2]:=-50;
  point[2,3]:=-50;
  point[3,1]:=50;
  point[3,2]:=50;
  point[3,3]:=-50;
  point[4,1]:=-50;
  point[4,2]:=50;
  point[4,3]:=-50;
  point[5,1]:=-50;
  point[5,2]:=-50;
  point[5,3]:=50;
  point[6,1]:=50;
  point[6,2]:=-50;
  point[6,3]:=50;
  point[7,1]:=50;
  point[7,2]:=50;
  point[7,3]:=50;
  point[8,1]:=-50;
  point[8,2]:=50;
  point[8,3]:=50;
  //arah
  //belakang
  arah[1,2]:=1;
  arah[2,3]:=1;
  arah[3,4]:=1;
  arah[4,1]:=1;
  //depan
  arah[5,6]:=1;
  arah[6,7]:=1;
  arah[7,8]:=1;
  arah[8,5]:=1;
  //samping
  arah[1,5]:=1;
  arah[2,6]:=1;
  arah[3,7]:=1;
  arah[4,8]:=1;
end;

procedure TForm1.project();
begin
  //matrix proyeksi orthographic
  p3D[1,1]:=1;
  p3D[1,2]:=0;
  p3D[1,3]:=0;

  p3D[2,1]:=0;
  p3D[2,2]:=1;
  p3D[2,3]:=0;

  p3D[3,1]:=0;
  p3D[3,2]:=0;
  p3D[3,3]:=0;
end;

procedure TForm1.matRot(angle: real);
var
  cosinus,sinus:real;
begin
  //convert rad ke degree
  cosinus:=cos(angle*pi/180);
  sinus:=sin(angle*pi/180);

  //matrix rotasiX
  rotX[1,1]:=1; rotX[1,2]:=0;        rotX[1,3]:=0;
  rotX[2,1]:=0; rotX[2,2]:=cosinus;  rotX[2,3]:=-sinus;
  rotX[3,1]:=0; rotX[3,2]:=sinus;    rotX[3,3]:=cosinus;

  //matrix rotasiY
  rotY[1,1]:=cosinus;  rotY[1,2]:=0; rotY[1,3]:=sinus;
  rotY[2,1]:=0;        rotY[2,2]:=1; rotY[2,3]:=0;
  rotY[3,1]:=-sinus;   rotY[3,2]:=0; rotY[3,3]:=cosinus;

  //matrix rotasiZ
  rotZ[1,1]:=cosinus;  rotZ[1,2]:=-sinus;  rotZ[1,3]:=0;
  rotZ[2,1]:=sinus;    rotZ[2,2]:=cosinus; rotZ[2,3]:=0;
  rotZ[3,1]:=0;        rotZ[3,2]:=0;       rotZ[3,3]:=1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if animated=true then
  begin
    angle+=TrackBar2.Position;
  end;
    formShow(Sender);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  kx:=image1.canvas.Width div 2;
  ky:=image1.canvas.height div 2;
  matRot(angle);
  clear(Sender);
  initPoint();
  project();
  drawpoint(Sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if TrackBar2.Position <> 0 then
  begin
    animated:=true;
  end
  else
  begin
    animated:=false;
  end;
end;

procedure TForm1.drawpoint(Sender: TObject);
var
  i,j,k: integer;
  sum: real;
begin
  image1.canvas.Pen.style:=psSolid;
  image1.canvas.pen.color:=clWhite;

  //rotasi XYZ
  if checkbox4.Checked = true then
  begin
    //point x rotasiZ
    if CheckBox3.Checked = true then
    begin
      for i:=1 to 8 do
      begin
        sum:=point[i,1];
        point[i,1]:=sum*rotZ[1,1]+point[i,2]*rotZ[1,2];
        point[i,2]:=sum*rotZ[2,1]+point[i,2]*rotZ[2,2];
      end;
    end;
    //point x rotasiY
    if CheckBox2.checked = true then
    begin
      for i:=1 to 8 do
      begin
        sum:=point[i,1];
        point[i,1]:=sum*rotY[1,1]+point[i,3]*rotY[1,3];
        point[i,3]:=sum*rotY[3,1]+point[i,3]*rotY[3,3];
      end;
    end;
    //point x rotasiX
    if CheckBox1.Checked = true then
    begin
      for i:=1 to 8 do
      begin
        sum:=point[i,2];
        point[i,2]:=sum*rotX[2,2]+point[i,3]*rotX[2,3];
        point[i,3]:=sum*rotX[3,2]+point[i,3]*rotX[3,3];
      end;
    end;
  end
  else
  begin
    //point x rotasiX
    if CheckBox1.Checked = true then
    begin
      for i:=1 to 8 do
      begin
        sum:=point[i,2];
        point[i,2]:=sum*rotX[2,2]+point[i,3]*rotX[2,3];
        point[i,3]:=sum*rotX[3,2]+point[i,3]*rotX[3,3];
      end;
    end;

    //point x rotasiY
    if CheckBox2.checked = true then
    begin
      for i:=1 to 8 do
      begin
        sum:=point[i,1];
        point[i,1]:=sum*rotY[1,1]+point[i,3]*rotY[1,3];
        point[i,3]:=sum*rotY[3,1]+point[i,3]*rotY[3,3];
      end;
    end;

    //point x rotasiZ
    if CheckBox3.Checked = true then
    begin
      for i:=1 to 8 do
      begin
        sum:=point[i,1];
        point[i,1]:=sum*rotZ[1,1]+point[i,2]*rotZ[1,2];
        point[i,2]:=sum*rotZ[2,1]+point[i,2]*rotZ[2,2];
      end;
    end;
  end;
  //hasil rotasi x proyeksi
  for i:=1 to 8 do
  begin
    for j:=1 to 3 do
    begin
      sum:=0;
      for k:=1 to 3 do
      begin
        sum+=point[i,k]*p3D[j,k];
      end;
      result[i,j]:=sum;
    end;
  end;

  //scaling hasil
  for i:=1 to 8 do
  begin
    for j:=1 to 3 do
    begin
      result[i,j]:=result[i,j]*(TrackBar1.Position/10);
    end;
  end;

  //output
  for i:=1 to 8 do
  begin
    for j:=1 to 8 do
    begin
      if (arah[i,j]=1) then
      begin
        //depan
        if ((i > 4) and (j > 4)) then
        begin
          image1.canvas.pen.color:=clRed;
        end
        //belakang
        else if ((i < 5) and (j < 5)) then
        begin
          image1.canvas.pen.color:=clGreen;
        end
        //samping
        else if ((i < 5) and (j > 4)) then
        begin
          image1.canvas.pen.color:=clBlue;
        end;
        image1.canvas.moveto(kx+round(result[i,1]),ky-round(result[i,2]));
        image1.canvas.lineto(kx+round(result[j,1]),ky-round(result[j,2]));
        image1.canvas.TextOut(kx+round(result[i,1]),ky-round(result[i,2]),'P'+IntToStr(i));
      end;
    end;
  end;



end;



procedure TForm1.clear(Sender: TObject);
var
  i,j,k:integer;
  sum:real;
begin
  image1.Canvas.Brush.Style:=bsSolid;
  image1.canvas.brush.Color:=clWhite;
  image1.canvas.pen.style:=psSolid;
  image1.canvas.pen.color:=clBlack;
  image1.canvas.Rectangle(0,0,image1.canvas.width,image1.canvas.height);

end;

end.

