unit gmath;

INTERFACE

type
	vector = record
		x,y,z:integer;
	end;

function grad2rad(gamma:real):real;


IMPLEMENTATION

function grad2rad(gamma:real):real;
begin
	grad2rad:=gamma/180*pi;
end;

begin
end.