

  uses
    Crt, Graph;
  const
    R = 50;
  var
    Driver, Modus : Integer;
    Xasp, Yasp : Word;
  begin
    DirectVideo := false;
    Driver := Detect;
	 InitGraph(Driver, Modus, '\tp55\graph');
    if GraphResult < 0 then Halt(1);
    GetAspectRatio(Xasp, Yasp); { Standard }
	 { Juster for VGA og 8514 (1:1) }
    if Xasp = Yasp then
      Yasp := 5 * Xasp;
    { Endre inntil 1:1 eller tastetrykk }
    while (Xasp < Yasp) and not KeyPressed do
    begin
      SetAspectRatio(Xasp, Yasp);
      Circle(GetMaxX div 2, GetMaxY div 2, R);
      Inc(Xasp, 20);
    end;
    SetTextJustify(CenterText, CenterText);
    OutTextXY(GetMaxX div 2, GetMaxY div 2,
              'Ferdig!');
    ReadLn;
    Closegraph;
  end.