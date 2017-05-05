% Top Level
agent:-
	perceive(Percepts),
	action(Percepts).

/* At the minute:
 * Prompts...
 * Reads input...
 * writes the output...*/
perceive(_):-
	write('|Enter Command|-> '),
	read(Input).

action(Input):-
	sentence(Input, Output).

% Sentence S -> NP VP
sentence(Sentence, sentence(np(Noun_Phrase), vp(Verb_Phrase))):-
	np(Sentence,Noun_Phrase,Rem),
	vp(Rem,Verb_Phrase).

% Sentence S -> VP
sentence(Sentence, vp(Verb_Phrase)):-
	vp(Rem,Verb_Phrase).

% NP -> Det NP2
np([X|T],np(det(X),NP2),Rem):-
	det(X),
	np2(T,NP2,Rem).

% NP -> NP2
np(Sentence,Parse,Rem):-
	np2(Sentence,Parse,Rem).

% NP -> NP PP
np(Sentence,np(NP,PP),Rem):-
	/* e.g. Jane on the dance_floor */
	np(Sentence,NP,Rem1),
	pp(Rem1,PP,Rem).

% NP2 -> Noun
np2([H|T],np2(noun(H)),T):-
	noun(H).

% NP2 -> Adj NP2
np2([H|T],np2(adj(H),Rest),Rem):-
	adj(H),np2(T,Rest,Rem).

% PP -> Prep NP
pp([H|T],pp(prep(H),Parse),Rem):-
	prep(H),
	np(T,Parse,Rem).

% VP -> Verb
vp([H|[]],verb(H)):-
	verb(H).

% VP -> Verb NP
vp([H|Rest],vp(verb(H),RestParsed)):-
	verb(H),
	np().

%  VP -> VP PP
vp([H|Rest],vp(verb(H),RestParsed)):-
	verb(H),
	pp().

% Rules Given
rule(np2(adj(very),np2(adj(short),np2(noun(command)))),listing,
     np2(adj(current),np2(noun(directory))),write('ls')).

rule(np2(adj(current), np2(noun(folder))),viewed,
     np2(adj(more),np(adj(fine),np2(noun(detail)))),write('ls –la')).

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



