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
Q1: What is a knowledge base? What is a “sentence” in this context?  #sidenote[AIMA Chapter 7.1 Page 227]

#answer[See the textbook]

Q2: What is the difference between knowledge level and implementation level? Why is this distinction important?#sidenote[AIMA Chapter 7.1 Page 228]

#answer[See the textbook]

Q3: Explain the difference between the declarative approach vs the procedural approach to building agents:#sidenote[AIMA Chapter 7.1 Page 228]

#answer[See the textbook]

Q4: Using the PEAS model, describe the environment of a student in CSC480.
(Performance measure, Environment, Actuators, Sensors)

#answer[This is review...]


Q5: Classify the student’s environment in CSC480 using standard environment properties (ie: deterministic vs stochastic, fully vs partially observable, episodic vs sequential... etc).

#answer[This is review...]


#sidenote("Questions 4 & 5 are mostly review from the last unit and wont be on this exam")

#pagebreak()

= Part : Propositional Logic
Q6: Define Propositional Logic in your own words. #sidenote[AIMA Chapter 7.4 Page 235]

#answer[See the textbook]

Q7:  Explain Syntax Semantics and Models:

#answer[
  Syntax: The set of sentences allowed within the formal system

  Semantics: The definition of truth in a logical system, generally as _correspondence_ of logical syntax sentences with _possible worlds_ and their properties.

  Model: An instance of a world
]

Q8: What are the five common logical connectives uses in complex sentences and what do they mean? #sidenote[AIMA Chapter 7.4.1 Page 235]

#answer[See the textbook]


Q9: Fill out this truth table:

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
#answer[In some sections of this true table any value could be permitted.]

Q10: Why is the statement “P $=>$ Q” true when P is false? Then give an example in your own words. #sidenote("Think of the example we talked through during lecture...")

#answer[
  In propositional logic, $P => Q$ is defined as a _material conditional_: it is only false when P is true and Q is false. When P is false, the implication is vacuously true #sidenote[The word vacuously will come up quite often it just means since the premise P is false the claim is if little value, but nevertheless inherently true.], so the statement makes no claim about what happens when P is false, so it cannot be violated.

  Consider: "If it is smoking, then there is fire" ($"Smoke" => "Fire"$). Think of this claim like a promise. If there is _no_ smoke, the promise is not broken no matter what. There for you never got to the condition that triggers the commitment. The only way to prove the promise wrong is to find smoke with no fire.
]

#v(2cm)

Q11: What is _Modus Ponens_? Give an example.

#answer[
  Modus Ponens is a rule of inference: 
  
  Given that $P => Q$ is true, and that $P$ is true, we can conclude $Q$.

  $ (P => Q) and P tack.r Q $

  Consider:
  - "If it is raining, the ground is wet" ($"Rain" => "WetGround"$)
  - "It is raining" ($"Rain"$)
  - Therefore: "The ground is wet" ($"WetGround"$)
]

#pagebreak()


= Part : Conjunctive Normal Form
For the Folllowing questions (12-14) convert them into CNF.

Q12: $(A or not B) <=> C$

#answer[
  eliminate biconditional:

  $((A or not B) => C) and (C => (A or not B)) $

  eliminate implications:

  $(not(A or not B) or C) and (not C or A or not B) $

  Push negations inward (de morgs):

  $((not A and B) or C) and (not C or A or not B) $

  distribute OR over AND on the left conjunct:

  $(not A or C) and (B or C) and (not C or A or not B) $
]

Q13: $not (A and B) => (not B or C)$

#answer[
  Eliminate implication:
  
  $not(not(A and B)) or (not B or C) $

  $= (A and B) or not B or C $

  dsistribute OR over AND:
  
  $(A or not B or C) and (B or not B or C) $

  The second clause $(B or not B or C)$ is a tautology and is dropped.

  $A or not B or C $
]

Q14: $((A and B ) or C) => (not B and not (C or A))$

#answer[
  eliminate implication:

  $not((A and B) or C) or (not B and not(C or A)) $

  Push negations inward (de morgs):

  $not(A and B) = not A or not B, quad not(C or A) = not C and not A $

  $((not A or not B) and not C) or (not B and not C and not A) $

  the right disjunct $(not A and not B and not C)$ entails the left $((not A or not B) and not C)$, so the disjunction collapses to the left conjunct.

  $(not A or not B) and not C $
]


#pagebreak()


= Part : Logical Justification
For the Folllowing questions (15-18) provide justification for whether each of the following are correct or incorrect.

Q15: $(X and Y)  models Y$
#v(3cm)

Q16: $(not X and Y) or X  models X or Y$
#v(3cm)


Q17: $not (X and Y) or (Z and not Y) models not X or Y$
#v(3cm)


Q18: $not X or (Y and Z)  models (X => Y)$


#v(3cm)

// = Part : Inference

// Q14: Define soundness and completeness. Why are both important?
// #v(3cm)

// Q15: Explain the difference between model checking and theorem proving. When might one be more efficient than the other?
// #v(3cm) 


// Q16: What is _Modus Ponens_? Give an example.
// #v(3cm)


// = Part : Inference

// Q: Define soundness and completeness. Why are both important?
// #v(3cm)


// Q: What is And-Elimination?
// #v(2cm)

#pagebreak()
= Part : First-Order Logic

Q19: What is an interpretation (model) in First-Order Logic? #sidenote[AIMA Chapter 8.2 Page 274]

#answer[See the textbook]

Q19: What does it mean for a FOL formula to be valid? Satisfiable? Unsatisfiabl? How do these concepts compare to the propositional logic versions?

#answer[A First Order Logic formula is valid (a tautology) if it is true under every possible interpretation. It is satisfiable if there exists at least one interpretation that makes it true. It is unsatisfiable (a contradiction) if no interpretation makes it true. These are the same as the propositional definitions. The difference is that propositional models just assign T/F to symbols, while FOL interpretations additionally fix a domain and predicate extensions (so the the space of models is much larger).
]

Q21: Consider the domain $D = {1, 2, 3}$ with interpretation $I$ where:
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

Q22: For each sentence below, decide if it is valid, satisfiable (but not valid), or unsatisfiable. Justify each answer, for satisfiable but not valid sentences, give both a model where it is true and one where it is false.

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

#pagebreak()

Q23: For each pair of sentences, determine whether they are logically equivalent. If not, clearly describe the difference in meaning and give a concrete counterexample interpretation.

(a) $forall x exists y F(x, y)$ #h(1em) vs. #h(1em) $exists y forall x F(x, y)$

#answer[Not equivalent. The first says "for each $x$, some $y$ exists (possibly different for each $x$)." The second says "there is a single $y$ that works for all $x$ simultaneously." The second implies the first, but not vice versa. See the answer for the prev questions part d]

(b) $not forall x P(x)$ #h(1em) vs. #h(1em) $forall x not P(x)$

#answer[Not equivalent. The first is equivalent to $exists x not P(x)$ ("at least one thing fails $P$"). The second says "nothing satisfies $P$." The second implies the first, but not vice versa. Counterexample: $D = {a, b}$, $P = {a}$. First: $not forall x P(x) = T$ (since $P(b) = F$). Second: $forall x not P(x) = F$ (since $P(a) = T$).]

(c) $forall x (P(x) => Q(x))$ #h(1em) vs. #h(1em) $(forall x P(x)) => (forall x Q(x))$

#answer[Not equivalent. Let $P(x) =$ "$x$ is a CS major" and $Q(x) =$ "$x$ owns a laptop."

$forall x(P(x) => Q(x))$ = "Every CS major owns a laptop." This checks each individual: for each person, if they are a CS major, they must own a laptop.

$(forall x P(x)) => (forall x Q(x))$ = "If everyone is a CS major, then everyone owns a laptop." This only fires if the entire domain consists of CS majors. In any realistic class with even one non-CS-major, the $(forall x P(x))$ is false and the whole statement is vacuously true, even if some CS majors don't own laptops.

So the first is strictly stronger as it implies the second, but not vice versa. The second can be true for a completely trivial reason (not everyone is a CS major) while the first requires actually verifying each CS major.

Counterexample where the second holds but the first fails: $D = {a, b}$, $P = {a}$, $Q = {b}$.

 $P(a) => Q(a) = T => F = F$ 

$forall x P(x) = F$ (since $b$ is not in $P$), so the implication is vacuously true
]


#pagebreak()

Q24: Consider the following knowledge base:
+ $forall x ("CS_Student"(x) => "TakesExams"(x))$
+ $forall x ("TakesExams"(x) and "StudiesHard"(x) => "Passes"(x))$
+ $forall x ("Passes"(x) => "Happy"(x))$
+ $"CS_Student"("John")$
+ $not "Happy"("John")$

For each of the following, determine whether it is entailed by the KB. Show your chain of reasoning.

(a) $"TakesExams"("John")$

#answer[Entailed. From (4) and (1) by Modus Ponens.]

(b) $not "StudiesHard"("John")$

#answer[Entailed.

(3) for John. $"Passes"("John") => "Happy"("John")$. We know from (5) that $not "Happy"("John")$. By contrapositive $not "Passes"("John")$

(2) for John. $"TakesExams"("John") and "StudiesHard"("John") => "Pases"("John")$. We know $not "Passes"("John")$ from Step 1. By contrapositive$not ("TakesExams"("John") and "StudiesHard"("John")) $

by de morgans law this is $not "TakesExams"("John") or not "StudiesHard"("John")$.

From part (a) we have $"TakesExams"("John")$ thus $not "StudiesHard"("John") $
]

(c) $exists x not "Happy"(x)$

#answer[Entailed. From (5)]

(d) $forall x "CS_Student"(x)$

#answer[Not entailed. The KB only asserts John is a CS student; nothing forces all objects to be CS students.
]

(e) $exists x ("CS_Student"(x) and not "StudiesHard"(x))$

#answer[Entailed. From (4) and (b) $"CS_Student"("John") and not "StudiesHard"("John")$.]


