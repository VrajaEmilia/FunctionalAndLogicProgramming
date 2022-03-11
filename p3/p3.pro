%10.For a list a1...an with integer and distinct numbers, 
%define a predicate to determine all subsets with sum of elements divisible with n.
%subsetsum(l1..ln,C)={ C , n = 0
%                      subsetsum(l2..ln,C+l1)
%
subsetsum([],C,C).
subsetsum([H|T],C,R):-
    C1 is C + H,
    subsetsum(T,C1,R).

%checkDivN(l1..ln,N)={ true, subsetsum(l1...ln) mod N = 0
%                      false, otherwise
checkDivN([H|T],N):-
    subsetsum([H|T],0,R),
    R mod N =:=0.

%subs(l1...ln) = { [], n=0
%                  l1 U subs(l2...ln), n>0
%                  subs(l2...ln)
subs([],[]).
subs([H|T],[H|R]):-
    subs(T,R).
subs([_|T],R):-
    subs(T,R).

onesol(L,N,R):-
    subs(L,R),
    checkDivN(R,N).

allsol(L,N,R):-
    findall(RPartial,onesol(L,N,RPartial),R).
