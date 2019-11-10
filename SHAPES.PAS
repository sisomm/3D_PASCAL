unit shapes;
interface

uses gmath,figures,graph;

procedure cube(var a:figure;size:real;solid:boolean);
procedure dodecaeder(var a:figure;size:real;solid:boolean);

implementation

procedure cube(var a:figure;size:real;solid:boolean);
begin

	a.addplane(1,solid,white);
	a.addpoint(1,-size,+size,+size);
	a.addpoint(1,+size,+size,+size);
	a.addpoint(1,+size,+size,-size);
	a.addpoint(1,-size,+size,-size);

	a.addplane(2,solid,red);
	a.addpoint(2,-size,-size,+size);
	a.addpoint(2,+size,-size,+size);
	a.addpoint(2,+size,-size,-size);
	a.addpoint(2,-size,-size,-size);

	a.addplane(3,solid,blue);
	a.addpoint(3,+size,+size,-size);
	a.addpoint(3,+size,+size,+size);
	a.addpoint(3,+size,-size,+size);
	a.addpoint(3,+size,-size,-size);

	a.addplane(4,solid,green);
	a.addpoint(4,-size,+size,-size);
	a.addpoint(4,-size,+size,+size);
	a.addpoint(4,-size,-size,+size);
	a.addpoint(4,-size,-size,-size);

	a.addplane(5,solid,yellow);
	a.addpoint(5,-size,+size,-size);
	a.addpoint(5,+size,+size,-size);
	a.addpoint(5,+size,-size,-size);
	a.addpoint(5,-size,-size,-size);

	a.addplane(6,solid,lightgray);
	a.addpoint(6,-size,+size,+size);
	a.addpoint(6,+size,+size,+size);
	a.addpoint(6,+size,-size,+size);
	a.addpoint(6,-size,-size,+size);
end;

procedure dodecaeder(var a:figure;size:real;solid:boolean);
begin
	a.addplane(1,solid,red);
	a.addpoint(1,-size,0,size);
	a.addpoint(1,size,0,size);
	a.addpoint(1,0,-size,0);

	a.addplane(2,solid,blue);
	a.addpoint(2,size,0,size);
	a.addpoint(2,size,0,-size);
	a.addpoint(2,0,-size,0);

	a.addplane(3,solid,green);
	a.addpoint(3,size,0,-size);
	a.addpoint(3,-size,0,-size);
	a.addpoint(3,0,-size,0);

	a.addplane(4,solid,cyan);
	a.addpoint(4,-size,0,-size);
	a.addpoint(4,-size,0,size);
	a.addpoint(4,0,-size,0);

	a.addplane(5,solid,white);
	a.addpoint(5,-size,0,size);
	a.addpoint(5,size,0,size);
	a.addpoint(5,0,size,0);

	a.addplane(6,solid,lightgray);
	a.addpoint(6,size,0,size);
	a.addpoint(6,size,0,-size);
	a.addpoint(6,0,size,0);

	a.addplane(7,solid,yellow);
	a.addpoint(7,size,0,-size);
	a.addpoint(7,-size,0,-size);
	a.addpoint(7,0,size,0);

	a.addplane(8,solid,magenta);
	a.addpoint(8,-size,0,-size);
	a.addpoint(8,-size,0,size);
	a.addpoint(8,0,size,0);

end;

begin
end.
