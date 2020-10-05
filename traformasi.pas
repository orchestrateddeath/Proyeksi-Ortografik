unit traformasi;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  ComCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonComposit: TButton;
    ButtonPivotScalling: TButton;
    ButtonPivotRotasi: TButton;
    ButtonClear: TButton;
    ButtonMatriks: TButton;
    ButtonRotasi: TButton;
    ButtonScaling: TButton;
    ButtonTranslasi: TButton;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    CheckBox43: TCheckBox;
    CheckBox44: TCheckBox;
    CheckBox45: TCheckBox;
    CheckBox51: TCheckBox;
    CheckBox52: TCheckBox;
    CheckBox53: TCheckBox;
    CheckBox54: TCheckBox;
    CheckBox55: TCheckBox;
    ColorBox1: TColorBox;
    EditPpx: TEdit;
    EditPpy: TEdit;
    EditRot: TEdit;
    EditSx: TEdit;
    EditSy: TEdit;
    EditTx: TEdit;
    EditTy: TEdit;
    EditX1: TEdit;
    EditX2: TEdit;
    EditX3: TEdit;
    EditX4: TEdit;
    EditX5: TEdit;
    EditY1: TEdit;
    EditY2: TEdit;
    EditY3: TEdit;
    EditY4: TEdit;
    EditY5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TrackBar1: TTrackBar;
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonCompositClick(Sender: TObject);
    procedure ButtonMatriksClick(Sender: TObject);
    procedure ButtonPivotRotasiClick(Sender: TObject);
    procedure ButtonPivotScallingClick(Sender: TObject);
    procedure ButtonRotasiClick(Sender: TObject);
    procedure ButtonScalingClick(Sender: TObject);
    procedure ButtonTranslasiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
 uses Math;
{$R *.lfm}

{ TForm1 }
var
  x:array[1..5] of double;
  y:array[1..5] of double;
  i,j : integer;
  px,py : integer;
  arah:array[1..5,1..5] of boolean;
  Tx, Ty, Sx, Sy, Rot : double;
  temp, ppx, ppy:double;
  pp:boolean;
procedure TForm1.ButtonClearClick(Sender: TObject);
begin
   Image1.canvas.Brush.style := bsSolid;
   Image1.Canvas.brush.color :=clWhite;
   Image1.canvas.Pen.color := clBlack;
   Image1.canvas.Rectangle(0,0,Image1.Width,Image1.height);
   px := Image1.Width div 2;
   py := Image1.height div 2;
   Image1.canvas.moveto(px,0);
   Image1.canvas.lineto(px,Image1.Height);
   Image1.canvas.moveto(0,py);
   Image1.canvas.lineto(Image1.width,py);
end;

procedure TForm1.ButtonCompositClick(Sender: TObject);
begin
    buttonclearclick(Sender);
    Image1.canvas.Pen.color := colorbox1.selected;
    Image1.canvas.Pen.width := TrackBar1.Position;
    rot:=StrtoFloat(EditRot.Text);
    Sx:=StrToFloat(EditSx.Text);
    Sy:=StrToFloat(EditSy.Text);
    for i:=1  to 5 do
    begin
         temp:=x[i];
         x[i]:=round(x[i]*cos(rot*pi/180)-y[i]*sin(rot*pi/180));
         y[i]:=round(temp*sin(rot*pi/180)+y[i]*cos(rot*pi/180));
    End;
     for i:=1 to 5 do
     begin
          x[i]:=x[i]*Sx;
          y[i]:=y[i]*Sy;
     end;
     for i:=1 to 5 do
     begin
     for j:=1 to 5 do
     begin
      if(arah[i,j] = true) then
      begin
        Image1.canvas.moveto(round(px+x[i]),round(py-y[i]));
        Image1.canvas.lineto(round(px+x[j]),round(py-y[j]));
      End;
    end;
  end;
end;

procedure TForm1.ButtonMatriksClick(Sender: TObject);
begin
   Image1.canvas.Pen.color := colorbox1.selected;
   Image1.canvas.Pen.width := TrackBar1.Position;
  Px:=Image1.width div 2;
  Py:=Image1.height div 2;
  x[1] := StrToFloat(EditX1.Text);
  x[2] := StrToFloat(EditX2.Text);
  x[3] := StrToFloat(EditX3.Text);
  x[4] := StrToFloat(EditX4.Text);
  x[5] := StrToFloat(EditX5.Text);
  y[1] := StrToFloat(EditY1.Text);
  y[2] := StrToFloat(EditY2.Text);
  y[3] := StrToFloat(EditY3.Text);
  y[4] := StrToFloat(EditY4.Text);
  y[5] := StrToFloat(EditY5.Text);
  arah[1,2]:=checkbox12.Checked;
  arah[1,3]:=checkbox13.Checked;
  arah[1,4]:=checkbox14.Checked;
  arah[1,5]:=checkbox15.Checked;
  arah[2,1]:=checkbox21.Checked;
  arah[2,3]:=checkbox23.Checked;
  arah[2,4]:=checkbox24.Checked;
  arah[2,5]:=checkbox25.Checked;
  arah[3,1]:=checkbox31.Checked;
  arah[3,2]:=checkbox32.Checked;
  arah[3,4]:=checkbox34.Checked;
  arah[3,5]:=checkbox35.Checked;
  arah[4,1]:=checkbox41.Checked;
  arah[4,2]:=checkbox42.Checked;
  arah[4,3]:=checkbox43.Checked;
  arah[4,5]:=checkbox45.Checked;
  arah[5,1]:=checkbox51.Checked;
  arah[5,2]:=checkbox52.Checked;
  arah[5,3]:=checkbox53.Checked;
  arah[5,4]:=checkbox54.Checked;
  for i:=1 to 5 do
  begin
    for j:=1 to 5 do
    begin
      if(arah[i,j] = true) then
      begin
        Image1.canvas.moveto(round(px+x[i]),round(py-y[i]));
        Image1.canvas.lineto(round(px+x[j]),round(py-y[j]));
      End;
    end;
  end;
end;

procedure TForm1.ButtonPivotRotasiClick(Sender: TObject);
begin
  buttonclearclick(Sender);
  Image1.canvas.Pen.color := colorbox1.selected;
  Image1.canvas.Pen.width := TrackBar1.Position;
  ppx:=StrToFloat(EditPpx.text);
  ppy:=StrToFloat(EditPpy.text);
  rot:=StrtoFloat(EditRot.Text);
  for i:=1 to 5 do
  begin
    x[i]:=x[i]-ppx;
    y[i]:=y[i]-ppy;
  end;

  for i:=1  to 5 do
  begin
    temp:=x[i];
    x[i]:=round(x[i]*cos(rot*pi/180)-y[i]*sin(rot*pi/180));
    y[i]:=round(temp*sin(rot*pi/180)+y[i]*cos(rot*pi/180));
  End;

  for i:=1 to 5 do
  begin
    x[i]:=x[i]+ppx;
    y[i]:=y[i]+ppy;
  end;

  for i:=1 to 5 do
  begin
    for j:=1 to 5 do
    begin
      if(arah[i,j] = true) then
      begin
        Image1.canvas.moveto(round(px+x[i]),round(py-y[i]));
        Image1.canvas.lineto(round(px+x[j]),round(py-y[j]));
      End;
    end;
  end;
end;

procedure TForm1.ButtonPivotScallingClick(Sender: TObject);
begin
  buttonclearclick(Sender);
  Image1.canvas.Pen.color := colorbox1.selected;
  Image1.canvas.Pen.width := TrackBar1.Position;
  ppx:=StrToFloat(EditPpx.text);
  ppy:=StrToFloat(EditPpy.text);
  Sx:=StrToFloat(EditSx.Text);
  Sy:=StrToFloat(EditSy.Text);
  for i:=1 to 5 do
  begin
    x[i]:=x[i]-ppx;
    y[i]:=y[i]-ppy;
  end;

  for i:=1 to 5 do
  begin
    x[i]:=x[i]*Sx;
    y[i]:=y[i]*Sy;
  end;

  for i:=1 to 5 do
  begin
    x[i]:=x[i]+ppx;
    y[i]:=y[i]+ppy;
  end;

  for i:=1 to 5 do
  begin
    for j:=1 to 5 do
    begin
      if(arah[i,j] = true) then
      begin
        Image1.canvas.moveto(round(px+x[i]),round(py-y[i]));
        Image1.canvas.lineto(round(px+x[j]),round(py-y[j]));
      End;
    end;
  end;
end;

procedure TForm1.ButtonRotasiClick(Sender: TObject);
begin
  buttonclearclick(Sender);
  Image1.canvas.Pen.color := colorbox1.selected;
   Image1.canvas.Pen.width := TrackBar1.Position;
  rot:=StrtoFloat(EditRot.Text);
  for i:=1  to 5 do
  begin
    temp:=x[i];
    x[i]:=round(x[i]*cos(rot*pi/180)-y[i]*sin(rot*pi/180));
    y[i]:=round(temp*sin(rot*pi/180)+y[i]*cos(rot*pi/180));
    End;
  for i:=1 to 5 do
  begin
    for j:=1 to 5 do
    begin
      if(arah[i,j] = true) then
      begin
        Image1.canvas.moveto(round(px+x[i]),round(py-y[i]));
        Image1.canvas.lineto(round(px+x[j]),round(py-y[j]));
      End;
    end;
  end;
end;

procedure TForm1.ButtonScalingClick(Sender: TObject);
begin
  buttonclearclick(Sender);
  Image1.canvas.Pen.color := colorbox1.selected;
   Image1.canvas.Pen.width := TrackBar1.Position;
  Sx:=StrToFloat(EditSx.Text);
  Sy:=StrToFloat(EditSy.Text);
  for i:=1 to 5 do
  begin
    x[i]:=x[i]*Sx;
    y[i]:=y[i]*Sy;
  end;
  for i:=1 to 5 do
  begin
    for j:=1 to 5 do
    begin
      if(arah[i,j]=true) then
      begin
        Image1.canvas.moveto(round(px+x[i]),round(py-y[i]));
        Image1.canvas.lineto(round(px+x[j]),round(py-y[j]));
      end;
    end;
  end;

end;

procedure TForm1.ButtonTranslasiClick(Sender: TObject);
begin
  buttonclearclick(Sender);
  Image1.canvas.Pen.color := colorbox1.selected;
  Image1.canvas.Pen.width := TrackBar1.Position;
  Tx:=StrToFloat(EditTx.Text);
  Ty:=StrToFloat(EditTy.Text);
  for i:=1 to 5 do
  begin
    x[i]:=x[i]+Tx;
    y[i]:=y[i]+Ty;
  end;
  for i:=1 to 5 do
  begin
    for j:=1 to 5 do
    begin
      if(arah[i,j]=true) then
      begin

       Image1.Canvas.MoveTo(round(px+x[i]),round(py-y[i]));
       Image1.Canvas.LineTo(round(px+x[j]),round(py-y[j]));
      end;
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  buttonclearclick(sender);
end;

end.

