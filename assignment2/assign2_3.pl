chalkboard(L) :- 
	L= [pizza(hawaiian, HT1,HT2,HP),
		pizza(marco_polo,MT1,MT2,MP),
		pizza(pepperoni,PT1,PT2,PP),
		pizza(super_supreme, ST1,ST2,SP),
		pizza(ninja_pizza,NT1,NT2,NP)],

	HT1 = mutton,
	member(HP,[70,85,100]),
	MT2 = tomato,
	member(MT1,[mutton,prawn,salami,tuna]),
	member(pizza(_,chicken,_,85),L),
	PP = 70,
	member(ST2,[onion,corn,olive,tomato]),
	member(pizza(_,tuna,corn,P),L),
	member(P,[55,70,85,100]),
	member(pizza(_,T1,olive,55),L),
	member(T1,[chicken,mutton,prawn,tuna]),
	member(pizza(_,_,pineapple,Q),L),
	member(Q,[55,65,70,85]),
	permutation([chicken,mutton,prawn,salami,tuna],[HT1,MT1,PT1,ST1,NT1]),
	permutation([onion,corn,olive,tomato,pineapple],[HT2,MT2,PT2,ST2,NT2]),
	permutation([55,65,70,85,100],[HP,MP,PP,SP,NP]),!.

permutation([],[]).
permutation(L,[X|P]) :- sel(X,L,L1), permutation(L1,P).

sel(X,[X|L],L).
sel(X,[Y|L],[Y|L1]) :- sel(X,L,L1).