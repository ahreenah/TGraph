program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  GraphUtils in 'GraphUtils.pas';

var
  g:TGraph<integer,integer>;
  cons:TGraph<integer,integer>.TConnectionList;
  con:TGraph<integer,integer>.TConnection;
  i,action,tmp,tmp2,tmp3:integer;

begin
  g:=TGraph<integer,integer>.Create();
  repeat
    writeln('Please enter action: ');
    writeln(' 1 - add elem             2 - remove elem');
    writeln(' 3 - add connection       4 - remove connection');
    writeln(' 5 - get all connections  6 - get element connections');
    writeln(' 7 - exit ');
    readln(action);
    case action of
      1:begin
          write('enter element: ');
          readln(tmp);
          g.AddItem(tmp);
        end;
      2:begin
          write('enter index: ');
          readln(tmp);
          g.DeleteItem(tmp);
        end;
      3:begin
          write('enter index_1, index_2 and weight: ');
          readln(tmp);
          readln(tmp2);
          readln(tmp3);
          g.AddConnection(tmp,tmp2,tmp3);
        end;
      4:begin
          write('enter connection number (starting from 0): ');
          readln(tmp);
          g.DeleteConnection(tmp);
        end;
      5:begin
          for con in g.connections do
            writeln(con.item1,' ',con.item2,' ',con.weight);
        end;
      6:begin
          write('enter element index (starting from 0): ');
          readln(tmp);
          for con in g.GetItemConnections(tmp) do
            writeln(con.item1,' ',con.item2,' ',con.weight);
        end;
    end;
  until action=7;
end.
