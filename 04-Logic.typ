
#import "wdf.typ": *

#show: template.with(
  title: [
    Propositional Logic and Model Checking
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover an introduction to propositional logic and model checking. Syntax and semantics of propositional logic. Concepts of models, inference, satisfiability. Model checking algorithms (DPLL) and some optimizations.],
  bib: none,
  serif: true,
  exam: false,
)






#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]



= Logic and Knowledge

#def(term: [Knowledge])[
  Data internal to an agent that represents a _justified true belief_.#sidenote()[If you are interested in more modern philosophical critiques of this traditional concept of knowledge, I recommend looking into the weird world of Getteir Cases, and the different ways that epistemologists have responded to them.]

  Modeled within an agent as a *_Knowledge Base_* which is a set of sentences in a formal language representing the things an agent knows.
]

#def(term: [Logic])[
  Agent's system of internal processing that can use the agent's knowledge to conclude new true statements. This works through the logic's *_Inference Engine_*, which is the set of generic procedures which can transform and answer formal queries on a knowledge base.
]

== Many Kinds of Knowledge
- Knowledge of the effects of actions (transition knowledge)
- Knowledge of how the environment affects sensors (sensor knowledge)
- Knowledge of the current state of the environment (state knowledge)
- Knowledge of the causal structure of the environment (world knowledge)

== Thinking Agents
- Acquire knowledge through perception, learning, language (_a posteriori_), or knowledge programmed in to the agent ahead of time (_a priori_).
- Use logic to make use of knowledge in order to formulate plans and keep track of partially observable world.

#discussion(vspace: 0pt)[
  The agent AristBOTle has been taught two things.
  + All men are mortal
  + Socrates is a man

  Aristbotle is then asked a query, "_Is socrates mortal?_". What is the agent's initial knowledge base? What about after reasoning about the query? When reasoning about the query, does the inference engine care about the specifics of the knowledge claims, or the structure of the sentences in relation to each other?
]

= Propositional Logic
Simplest system of knowledge and inference, where all terms have direct, binary, truth values. Defined as a syntactic system of valid general transformations, and semantic interpretation procedure to asses the underlying _truth_ of sentences.

#def(term: [Syntax])[
  The set of sentences allowed within the formal system
]
#def(term: [Semantics])[
  The definition of truth in a logical system, generally as _correspondence_ of logical syntax sentences with _possible worlds_ and their properties.]

== Syntax of Propositions
- Terms: Binary variables which can be true or false
- Propositions: Compositions of terms and propositions using logical operators, ${not, and, or, =>}$#sidenote()[Notation here varies. Sometimes $->$ is used for implication. And sometimes $~$ is used for negation.]
- Operators are defined by _truth tables_.

#discussion()[
  Consider the phrase "If there is smoke there is fire". How would we write this as a proposition? What about if we only had access to the operators: ${and, not}$ ?
]



== Semantics of Models
Variables that can be different values creates a notion of "possible worlds" where different sets of the terms are true or false. Propositions are true or false "in a world".

#def(term: [Model])[
  A model is a possible world with definite values for every proposition symbol. A model is said to be a _model of a formula_ or to _satisfy_ a formula when in the model, the formula evaluates to true. We then say that a formula $phi$ _models_ or _entails_ another formula $psi$ when all models of $phi$ are also models of $psi$, which is written as:
  $
    phi models psi
  $
]

#discussion(vspace: 5em)[
  Consider the set of propositions:
  $
    "Smoke" => "Fire"\
    "Fire" => ("Arson" or "Accident")
  $
  Come up with three different models for the propositions. Come up with at least one more assignment of a possible world which is _not_ a model.
]


=== Validity and Satisfiability

Using the language of models we may wish to then identify different properties of formula.

#def(term: [Validity])[
  A formula is _valid_ if and only if it is _true in all models_. This is also sometimes called a _tautology_.
]

#discussion()[
  The _deduction theorem_ states that for any propositions $alpha, beta$ that $ alpha models beta "if and only if" (alpha => beta) "is valid" $. In propositional logic (unlike some other formal systems) this is a _theorem_ and so can be proved based on our existing definitions. Try to come up with a proof.
]

#def(term: [Satisfiability])[
  A formula is _satisfiable_ if and only if it is _true in at least one model_.
]

#def(term: [Unsatisfiability])[
  A formula is _unsatisfiable_ if and only if it is _not true in any one model_. (Or alternatively its _negation is valid_).
]

#discussion(vspace: 7em)[
  Satisfiability problems, determining whether some formula is satisfiable or not, turns out to be an extremely flexible framework to solve almost any other kind of problem#sidenote()[Of course this means we should expect it to also be, in general, NP-Complete, although we can leave the proof of that as an exercise.]. What would you need to do (informally) to encode a search problem as a satisfiability problem?
]

=== Logical Equivalence

We may want to compare syntactically different sentences that have the same _meaning/semantics_. Therefore we can define _logical equivalence_ for two formulae $phi$ ad $psi$, as
$
  phi equiv psi "if and only if" phi models psi "and" psi models phi
$

=== Note about meta-language
#discussion(vspace: 0em)[
  It seems that we have many overlapping concepts. $=>, models, tack$ all kind of seem the same in some sense, why do we not just notate logic _in logic_, since it is meant to be our best language for general purpose reasoning?

  Consider the statement "This statement is false". What are the issues when trying to encode and use this statement in propositional logic, and what does it have to do with needing multiple implication-_ish_ things?
]

== Inference and Deduction
Need procedures of generating new true sentences, if you already have existing true sentences. These procedures are called, variably, _deductions_, _proofs_, or _inferences_.

An inference of a formula $phi$ from a set of known context $Gamma$ is written as: $ Gamma tack phi $
Note that if we can prove or infer a statement, it must be able to be modeled. So
$ "If" alpha tack beta "then " alpha models beta $, however the inverse is _not necessarily true_#sidenote(dy: -5em)[While it is always true in propositional logic, when extending to any slightly more flexible logic, the existence of undecidable sentences means that not all formulae can be proved.].

We can generate proofs based on a sequence of inference steps which are _purely syntactic_. The possible steps#sidenote()[Doesn't this look a lot like possible actions of a search problem?] are given by the _rules of inference_. Which are the _valid_ rules written in the following form, where listed formulae are implicitly a conjunction:
$
  ("some formula, another formula") / ("new inferred formula")
$

Inference rules can be derived in propositional logic when
$
  (("(some formula)" and "(another formula)") => "new formula") "is valid"
$

Note how we can thus always substitute / infer propositions which are logically equivalent.

=== Modus Ponens
$
  (a wide a => b) / (b)
$

=== Modus Tollens
$
  (not b wide a => b) / (not b)
$

=== And-Elimination
$
  (a and b) / (a)
$

=== Resolution
If we have _complimentary literals_ $l_i$ and $m$, which is where $l_i equiv not m$, then if we have a _clause_ (disjunction of literals)
$
  (l_1 or ... or l_k wide m) / (l_1 or ... or l_(i-1) or l_(i+1) or ... or l_k)
$

Resolution in particular forms a _complete_ inference procedure, such that for any $alpha, beta$ we can decide whether or not $alpha models beta$.

#discussion(vspace: 3em)[
  The above is _unit resolution_ for a single complimentary literal. Write what the inference rule for the more general _full resolution_ for an arbitrary clause of complimentary literals.
]


=== Monotonicity
Another property of formal proof systems is _monotonicity_ which states that the set of entailed sentences only ever increases with new knowledge.
$
  "If" Gamma models c "then" Gamma and a models c
$
#discussion(vspace: 5em)[
  Consider what it means for a logic to be monotonic, what would it mean for a logic to be _non-monotonic_?
]

== Classical Laws of Logic
In classical propositional logic these are _tautologies_, or propositions which are always true, regardless of the truth values of the terms. However they form a good starting point for more more general formal systems than classical propositional logic.

=== Law of Identity
The most primitive of logical laws "everything is equal to itself". While this is the basis of being able to actually work with formula, there is a surprising amount of depth both in contexts where we can imagine this law being false, as well as different notions of equality. While these extensions end up being well outside the scope of the course, if you are interested there is a vast literature of both philosophical critiques, as well as mathematical complications to the most seemingly simple concept.
$
  a=a
$


=== Law of Non-Contradiction
$
  not(p and not p)
$
#discussion(vspace: 5em)[
  One reason#sidenote()[Although sometimes not determinative. The world of _para-consistent logics_ which are formal systems which are able to handle true contradictions is extremely interesting (in particular how they deal with the principle of explosion).] (outside of classical propositional logic) to hold the LNC is the _principle of explosion_. This states that if we have a true contradiction $q = p and not p$, then we can prove literally any other claim. How might you go about trying to do this?
]
=== Law of the Excluded Middle
In classical propositional logic we simply have that things are only ever either true or false, and that if something is true, then it's negation is false. Like the other laws, developing new systems that can violate this law (such as three-valued logics) is a rich area of work outside of the scope of this course.
$
  p or not p
$
#discussion()[
  Consider again the proposition "_This statement is false_". Try to write it out more formally, which laws of logic does it violate?
]





= Model Checking and Satisfiablity

If we are able to encode an agent's knowledge as a knowledge base in propositional logic, and similarly encode any problem it might face as a new formula and satisfiability problem, then we are one step closer to achieving a general purpose reasoning agent. The key remaining step for our inference engine is the actual mechanics of solving the satisfiability of an arbitrary propositional formula.

As you might imagine, this class of engine for satisfiability problems is called a _SAT solver_.

#discussion(vspace: 5em)[
  If we want to know if our knowledge base $"KB"$ entails some new claim $q$, then we want to prove or disprove $"KB" models q$. How would we write this as a satisfiability problem?
]

== Conjunctive Normal Form
SAT solvers use repeated application of resolution in order to solve the satisfiability of a formula. That means that formula need to be rewritten in a way where we can apply resolution, which is called Conjunctive Normal Form (CNF), which is a formula that is a _conjunction of disjunctions of units (clauses)_.

Lucky for us it turns out that *every sentence of propositional logic is logically equivalent to a sentence in CNF*. Note that CNF is pretty hard to read for humans when compared to a more natural logical encoding, and so frequently the encoding into CNF is done right before running the SAT solver, or even abstracted away and performed internally to the solver.

#colorbox(title: [Example])[
  $
    a => (b <=> c)\
    a => (b => c and c => b)\
    not a or ((not b or c) and (not c or b))\
    (not a or not b or c) and (not a or b or not c)
  $
]

#discussion(vspace: 5em)[
  Rewrite the following formula in  in CNF:
  $
    (a or not b) => c
  $
]





== DPLL Algorithm

Once we have a formula in CNF, we can apply _resolution_ to determine satisfiability. The classical core algorithm for this is DPLL for Davis-Putnam-Logemann-Loveland, after the seminal papers by Martin Davis and Hilary Putnam (1960) and Davis, Logemann, and Loveland (1962). The general idea is to do a depth first backtracking search of possible models until we wither find a model or show no model can exist. This is helped by a few tricks.

=== Pure Symbols
In CNF we may have symbols that always appear with the same valence (positive or negated). We call these symbols _pure symbols_, since we can just directly set them to the value that will make their clauses true (since in any model if it exists must have this assignment). Note that if we have a model, we can ignore clauses that are already set to be true by some other means when searching for pure symbols.


=== Unit Clause
A unit clause is just a clause with only a single literal (or only a single "live" literal). We can immediately set the value of the unit to the required value. Note how when we can do this, new unit clauses may appear, which is a process called _unit propagation_.
#discussion(vspace: 0em)[
  Consider the formula in CNF: $A and (not A or not B)$. Trace how unit propagation is able to satisfy the formula.
]

== Pseudocode

```
def dpll-satisfiable(s) -> bool:
    clauses <- the set of clauses in s
    symbols <- the set of
    return dpll(clauses, symbols, {})

def dpll(clauses, symbols, model) -> bool:
    if every clause in clauses is true in model:
      return true

    if any clause in clauses is false in model:
      return false

    P, value <- find-pure-symbol(symbols,clauses, model)
    if P is non-null:
      return dpll(clauses, symbols/P, model ∪ {P = value}

    P, value <- find-unit-clause(symbols,clauses, model)
    if P is non-null:
      return dpll(clauses, symbols/P, model ∪ {P = value})

    P, rest <- first(symbols), rest(symbols)
    return (dpll(clauses,rest,model ∪ {P = true})
            or dpll(clauses,rest,model ∪ {P = false}))
```

=== Optimizations
- Smart Ordering
  - Use heuristics to choose next symbol to assign. One popular option is _degree heuristic_ which chooses term that is most frequently present in remaining clauses.
- Component Analysis
  - If we see the problem reaches a point where there are unconnected sets of clauses, we can get a lot of speed up by solving these smaller sub-problems independently.
- Smart backtracking
  - Keeping track of relevant points of conflict and not repeating them.
- Random restarts
  - Sometimes you get unlucky and go down an ineffieicnet branch. And so sometimes restarting with different random choices can even out the variance.
- Tons of cool and fancy tricks
- Goes from solvable ~100 variables -> ~100000000 variables

// == Theorem Proving
// === Forward Chaining
// - keep applying modus ponens until you cant anymore
// - only definite clauses (implication or unit)
// - sound and complete
// - *linear time*!
// - Datalog
// === Backward Chaining
// - start from goal, recursively solve subgoals
// - sound/complete for definite clause
// - also linear with some tricks
// - Prolog
