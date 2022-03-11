% 11.
% a. Write a predicate to substitute an element from a list with another element in the list.
% b. Write a predicate to create the sublist (lm, …, ln) from the list (l1,…, lk).


% substitute(l1...ln, e1, e2) =
%	[], n = 0
%	e2 U substitute_elem(l2...ln, e1, e2), l1 = e1
%	l1 U substitute_elem(l2...ln, e1, e2), otherwise
% substitute(L:list, E1:number, E2:number, R:list)
% substitute(i,i,i,i),(i,i,i,o)

substitute([], _, _, []) :- !.
substitute([H|T], E1, E2, [E2|R]) :- H =:= E1,
    substitute(T, E1, E2, R).
substitute([H|T], E1, E2, [H|R]):-
    substitute(T, E1, E2, R).

%b
c_sublist([],_, _,[]):-!.
c_sublist([H|T],N,M,R) :-
    sublist([H|T],N,M,0,R).

% sublist(l1...lk, m, n, index) =
%	[],k=0 or index > n
%	l1 U sublist(l2...lk, m, n, index + 1), m<index< n
%	sublist(l2...lk, m, n, index + 1), otherwise

% sublist(L:list, M:number, N:number, index:number, R:list)
% sublist(i,i,i,i),(i,i,i,o)


sublist([], _, _, _, []) :-  !.
sublist(_, _, N, INDEX, []) :- INDEX > N, !.
sublist([H|T], M, N, INDEX, [H|R]) :- M =< INDEX, INDEX=< N,
    INDEX2 is INDEX + 1,
    sublist(T, M, N, INDEX2, R), !.
sublist([_|T], M, N, INDEX, R) :-
    INDEX2 is INDEX + 1,
    sublist(T, M, N, INDEX2, R).
