#import "../../wdf.typ": *


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
#let answer(body) = text(fill: red, body)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]


= Part : Knowledge Based Agents
Q: What is a knowledge base? What is a “sentence” in this context?
#v(1.5cm)


Q: What is the difference between knowledge level and implementation level? Why is this distinction important?
#v(1.5cm)

Q: Explain the difference between the declarative approach vs the procedural approach to building agents:
#v(2cm)

Q: Using the PEAS model, describe the environment of a student in CSC480.
(Performance measure, Environment, Actuators, Sensors)
#v(4cm)


Q: Classify the student’s environment in CSC480 using standard environment properties (ie: deterministic vs stochastic, fully vs partially observable, episodic vs sequential... etc).
#v(2cm)


#sidenote("Questions 4 & 5 are mostly review from the last unit and wont be on this exam")
= Part : Propositional Logic
Q: Define Propositional Logic in your own words. #sidenote[AIMA Chapter 7.4 Page 235]
#v(2cm)

Q: What are the five common logical connectives uses in complex sentences and what do they mean?

#v(3cm)


Q: Fill out this truth table:

#table(
  columns: 8,
  align: (left, center, center, center, center, center, center, center),
  stroke: 0.5pt,

  [*P*], [*Q*], [*R*], [*$not$ P*], [*P $or$ Q*], [*Q $and$ R*], [*$not$(P $and$ R)*], [*(P $or$ Q) $and$ $not$ R*],

  [True],  [False], [True],  [#answer("False")], [#answer("True")],  [#answer("False")], [#answer("False")], [#answer("False")],
  [False], [#answer("False")], [True], [#answer("True")], [False], [#answer("False")], [#answer("True")], [#answer("False")],
  [#answer("False")], [True], [False], [#answer("True")], [#answer("True")], [False], [#answer("True")], [True],
  [#answer("False")], [#answer("True")], [True], [True], [#answer("True")], [True], [#answer("True")], [#answer("False")],

  [True], [#answer("True")], [#answer("True")], [#answer("False")], [True], [True], [False], [#answer("False")],

  [#answer("True")], [False], [False], [#answer("False")], [#answer("True")], [False], [True], [#answer("True")],
  [False], [True], [#answer("False")], [#answer("True")], [#answer("True")], [#answer("False")], [#answer("True")], [True],
  [#answer("False")], [#answer("False")], [True], [#answer("True")], [True], [#answer("False")], [True], [False],
)

Q: Why is the statement “P $=>$ Q” true when P is false? Then give an example in your own words. #sidenote("Think of the example we talked through during lecture...")

#v(4cm)

#pagebreak()

= Part : Logic
For the Folllowing questions (XX-XX) provide justification for whether each of the following are correct or incorrect.

Q: $(X and Y)  models Y$

Q: $(not X and Y) or X  models X or Y$


Q: $not (X and Y) or (Z and not Y) models not X or Y$


Q: $not X or (Y and Z)  models (X => Y)$



= Part : Inference

Q: Define soundness and completeness. Why are both important?
#v(3cm)

Q Explain the difference between model checking and theorem proving. When might one be more efficient than the other?
#v(3cm) 


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

#answer[See the textbook]

Q: What does it mean for a FOL formula to be valid? Satisfiable? Unsatisfiabl? How do these concepts compare to the propositional logic versions?

#answer[A First Order Logic formula is valid (a tautology) if it is true under every possible interpretation. It is satisfiable if there exists at least one interpretation that makes it true. It is unsatisfiable (a contradiction) if no interpretation makes it true. These are the same as the propositional definitions. The difference is that propositional models just assign T/F to symbols, while FOL interpretations additionally fix a domain and predicate extensions (so the the space of models is much larger).
]

Q: Consider the domain $D = {1, 2, 3}$ with interpretation $I$ where:
- $"Even" = {2}$, $"Prime" = {2, 3}$
- $"Less"(x, y)$ is true iff $x < y$ 

Evaluate each sentence as true or false under $I$, and briefly justify:

(a) $forall x ("Even"(x) => "Prime"(x))$

#answer[TRUE. The only element where $"Even"(x)$ holds is $x=2$, and $"Prime"(2)$ is also true. For $x=1$ and $x=3$, the "Even"(x) is false, making the implication vacuously true.]

(b) $forall x ("Prime"(x) => "Even"(x))$

#answer[FALSE. Consider: $x = 3$. $"Prime"(3) = T$ but $"Even"(3) = F$, so $T => F = F$.]

(c) $exists x ("Even"(x) and "Prime"(x))$

#answer[TRUE. Witness: $x = 2$. $"Even"(2) = T$ and $"Prime"(2) = T$.]

(d) $forall x exists y "Less"(x, y)$

#answer[FALSE. Counterexample: $x = 3$. There is no $y in {1,2,3}$ with $3 < y$, so no witness exists for $x = 3$.]

(e) $exists x forall y (x eq.not y => "Less"(x, y))$

#answer[
TRUE. Consider: $x = 1$. For $y = 2$: $1 eq.not 2$ and $"Less"(1, 2) = T$. For $y = 3$: $1 eq.not 3$ and $"Less"(1, 3) = T$.]

#pagebreak()

Q: For each sentence below, decide if it is valid, satisfiable (but not valid), or unsatisfiable. Justify each answer, for satisfiable but not valid sentences, give both a model where it is true and one where it is false.

(a) $forall x P(x) => exists x P(x)$

#answer[Valid. If $P$ holds for every element in the domain, then trivially at least one element satisfies $P$ (assuming a non-empty domain).]

(b) $exists x P(x) => forall x P(x)$

#answer[Satisfiable but not valid. 

True in: $D = {a}$, $P = {a}$. Then both sides are true.

False in: $D = {a, b}$, $P = {a}$. $exists x P(x) = T$ (witness $a$), but $forall x P(x) = F$ ($P(b)$ is false). So $T => F = F$.]

(c) $(forall x P(x)) => (forall x (P(x) or Q(x)))$

#answer[Valid. If $P(x)$ holds for every $x$, then $P(x) or Q(x)$ also holds for every $x$, since $P(x)$ is already sufficient.]

(d) $forall x exists y F(x, y) => exists y forall x F(x, y)$

#answer[Satisfiable but not valid.

Think of $F(x,y)$ as "x has y as a best friend." The left side says _"everyone has a best friend"_ , each person just needs one, and it can be a different person for each. The right side says _"there is one person who is everyone's best friend"_, a single universal friend for the whole group. Those are very different claims.

True: one-person domain $D = {a}$, $F = {chevron.l a, a chevron.r}$ ($a$ is their own best friend). With only one person, both sides collapse to the same thing. $T => T = T$.

False: $D = {a, b}$, $F = {chevron.l a,a chevron.r, chevron.l b,b chevron.r}$, everyone is their own best friend, and only their own. LHS: $a$ has $a$, $b$ has $b$, everyone has someone, so LHS is true. RHS: is there one person that both $a$ and $b$ call their best friend? $a$ only likes $a$, so $b$ doesn't count. $b$ only likes $b$, so $a$ doesn't count. No universal friend exists, so RHS is false. $T => F = F$.

In this example _friend_ is just a stand in for some nebulous predicate/relation that could mean anything, the important bit here is the mapping.
]

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
