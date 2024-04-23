sym('-').
sym('+').
sym('/').
sym('*').
sym('(').
sym(')').
sym('[').
sym(']').


main(Sent, N):-
    % converts to characters and sends to tokenizer
    atom_chars(Sent, Chars),
    tokenizer(Chars, [], Tokens),
    processing(Tokens, PTokens),
    evaluator(PTokens, N).

tokenizer([], Acc, Acc).
% once everything has been tokenized

tokenizer([C|Chars], Acc, Tokens):-
    % non empty accumulator and character parsed is a symbol
    sym(C),
    append(Acc, [C], NewAcc),
    tokenizer(Chars, NewAcc, Tokens).

tokenizer([C|Chars], Acc, Tokens):-
    % non empty accumulator and character parsed is a digit
    \+ sym(C),
    atom_number(C, X),
    add_number(Acc, X, NewAcc),
    tokenizer(Chars, NewAcc, Tokens).

tokenizer([C|Chars], [], Tokens):-
    % case for empty accumulator
    \+ sym(C),
    atom_number(C, X),
    tokenizer(Chars, [X], Tokens).

add_number([Y], X, [Z]):-
    % if there already is a number in the accumulator
    \+ sym(Y),
    Z is Y*10+X.

add_number([Y], X, [Y,X]):-
    % there is a symbol in the accumulator
    sym(Y).

add_number([H|T], X, [H|U]):-
    % reaching the end
    add_number(T, X, U).


%processing is used to deal with a -- or a +-
processing([], []).

processing(['-', '-'|Tokens], ['+'|NewTokens]):-
    processing(Tokens, NewTokens).

processing(['+','-'|Tokens], ['-'|NewTokens]):-
    processing(Tokens, NewTokens).

processing(['*', '-', X|Tokens], ['*', -X |NewTokens]):-
    processing(Tokens, NewTokens).

processing(['/', '-', X|Tokens], ['/', -X |NewTokens]):-
    processing(Tokens, NewTokens).

processing(['(', '-', X|Tokens], ['/', -X |NewTokens]):-
    processing(Tokens, NewTokens).

processing(['(', X, ')'|Tokens], [X|NewTokens]):-
    processing(Tokens, NewTokens).

processing([T|Tokens], [T|NewTokens]):-
    processing(Tokens, NewTokens).

evaluator(PTokens, PTokens):-
    number(PTokens).

evaluator(['-', PToken2], N):-
    number(PToken2),
    N is ((-1) * Ptoken2).

evaluator(PTokens, N):-
    \+ number(PTokens),
    writeln(PTokens),
    evaluation(PTokens, NewPTokens),
    evaluator(NewPTokens, N).



evaluation([],[]).

evaluation(PTokens, Z):-
    length(PTokens, 1),
    elem_list(PTokens, 0, Z). 

evaluation(PTokens, -Z):-
    length(PTokens, 2),
    elem_list(PTokens, 1, Z). 

evaluation(PTokens, NewPTokens):-
    member('(', PTokens),
    bhandler(PTokens, NewPTokens).

evaluation([X,'-',Y|PTokens], [Z|PTokens]):-
    \+member('(', PTokens),
    \+member('/', PTokens),
    \+member('*', PTokens),
    \+member('+', PTokens),
    Z is X-Y.

evaluation([X,'+',Y|PTokens], [Z|PTokens]):-
    \+member('(', PTokens),
    \+member('/', PTokens),
    \+member('*', PTokens),
    Z is X+Y.

evaluation([X,'*',Y|PTokens], [Z|PTokens]):-
    \+member('(', PTokens),
    \+member('/', PTokens),
    Z is X*Y.

evaluation([X,'/',Y|PTokens], [Z|PTokens]):-
    \+member('(', PTokens),
    Z is X/Y.
    
evaluation([P|PTokens], [P|NewPTokens]):-
    evaluation(PTokens, NewPTokens).

bhandler(['('|PTokens], [N|NewPTokens]):-
    stopper(PTokens, Exp, 1),
    writeln(Exp),
    evaluator(Exp, N),
    replacein(PTokens,NewPTokens, 1).

bhandler([P|PTokens], [P|NewPTokens]) :-
    P \== '(',
    bhandler(PTokens, NewPTokens).

stopper([')'|_], [], 1).
stopper(['('|PTokens], ['('|Exp], C):-
    stopper(PTokens, Exp, C+1).
stopper([')'|PTokens], ['('|Exp], C):-
    stopper(PTokens, Exp, C-1).    
stopper([P|PTokens], [P|Exp], C):-
    stopper(PTokens, Exp, C).

replacein([')'|NewPTokens], NewPTokens, 1).
replacein(['('|PTokens], NewPTokens, C):-
    replacein(PTokens, NewPTokens, C+1).
replacein([')'|PTokens], NewPTokens, C):-
    replacein(PTokens, NewPTokens, C-1).    
replacein([_|PTokens], NewPTokens, C):-
    replacein(PTokens, NewPTokens, C).


elem_list([L|_], 0, L).
elem_list([_|List], N, Elem):-
    elem_list(List, N-1, Elem).


