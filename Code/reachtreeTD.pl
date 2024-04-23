path(x,y).
path(y,z).
path(z,a).
path(z,x).
path(X,X):-
    member(X, [x,y,z,a]).

reachTD(X,X).
reachTD(X,Y):-
    path(X,K),
    reachTD(K,Y).

reachedBU(X,Y):-
    length(X, N),
    closure(X,Y),
    length(Y, N).

reachedBU(X,Y):-
    closure(X,C),
    length(X, N1),
    length(C, N),
    N \== N1,
    reachedBU(C,Y).

closure(X, [(Y,Z)|X]):-
    infer((Y,Z), X, []).

closure(X,X).

infer((Y,Z), [(Y,A)|X], Pop):-
    path(A, Z),
    A \== Z,
    \+ member((Y,Z), Pop),
    \+ member((Y,Z), X).

infer((Y,Z), [A|X], Pop):-
    infer((Y,Z), X, [A|Pop]).
