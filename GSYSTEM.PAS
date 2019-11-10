unit gsystem;

INTERFACE

uses graph;

var
	maxy 	: integer;
	maxx 	: integer;
	maxz  : integer;
	viewx : integer;
	viewy	: integer;
	viewz : integer;
	bcolor: integer;

procedure graphinit;
procedure error(m:string);

IMPLEMENTATION

procedure graphinit;
var f:text;
   driver    : string;
   grDriver  : Integer;
   grModus   : Integer;
   FeilKode  : Integer;
   count     : Integer;
begin
     assign(f,'\gdrivers.tp');
     reset(f);
     readln(f,driver);
     close(f);
     grDriver := Detect;
     InitGraph(grDriver,grModus,driver);
     maxx := getmaxx;
     maxy := getmaxy;
	  maxz := 200;
	  FeilKode := GraphResult;
     if FeilKode <> grOk then begin
        writeln('graphics initialisation error');
        halt;
     end;
	  bcolor := getbkcolor;
end;

procedure error(m:string);
begin
	writeln('Error :',m);
	writeln('Program execution is halted.');
	halt;
end;

begin;
end.