uses graph, crt;

procedure init;
var
   grDriver  : Integer;
   grModus   : Integer;
   FeilKode  : Integer;
begin
     grDriver := Detect;
     InitGraph(grDriver,grModus,'\tp55\graph');
     FeilKode := GraphResult;
     if FeilKode <> grOk then begin
        writeln('Fy faen!');
     end;
end;

procedure produce;
begin
     circle(320,240,240);
end;

procedure wait;
begin
     if readkey=#0 then begin end;
end;



begin
   init;
   produce;
   wait;
end.