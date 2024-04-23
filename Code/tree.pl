
depth(S, 0, Ans):-
    rbracket(S,Ans).
depth(S, D, Ans):-
    layer1(S,S1),
    D2 is D-1,
    \+ member(',', S1),
    depth(S1,D2,Ans).
depth(S, D, Ans):-
    layer1(S,S1),
    D2 is D-1,
    member(',', S1),
    listmaker(S1, L),
    writeln(L),
    depth_list(L, D2, Ans).

depth_list([], _, []).
depth_list([L|Ls], D, [A|Ans]):-
    depth(L, D, A),
    depth_list(Ls, D, Ans).

listmaker([], []).
listmaker(S, [S1|L]):-
    firststring(S, S1),
    writeln(S1),
    append(S1, [','|S2], S),
    listmaker(S2, L).
listmaker(S, [S]):-
    firststring(S, S).

firststring([], []).
firststring([','|_], []).
firststring([C|Ch], [C|Ans]):-
    C \== ',',
    firststring(Ch, Ans).

layer1([_|Ss], Ans):-
    layer2(Ss, Ans).
    
layer2(['('|Ch], Ans):-
    butlast(Ch, Ans).

butlast([')'], []).
butlast([C|Ch], [C|Ans]):-
    length(Ch, N),
    N>0,
    butlast(Ch, Ans).

rbracket([], []).
rbracket([C|Cs],[C|Ans]):-
    C \== '(',
    C \==')',
    C \== ',',
    writeln([C|Cs]),
    rbracket(Cs, Ans).

rbracket(['('|Cs],Ans):-
    rbracket(Cs, Ans).

rbracket([')'|Cs],Ans):-
    rbracket(Cs, Ans).

rbracket([','|Cs],Ans):-
    rbracket(Cs, Ans).

main(S, D, Ans):-
    atom_chars(S,X),
    depth(X, D, Ans).

/*
Tue 19 2 pm 

Tree program 
*/