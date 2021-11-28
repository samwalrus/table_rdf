%%% Read in the csv as tripples


:- [library(csv)].


list_of_rows_tripples(Rows,ColHeaders,Tripples):-
    Rows = [HeaderRow|Rest],
    HeaderRow =..[row,ID|ColHeaders],
    Rest=[First|Rest2],
%    colheaders_row_tripple(ColHeaders,First,Tripples).
    maplist(colheaders_row_tripple(ColHeaders),Rest,Tripples).


colheaders_row_tripple(ListOfCols,RowList,Tripple):-
    RowList =..[row,ID|Values],
    maplist(tripple(ID),ListOfCols,Values,Tripple).

tripple(ID,Col,Value,Tripple):-
    Tripple = tripple(ID,Col,Value).
%    writeln(Tripple).

% ?- csv_read_file("../data_in/herd.csv", Rows),Rows = [HeaderRow|Rest],HeaderRow =..[row,ID|ColHeaders],    Rest=[First|Rest2], First =..[row,ID2|Things], maplist(tripple(ID2),ColHeaders,Things).


% ?- csv_read_file("../data_in/herd.csv", Rows),Rows = [HeaderRow|Rest],HeaderRow =..[row,ID|ColHeaders],    Rest=[First|Rest2], maplist(colheaders_row_tripple(ColHeaders),Rest,Tripples).

%%%% This makes a *list of list* of tripples

% ?- csv_read_file("../data_in/herd.csv", Rows),list_of_rows_tripples(Rows,ColHeaders,Tripples).
%@ Rows = [row(sample, 'Species', 'Age', 'Height', 'Income', 'favourite thing'), row('Sam', 'Human', 38, '5 ft 11', 38, pubs), row('Louise', 'Human', 38, '5ft 5', 50, puzzles), row('Wally', 'Walrus', 5, '1 ft', 0, 'the sea'), row('Tulip', 'Walrus', 4, '1 ft', 0, 'the iceberg'), row('Phoebe', 'Dog', 10, '2 ft', 0, bread), row('Sausage', 'Dog', 31, '6 inch', 0, sleeping), row('Old Boy', 'Walrus', 100, '10 inch', 0, maps)],
%@ ColHeaders = ['Species', 'Age', 'Height', 'Income', 'favourite thing'],
%@ Tripples = [[tripple('Sam', 'Species', 'Human'), tripple('Sam', 'Age', 38), tripple('Sam', 'Height', '5 ft 11'), tripple('Sam', 'Income', 38), tripple('Sam', 'favourite thing', pubs)], [tripple('Louise', 'Species', 'Human'), tripple('Louise', 'Age', 38), tripple('Louise', 'Height', '5ft 5'), tripple('Louise', 'Income', 50), tripple('Louise', 'favourite thing', puzzles)], [tripple('Wally', 'Species', 'Walrus'), tripple('Wally', 'Age', 5), tripple('Wally', 'Height', '1 ft'), tripple('Wally', 'Income', 0), tripple('Wally', 'favourite thing', 'the sea')], [tripple('Tulip', 'Species', 'Walrus'), tripple('Tulip', 'Age', 4), tripple('Tulip', 'Height', '1 ft'), tripple('Tulip', 'Income', 0), tripple(..., ..., ...)], [tripple('Phoebe', 'Species', 'Dog'), tripple('Phoebe', 'Age', 10), tripple('Phoebe', 'Height', '2 ft'), tripple(..., ..., ...)|...], [tripple('Sausage', 'Species', 'Dog'), tripple('Sausage', 'Age', 31), tripple(..., ..., ...)|...], [tripple('Old Boy', 'Species', 'Walrus'), tripple(..., ..., ...)|...]].


tripples_terms(Tripples,Terms):-
    setof(Term,X^Y^(member(tripple(Term,X,Y),Tripples);member(tripple(X,Term,Y),Tripples);member(tripple(Y,X,Term),Tripples)),Terms).




% ?- csv_read_file("../data_in/herd.csv", Rows),list_of_rows_tripples(Rows,ColHeaders,Tripples), flatten(Tripples,Flat),tripples_terms(Flat,Terms).
%@ Rows = [row(sample, 'Species', 'Age', 'Height', 'Income', 'favourite thing'), row('Sam', 'Human', 38, '5 ft 11', 38, pubs), row('Louise', 'Human', 38, '5ft 5', 50, puzzles), row('Wally', 'Walrus', 5, '1 ft', 0, 'the sea'), row('Tulip', 'Walrus', 4, '1 ft', 0, 'the iceberg'), row('Phoebe', 'Dog', 10, '2 ft', 0, bread), row('Sausage', 'Dog', 31, '6 inch', 0, sleeping), row('Old Boy', 'Walrus', 100, '10 inch', 0, maps)],
%@ ColHeaders = ['Species', 'Age', 'Height', 'Income', 'favourite thing'],
%@ Tripples = [[tripple('Sam', 'Species', 'Human'), tripple('Sam', 'Age', 38), tripple('Sam', 'Height', '5 ft 11'), tripple('Sam', 'Income', 38), tripple('Sam', 'favourite thing', pubs)], [tripple('Louise', 'Species', 'Human'), tripple('Louise', 'Age', 38), tripple('Louise', 'Height', '5ft 5'), tripple('Louise', 'Income', 50), tripple('Louise', 'favourite thing', puzzles)], [tripple('Wally', 'Species', 'Walrus'), tripple('Wally', 'Age', 5), tripple('Wally', 'Height', '1 ft'), tripple('Wally', 'Income', 0), tripple('Wally', 'favourite thing', 'the sea')], [tripple('Tulip', 'Species', 'Walrus'), tripple('Tulip', 'Age', 4), tripple('Tulip', 'Height', '1 ft'), tripple('Tulip', 'Income', 0), tripple(..., ..., ...)], [tripple('Phoebe', 'Species', 'Dog'), tripple('Phoebe', 'Age', 10), tripple('Phoebe', 'Height', '2 ft'), tripple(..., ..., ...)|...], [tripple('Sausage', 'Species', 'Dog'), tripple('Sausage', 'Age', 31), tripple(..., ..., ...)|...], [tripple('Old Boy', 'Species', 'Walrus'), tripple(..., ..., ...)|...]],
%@ Flat = [tripple('Sam', 'Species', 'Human'), tripple('Sam', 'Age', 38), tripple('Sam', 'Height', '5 ft 11'), tripple('Sam', 'Income', 38), tripple('Sam', 'favourite thing', pubs), tripple('Louise', 'Species', 'Human'), tripple('Louise', 'Age', 38), tripple('Louise', 'Height', '5ft 5'), tripple(..., ..., ...)|...],
%@ Terms = [0, 4, 5, 10, 31, 38, 50, 100, '1 ft'|...].



