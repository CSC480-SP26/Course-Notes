
#import "../wdf.typ": *

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

#answer[This question is very open ended but here are some potential answers:
  - The stakes of the agents decisions (ie: high cost errors demand stricter justification)
  - The reliability and quality of available evidence sources
  - The domain (ie: legal or medical vs consumer)
  - The computational constraints on verification
  - Whether the agent needs to act under time pressure
]

#v(1.5fr)
#question(
  points: 0.3,
)[Briefly describe the difference between logical syntax and semantics?]

#answer[Syntax defines the rules for what constitutes a well formed formula (ie: which strings of symbols are legal sentences) where as semantics define the meaning of said sentences. Semantics are how truth values are assigned to sentences under an interpretation (an  interpretation is the mapping of symbols to things in the world).]
#v(1fr)



#pagebreak()
= Propositional Logic and Model Checking
#colorbox()[
  _Note that for all questions, whenever using the word "or" we are assuming logical or (not exclusive or)_
]



#question(
  points: 0.3,
)[Consider a vocabulary with only four symbols, A, B, C, and D. For each of the following sentences, in how many possible worlds (models) is it true?]

#subquestion()[$(A and B) or (C and D)$ : #answer[7]]

#answer[With 4 binary variables there are $2^4 = 16$ total possible worlds. Use inclusion-exclusion:
  - Worlds where $(A and B)$ is true: fix $A=T, B=T$, let $C, D$ vary $-> 2^2 = 4$ worlds
  - Worlds where $(C and D)$ is true: fix $C=T, D=T$, let $A, B$ vary $-> 2^2 = 4$ worlds
  - Worlds where both hold (counted twice): $A=T, B=T, C=T, D=T -> 1$ world
  - Total: $4 + 4 - 1 = 7$
]

#subquestion()[$not (A and B and C and D)$ : #answer[15]]

#answer[$(A and B and C and D)$ is true in exactly 1 world (all four variables true). The negation is therefore true in $16 - 1 = 15$ worlds.]

#subquestion()[$B => (A and B)$ : #answer[12]]

#answer[An implication $P => Q$ is false only when $P$ is true and $Q$ is false.

  So this formula is false when $B = T$ and $(A and B) = F$.

  Since $B = T$, $(A and B) = F$ iff $A = F$. The false worlds are therefore those with $A=F, B=T$ (and $C, D$ anything) $-> 2^2 = 4$ worlds.

  True worlds: $16 - 4 = 12$.]



#v(1cm)
#pagebreak()


#question(
  points: 0.3,
)[Which, if any, of the following assertions are true?
]
#columns(2)[
  #answer($qed$) If $alpha models gamma$ or $beta models gamma$ then $(alpha and beta) models gamma$

  #answer[_True._ Recall that $alpha models gamma$ means: for _every_ model $M$, if $M models alpha$ then $M models gamma$. Now take any model $M$ of $(alpha and beta)$. Since $M$ satisfies the conjunction, it must satisfy $alpha$ individually (and also $beta$). If $alpha models gamma$, then since $M models alpha$ we immediately get $M models gamma$. The same reasoning applies if instead $beta models gamma$. Either way, every model of the conjunction satisfies $gamma$, so $(alpha and beta) models gamma$.

  So adding the extra constraint $beta$ can only shrink the set of models, from all models of $alpha$ down to only those that also satisfy $beta$. A conclusion that follows from the larger set certainly follows from the smaller one.]

  #checkbox() If $(alpha and beta) models gamma$ then  $alpha models gamma$ or $beta models gamma$

  #answer[_False._ Counterexample: Let $gamma = alpha and beta$. Then $(alpha and beta) models (alpha and beta)$ is trivially true, any model satisfying the left side satisfies the right side identically. But does $alpha$ alone entail $(alpha and beta)$? 
  
  No. Take a model where $alpha$ is true and $beta$ is false; then $alpha$ holds but $(alpha and beta)$ does not. Likewise $beta$ alone cannot entail $(alpha and beta)$, by symmetric reasoning.

  $(alpha and beta) models gamma$ only constrains models where _both_ $alpha$ and $beta$ hold at once. It says nothing about what happens in models where only $alpha$ holds (with $beta$ possibly false), so we cannot conclude $alpha models gamma$ on its own.]



  #colbreak()

  #checkbox() If $alpha models (beta or gamma)$ then  $alpha models beta$ or $alpha models gamma$

  #answer[_False._ Counterexample: Let $gamma = not beta$. Then $(beta or not beta)$ is a tautology(true in every possible model) so $alpha models (beta or not beta)$ holds for _any_ choice of $alpha$. But $alpha models beta$ says every model of $alpha$ makes $beta$ true, and $alpha models not beta$ says every model of $alpha$ makes $beta$ false. Both cannot hold simultaneously (unless $alpha$ is unsatisfiable), and neither needs to hold individually.

  $alpha$ may entail a disjunction without being able to determine _which_ disjunct holds. Different models of $alpha$ might satisfy different disjuncts with some making $beta$ true and $gamma$ false, others the reverse, so neither disjunct is universally forced.]

  #answer($qed$) If $alpha models (beta and gamma)$ then  $alpha models beta$ and $alpha models gamma$

  #answer[_True._ Assume every model of $alpha$ satisfies $(beta and gamma)$. Take any model $M$ such that $M models alpha$. Then $M models (beta and gamma)$, which means $M models beta$ and $M models gamma$ (a conjunction is true iff both conjuncts are true). Since this holds for _every_ model of $alpha$, we get $alpha models beta$ and $alpha models gamma$.

  A conjunction is strictly stronger than either conjunct alone, satisfying both together guarantees satisfying each individually.]


]

#pagebreak()

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


  #answer($qed$) $not "SAT"(H and not(E_1 and E_2 and E_3))$

  #checkbox() $not "SAT"(not (H and E_1 and E_2 and E_3))$

  #checkbox() $not "SAT"(not H and E_1 and E_2 and E_3)$


]

#answer[

  We need to show that $H models (E_1 and E_2 and E_3)$

  In order to prove entailment, it suffices to show that the implication is _valid_: $(H => (E_1 and E_2 and E_3))$

  Therefore we need to show that its negation is unsatisfiable.  $not "SAT"(not (H => (E_1 and E_2 and E_3)))$

  From here we can replace the implication with disjunction $not "SAT"(not (not H or (E_1 and E_2 and E_3)))$

  And then simplify by moving the negation in and using demorgans law $not "SAT"( H and not (E_1 and E_2 and E_3))$

  Thus the correct answer is $not "SAT"( H and not (E_1 and E_2 and E_3))$]

#v(1fr)


#pagebreak()

#question(
  points: 0.3,
)[Jeff has a formula in propositional logic that he needs to convert to CNF in order to check its satisfiability. Below is his written out derivation of each step of the conversion. For the following conversion steps, mark any mistakes of substitution between formulae that are not logically equivalent.
  $
    & A<=>(C or D) \
    & (A=>(C or D)) and ((C or D)=> A) \
    #answer()[#sidenote()[#answer()[This is ok but tricky. Look how the left side of the conjunction is the equivalent of the right side above (and vice versa). The substitution of the left to the left is incorrect but the substitution of the overall formula is still equivalent.]]] & (A or not (C or D)) and ((C or D) or not A)\
    & (A or (not C and not D)) and ((C or D) or not A) \
    #answer()[Incorrect $&(A or not C or not D) and (C or D or not A)$]\
    #answer()[Correct $&((A or not C) and (A or not D)) and (C or D or not A)$]\
  $

  #answer[
    _Step 5 error:_ Distributing $or$ over $and$ requires splitting into two clauses: $(A or (not C and not D))$ becomes $(A or not C) and (A or not D)$, not the single clause $(A or not C or not D)$.
  ]
]


#question(
  points: 0.3,
)[Is Jeff's CNF formula logically equivalent to the original formula? If not, provide a counterexample of a model (assignment of truth values of the variables) where the two formulae have different values.]

#answer[No. Consider $A=F, C=T, D=F$

  We would then have $(F <=> T)_("original") != (T and T)_("final")$
]
#v(1fr)

#question(
  points: 0.3,
)[Write out the correct equivalent formula in CNF]

#answer[$
    & A<=>(C or D) \
    & (A=>(C or D)) and ((C or D)=> A) \
    & (not A or (C or D)) and (not (C or D) or A) \
    & (not A or C or D) and ((not C and not D) or A) \
    & (not A or C or D) and (not C or A) and (not D or A)) \
  $
  Final answer:
  $(not A or C or D) and (not C or A) and (not D or A))$
]

#v(1fr)

#pagebreak()

#question(
  points: 0.4,
)[ Consider the following formula in CNF. Write out the resulting recursive sub-problem clauses of each step of using DPLL to search for a satisfying assignment. Use the degree heuristic when non-deterministically assigning a variable if given a choice (i.e. select the variable present in the most number of clauses). Finally write the satisfying assignment, or if there is none write that the formula is unsatisfiable.
  $
    (a or b or not c or not e) and (not a or not b) and (b or not d or c) and (not a or d or c) and (a or not d) and (a or b) and (d or e)
  $
]


#answer[
  _Step 1:_
  - No unit clauses, No pure literals

  - Degree Counts: (a: 5), (b: 4), (c: 3), (d: 4), (e: 2)

  - Set a$->$ True which results in: $(not b) and (b or not d or c) and (d or c) and (d or e)$

  _Step 2:_
  - UNIT CLAUSE DETECTED!
  - b$->$False which results in: $(not d or c) and (d or c) and (d or e)$

  _Step 3:_
  - No unit clauses.
  - PURE LITERAL DETECTED: $c$ appears only positively.
  - c$->$True which results in: $(d or e)$

  _Step 4:_
  - No unit clauses.
  - PURE LITERAL DETECTED: $d$ and $e$ appear only positively.
  - d$->$True which results in an empty formula (all clauses satisfied).

  Resulting Final Answer:
  a=True, b=False, c=True, d=True]

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


#answer[$forall x forall y ("Tigger"(x) and "Tigger"(y)) => (x=y)$]
#v(1cm)


#question(
  points: 0.3,
)[Is your formula from the previous question _valid_ in the domain (i.e. is the formula true for _every possible interpretation_)? If so, explain why. If not, describe an interpretation for which it is false.]

#answer[No, suppose we had the model $"Tigger(Pooh)" =$ True and $"Tigger(Eeyore)" =$ True,

  based on our previous formula, $forall x forall y ("Tigger"(x) and "Tigger"(y)) => (x=y)$

  $forall x forall y ("Tigger"("Pooh") and "Tigger"("Eeyore")) => ("Pooh"="Eeyore")$

  However we know that $"Pooh" != "Eeyore"$
]
#v(1cm)

#pagebreak()

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

  #answer[There is no requirement that Tigger must be bouncing, only that if its bouncing it must be Tigger. Thus even if we can ensure a Tigger, we can't state the existance of something bouncing]

  #checkbox() $forall x ("Tigger"(x) => "Bouncing"(x))$

  #answer[There is no requirement that Tigger must be bouncing, only that if its bouncing it must be Tigger]

  #colbreak()

  #answer($qed$) $forall x ("Tigger"(x) or not "Bouncing"(x))$

  #answer[$forall x ("Bouncing"(x) => "Tigger"(x))$ via de morgan's becomes $forall x ("Tigger"(x) or not "Bouncing"(x))$]

  #answer($qed$) $exists x (not "Bouncing"(x) and not "Tigger"(x))$

  #answer[Since there exists four objects in the domain, and there is atmost one tigger in the domain, and bouncing implies that the given object is a Tigger, then there can be atmost one that bounces. Thus there must exist at least one non-Tigger non-Bouncer]

]

#v(2cm)


#question(
  points: 0.3,
)[Now suppose we have observed some character bouncing, and thus added to the previous knowledge base a new sentence to encode the knowledge that we have seen something bouncing.
  Which statements can _now_ be entailed?
]
#columns(2)[
  #answer($qed$) $exists x "Bouncing"(x)$

  #answer["Now suppose we have observed some character bouncing"]

  #answer($qed$)$forall x ("Tigger"(x) => "Bouncing"(x))$

  #answer[Since there is atmost one Tigger, and all that bounces is a Tigger, then we know that the bouning object is a Tigger, and infact the only Tigger.

    Thus:

    $forall x ("Tigger"(x) => "Bouncing"(x))$ ]

  #colbreak()

  #answer($qed$) $forall x ("Tigger"(x) or not "Bouncing"(x))$

  #answer[See above]



  #answer($qed$) $exists x (not "Bouncing"(x) and not "Tigger"(x))$

  #answer[See above]


]
