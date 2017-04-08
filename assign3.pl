%%%%%%%%%%%%%%%%%%%%%%%%%% Assignment 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Q1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          

%% Question 1. [3.5 marks]
% A database for student and course information system needs to be 
% constructed. The following facts are given:


% a) Design a predicate addStudent/0 which interactively accepts 
% input to createa new student/3 record with an empty class list. 
% Your predicate must check that the student is not yet in the system 
% and the student ID is not yet used. 
% Consider the following example:


:- dynamic(student/3).
:- dynamic(mark/4).
:- dynamic(evaluation/4).

% name, studentId, course list
student(name(blake, [ann]), 33333, ['CSI2120'] ).
student(name(simpson, [abe,j]), 12345, ['CSI2120'] ).
student(name(smith, [jon]), 12321, ['CSI2120'] ).
student(name(singerman, [felix]), 11223, ['CSI2120'] ).


% course, type, name as list of text, maximum marks
evaluation('CSI2120', assignment(1),  ['Prolog', database ],  5).

% course, studentId, evaluation, mark
mark('CSI2120', 33333, assignment(1), 3.5 ).
mark('CSI2120', 12345, assignment(1), 4 ).
mark('CSI2120', 11223, assignment(1), _ ).
mark('CSI2120', 12321, assignment(1), _ ).


addStudent :- write('Student last name: '), read(Last), 
				write('Student first name: '), read(First),
				write('Student ID: '), read(ID),
				addingStudent(Last,First,ID).
				



addingStudent(stop,stop,stop):- write('Exiting..'),nl. 

addingStudent(Last,First,ID) :- student(_,ID2,_),
								ID == ID2, !, fail.

% addingStudent(Last,First,ID) :- student(name(Last1,First1),ID1,_),
%								ID == ID1,
%								member(First,First1),
%								member(Last,Last1),!,fail.


addingStudent(Last,First,ID) :- asserta(student(name(Last,First),ID,[_])),
								tell('assign3.txt'),listing(student),told.

%%%%% assumption: 2 people can have the same name 


% b) Design a predicate add/2 which given a course and student ID, 
% adds a course to this student’s course list. Your predicate must ensure 
% that the same course can only be added once. Consider the following example:

%   ?- add('CSI2120',23123).
%   true.



add(Course,ID) :- student(_,ID1,Course1),
					ID == ID1,
					member(Course,Course1),!,fail.


add(Course,ID) :- student(Name,ID,Course2),
					append([Course],Course2,Courses),
					retract(student(_,ID,_)),
					asserta(student(Name,ID,Courses)),
					tell('assign3.txt'),listing(student),told.




% c) Design a predicate addAllMarks/2 which given a course and evaluation, 
% loops over all students in the course and let a user enter marks. 
% Your predicate should loop over students who have the course in their 
% course list and which have not yet received a mark for the evaluation. 
% Consider the following example (user input in italic):

% ?- addAllMarks('CSI2120',midterm(1)). 
% name(blake,[ann]) Mark (out of 26): 25. 
% name(doe,[jane,j]) Mark (out of 26): 22. 
% name(doe,[jim,k]) Mark (out of 26): 14. 
% false.

% Note, the information provided to the user in input. Also, note that your 
% program must check if an entered mark is valid. For example:

% ?- addAllMarks('CSI2120',assignment(1)). 
% name(doe,[jane,j]) Mark (out of 5): 7. 
% name(doe,[jane,j]) Mark (out of 5): -2. 
% name(doe,[jane,j]) Mark (out of 5): 3. 
% name(doe,[jim,k]) Mark (out of 5): 4. 
% false.


addAllMarks(Class,Exam):- evaluation(Class,Exam,_,Max),
							mark(Class,ID,Exam,_),	
							student(Name,ID,_),
							write(Name),
							write(' Mark (out of '), write(Max),
							write('): '), read(Mark),
							addingMarks(Name,ID,Class,Exam,Max,Mark).



addingMarks(Name,ID,Class,Exam,Max,Mark) :- 
							mark(Class,ID,Exam,Existing),
							Existing @> 0,
							write('They already have a mark'),nl,
							!,fail.


addingMarks(Name,ID,Class,Exam,Max,Mark) :- 
							mark(Class,ID,Exam,_),
							Mark > Max, addAllMarks(Class,Exam).

addingMarks(Name,ID,Class,Exam,Max,Mark) :- 
							mark(Class,ID,Exam,_),
							Mark < 0, addAllMarks(Class,Exam). 

addingMarks(Name,ID,Class,Exam,Max,Mark) :- 
							mark(Class,ID,Exam,_),
							Mark =< Max, 
							Mark >= 0,
							retract(mark(Class,ID,Exam,Mark)),
							asserta(mark(Class,ID,Exam,Mark)),
							tell('assign3.txt'),listing(mark),told,!,fail.






% d) Design a predicate listAllMarks/3 which given a course and evaluation, 
% shows the student number and mark of all students which completed 
% the evaluation. Use setof to achieve the result.
% For example:

%   ?- listAllMarks('CSI2120',midterm(1),L).
%   L = [ (23123, 14), (33333, 25), (88345, 22)].


listAllMarks(Class, Exam, L):- setof((ID,Grade),mark(Class,ID,Exam,Grade),L).





% e) Create a predicate averageMark/3 that computes the average mark of a 
% given evaluation. Hint: Create a list of all marks and create a helper 
% predicate to sum the marks. For example:

% ?- averageMark('CSI2120',midterm(1),A).
% A = 20.333333333333332.




averageMark(Class,Exam,A) :- findall(Grade,mark(Class,_,Exam,Grade),All),
							average(All,A).




average(Mark,Avg) :- length(Mark,Len), 
					sumMark(Mark,Sum), 
					Avg is Sum/Len.

sumMark([],0).
sumMark([H|T],Sum) :- Marks = listAllMarks(Class,Exam,L),			
					sumMark(T,Sum1),
					Sum is H + Sum1.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Q2   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          


%% Question 2. [1.5 marks]
% Write a predicate cleanListDCG/3 which parses a list and returns a 
% new list with the same numbers but all elements that are not a 
% number removed. You must use only DCG notation. Your implementation 
% of cleanListDCG/3 must work correctly when called from cleanList/2.

% Example:
% ?- cleanList([1,2,d,67,3.2,'CSI2120',foo,5],LL).
% LL = [1, 2, 67, 3.2, 5].

cleanList(L,LL) :- cleanListDCG(LL,L,[]),!.


cleanListDCG([]) --> [].
cleanListDCG([X|Y])--> [X], {number(X)}, cleanListDCG(Y).
cleanListDCG(Y) --> [_], cleanListDCG(Y).



%cleanListDCG(LL,[_|T],L):-
%    cleanListDCG(LL,T,L).


%cleanListDCG() :- number(L).
%num([D]) :- number(D).



%cleanListDCG(PT) --> cleanListDCG(_,PT).
%cleanListDCG(L,cleanListDCG(Number)) --> digit(Number).
%cleanListDCG(L) --> digit(Number).

digit(D) --> [D], {D @>= 0, D @=< 99999999},append([D],X,LL).

digit(0) --> [0].
digit(1) --> [1].
digit(2) --> [2].
digit(3) --> [3].
digit(4) --> [4].
digit(5) --> [5].
digit(6) --> [6].
digit(7) --> [7].
digit(8) --> [8].
digit(9) --> [9].

whole_num(N) --> digit(A), whole_num(A,N).
whole_num(N,N) --> [].
whole_num(B,N) --> digit(A), {B1 is B*10 +A}, whole_num(B1,N).






