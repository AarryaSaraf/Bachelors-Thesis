
rule(1, '(', [2,1]).
rule(1, '(', [2]).
rule(1, '(', [1,2]).
rule(1, '(', [1,2,1]).

rule(2, ')', []).


%pretty printer for rules
pp_rule(N,C,Ans):-
writeln('Rule Number ' = N),
writeln('Rule constant ' = C),
writeln('Rule non terminal ' = Ans),
writeln('').

%base case
parse_rule([], '').

%parses according to the rules in the stack
parse_rule(['('|Str], a(X,Y)):-
    parse_subword([2], Str, NParse1, Parse1),
    parse_subword([1], NParse1, [], NParse1),
    parse_rule(Parse1, X),
    parse_rule(NParse1, Y).

parse_rule(['('|Str], b(X)):-
    parse_subword([2], Str, [], Str),
    parse_rule(Str, X).

parse_rule(['('|Str], c(X,Y)):-
    parse_subword([1], Str, NParse1, Parse1),
    parse_subword([2], NParse1, [], NParse1),
    parse_rule(Parse1, X),
    parse_rule(NParse1, Y).

parse_rule(['('|Str], d(X,Y,Z)):-
    parse_subword([1], Str, NParse1, Parse1),
    parse_subword([2], NParse1, NParse2, Parse2),
    parse_subword([1], NParse2, [], NParse2),
    parse_rule(Parse1, X),
    parse_rule(Parse2, Y),
    parse_rule(NParse2, Z).

parse_rule([')'], e).



% main function
main(X, ParseTree):-
    atom_chars(X,Y),
    parse_rule(Y, ParseTree).


parse_subword([], Input, Input, []).
parse_subword([R|Rules], [I|Input], Output, [I|Parsed]):-
    rule(R, I, NTs),
    append(NTs, Rules, NewRules),
    parse_subword(NewRules, Input, Output, Parsed).

