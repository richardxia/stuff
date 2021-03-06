%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Observations
observed_deleterious_count(mother, 1).
observed_deleterious_count(father, 0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (detection_rate = 0.9)
% (prevalence = 2.5e-05)
2.5e-05::deleterious(father, chr_X).
2.5e-05::deleterious(mother, chr_X1).
2.5e-05::deleterious(mother, chr_X2).

0.5::transmitted(father, chr_X); 0.5::transmitted(father, chr_Y).
0.5::transmitted(mother, chr_X1); 0.5::transmitted(mother, chr_X2).

deleterious(mother, chr_X1) :- observed_deleterious_count(mother, Count), Count >= 1.
deleterious(mother, chr_X2) :- observed_deleterious_count(mother, Count), Count >= 2.
deleterious(father, chr_X) :- observed_deleterious_count(father, Count), Count >= 1.

affected :-
  passed_deleterious(mother), (transmitted(father, chr_Y); passed_deleterious(father)).

passed_deleterious(Parent) :-
  (deleterious(Parent, X), transmitted(Parent, X)).

foo :- transmitted(mother, chr_X1), transmitted(mother, chr_X2).
foo2 :- transmitted(father, chr_X), transmitted(father, chr_Y).

query(foo).
query(foo2).
query(passed_deleterious(father)).
query(passed_deleterious(mother)).
query(deleterious(father, chr_Y)).
query(deleterious(father, chr_X)).
query(deleterious(mother, chr_X1)).
query(deleterious(mother, chr_X2)).
query(transmitted(mother, chr_X1)).
query(transmitted(mother, chr_X1)).
query(transmitted(mother, chr_X2)).
query(affected).
