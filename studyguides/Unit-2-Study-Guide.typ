#import "../wdf.typ": *


#show: template.with(
  title: [
    Logical Agents
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: none,
  bib: none,
  serif: true,
  exam: false,
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]


= Part : Knowledge Based Agents
Q: What is a knowledge base? What is a “sentence” in this context?
#v(1.5cm)


Q: What is the difference between knowledge level and implementation level? Why is this distinction important?
#v(1.5cm)

Q: Explain the difference between the declarative approach vs the procedural approach to building agents:
#v(2cm)

Q: Using the PEAP/PEAS model, describe the environment of a student in CSC480. #sidenote[AIMA Chapter 7.4 Page 228]
(Performance measure, Environment, Actions/Actuators, Preception/Sensors)
#v(4cm)


Q: Classify the student's environment in CSC480 using standard environment properties (ie: deterministic vs stochastic, fully vs partially observable, episodic vs sequential... etc).
#v(2cm)



= Part : Propositional Logic
Q: Define Propositional Logic in your own words. #sidenote[AIMA Chapter 7.4 Page 235]
#v(2cm)


Q:  Explain Syntax Semantics and Models:
#v(3cm)


Q: What are the five common logical connectives uses in complex sentences and what do they mean?

#v(3cm)


Q: Fill out this truth table:

#table(
  columns: 8,
  align: (left, center, center, center, center, center, center, center),
  stroke: 0.5pt,

  [*P*], [*Q*], [*R*], [*$not$ P*], [*P $or$ Q*], [*Q $and$ R*], [*$not$(P $and$ R)*], [*(P $or$ Q) $and$ $not$ R*],

  [True],  [False], [True],      [],      [],      [],      [],      [],
  [False], [],      [True],  [],      [False], [],      [],      [],
  [],      [True],  [False], [],      [],      [False], [],      [True],
  [],      [],      [True],  [True],  [],      [True],  [],      [],
  [True],  [],      [],      [],      [True],  [True],      [False], [],
  [],      [False], [False], [],      [],      [False], [True],  [],
  [False], [True],  [],      [],      [],      [],      [],      [True],
  [],      [],      [True],  [],      [True],  [],      [True],  [False],
)


Q: Why is the statement “P $=>$ Q” true when P is false? Then give an example in your own words. #sidenote("Think of the example we talked through during lecture...")

#v(4cm)


// Q Explain the difference between model checking and theorem proving. When might one be more efficient than the other?
// #v(3cm) 


Q: What is _Modus Ponens_? Give an example.
#v(3cm)

#pagebreak()

= Part : Conjunctive Normal Form
For the Folllowing questions (XX-XX) convert them into CNF.

Q: $(A or not B) <=> C$
#v(3cm)

Q: $not (A and B) => (not B or C)$

#v(3cm)

Q: $((A and B ) or C) => (not B and not (C or A))$
#v(3cm)

= Part : Logical Justification
For the Folllowing questions (XX-XX) provide justification for whether each of the following are correct or incorrect.

Q: $(X and Y)  models Y$
#v(3cm)

Q: $(not X and Y) or X  models X or Y$
#v(3cm)


Q: $not (X and Y) or (Z and not Y) models not X or Y$
#v(3cm)


Q: $not X or (Y and Z)  models (X => Y)$



// = Part : Inference

// Q: Define soundness and completeness. Why are both important?
// #v(3cm)


// Q: What is And-Elimination?
// #v(2cm)

#pagebreak()
= Part : First-Order Logic

Q: What is an interpretation (model) in First-Order Logic? #sidenote[AIMA Chapter 8.2 Page 274]
#v(2.5cm)

Q: What does it mean for a FOL formula to be valid? Satisfiable? Unsatisfiabl? How do these concepts compare to the propositional logic versions?
#v(2.5cm)

Q: Consider the domain $D = {1, 2, 3}$ with interpretation $I$ where:
- $"Even" = {2}$, $"Prime" = {2, 3}$
- $"Less"(x, y)$ is true iff $x < y$ 

Evaluate each sentence as true or false under $I$, and briefly justify:

(a) $forall x ("Even"(x) => "Prime"(x))$
#v(1.2cm)
(b) $forall x ("Prime"(x) => "Even"(x))$
#v(1.2cm)
(c) $exists x ("Even"(x) and "Prime"(x))$
#v(1.2cm)
(d) $forall x exists y "Less"(x, y)$
#v(1.2cm)
(e) $exists x forall y (x eq.not y => "Less"(x, y))$
#v(1.2cm)

#pagebreak()

Q: For each sentence below, decide if it is valid, satisfiable (but not valid), or unsatisfiable. Justify each answer, for satisfiable but not valid sentences, give both a model where it is true and one where it is false.

(a) $forall x P(x) => exists x P(x)$
#v(2cm)
(b) $exists x P(x) => forall x P(x)$
#v(2cm)
(c) $(forall x P(x)) => (forall x (P(x) or Q(x)))$
#v(2cm)
(d) $forall x exists y F(x, y) => exists y forall x F(x, y)$
#v(2cm)

Q: For each pair of sentences, determine whether they are logically equivalent. If not, clearly describe the difference in meaning and give a concrete counterexample interpretation.

(a) $forall x exists y F(x, y)$ #h(1em) vs. #h(1em) $exists y forall x F(x, y)$
#v(2.5cm)
(b) $not forall x P(x)$ #h(1em) vs. #h(1em) $forall x not P(x)$
#v(2.5cm)
(c) $forall x (P(x) => Q(x))$ #h(1em) vs. #h(1em) $(forall x P(x)) => (forall x Q(x))$
#v(2.5cm)

Q: Consider the following knowledge base:
+ $forall x ("CS_Student"(x) => "TakesExams"(x))$
+ $forall x ("TakesExams"(x) and "StudiesHard"(x) => "Passes"(x))$
+ $forall x ("Passes"(x) => "Happy"(x))$
+ $"CS_Student"("John")$
+ $not "Happy"("John")$

For each of the following, determine whether it is entailed by the KB. Show your chain of reasoning.

(a) $"TakesExams"("John")$
#v(1.5cm)
(b) $not "StudiesHard"("John")$
#v(1.5cm)
(c) $exists x not "Happy"(x)$
#v(1.5cm)
(d) $forall x "CS_Student"(x)$
#v(1.5cm)
(e) $exists x ("CS_Student"(x) and not "StudiesHard"(x))$
#v(1.5cm)

#pagebreak()
$models$
$tack$
