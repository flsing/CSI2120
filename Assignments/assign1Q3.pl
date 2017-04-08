% Question 3 %

blue('Blue Lobelia').
blue('Periwinkle').
blue('Chrysanthemum').
blue('Iris').

pink('Impatiens').
pink('Anemore').
pink('Bleeding Heart').
pink('Iris').
pink('Phlox').

yellow('Marigold').
yellow('Black-Eyed Susan').
yellow('Chrysanthemum').
yellow('False Lupine').

red('Impatiens').
red('Chrysanthemum').
red('Iris').
red('Phlox').

white('Impatiens').
white('Anemore').
white('Bleeding Heart').
white('Chrysanthemum').
white('Iris').

orange('Marigold').
orange('Iris').

purple('Heather').
purple('Phlox').


% Main database %

plant('Blue Lobelia',['partial sun', 'shade'],[blue], 6,12,2,11,'annual').
plant('Impatiens',['shade'],[red,white,pink],12,36,10,11,'annual').
plant('Periwinkle',['partial sun','shade','sun'],[blue],0,6,4,9,'perennial').
plant('Anemore',['partial sun', 'sun'],[pink,white],12,36,4,8,'perennial').
plant('Marigold',['sun'],[yellow,orange],3,12,-1,-1,'annual').
plant('Black-Eyed Susan',['partial sun','sun'],[yellow],12,24,3,11,'annual').
plant('Bleeding Heart',['partial sun','shade'],[pink,white],6,12,3,9,'perennial').
plant('Chrysanthemum',['partial sun','sun'],[red,yellow,blue,white],12,36,5,9,'perennial').
plant('False Lupine',['partial sun','sun'],[yellow],12,96,4,8,'perennial').
plant('Heather',['partial sun','sun'],[purple],36,96,6,10,'perennial').
plant('Iris',['partial sun','sun'],[blue,orange,pink,red,white],6,36,3,9,'perennial').
plant('Phlox',[],[purple,red,pink],12,36,2,11,'annual').

%  A  %
hardy(P):- plant(P,_,_,_,H,A,_,Time),
			Time == 'perennial',
			H >= 48,
			A > 0,
			A < 6.
											

%  B  %
trio(C1,P1,C2,P2,C3,P3) :- plant(P1,_,Co1,_,_,_,_,_),
						member(C1,Co1),
						plant(P2,_,Co2,_,_,_,_,_),
						member(C2,Co2),
						plant(P3,_,Co3,_,_,_,_,_),
						member(C3,Co3),
						\+ P1==P2,
						\+ P2==P3,
						\+ P1==P3.
				

%  C  %
suggestion(paul(X),mary(Y)) :-  plant(X,_,_,_,Height,A,Z,_),
								Height >= 36,
								A =< 7,
								Z >= 7.
								
								
suggestion(paul(X),mary(Y)) :-  plant(Y,_,_,_,_,A,Z,_),
								A =< 7,
								Z >= 7,
								\+ yellow(Y).