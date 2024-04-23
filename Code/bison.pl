rule(1, '(', [2,1], a).
rule(1, '(', [2], b).
rule(1, '(', [1,2], c).
rule(1, '(', [1,2,1], d).

rule(2, ')', [], e).


main():-
    writeln('main(X, ParseTree):-'),
    writeln('   atom_chars(X,Y),'),
    writeln('   parse_rule(Y, ParseTree).'),
    writeln(''),
    writeln('parse_subword([], Input, Input, []).'),
    writeln('parse_subword([R|Rules], [I|Input], Output, [I|Parsed]):-'),
    writeln('   rule(R, I, NTs),'),
    writeln('   append(NTs, Rules, NewRules),'),
    writeln('   parse_subword(NewRules, Input, Output, Parsed).'),
    writeln(''),
    rule(_,B,C,D),
    rulemaker(B, C, D).

rulemaker(B,[],D):-
    write('parse_rule([\''),
    write(B),
    write('\'],'),
    write(D),
    writeln(').').

rulemaker(B, C, D):-
    length(C, A),
    A>0,
    write('parse_rule([\''),
    write(B),
    write('\'|Str],'),
    write(D),
    write('('),
    write_letters(C, 65, Output),
    writeln(')):-'),
    write_subwords(C, 1),
    write_parse(1, Output).



write_letters([_],Num, [Char]):-
    char_code(Char, Num),
    write(Char).
write_letters([_|Ch], Num, [Char|Output]):-
    length(Ch, A),
    A>0,
    char_code(Char, Num),
    write(Char),
    write(','),
    Num2 is Num+1,
    write_letters(Ch, Num2, Output).

write_subwords([C], N):-
    write('    parse_subword(['),
    write(C),
    write('], '),
    write('NParse'),
    N2 is N-1,
    write(N2),
    write(', [], '),
    write('NParse'),
    write(N2),
    writeln('),').

write_subwords([C|Ch], 1):-
    length(Ch, A),
    A>0,
    write('    parse_subword(['),
    write(C),
    writeln('], Str, NParse1, Parse1),'),
    write_subwords(Ch, 2).

write_subwords([C|Ch],N):-
    N \==1,
    length(Ch, A),
    A>0,
    write('    parse_subword(['),
    write(C),
    write('], '),
    write('NParse'),
    N2 is N-1,
    write(N2),
    write(', NParse'),
    write(N),
    write(', '),
    write('Parse'),
    write(N),
    writeln('),'),
    N3 is N+1,
    write_subwords(Ch, N3).

write_parse(N, [O]):-
    write('    parse_rule(NParse'),
    N2 is N-1,
    write(N2),
    write(', '),
    write(O),
    writeln(').').

write_parse(N, [O|Output]):-
    length(Output, A),
    A>0,
    write('    parse_rule(Parse'),
    write(N),
    write(', '),
    write(O),
    writeln('),'),
    N2 is N+1,
    write_parse(N2, Output).


