
#import "wdf.typ": *

#show: template.with(
  title: [
    Exam 2: Logic
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: true,
  header-content: none,
  abstract: none,
  bib: none,
  serif: true,
  exam: true,
)


= Knowledge and Logic

#question(
  points: 0.3,
)[
  Under the classical concept of knowledge as _justified true belief_, the threshold for what can be considered good _justification_ can be fuzzy, ranging from only including logical deduction and entailment, to including scientific empirical evidence, to potentially even including hearsay or intuitive gut feelings. When designing a knowledge based agent, what factors should influence the threshold for inclusion of statements in a knowledge base as justified?
]
#v(2fr)
#question(
  points: 0.3,
)[Briefly describe the difference between logical syntax and semantics? ]
#v(1fr)



#pagebreak()
= Propositional Logic and Model Checking
#colorbox()[
  _Note that for all questions, whenever using the word "or" we are assuming logical or (not exclusive or)_
]



#question(
  points: 0.3,
)[Consider a vocabulary with only four symbols, A, B, C, and D. For each of the following sentences, in how many possible worlds (models) is it true?]

#subquestion()[$(A and B) or (C and D)$ : #blank(width: 5em)]
#subquestion()[$not (A and B and C and D)$ : #blank(width: 5em)]
#subquestion()[$B => (A and B)$ : #blank(width: 7.25em)]

#v(1fr)

#question(
  points: 0.3,
)[Which, if any, of the following assertions are true?
]
#columns(2)[
  #checkbox() If $alpha models gamma$ or $beta models gamma$ then $(alpha and beta) models gamma$

  #checkbox() If $(alpha and beta) models gamma$ then  $alpha models gamma$ or $beta models gamma$
  #colbreak()

  #checkbox() If $alpha models (beta or gamma)$ then  $alpha models beta$ or $alpha models gamma$

  #checkbox() If $alpha models (beta and gamma)$ then  $alpha models beta$ and $alpha models gamma$

]

#v(1fr)

#question(
  points: 0.3,
)[Suppose we want to build an agent to do _science_. The agent must be able to come up with some hypothesis $H$ which entails and thus _explains_ all of the evidence for a particular experiment. Suppose we are implementing this as a search problem and we need to have a way to check if a hypothesis has reached our goal. We have the propositions $H, E_1, E_2, "and" E_3$ which are each propositions over a large number of variables representing the hypothesis and pieces of evidence. Additionally we have a solver, $"SAT"(alpha)$, which returns true if the formula $alpha$ is satisfiable and false if it is unsatisfiable. Which, if any, of the following formulations correctly returns true if we have reached our goal of a hypothesis that entails the evidence?]

#columns(2)[
  #checkbox() $"SAT"(H and E_1 and E_2 and E_3)$

  #checkbox() $"SAT"( H and not(E_1 and E_2 and E_3))$

  #checkbox() $"SAT"( not (H and E_1 and E_2 and E_3))$

  #checkbox() $"SAT"(not H and E_1 and E_2 and E_3)$


  #colbreak()

  #checkbox() $not "SAT"(H and E_1 and E_2 and E_3)$


  #checkbox() $not "SAT"(H and not(E_1 and E_2 and E_3))$


  #checkbox() $not "SAT"(not (H and E_1 and E_2 and E_3))$

  #checkbox() $not "SAT"(not H and E_1 and E_2 and E_3)$


]
#v(1fr)


#pagebreak()

#question(
  points: 0.3,
)[Jeff has a formula in propositional logic that he needs to convert to CNF in order to check its satisfiability. Below is his written out derivation of each step of the conversion. For the following conversion steps, mark any mistakes of substitution between formulae that are not logically equivalent.
  $
    & A<=>(C or D) \
    & (A=>(C or D)) and ((C or D)=> A) \
    & (A or not (C or D)) and ((C or D) or not A) \
    & (A or (not C and not D)) and ((C or D) or not A) \
    & (A or not C or not D) and (C or D or not A) \
  $
]

#question(
  points: 0.3,
)[Is Jeff's CNF formula logically equivalent to the original formula? If not, provide a counterexample of a model (assignment of truth values of the variables) where the two formulae have different values.]
#v(1fr)

#question(
  points: 0.3,
)[Write out the correct equivalent formula in CNF]

#v(1fr)

#question(
  points: 0.4,
)[ Consider the following formula in CNF. Write out the resulting recursive sub-problem clauses of each step of using DPLL to search for a satisfying assignment. Use the degree heuristic when non-deterministically assigning a variable if given a choice (i.e. select the variable present in the most number of clauses). Finally write the satisfying assignment, or if there is none write that the formula is unsatisfiable.
  $
    (a or b or not c or not e) and (not a or not b) and (b or not d or c) and (not a or d or c) and (a or not d) and (a or b) and (d or e)
  $
]


#v(3fr)



#pagebreak()
= First-Order Logic
For the following questions you will be reasoning in first-order logic, over the domain of the characters of Winnie-the-Pooh and The Hundred Acre Wood. The domain is shown below:

#figure(caption: [Domain of The Hundred Acre Wood])[
  #diagram(
    node(enclose: ((0, 0), (5, 0.5)), stroke: 1pt, corner-radius: 5pt),
    node((1, 0.25), [_Pooh_]),
    node((2, 0.25), [_Eeyore_]),
    node((3, 0.25), [_Tigger_]),
    node((4, 0.25), [_Piglet_]),
  )
]

#question(
  points: 0.3,
)[It is famously said that: _"The most wonderful thing about Tiggers is I'm the only one!"_. How would you write that *_there is at most only one Tigger_* in First Order Logic?\ _Hint: For the above sentence, remember that Tigger is not just a name of an object in the domain but also a *kind* of thing for which we want to say there is only one!_]

#v(1fr)


#question(
  points: 0.3,
)[Is your formula from the previous question _valid_ in the domain (i.e. is the formula true for _every possible interpretation_)? If so, explain why. If not, describe an interpretation for which it is false.]
#v(1fr)

#question(
  points: 0.3,
)[Suppose something we know about Tiggers is that they, unlike the rest of the characters, sometimes like to bounce. Additionally we also know that there is, in fact, a Tigger in the domain. We can then build a knowledge base that includes the three sentences:
  + The sentence representing that there is at most only one Tigger
  + $forall x ("Bouncing"(x) => "Tigger"(x))$
  + $exists y "Tigger"(y)$

  Which of the following sentences, if any, can be _entailed_ from the provided knowledge base?

]
#columns(2)[
  #checkbox() $exists x "Bouncing"(x)$

  #checkbox() $forall x ("Tigger"(x) => "Bouncing"(x))$

  #colbreak()

  #checkbox() $forall x ("Tigger"(x) or not "Bouncing"(x))$

  #checkbox() $exists x (not "Bouncing"(x) and not "Tigger"(x))$

]

#v(0.25fr)
#question(
  points: 0.3,
)[Now suppose we have observed some character bouncing, and thus added to the previous knowledge base a new sentence to encode the knowledge that we have seen something bouncing.
  Which statements can _now_ be entailed?
]
#columns(2)[
  #checkbox() $exists x "Bouncing"(x)$

  #checkbox() $forall x ("Tigger"(x) => "Bouncing"(x))$

  #colbreak()

  #checkbox() $forall x ("Tigger"(x) or not "Bouncing"(x))$

  #checkbox() $exists x (not "Bouncing"(x) and not "Tigger"(x))$

]
