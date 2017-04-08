% Question 1 %

% A) Write a generator which produces all positive numbers X 
% divisible by a number D below an upper bound U.
% ?- divisible( 4, 15, X ). 
% X=4;
% X=8;
% X = 12


divisible(Div,Up,Div) :- Up>Div.
divisible(1,Up,1).
divisible(Div,Up,X) :-  Div > 1,
						divisible(Div,Up,XX),!,				
						X is XX + Div,
						\+ XX > Up,
						\+ X > Up.



% the code stops after 2 loops. I had the program running to get all the 
% solutions if i remove the cut, however after reaching the upper 
% limit it would run infinitely.o In order to have 1b work i have only 
% allowed the code to loop twice. 

					


% B) Design predicate that collects all divisors (the solutions from a) into a list.
% ?- divisibleAll( 4, 15, L ).
% L = [ 4, 8, 12]


divisibleAll(Div,Up,L) :- findall(X,divisible(Div,Up,X),L).





% Question 2 %

% A wizard has 16 different hats with four different colours and four different letters. The four colours of
% the hats are red, green, yellow and blue, the four different letters are w,x,y and z. No two hats are the
% same. The wizard stores the hats in a drawer with a four by four grid. Because of wizardry, the hats need
% to be stored in such a way that in each column and each row of the drawer, no two hats have the same
% colour or the same letter. You are asked to help the wizard to find a solution to put the wizard’s hat in
% the drawer.%



color(red).
color(green).
color(yellow).
color(blue).

letter(w).
letter(x).
letter(y).
letter(z).


%  A  %



generateHats(H) :- findall((X,Y),(color(X),letter(Y)),H).


% works

%  B  %

								
validRow([H]).

validRow([H|T]) :- H=(Row,Col,Color,Letter),
	T = [Y|Z],
	Y = (Row2,Col2,Color2,Letter2),
	Row == Row2,
	\+(Color==Color2),
	\+(Letter==Letter2),
	validRow(T),
	validRow([H|Z]).


%works

%  C  %

generateRow([H|T],X,Row) :- 
%H=(X,_,Color,Letter),
%%						H = (X2,_,Color2,Letter2),
						Row = [W,X,Y,Z],!,
						validRow(Row).

% deosnt work -- i am trying to generate the rows similarly to the way i
% was checking if its a valid row. 

%  D  %

uniqueRows([_|[]]).
uniqueRows([H,I|T]) :- H=(_, Col, Color, Letter),
					I = (_, Col2, Color2, Letter2),
					(Col == Col2 ->
					\+(Color ==Color2),
					\+(Letter ==Letter2);
					uniqueRows([H|T]),
					uniqueRows([I|T])).

%works


%  E  %

wizardry(A):-  findall((A,B,C,D,E,F,G,I,J,K,Z,M,N,O,P,Q),generateHats(H),W),
    		generateRow(W,1,[A,B,C,D]),
    		generateRow(W,2,[E,F,G,I]),
    		generateRow(W,3,[J,K,Z,M]),
    		generateRow(W,4,[N,O,P,Q]).

% doesnt work -- my generateRow doesnt work as planned so this will not work either. 
% BUt my logic here is to instantiate each of the 16 possible combinations (A-Q)
%  from generateHats then I will generate the rows (1-4) with generateRow and
%  place each of the validRows in them. 


%  F  %


drawer([]).
drawer([H|T]) :- H = (Row, Col,_,_),
				T = [Y|Z],
				Y = (Row2,Col2,_,_),
				(Row == Row2 -> 
				write(H),tab(5), drawer(T));
				(Col == Col -> 
				write(H), nl, drawer(T)). 

% works!







