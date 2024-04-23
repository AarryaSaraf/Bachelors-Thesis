/*
Prolog program to take rules in Greiback Normal Form and check whether a given string follows that
*/


/*
rules are of the Form 
n,c,L
where 
n is the number of the rule 
c is the terminal symbol
L is list of numbers associated to the non terminal symbols (possibly empty)

*/

%---------------------- STRICT------------------------------------------------------------- 
/*
rules for binary numbers
rule(1, '0', [1]).
rule(1, '1', [1]).
rule(1, '0', []).
rule(1, '1', []).
*/

/* 
well formed brackets 

S
rule(1, '(', [2,1]).
rule(1, '(', [2]).
rule(1, '(', [1,2]).
rule(1, '(', [1,2,1]).
rule(1, '[', [3,1]).
rule(1, '[', [3]).
rule(1, '[', [1,3]).
rule(1, '[', [1,3,1]).

R1
rule(2, ')', []).

R2
rule(3, ']', []).
*/

/*
Even number of 1s

S
rule(1, '0', [1]).
rule(1, '1', [3]).
rule(1, '1', [4,3]).

B
rule(2, '1', []).

C
rule(3, '1', [1]).
rule(3, '1', [4,1]).
rule(3, '1', [4]).
rule(3, '1', []).
rule(3, '0', [2,4]).
rule(3, '0', [4,2]).
rule(3, '0', [4,2,4]).
rule(3, '0', [2]).
rule(3, '0', [2,4,1]).
rule(3, '0', [4,2,1]).
rule(3, '0', [4,2,4,1]).
rule(3, '0', [2,1]).

Z
rule(4, '0', [4]).
rule(4, '0', []).
*/

/*
Strings ending in 0011

S
rule(1, '0', [2,3]).
rule(1, '1', [2,3]).
rule(1, '0', [4,5,5]).

A
rule(2, '0', [2]).
rule(2, '1', [2]).
rule(2, '0', []).
rule(2, '1', []).

B
rule(3, '0', [4,5,5]).

Z
rule(4, '0', []).

O
rule(5, '1', []).

*/
%----------------------NON-STRICT---------------------------------------------------------------------

/*
rules for binary numbers

S
rule(1, '0', [1]).
rule(1, '1', [1]).
rule(1, '', []).
*/

/* 
well formed brackets 

S
rule(1, '(', [1,2,1]).
rule(1, '[', [1,3,1]).
rule(1, '', []).

R1
rule(2, ')', []).

R2
rule(3, ']', []).
*/

/*
Even number of 1s

S
rule(1, '0', [1]).
rule(1, '1', [4,3]).

B
rule(2, '1', []).

C
rule(3, '1', [4,1]).
rule(3, '1', [4]).
rule(3, '0', [4,2,4]).
rule(3, '0', [4,2,4,1]).

Z
rule(4, '0', [4]).
rule(4, '', []).
*/

/*
Strings ending in 0011

S
rule(1, '0', [2,3]).
rule(1, '1', [2,3]).

A
rule(2, '0', [2]).
rule(2, '1', [2]).
rule(2, '', []).

B
rule(3, '0', [4,5,5]).

Z
rule(4, '0', []).

O
rule(5, '1', []).
*/
%----------------------CODE---------------------------------------------------------------------------

rule(1, '(', [2,1]).
rule(1, '(', [2]).
rule(1, '(', [1,2]).
rule(1, '(', [1,2,1]).
rule(1, '[', [3,1]).
rule(1, '[', [3]).
rule(1, '[', [1,3]).
rule(1, '[', [1,3,1]).

rule(2, ')', []).

rule(3, ']', []).

%pretty printer for rules
pp_rule(N,C,Ans):-
writeln('Rule Number ' = N),
writeln('Rule constant ' = C),
writeln('Rule non terminal ' = Ans),
writeln('').

%base case
parse([], []).

%parses according to the rules in the stack
parse(Str, [L, M|Ls]):-
    rule(M, A, _,),
    member(A, Str),
    splitter(Str, S1, S2, A),
    parse(S1, [L]),
    parse(S2, [M|Ls]).

parse([C|Str], [L]):-
    rule(L, C, Li),
    parse(Str, Li).

% main function
main(X):-
    atom_chars(X,Y),
    parse(Y, [1]),
    writeln('Parsable').

splitter([Split|Str], [], [Split|Str], Split).

splitter([S|Str], [S|Subone], Subtwo, Split):-
    splitter(Str, Subone, Subtwo, Split).

