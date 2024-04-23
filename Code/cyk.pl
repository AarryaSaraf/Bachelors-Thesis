
%taken from Scheiber
senT(I,J,S):-
    member((I,K,np), S),
    member((K, J, vp), S).

nP(I,J,S):-
    det(I,K,S),
    K is I+1,
    no(K,L,S),
    L is K+1,
    member((L, J, optrel), S).

nP(I,J,S):-
    det(I,K,S),
    K is I+1,
    no(K,J,S),
    J is K+1.    

nP(I,J,S):-
    pos(S,I,J,'Trip'),
    J is I+1.

nP(I,J,S):-
    pos(S,I,J,np).

vP(I,J,S):-
    tV(I,K,S),
    K is I+1,
    member((K, J, np), S).

vP(I,J,S):-
    pos(S,I,J,'swings'),
    J is I+1.

vP(I,J,S):-
    pos(S,I,J,vp).

optRel(I,J,S):-
    relPro(I,K,S),
    K is I+1,
    member((K, J, vp), S).

optRel(I,J,S):-
    pos(S,I,J,optrel).

det(I,J,S):-
    pos(S,I,J,'a'),
    J is I+1.

no(I,J,S):-
    pos(S,I,J,'lindy'),
    J is I+1.

tV(I,J,S):-
    pos(S,I,J,'dances'),
    J is I+1.

relPro(I,J,S):-
    pos(S,I,J,'that'),
    J is I+1.

pos([(I, J, S)|_], I, J, S).

pos([(K, _, _)|Atoms], I, J, S):-
    K \== I,
    pos(Atoms, I, J, S).

pos([(_, K, _)|Atoms], I, J, S):-
    K \== J,
    pos(Atoms, I, J, S).

main(X,C,L):-
    length(X, N),
    closure(X,C),
    length(C, N),
    member((0,L,sent),C).

main(X,Y,L):-
    closure(X,C),
    length(X, N1),
    length(C, N),
    N \== N1,
    main(C,Y,L).

closure(X, [(I,J,np)|X]):-
    nP(I,J,X),
    \+ member((I,J,np), X).

closure(X, [(I,J,vp)|X]):-
    vP(I,J,X),
    \+ member((I,J,vp), X).

closure(X, [(I,J,optrel)|X]):-
    optRel(I,J,X),
    \+ member((I,J,optrel), X).

closure(X, [(I,J,sent)|X]):-
    senT(I,J,X),
    \+ member((I,J,sent), X).

closure(X,X).

/*

If you change the nature of inference then the nature of CYK is more free
Just having some program is not the point
what we would like to do is to take the grammar for a CFG and add DFS = RD
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" BUPS = CKY


The project isnt about writing these 2 parsers but also the 2 approaches 


simple prog to convert between the two CFG representations

Future work - Earley algorithm is a mixture of both and its not clear how we can mix these two 

*/