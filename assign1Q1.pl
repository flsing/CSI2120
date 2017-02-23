sosd(0,0):-!.
sosd(X,Y):- 
	Z is floor(X/10),
	sosd(Z,Y1),
	Y is Y1 + (X mod 10)**2,!.


nothappy(0) :- write(0).
nothappy(4) :- write(4).
nothappy(16):- write(16).
nothappy(20):- write(20).
nothappy(37):- write(37).
nothappy(42):- write(42).
nothappy(58):- write(58).
nothappy(89):- write(89).
nothappy(145):- write(145).


happyNumber(1) :- write(1),!.
happyNumber(X):- 
    sosd(X,Y),
    Number is Y,
    Number2 is floor(Number/1),
    \+ nothappy(Number2),
    happyNumber(Number2).

