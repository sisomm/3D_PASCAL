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

begin


   writeln('(c) Sommerfeldt graphics 1992');
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
   graphinit;
   setlinestyle(solidln,0,thickwidth);

	a.init(320,240,0,hide);

	cube(a,aside,solid);

	aangle:=grad2rad(step);
	acosa:=cos(aangle);
	asina:=sin(aangle);
	turnx:=false;
	turny:=false;
	turnz:=false;
	scale:=false;
	inchar:=#0;
	a.display(true);
	repeat
		repeat
			if (turnx or turny) or  (scale or turnz) then begin
				a.display(false);
         end;
			if turnx then a.xturn(acosa,asina);
			if turny then a.yturn(acosa,asina);
			if turnz then a.zturn(acosa,asina);
			if scale then begin
				a.xscale(sfactor);
				a.yscale(sfactor);
				a.zscale(sfactor);
			end;
			if (turnx or turny) or (turnz or scale) then begin
				a.display(true);
			end;
			delay(pause);
		until keypressed;
		inchar := readkey;
		if inchar = 'x' then turnx:=not(turnx);
		if inchar = 'y' then turny:=not(turny);
		if inchar = 'z' then turnz:=not(turnz);
		if inchar = 'u' then begin
			if scale then begin
				if sfactor > 1 then begin
					scale:=false;
				end else begin
					sfactor := 1.05;
					scale := true;
				end;
			end else begin
				scale:=true;
				sfactor:=1.05;
			end;
		end;
		if inchar = 'd' then begin
			if scale then begin
				if sfactor < 1 then begin
					scale:=false;
				end else begin
					sfactor := 0.95;
					scale:=true;
				end;
			end else begin
				scale:=true;
				sfactor:=0.95;
			end;
		end;
	until inchar = 'q';
end;

begin
	  showoff;
end.
