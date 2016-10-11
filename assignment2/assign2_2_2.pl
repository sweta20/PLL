%Append two lists
append([],List,List).
append([H|T],List,[H|T1]):-
	append(T,List,T1).

movement([X1,Y1|_], O, [X2,Y2|_]):-
	N1 is X2-X1,
	N2 is Y2-Y1,
	(
		O=east ->
		(
			(
				N1>=0 -> (
						N2>=0 -> 
							(
							length(L0,N1),
							maplist(=(move),L0),
							append(L0,[left],L2),
							length(L,N2),
							maplist(=(move),L),
							append(L2,L,L3)
							)
						;
						N2<0 -> 
							(
							length(L0,N1),
							maplist(=(move),L0),
							append(L0,[right],L2),
							N3 is Y1-Y2,
							length(L,N3),
							maplist(=(move),L),
							append(L2,L,L3)
							)
					)
				;
				N1=<0 -> (
					N2>=0 -> (
						length(L,N2),
						maplist(=(move),L),
						append([left],L,L1),
						append(L1,[left],L2),
						N3 is X1-X2,
						length(L0,N3),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
					;
					N2<0 -> (
						N4 is Y1-Y2,
						length(L,N4),
						maplist(=(move),L),
						append([right],L,L1),
						append(L1,[right],L2),
						N3 is X1-X2,
						length(L0,N3),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
				)
			)
		)
		;
		O=west ->
		(
			(
				N1=<0 -> (
						N2>=0 -> 
							(
							N3 is X1-X2,
							length(L0,N3),
							maplist(=(move),L0),
							append(L0,[right],L2),
							length(L,N2),
							maplist(=(move),L),
							append(L2,L,L3)
							)
						;
						N2<0 -> 
							(
							N3 is X1-X2,
							length(L0,N3),
							maplist(=(move),L0),
							append(L0,[left],L2),
							N4 is Y1-Y2,
							length(L,N4),
							maplist(=(move),L),
							append(L2,L,L3)
							)
					)
			;
				N1>0 -> (
					N2>=0 -> (
						length(L,N2),
						maplist(=(move),L),
						append([right],L,L1),
						append(L1,[right],L2),
						length(L0,N1),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
					;
					N2<0 -> (
						N4 is Y1-Y2,
						length(L,N4),
						maplist(=(move),L),
						append([left],L,L1),
						append(L1,[left],L2),
						length(L0,N1),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
				)
			)
		)
		;
		O=south ->
		(
			(
				N2<0 -> (
						N1>=0 -> 
							(
							N3 is Y1-Y2,
							length(L0,N3),
							maplist(=(move),L0),
							append(L0,[left],L2),
							length(L,N1),
							maplist(=(move),L),
							append(L2,L,L3)
							)
						;
						N1=<0 -> 
							(
							N3 is Y1-Y2,
							length(L0,N3),
							maplist(=(move),L0),
							append(L0,[right],L2),
							N4 is X1-X2,
							length(L,N4),
							maplist(=(move),L),
							append(L2,L,L3)
							)
					)
			;
				N2>=0 -> (
					N1>=0 -> (
						length(L,N1),
						maplist(=(move),L),
						append([left],L,L1),
						append(L1,[left],L2),
						length(L0,N2),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
					;
					N1<0 -> (
						N3 is X1-X2,
						length(L,N3),
						maplist(=(move),L),
						append([right],L,L1),
						append(L1,[right],L2),
						length(L0,N2),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
				)
			)
		)
		;
		O=north ->
		(
			(
				N2>=0 -> (
						N1>=0 -> 
							(
							length(L0,N2),
							maplist(=(move),L0),
							append(L0,[right],L2),
							length(L,N1),
							maplist(=(move),L),
							append(L2,L,L3)
							)
						;
						N1=<0 -> 
							(
							length(L0,N2),
							maplist(=(move),L0),
							append(L0,[left],L2),
							N3 is X1-X2,
							length(L,N3),
							maplist(=(move),L),
							append(L2,L,L3)
							)
					)
			;
				N2=<0 -> (
					N1>=0 -> (
						length(L,N1),
						maplist(=(move),L),
						append([right],L,L1),
						append(L1,[right],L2),
						N3 is Y1-Y2,
						length(L0,N3),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
					;
					N1<0 -> (
						N3 is X1-X2,
						length(L,N3),
						maplist(=(move),L),
						append([left],L,L1),
						append(L1,[left],L2),
						N4 is Y1-Y2,
						length(L0,N4),
						maplist(=(move),L0),
						append(L2,L0,L3)
					)
				)
			)
		)
	),
	write(L3),!.