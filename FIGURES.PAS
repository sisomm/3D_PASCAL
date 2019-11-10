unit figures;

INTERFACE

uses gsystem2,graph,gmath;

type

	popointer = ^point;

	point = record
		xpos,ypos,zpos :real;
		next: popointer;
	end;

	plpointer = ^plane;

	plane = record
		number: integer;
		solid : boolean;
		color : integer;
		firstpoint : popointer;
		next: plpointer;
		visible:boolean;
	end;

figure = object
	xoffset           : real;
	yoffset           : real;
	zoffset           : real;
	firstplane        : plpointer;
   hide              : boolean;

	constructor init(x1,y1,z1:real;hidden:boolean);
	destructor  demolish;
	function  isvisible(p1:popointer):boolean;
	procedure addplane(planeno:integer;solid:boolean;color:integer);
	procedure addpoint(planeno:integer;x,y,z:real);
	procedure display(on:boolean);
	procedure xturn(cosa,sina:real);
	procedure yturn(cosa,sina:real);
	procedure zturn(cosa,sina:real);
	procedure xscale(factor:real);
	procedure yscale(factor:real);
	procedure zscale(factor:real);
	procedure move(dx,dy,dz:real);
	procedure moveto(x,y,z:real);
	procedure copy(a:figure);
end; {figure}

IMPLEMENTATION

function figure.isvisible(p1:popointer):boolean;
var
	a1,a2,a3:real;
	b1,b2,b3:real;
	c1,c2,c3:real;
   clength :real;
	d1,d2,d3:real;
	e1,e2,e3:real;
   elength :real;
	p2,p3:popointer;
	cosalpha : real;
   cosbeta  : real;
begin
	p2:=p1^.next;
	p3:=p2^.next;
											{ calculate vectors in plane }
	a1 := (p2^.xpos - p1^.xpos);
	a2 := (p2^.ypos - p1^.ypos);
	a3 := (p2^.zpos - p1^.zpos);

	b1 := (p2^.xpos - p3^.xpos);
	b2 := (p2^.ypos - p3^.ypos);
	b3 := (p2^.zpos - p3^.zpos);
											{ vector cross product }
	c1 := a2 * b3 - a3 * b2;
	c2 := a3 * b1 - a1 * b3;
	c3 := a1 * b2 - a2 * b1;
   clength := sqrt(sqr(c1)+sqr(c2)+sqr(c3));

											{ the z-vector }
	d1 := 0;
	d2 := 0;
	d3 := -1;

   e1 := (p1^.xpos+p3^.xpos)/2;
   e2 := (p1^.ypos+p3^.ypos)/2;
   e3 := (p1^.zpos+p3^.zpos)/2;

   elength := sqrt(sqr(e1)+sqr(e2)+sqr(e3));

   cosbeta  := (c1 * e1 + c2 * e2 + c3 * e3)/(clength*elength);

	if (cosbeta>0) then cosalpha := c3 / clength else cosalpha := -c3 /clength;

	isvisible  := (cosalpha > 0);
end;

constructor figure.init(x1,y1,z1:real;hidden:boolean);
begin
	xoffset := x1;
	yoffset := y1;
	zoffset := z1;
   hide    := hidden;
	firstplane := nil;
end; {figure.init}

destructor figure.demolish;
var
	thispl,nextpl:plpointer;
	thispo,nextpo:popointer;
begin
	thispl := firstplane;
	while thispl <> nil do begin
		thispo := thispl^.firstpoint;
		while thispo <> nil do begin
			nextpo := thispo^.next;
			dispose(thispo);
			thispo := nextpo;
		end;
		nextpl := thispl^.next;
		dispose(thispl);
		thispl := nextpl;
	end;
end; {figure.demolish}

procedure figure.addplane(planeno:integer;solid:boolean;color:integer);
var p:plpointer;
begin
	new(p);
	p^.next:=firstplane;
	firstplane:=p;
	p^.solid:=solid;
	p^.number:=planeno;
	p^.color:=color;
	p^.firstpoint:=nil;
	p^.visible:=true;
end;

procedure figure.addpoint(planeno:integer;x,y,z:real);
var
	pl:plpointer;
	po:popointer;
begin
	pl:=firstplane;
	while((pl<>nil) and (pl^.number<>planeno)) do pl:=pl^.next;
	if pl=nil then error('plane number does not exist');
	new(po);
	po^.next:=pl^.firstpoint;
	pl^.firstpoint:=po;
	po^.xpos := x;
	po^.ypos := y;
	po^.zpos := z;
end;

procedure figure.display(on:boolean);
var
	pl:plpointer;
	po:popointer;
	plist: array[1..40] of pointtype;
	pnum:integer;
	color:integer;
begin
	pl:=firstplane;
	while pl<>nil do begin
      if (hide and pl^.visible) or (not(hide)) then begin
         pnum:=0;
         po:=pl^.firstpoint;
         while po <> nil do begin
            inc(pnum);
            plist[pnum].x := round(xoffset + po^.xpos);
            plist[pnum].y := round(yoffset + po^.ypos);
            po:=po^.next;
         end;
         inc(pnum);
         plist[pnum].x := round(xoffset + pl^.firstpoint^.xpos);
         plist[pnum].y := round(yoffset + pl^.firstpoint^.ypos);
         if(on) then color := pl^.color else color:=bcolor;
         setfillstyle(solidfill,color);
         setcolor(color);
         if pl^.solid then begin
            drawpoly(pnum,plist);
            fillpoly(pnum,plist);
         end
         else begin
            drawpoly(pnum,plist);
         end;
      end;
   pl:=pl^.next;
   end;
end;

procedure figure.xturn(cosa,sina:real);
var
	x,y,z:real;
	po:popointer;
	pl:plpointer;
begin
	pl:=firstplane;
	while pl<> nil do begin
		po:=pl^.firstpoint;
		while po <> nil do begin
			x:=po^.xpos;
			y:=po^.ypos;
			z:=po^.zpos;
			po^.xpos := x;
			po^.ypos := y * cosa + z * sina;
			po^.zpos := z * cosa - y * sina;
			po:=po^.next;
		end;
		if hide then pl^.visible := isvisible(pl^.firstpoint);
		pl := pl^.next;
	end;
end;

procedure figure.yturn(cosa,sina:real);
var
	x,y,z:real;
	po:popointer;
	pl:plpointer;
begin
	pl:=firstplane;
	while pl<> nil do begin
		po:=pl^.firstpoint;
		while po <> nil do begin
			x:=po^.xpos;
			y:=po^.ypos;
			z:=po^.zpos;
			po^.xpos := x * cosa - z * sina;
			po^.ypos := y;
			po^.zpos := x * sina + z * cosa;
			po:=po^.next;
		end;
		if hide then pl^.visible := isvisible(pl^.firstpoint);
		pl := pl^.next;
	end;
end;

procedure figure.zturn(cosa,sina:real);
var
	x,y,z:real;
	po:popointer;
	pl:plpointer;
begin
	pl:=firstplane;
	while pl<> nil do begin
		po:=pl^.firstpoint;
		while po <> nil do begin
			x:=po^.xpos;
			y:=po^.ypos;
			z:=po^.zpos;
			po^.xpos := x * cosa - y * sina;
			po^.ypos := x * sina + y * cosa;
			po^.zpos := z;
			po:=po^.next;
		end;
		if hide then pl^.visible := isvisible(pl^.firstpoint);
		pl := pl^.next;
	end;
end;

procedure figure.xscale(factor:real);
var
	po:popointer;
	pl:plpointer;
begin
	pl:=firstplane;
	while pl<> nil do begin
		po:=pl^.firstpoint;
		while po <> nil do begin
			po^.xpos:=po^.xpos*factor;
			po:=po^.next;
		end;
		pl := pl^.next;
	end;
end;

procedure figure.yscale(factor:real);
var
	po:popointer;
	pl:plpointer;
begin
	pl:=firstplane;
	while pl<> nil do begin
		po:=pl^.firstpoint;
		while po <> nil do begin
			po^.ypos:=po^.ypos*factor;
			po:=po^.next;
		end;
		pl := pl^.next;
	end;
end;

procedure figure.zscale(factor:real);
var
	po:popointer;
	pl:plpointer;
begin
	pl:=firstplane;
	while pl<> nil do begin
		po:=pl^.firstpoint;
		while po <> nil do begin
			po^.zpos:=po^.zpos*factor;
			po:=po^.next;
		end;
		pl := pl^.next;
	end;
end;

procedure figure.move(dx,dy,dz:real);
begin
	xoffset:=xoffset+dx;
	yoffset:=yoffset+dy;
	zoffset:=yoffset+dz;
end;

procedure figure.moveto(x,y,z:real);
begin
	xoffset:=x;
	yoffset:=y;
	zoffset:=z;
end;

procedure figure.copy(a:figure);
var
	pl:plpointer;
	po:popointer;
begin
	init(a.xoffset,a.yoffset,a.zoffset,a.hide);
	pl:=a.firstplane;
	while pl <> nil do begin
		addplane(pl^.number,pl^.solid,pl^.color);
		po:=pl^.firstpoint;
		while po <> nil do begin
			addpoint(pl^.number,po^.xpos,po^.ypos,po^.zpos);
			po:=po^.next;
		end;
		pl := pl^.next;
	end;
end;

{ INITIALISATION }

begin
end.
