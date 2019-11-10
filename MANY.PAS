program dak;
uses crt,graph,figures,gsystem2,gmath,shapes;

procedure key;
begin
     if readkey=#0 then begin end;
end;

procedure showoff;
var
	acosa,asina,bcosa,bsina:real;
	twist:integer;
	a,b:figure;
	aangle,bangle:real;
	aside,bside:integer;
   solid:boolean;
   pause:integer;
   hide:boolean;
	step:real;
	inchar:char;
	turnx,turny,turnz:boolean;
	sfactor:real;
	scale:boolean;
	a1,da1,a2,da2,a3:real;
	b1,db1,b2,db2,b3:real;
	c1,dc1,c2,dc2,c3:real;
	xlimit1,xlimit2,ylimit1,ylimit2:real;
begin

{	writeln('(c) Sommerfeldt graphics 1992');
   writeln;
   write('  Solid............');
   solid:=(readkey='y');
   writeln(solid);
   write('  Hide invisible...');
   hide:=(readkey='y');
   writeln(hide);
   write('  Size.............');readln(aside);
   write('  Delay............');readln(pause);
   write('  Step (deg).......');readln(step);
}
	solid:=false;
	hide:=true;
	aside:=30;
	pause:=1;
	step:=4;

        graphinit;

	xlimit1:=aside*2;
	xlimit2:=maxx-aside*2;

	ylimit1:=aside*2;
	ylimit2:=maxy-aside*2;



	setlinestyle(solidln,0,thickwidth);

	a1:=maxx/4;
	da1:=step;
	a2:=maxy/4;
	da2:=-step;
	a3:=0;

	b1:=2*maxx/4;
	db1:=-step;
	b2:=2*maxy/4;
	db2:=step;
	b3:=0;

	c1:=3*maxx/4;
	dc1:=step;
	c2:=3*maxy/4;
	dc2:=step;
	c3:=0;

	a.init(0,0,0,hide);

	cube(a,aside,solid);

	aangle:=grad2rad(step);
	acosa:=cos(aangle);
	asina:=sin(aangle);
	turnx:=false;
	turny:=false;
	turnz:=false;
	scale:=false;
	inchar:=#0;
	a.moveto(a1,a2,a3);
	a.display(true);
	a.moveto(b1,b2,b3);
	a.display(true);
	a.moveto(c1,c2,c3);
	a.display(true);
	repeat
		repeat
			a.moveto(a1,a2,a3);
			a.display(false);
			a.moveto(b1,b2,b3);
			a.display(false);
			a.moveto(c1,c2,c3);
			a.display(false);
         if turnx then a.xturn(acosa,asina);
			if turny then a.yturn(acosa,asina);
			if turnz then a.zturn(acosa,asina);
			if da1>0 then begin
				if a1>xlimit2 then begin
					da1:=-da1;
				end;
			end
			else begin
				if a1<xlimit1 then begin
					da1:=-da1;
				end;
			end;
			if da2>0 then begin
				if a2>ylimit2 then begin
					da2:=-da2;
				end;
			end
			else begin
				if a2<ylimit1 then begin
					da2:=-da2;
				end;
			end;
			if db1>0 then begin
				if b1>xlimit2 then begin
					db1:=-db1;
				end;
			end
			else begin
				if b1<xlimit1 then begin
					db1:=-db1;
				end;
			end;
			if db2>0 then begin
				if b2>ylimit2 then begin
					db2:=-db2;
				end;
			end
			else begin
				if b2<ylimit1 then begin
					db2:=-db2;
				end;
			end;
			if dc1>0 then begin
				if c1>xlimit2 then begin
					dc1:=-dc1;
				end;
			end
			else begin
				if c1<xlimit1 then begin
					dc1:=-dc1;
				end;
			end;
			if dc2>0 then begin
				if c2>ylimit2 then begin
					dc2:=-dc2;
				end;
			end
			else begin
				if c2<ylimit1 then begin
					dc2:=-dc2;
				end;
			end;

			a1:=a1+da1;
			a2:=a2+da2;

			b1:=b1+db1;
			b2:=b2+db2;

			c1:=c1+dc1;
			c2:=c2+dc2;

			a.moveto(a1,a2,a3);
			a.display(true);
			a.moveto(b1,b2,b3);
			a.display(true);
			a.moveto(c1,c2,c3);
			a.display(true);
         delay(pause);
		until keypressed;
		inchar := readkey;
		if inchar = 'x' then turnx:=not(turnx);
		if inchar = 'y' then turny:=not(turny);
		if inchar = 'z' then turnz:=not(turnz);
	until inchar = 'q';
end;

begin
	  showoff;
end.