% Top Level
agent:-
	perceive(Percepts),
	action(Percepts).

/* At the minute:
 * Prompts...
 * Reads input...
 * writes the output...*/
perceive(Input):-
	write('|Enter Command|-> '),
	read(Input).

action(Input):-
	sentence(Input, Output),
	write(Output), nl,
	rulesBits(Output, X, Y, Z).

% Sentence S -> NP VP
sentence(Sentence, sentence(np(Noun_Phrase), vp(Verb_Phrase))):-
	np(Sentence,Noun_Phrase,Rem),
	vp(Rem,Verb_Phrase).

% Sentence S -> VP
sentence(Sentence, vp(Verb_Phrase)):-
	vp(Rem,Verb_Phrase).

% NP -> Det NP2
np([H|T],np(det(H),NP2),Rem):-
	det(H),
	np2(T,NP2,Rem).

% NP -> NP2
np(Sentence,Parse,Rem):-
	np2(Sentence,Parse,Rem).

% NP -> NP PP
np(Sentence,np(NP,PP),Rem):-
	/* e.g. Jane on the dance_floor */
	np(Sentence,NP,Rem1),
	prep(Rem1,PP,Rem).

% NP2 -> Noun
np2([H|T],np2(noun(H)),T):-
	noun(H).

% NP2 -> Adj NP2
np2([H|T],np2(adj(H),Rest),Rem):-
	adj(H),
	np2(T,Rest,Rem).

% PP -> Prep NP
prep([H|T],prep(pp(H),Parse),Rem):-
	pp(H),
	np(T,Parse,Rem).

% VP -> Verb
vp([H|[]],verb(H)):-
	verb(H).

%  VP -> VP PP
vp([H|T],vp(verb(H),RestParsed)):-
	verb(H),
	prep(T, RestParsed, _).

% VP -> Verb NP
vp([H|T],vp(verb(H),RestParsed)):-
	verb(H),
	np(T, RestParsed, _).

% Rules Given
rule(np2(adj(very),np2(adj(short),np2(noun(command)))),listing,
     np2(adj(current),np2(noun(directory))),write('ls')).

rule(np2(adj(current), np2(noun(directory))),viewed,
     np2(adj(more),np(adj(fine),np2(noun(detail)))),write('ls -la')).

rule(np2(noun(command)), moving, np2(adj(higher), np2(noun(directory))),
     write('cd ..')).

rule(np2(noun(command)), moves, np2(noun(parent), np2(noun(directory))),
	write('cd ..')).

rule(np2(noun(command)), prints, np2(adj(current), np2(noun(directory))),
     write('pwd')).

rule(np2(noun(command)), types, np2(noun(file), np2(noun('08226txt'))),
     write('cat 08226.txt')).

rulesBits(sentence(np(_, X), vp(verb(Y), np(_, Z))), X, Y, Z):-
	write('Success!').

% Grammar Facts
det(a).
det(the).

adj(short).
adj(current).
adj(more).
adj(fine).
adj(higher).
adj(very).

noun(command).
noun(directory).
noun(detail).
noun(parent).
noun(file).
noun('08226txt').

verb(listing).
verb(viewed).
verb(moving).
verb(moves).
verb(prints).
verb(types).

pp(in).
pp(to).
pp(and).
















