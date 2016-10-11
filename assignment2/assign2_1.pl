%Append two lists
append([],List,List).
append([H|T],List,[H|T1]):-
	append(T,List,T1).

%successor 
successor(X,Result):- append(X,[x],Result),!.

%predicate plus
plus(X,Y,Result):- append(X,Y,Result),!.

%predicate minus
minus(L1,[],L1):- !.
minus([],L2,[]):- !.
minus([H1|T1],[H2|T2],Result):-
	minus(T1,T2,Result).	

%predicate multiply
mult([],List,[]):-!.
mult([x],List,List):-!.
append([],List,List).

mult([H|T],List,Result):-
	mult(T,List,Result1),
	append(Result1,List,Result),!.


%predicate divide
div(L,L):- write("Yes"),!.
div([],L):- write("No"),!.
div(L1,L2):-
	minus(L1,L2,R),
	div(R,L2).