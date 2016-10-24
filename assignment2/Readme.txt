Assignment Set- II

By: Jitendra Choudhary(130101017) and Sweta Agrawal(130101089) 

Problem 1

[a] The successor of a number
Usage: successor([x, x, x], Result).
Logic: To find successor we have used append function which adds [x] to the end of list.

[b] A predicate plus to compute the sum of two given numbers.
Usage: plus([x,x],[x,x,x,x],Result).
Logic: To find successor we have used append function which adds list2 to the end of list1.

[c] A predicate minus to compute the subtraction of second argument.
Usage: minus([x,x,x,x],[x,x,x], Result).
Logic: To subtract two lists we use base base cases minus(L1,[],L1):- !., minus([],L2,[]):- !. in which the first gives the answer and the second is to avoid negative numbers. 

[d] A predicate multiply to multiply two given numbers.
Usage: mult([x,x,x,x],[x,x,x], Result).
Logic: To multiply two lists we use append function. We append list2 to the result len(list1) number of times.

[e] A predicate divide to divide two given numbers
Usage: div([x,x,x,x],[x,x,x]).
Logic: To divide two lists we subtract list2 from list1 using predicate minus and then use base base cases div(L,L):- write("Yes"),!., div([],L):- write("No"),!. in which the first gives the yes answer and the second gives no when the second number is larger than the first number.


Problem 2

[a] Usage: status([move, move, left, move, move, move], Position, Orientation).
	Logic: For this question we use simple if condition. There are two variables X, Y which stores the X and Y co-ordinates and a variable O to represent orientation. We update the variables when certain conditions are met. For e.g if the current orientation O is north and the status is "move" then we increment Y.

[b] Usage: movement([0,0], east, [2,3]).
	Logic: To solve this problem, we use two variables N1 and N2 which represents how many steps to move with their sign representing which direction to take. Depending on signs and after comparing N1 and N2 we take steps in a certain direction.
	For e.g
	movement([0,1], east, [0,2]).

	N1 = 0
	N2 = 1

	since N2>0 we need to move in north direction. To go from east to north, the robot need to turn left and then move N2 steps which in this case is 1. So answer is [left,move]


Problem 3

[a] Usage: chalkboard(Techniche).
	Logic: We use a four-tuple of the type pizza(pizza_name, T1,T2, P) which denotes the pizza_name, the non-veg topping, the veg topping and the price. We first supply all the constraints given in the question in the form of membership and facts. To ensure that each of the veg, non-veg, price is unique for each pizza, we further supply the permuation constraint. For e.g. permutation([chicken,mutton,prawn,salami,tuna],[HT1,MT1,PT1,ST1,NT1]).
