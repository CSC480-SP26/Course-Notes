
#import "wdf.typ": *

#show: template.with(
  title: [
    Uncertainty, Probability, and Bayes Rule
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover an introduction to reasoning in the presence of uncertainty, the preliminaries of probability theory, and the Bayesian approach to probabilistic modeling.],
  bib: none,
  serif: true,
  exam: false,
)






#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]


= Uncertainty and Probability
Knowledge and logic are all well and good when you can be certain about the truth or falsity of your propositions. However sometimes we need to be able to reason in the presence of _uncertainty_.
Probabilistic reasoning and inference gives us a
framework for managing uncertain beliefs and knowledge. In general this will involve
- _Observed variables_ (evidence) : Things the agent knows about the world.
- _Unobserved variables_ (hidden/latent): Things that the agent needs to reason about the world but cannot access correctly.
- _Model_#sidenote()[It simply cannot be avoided that the word model is inextricable and fundamental in the two areas of both logic and probability, but their meanings have very little to do with each other. Be careful, then, to ensure you understand the context of when this word is being used and thus what it refers to.] (probabilistic): Things the agent knows about how the observed and unobserved variables relate.

In order to reason about these variables we must first introduce the fundamental language of probability#sidenote()[More so than any other unit of this course, what we are going to be able to cover is only the slightest fraction of the field. If anything covered in this unit is remotely of interest or relevance, you would be well served taking more of the plethora of statistics, probability, machine learning, or data science courses offered here.].

== Random Variable
The first fundamental concept in probability theory (for our purposes that ignores all of the actual fundamental concepts in Measure Theory) is that of a _Random Variable_.

#def(term: [Random Variable])[
  A random variable is a representation of a value corresponding to some aspect of the environment about which we may have uncertainty. Random variables are written with capital letters, and the values that they may take are written either numerically or in lower case for qualitative values in the _domain_ of the random variable. We generally reserve the symbol $Omega$ to denote the set of actually possible values or the _sample space_ of the domain.
]


== Probability Distribution
The other fundamental concept in probability theory is the mechanism that allows us to actual reason with random variables: _probability distributions_.

#def(term: "Probability Distribution")[
  The probability distribution for a random variable associates a probability (or probability density) with each possible value of the random variable. The probability that a random variable $X$ is equal to value $x$ is written as $P(X=x)$ or just $P(x)$ for some $x in Omega$.

  A probability distribution must have the two properties that all probabilities are non-negative and must sum to one:#v(0.25em)
  + $forall x P(X=x) >= 0$#v(1em)
  + $(sum_x P(X=x)) = 1$
]

#colorbox()[
  Example:
  Let the random variable $C$ represent the outcome of a coin flip. $C$ may have outcomes as heads or tails written as  $Omega = {italic("heads"), italic("tails")}$. If the coin is fair then we have that:
  $
    & P(italic("heads")) = 0.5 \
    & P(italic("tails")) = 0.5 \
  $
]
// #discussion()[
//   TODO: Need short problem / activity here
// ]


== Joint and Marginal Distributions
Generally we need to describe more than one random variable in an environment. To do this we define a _joint distribution_ over the set of random variables.

#def(term: [Joint Distribution])[
  The _joint distribution_ of a set of random variables $X_1, X_2, ..., X_N$ specifies a value for each variable as a single _outcome_ #sidenote()[Where we define a new sample space for the joint outcome as the cartesian product of the component measure spaces: $Omega = Omega_(X_1) times Omega_(X_2)$] for $X_1$ _and_ $X_2$ _and_ $X_N$ etc.

  $P(X_1=x_1, X_2=x_2, ... , X_N=x_N)\
  "or" P(x_1,x_2,...,x_N)$

  The joint distribution must similarly follow the requirements:#v(0.25em)
  + $forall x_1,x_2,...,x_N P(x_1,x_2,...,x_N) >= 0$#v(1em)
  + $(sum_(x_1,x_2,...,x_N) P(x_1,x_2,...,x_N)) = 1$

]

From the joint distribution, we can aggregate a random variable in order to calculate the standalone probability distribution of a single variable. We call this the _marginal distribution_.

#discussion(vspace: 0em)[
  Note how the joint distribution has a similar exhaustive definition to a truth table. Consider the set of two random variables $T$ representing the temperature and $W$ representing the weather. If we write the partially filled joint distribution, what must the final value $p$ be? Then calculate the marginal distributions for $T$ and $W$

  #table(
    columns: 3,
    [$T$], [$W$], [$P(t,w)$],
    [_hot_], [_sun_], [$0.4$],
    [_hot_], [_rain_], [$0.1$],
    [_cold_], [_sun_], [$0.2$],
    [_cold_], [_rain_], [$p$],
  )
]



== Probabilistic Models

If we have a complete joint distribution for a set of random variables then we are said to have a _model_ of those variables. The joint distribution encodes the maximal amount of information about the variables and their probabilities _and how those probabilities interact_ by exhaustively assigning probabilities to every single distinct outcome.

== Events
Since the best way to describe new pieces of information or occurrences is not always to enumerate an assignment for every single variable (an outcome), we can also speak of _events_ as _sets of outcomes_. The most common kind of event is a _partial assignment_ which restricts some random variables while leaving others unassigned. We can then define the probability of an event as the sum of the probabilities of the component outcomes:
$
  P(E) = sum_((x_1 ... x_N) in E) P(x_1, ... , x_N)
$

== Probabilistic Logic and Combining Events
Once we can reason about the probabilities of events, we can then begin to reason about _the logical composition of events_. In probability we have a new formalism to do the same things we did with logic.

=== Negation
The negation of an event is the event that occurs precisely when the original event _does not occur_, and thus is can be defined as the set of all outcomes not included in the original event set.
$
  not E = {x in Omega | x in.not E}
$


=== Conjunction
The conjunction of two events is defined as the event corresponding to the _intersection_ of the outcome sets of the composing events. This can be written either as $P(E_1 and E_2)$ or as a joint distribution $P(E_1, E_2)$.
$
  E_1 and E_2 = {x in Omega | (x in E_1) and (x in E_2)}
$

If the intersection of the two events is empty ($E_1 inter E_2 = emptyset$) then we say the events are _mutually exclusive_.

=== Disjunction
The disjunction of two events is defined as the event corresponding to the _union_ of the outcome sets of the composing events.
$
  E_1 or E_2 = {x in Omega | (x in E_1) or (x in E_2)}
$

#discussion()[
  How would we find the probability $P(E_1 or E_2)$ in terms of $P(E_1)$, $P(E_2)$, and $P(E_1 and E_2)$? What about $P(E_1 or E_2 or E_3)$?
]

#discussion(vspace: 0em)[
  Using the joint distribution below what are the following event probabilities?

  + $P(a,c)$
  + $P(a)$
  + $P(b or d)$

  #table(
    columns: 3,
    [X], [Y], [$P(x,y)$],
    [$a$], [$c$], [$0.2$],
    [$a$], [$d$], [$0.3$],
    [$b$], [$c$], [$0.4$],
    [$b$], [$d$], [$0.1$],
  )
]


=== Independence
Another fundamental component of probability theory is the notion of events being _independent_, or loosely, the occurrence of one event having no effect on the probability of the other. Two events $E_1$ and $E_2$ are independent, written $E_1 bot E_2$ if

$
  P(E_1 and E_2) = P(E_1) dot P(E_2)
$


== Conditional Distribution
Frequently we want to understand probability in a conditional manner (if Event A occurs what is the probability of Event B)#sidenote()[This is similar to implication, but note how it does not get defined in terms of negation and disjunction. Instead we have that conditional probability is more akin to _entailment_].

We write this as $P(a | b)$ for: _"the probability of A given B"_. We can reason through how to calculate this. First to say "given B", if we know that B has occurred, then out new sample space is just the event space of B (since all joint outcomes must have B occurring by taking it as a given). We then can find the part of B that has A in it, the intersection. This leaves the formula:
$
  P(a | b) = P(a,b) / P(b)
$

The formula has two components, the first is _selection_ of the relevant outcomes from the joint, and the second is _normalization_ to ensure the resultant probability distribution is well formed.

#discussion(vspace: 0em)[
  In the previous example, find $P(italic("hot")|italic("sun"))$
]

This structure of conditional probabilities forms the primary means by which we will use probability theory to have agents reason in the presence of uncertainty. In general we want to find good models of $P("unknown"|"evidence")$.

#discussion()[
  Monty Hall Problem
]

== Conditional Independence
Sometimes we will find that events may not be generally independent, but are effectively independent given the same background. We can retwite independence as:
$
  A bot B "iff" P(A | B) = P(A)
$
And _conditional independence_ is when this holds only with a certain condition
$
  (A bot B |C) "iff" P(A | B, C) = P(A | C)
$

= Bayesianism

== Bayes Rule

== Updating Beliefs
#discussion()[
  Card deck example
]

== Priors

= Bayes Networks
