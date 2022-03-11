%4
%a. Write a predicate to determine the sum of two numbers written in list representation.
%b. For a heterogeneous list, formed from integer numbers and list of digits, write a predicate to 
%compute the sum of all numbers represented as sublists.Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].


%a
%get_nr_rec(l1..ln,C)=
%               C, n =0
%               0, l1>9
%               get_nr_rec(l1..ln,C*10+l1)
get_nr_rec([],C,C).
get_nr_rec([H|_],_,0):- H>9.
get_nr_rec([H|T],C,R):-
    C1 is C*10+H,
    get_nr_rec(T,C1,R).

get_nr([],0).
get_nr([H|T],R):-
    get_nr_rec([H|T],0,R).

%add_2(x,y) =
%             x+y
add_2(X,Y,S):-
    S is X + Y.

%sum_of_two_lists(l1...ln,l1...lm)=
%                                    0, n=0 and m=0
%                                    get_nr(l1..ln), m = 0
%                                    get_nr(l1..lm), n =0
%                                    get_nr(l1..ln) + get_nr(l1..lm),
%                                    otherwise
sum_of_two_lists([],[],0).
sum_of_two_lists([H|T],[],R):-
    get_nr([H|T],R).
sum_of_two_lists([],[H|T],R):-
    get_nr([H|T],R).
sum_of_two_lists([H|T],[H2|T2],R):-
    get_nr([H|T],R1),
    get_nr([H2|T2],R2),
    add_2(R1,R2,R).

%b
%sum_susblist(l1..ln,C) =
%                         C, n = 0
%                         sum_sublist(l2..ln,C+get_nr(l1)), if l1 = list
%                         sum_sublist(l2..ln,C),otherwise
sum_sublist([],C,C).
sum_sublist([H|T],C,R):-is_list(H),
    get_nr(H,NR),
    C1 is C+NR,
    sum_sublist(T,C1,R),!.
sum_sublist([_|T],C,R):-
    sum_sublist(T,C,R).

%create_list(nr)=
%                 [], if nr = 0
%                 (nr mod 10) U create_list(nr div 10), otherwise
create_list(0,[]).
create_list(NR,[A|R]):-
    NR1 is NR div 10,
    A is NR mod 10,
    create_list(NR1,R).

%reverse_list(l1...ln,C) =
%                          [] , n=0
%                          l1 U reverse_list(l1..ln,C)
reverse_list([], C, C).
reverse_list([H|T],C,R) :-
        reverse_list(T,[H|C],R).
%res_b(l1..ln) =
%                [], n = 0
%                reverse_list(create_list(sum_sublist(l1...ln,c=0))),
%                otherwise
res_b([],[]).
res_b([H|T],R):-
    sum_sublist([H|T],0,NR),
    create_list(NR,L),
    reverse_list(L,[],R).















