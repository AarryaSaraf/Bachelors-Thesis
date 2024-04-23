join([], L, L).
join([X|K], L, M):- 
    member(X, L), 
    !,
    join(K,L,M).
join([X|K],L,[X|M]) :- 
    join(K,L,M).

subset([],_).
subset([X|L],K) :- 
    member(X,K), 
    subset(L,K).

rule(node(a), []).
rule(node(b), []).
rule(node(c), []).
rule(node(d), []).
rule(node(e), []).

rule(adj(a,b), []).
rule(adj(b,c), []).
rule(adj(a,d), []).
rule(adj(c,e), []).

rule(path(X,X),[node(X)]).
rule(path(X,Y),[adj(X,Z), path(Z,Y)]).

reachBU(X,Y):-
    length(X, N),
    fchain(X,Y),
    length(Y, N).

reachedBU(X,Y):-
    fchain(X,C),
    length(X, N1),
    length(C, N),
    N \== N1,
    reachedBU(C,Y).

fchain(In, Out):-
    bagof(Atom,Body^(rule(Atom,Body),subset(Body,In)),Conseq),
    join(Conseq, In, Out).


