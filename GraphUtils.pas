unit GraphUtils;

interface

uses
  Generics.Collections;

type
  TGraph<TItem,TConnectionWeightType>=class
    type
      TConnection=record
        item1,item2:integer;
        weight:TConnectionWeightType;
        function IncludesElement(index:integer):boolean;
        function OtherElement(index:integer):integer;
      end;
      TConnectionList=TList<TConnection>;
    var
      elems:TList<TItem>;
      connections:TList<TConnection>;
    constructor Create();
    procedure AddItem(item:TItem);
    procedure AddConnection(index1,index2:integer;newweight:TConnectionWeightType);
    procedure DeleteItem(index:integer);
    procedure DeleteConnection(index:integer);
    function GetItemConnections(index:integer):TConnectionList;

  end;

implementation

  function TGraph<TItem,TConnectionWeightType>.TConnection.IncludesElement(index:integer):boolean;
  begin
     if (item1=index) or (item2=index) then
         Result:=true
     else
         Result:=false
  end;

  function TGraph<TItem,TConnectionWeightType>.TConnection.OtherElement(index:integer):integer;
  begin
    Result:=item1+item2-index;
  end;

  procedure TGraph<TItem,TConnectionWeightType>.AddItem(item:TItem);
  begin
    elems.Add(item);
  end;

  constructor TGraph<TItem,TConnectionWeightType>.Create();
  begin
    elems:=TList<TItem>.Create();
    connections:=TList<TConnection>.Create();
  end;

  procedure TGraph<TItem,TConnectionWeightType>.AddConnection(index1,index2:integer;newweight:TConnectionWeightType);
  var
    con:TConnection;
  begin
    with con do
      begin
        item1:=index1;
        item2:=index2;
        weight:=newweight;
      end;
    Connections.Add(con);
  end;

  procedure TGraph<TItem,TConnectionWeightType>.DeleteItem(index:integer);
  var
    i:integer;
  begin
    i:=0;
    while i<connections.Count do
      begin
        if (connections[i].item1=index) or (connections[i].item2=index) then
          connections.Delete(i);
        inc(i);
      end;
    elems.Delete(i);
  end;

  procedure TGraph<TItem,TConnectionWeightType>.DeleteConnection(index:integer);
  begin
    connections.Delete(index);
  end;

  function TGraph<TItem,TConnectionWeightType>.GetItemConnections(index:integer):TConnectionList;
  var
    lst:TConnectionList;
    con:TConnection;
  begin
    lst:=TConnectionList.Create();
    for con in connections do
    begin
      if con.IncludesElement(index) then
        lst.Add(con)
    end;
    result:=lst;
  end;

end.
