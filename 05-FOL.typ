
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
  abstract: [We will cover an introduction to first order logic syntax and semantics, as well as the general process of knowledge engineering for building knowledge based agents.],
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
We can refer to predicates (these look somewhat like functions but are a special kind that must be total) which have truth values as a function of the object terms. It is through predicates that we can access truth values and use logical connectives to combine statements about objects. By convention we write functions in  lower case and predicates in uppercase.

=== Quantifiers
The two new symbols in FOL are the _quantifiers_ which allow us to talk about the domain as a whole. the quantifiers are:
- Existential quantifier: $exists$, which is read "there exists"
- Universal quantifier: $forall$ which is read "for all"

So we can write: $forall x "Man"(x) => "Mortal"(x)$ to say "For all objects in the domain, if the object is a man, then it is mortal, i.e. All men are mortal". Note how $x$ is a variable which refers to an arbitrary object in the domain, defined via a quantifier.

=== Order of operations
The notational convention used to help reduce too many parentheses uses the order of operations:
+ $not$
+ $and , or$
+ $forall , exists$
+ $=> , <=>$

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
In addition to defining a domain, a model in first order logic must also define an _interpretation_ of the relevant symbols in a formula. An interpretation of a first-order language assigns a denotation to each non-logical symbol (predicate symbol, function symbol, or constant symbol) in that language. An interpretation ($I$) will take the symbol of a function in a formula and determine a specific mapping of domain objects that the function symbol refers to in the interpretation
$
  I(f) mapsto (D^n -> D)
$

It will also take the symbol of a free variable and assign it to a specific domain object#sidenote()[Sometimes this operation is separated from the interpretation and given its own name of a _variable assignment_. For this class we can consider the interpretation to include a variable assignment. We must be careful, however, when considering quantified bound variables which are defined as compositions over all possible variable assignments for the bound variable.].
$
  I(x) mapsto o in D
$

An interpretation finally will also assign a truth table to each predicate over all possible domain object arguments.

$
  I(P) mapsto (D^n -> {T,F})
$

We can now redefine all of the same concepts as in propositional logic (validity, satisfiability, logical equivalence, etc...) over this new class of models (interpretations) and formulae (FOL). In fact for finite domains you can always reduce a formula in FOL to propositional logic. However this is frequently infeasible with infinite or very large domains#sidenote()[It is an interesting fact however that even in infinite domains, if a sentence is entailed in a first order logic base then there must exists a proof involving just a _finite_ subset of the propositional knowledge base! This is to say that first-order logic is _semidecidable_, and so algorithms exist that say yes to every entailed sentence, but no algorithm exists that also says no to every nonentailed sentence.]. In such scenarios we rely purely on _inference_ rather than _model checking_ in order to answer queries.


#discussion(vspace: 0em)[
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
  Find a model for which the formula is true, and a model for which it is false.

  $
    exists y ( P (f(y)) ∧ not Q(y) ) ∧ forall z( P (z) ∨ Q(z) )
  $
]



#pagebreak()
#wideblock()[
  = Knowledge Engineering
  Using FOL or any other logic system, we can formulate the general process by which we can use our inference engines to build agents that "know" something and can reason about the world. This is sometimes called _knowledge engineering_, the process of designing formal representations and systems of objects and relations in a domain in order to facilitate the effective use of knowledge. This is also sometimes divided between _special-purpose_ knowledge bases which are more carefully constructed and _general-purpose_ knowledge bases which aim to cover a broader range of queries. For example, while a general purpose system may have standard representations for "Birds", an ornithological agent may specifically wish to name each bird it sees and note its species in order to track migration patterns or survival rates.

  == Identify the question
  The first step to to delineate the range of queries and kinds of facts that a knowledge base will support. The specific task and domain of the agent as well as any particular demands of the environment and performance measure, will determine what must eb represented in order to connect problem instances to answers.

  == Assemble the relevant knowledge
  The next step is to gather as much information about the domain as possible. At this stage things need not be fully formalized, the idea is to understand the scope and structure of the domain

  == Decide on a vocabulary of predicates, functions, and constants
  Once we understand the _structure_ our knowledge needs to take, we can encode the high level concepts of the domain. These first choices will be have the biggest impact on the remainder of the project and outline the main engineering style decisions affecting the system. These are choices like to encode certain kinds of basic structures as functions, predicates, or objects, or how should basic concepts like space and time be encoded. Once these choices have been made the result is the structure of an _ontology_ of the domain which determines what kinds of things there are without determining anything specific about individual entities.

  == Encode general knowledge about the domain
  After the encoding structure of the domain is decided, the _axioms_ of the domain must be encoded. This will pin down to the extent possible the meanings of the terms, enabling experts to check the content and spot gaps (leading to cycles of revision back to earlier steps).

  == Encode a description of problem instance
  If all of the preceding steps have been well thought out, the rest should be easy. It involves simply writing out sentences describing specific problem instances using the already established concepts (this can sometimes be differentiated as _ontic_ referring to specific _beings_, as opposed to the earlier  _ontological_ steps concerning _being_ in general). These are provided as inputs to the agent (either through specification or through sensors).

  == Pose queries to inference procedure
  Finally, once all of the knowledge of a situation has been encoded we can let the inference engine do all of the work to derive facts and answer queries. Of course, it is unlikely that you did this whole process without mistakes, and at this point you will have to check your system against externally validated queries and catch (sometimes very subtle) errors in the formulation.
]
