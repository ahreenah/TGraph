unit GraphUtils;

interface

uses
  Generics.Collections;

type
  TGraph<TItem,TConnectionWeightType>=class
    type
      TConnection=record
        &to:integer;
        weight:TConnectionWeightType;
      end;
      TConnectionList=TList<TConnection>;
    var
      elems:TList<TItem>;
      connections:TList<TConnectionList>;
    constructor Create();
    procedure AddItem(item:TItem);
    procedure AddConnection(index1,index2:integer;newweight:TConnectionWeightType);
    procedure DeleteItem(index:integer);
    procedure DeleteConnection(elem:integer;&to:integer);
    function GetItemConnections(index:integer):TConnectionList;

  end;

implementation

  procedure TGraph<TItem,TConnectionWeightType>.AddItem(item:TItem);
  begin
    connections.Add(TConnectionList.Create);
    elems.Add(item);
  end;

  constructor TGraph<TItem,TConnectionWeightType>.Create();
  begin
    elems:=TList<TItem>.Create();
    connections:=TList<TConnectionList>.Create();
  end;

  procedure TGraph<TItem,TConnectionWeightType>.AddConnection(index1,index2:integer;newweight:TConnectionWeightType);
  var
    con:TConnection;
  begin
    with con do
      begin
        &to:=index2;
        weight:=newweight;
      end;
    Connections[index1].Add(con);
  end;

  procedure TGraph<TItem,TConnectionWeightType>.DeleteItem(index:integer);
  var
    i,j:integer;
  begin
    connections.Delete(index); //bug
    elems.Delete(index);       //bug
    for i:=0 to connections.Count-1 do
      for j:=0 to connections[i].Count-1 do
        begin
          if connections[i][j].&to=index then
            begin
              connections[i].Delete(j);
            end;
        end;
  end;

  procedure TGraph<TItem,TConnectionWeightType>.DeleteConnection(elem:integer;&to:integer);
  var
    index:integer;
  begin
    index:=0;
    while index<connections[elem].Count do
    begin
      if connections[elem][index].&to=&to then
      begin
        connections[elem].Delete(index);
        break;
      end;
      inc(index);
    end;
  end;

  function TGraph<TItem,TConnectionWeightType>.GetItemConnections(index:integer):TConnectionList;
  begin
    result:=connections[index];
  end;

end.
