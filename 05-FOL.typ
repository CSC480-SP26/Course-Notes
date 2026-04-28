
#import "wdf.typ": *

#show: template.with(
  title: [
    First Order Logic
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover an introduction to first order logic and continue to cover some inference. ],
  bib: none,
  serif: true,
  exam: false,
)






#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]



= First Order Logic

#discussion()[
  In propositional logic, how many terms would you need in a formula that encodes the sentence "All men are mortal"?
]

== Models and Possible Worlds
While in propositional logic a possible world is an assignment of facts (terms) as True or False, In first order logic a possible world has _objects_.

#def(
  term: "Domain",
)[The domain of a model in first order logic is the set of _objects_ that it contains. The domain is _required to be non-empty_, and objects must be defined to be _identifiable_ and _distinct_ (i.e. objects are monadic, self-identical and non-identical to other objects)]

== Syntax

=== Terms
In first order logic we maintain having the ability to have standalone terms of some truth value such as in propositional logic.

=== Constant Symbols
In FOL we can refer directly to the objects of the domain, but can only ever form them into a sentence through direct equality comparison, or through a predicate.

=== Variables
We can also refer to _variables_ which are unassigned names of objects in the domain. They can either be "free", which means they are just written in the formula and can be interpreted as any object in the domain, or they can be "bound" by a quantifier.

=== Functions
In FOL we can also refer to _functions_ of objects which take objects as input and output other objects, building _relations_ between objects in the domain.

=== Predicates
We can refer to predicates (these look somewhat like functions but are a special kind that must be total) which have truth values as a function of the object terms. It is through predicates that we can access truth values and use logical connectives to combine statements about objects.

=== Quantifiers
The two new symbols in FOL are the _quantifiers_ which allow us to talk about the domain as a whole. the quantifiers are:
- Existential quantifier: $exists$, which is read "there exists"
- Universal quantifier: $forall$ which is read "for all"

So we can write: $forall x "Man"(x) => "Mortal"(x)$ to say "For all objects in the domain, if the object is a man, then it is mortal, i.e. All men are mortal". Note how $x$ is a variable which refers to an arbitrary object in the domain, defined via a quantifier.


#discussion()[
  Consider the example sentence from earlier in class: "When there is smoke there is fire". Would this sentence be better translated in FOL as opposed to propositional logic? If so how? What is the difference?
]

#discussion(vspace: 1fr)[
  Translate the following sentences into FOL:
  + Everything is bitter or sweet
  + Either everything is bitter or everything is sweet
  + If someone is noisy, everybody is annoyed
  + Nobody is loved by no one
  + There is somebody who is loved by everyone
  + Frogs are green.
  + Frogs are not green.
  + No frog is green.
  + Some frogs are not green.
  + A cat likes treats.
  + A cat likes itself.
  + Every cat likes treats.
  + Some cat does not like any dog.
  + There is a cat who is liked by every dog.
  + Some dogs chase their own tail.


]

== Semantics and Interpretations
In addition to defining a domain, a model in first order logic must also define an _interpretation_ of the relevant symbols in a formula. An interpretation of a first-order language assigns a denotation to each non-logical symbol (predicate symbol, function symbol, or constant symbol) in that language. An interpretation ($I$) will take the symbol of a function in a formula and determine a specific mapping of domain objects that the function symbol refers to in the interpretation ($I(f) mapsto (D^n -> D)$). It will take the symbol of a free variable and assign it to a specific domain object. An interpretation finally will also assign a truth table to each predicate over all possible domain object arguments.

We can now redefine all of the same concepts as in propositional logic (validity, satisfiability, logical equivalence, etc...) over this new class of models (interpretations) and formulae (FOL). In fact for finite domains you can always reduce a formula in FOL to propositional logic. However this is frequently infeasible with infinite or very large domains#sidenote()[It is an interesting fact however that even in infinite domains, if a sentence is entailed in a first order logic base then there must exists a proof involving just a _finite_ subset of the propositional knowledge base!]. In such scenarios we rely purely on _inference_ rather than _model checking_ in order to answer queries.


#discussion()[
  For the following formula, state which, if any, are logically equivalent.

  $
    & F_1 = forall x exists(P (x) ∧ Q(y)) \
    & F_2 = (forall x P (x) ∧ exists (y)) \
    & F_3 = (forall x Q(y) ∧ exists P (x)) \
    & F_4 = forall x(Q(y) ∧ exists (x)) \
    & F_5 = exists y forall x(P (x) ∧ Q(y)) \
  $
]

#discussion()[
  Find a model for which the formula is true, and a model for which it is false

  $
    exists y ( P (y) ∧ not Q(y) ) ∧ forall z( P (z) ∨ Q(z) )
  $
]



#pagebreak()
= Inference in FOL


== Unification
Lifted inference rules require finding substitutions that make different logical expressions look identical. This process is called _unification_ and is a key component of all first-order inference algorithms. The unification algorithm takes two sentences and returns a unifier for them (a substitution) if one exists:
$
  "Unify"("Knows"("John",x), "Knows"("John","Jane")) = {x "/" "Jane"}
$

== Subsumption

== Forward Chaining

== Backward Chaining

== Resolution


#pagebreak()
= Knowledge Engineering
Using FOL or any other logic system, we can formulate the general process by which we can use our inference engines to build agents that "know" something and can reason about the world.

+ Identify the question
+ Assemble relevant knowledge
+ Decide on vocabulary of predciates, functions, constants
+ Encode _general knowledge_ about the domain
+ Encode a _description of problem instance_
+ Pose queries to inference procedure
+ Debug and evaluate knowledge base
