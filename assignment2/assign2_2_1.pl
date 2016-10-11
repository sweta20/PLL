status(L,Position,Orientation):-
	status1(L,[0|0],east).

status1([],[X|Y],O):-
	write("Position = ("),
	write(X),
	write(","),
	write(Y),
	write(")"),
	nl,
	write("Orientation = "),
	write(O).

status1([H|T],[X|Y],O):-
	(
		H=move ->
		(
			O=east -> (N1 is X+1,N2 is Y,P = O)
			;
			O=west -> (N1 is X-1,N2 is Y,P = O)
			;
			O=north -> (N1 is X,N2 is Y+1,P = O)
			;
			O=south -> (N1 is X,N2 is Y-1,P = O)
		)
		;
		H=left ->
		(
			O=east -> (N1 is X, N2 is Y,P = north)
			;
			O=west -> (N1 is X, N2 is Y, P = south)
			;
			O=south -> (N1 is X, N2 is Y, P = east)
			;
			O=north -> (N1 is X, N2 is Y, P = west)
		)
		;
		H=right ->
		(
			O=east -> (N1 is X, N2 is Y,P = south)
			;
			O=west -> (N1 is X, N2 is Y, P = north)
			;
			O=south -> (N1 is X, N2 is Y, P = west)
			;
			O=north -> (N1 is X, N2 is Y, P = east)
		)
	),
	status1(T,[N1|N2], P).