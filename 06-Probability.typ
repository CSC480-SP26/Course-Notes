
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


#discussion(vspace: 0em)[
  Are X and Y Independent?
  #table(
    columns: 3,
    [X], [Y], [$P(x,y)$],
    [$a$], [$d$], [$0.1$],
    [$a$], [$e$], [$0.3$],
    [$a$], [$f$], [$0.1$],
    [$b$], [$d$], [$0.04$],
    [$b$], [$e$], [$0.12$],
    [$b$], [$f$], [$0.04$],
    [$c$], [$d$], [$0.07$],
    [$c$], [$e$], [$0.16$],
    [$c$], [$f$], [$0.07$],
  )
]

== Conditional Distribution
Frequently we want to understand probability in a conditional manner (if Event A occurs what is the probability of Event B)#sidenote()[While this looks similar to implication, note how it does not get defined in terms of negation and disjunction. Instead conditional probability is more akin to _entailment_].

We write this as $P(a | b)$ for: _"the probability of A given B"_. We can reason through how to calculate this. First to say "given B", if we know that B has occurred, then out new sample space is just the event space of B (since all joint outcomes must have B occurring by taking it as a given). We then can find the part of B that has A in it, the intersection. This leaves the formula#sidenote()[
  Also note how we can use this to get the joint from the conditional, $P(a) P(b | a) = P(a,b)$
]:
$
  P(a | b) = P(a,b) / P(b)
$


The formula has two components, the first is _selection_ of the relevant outcomes from the joint, and the second is _normalization_ to ensure the resultant probability distribution is well formed.

#discussion(vspace: 0em)[
  In the previous example, find $P(italic("hot")|italic("sun"))$
]

This structure of conditional probabilities forms the primary means by which we will use probability theory to have agents reason in the presence of uncertainty. In general we want to find good models of $P("unknown"|"evidence")$.

#discussion(vspace: 0pt)[
  Monty Hall Problem
]

== Conditional Independence
Sometimes we will find that events may not be generally independent, but are effectively independent given the same background. We can rewrite independence as:
$
  A bot B "iff" P(A | B) = P(A)
$
And _conditional independence_ is when this holds only with a certain condition
$
  (A bot B |C) "iff" P(A | B, C) = P(A | C)
$
We can see how conditions could be interpreted under _specific conditions_ of $C=c$, or _general conditions_ of all values of $C$. If conditional independence is written without reference to a specific value, you may assume the general condition is what is implied.

#discussion(vspace: 5em)[
  Consider smoke detectors used to sound an alarm when it detects a fire. What does the statement: $("Alarm" bot "Fire" )| "Smoke"$ mean in this context and is it a true description of the system? What about just $("Alarm" bot "Fire" )$?
]


#discussion(vspace: 0em)[
  Are Red and Blue independent? What about conditional on Yellow? Note the difference between the general case over all values of a random variable and the specific case of specific values of a random variable.
  #figure()[
    #image("Figures/Conditional_independence.png", width: 95%),
  ]
]


#pagebreak()
= Bayesianism
After establishing the core language of probability, we can outline the _Bayesian_ interpretation of probability that is used in this course. For Bayesians, we understand probability to represent degrees of belief, or reasonable expectations, and are fundamentally properties of the internal beliefs of agents rather than an objective true hypothetical frequency. The task is to use these beliefs to do _probabilistic inference_ and reason in the presence of uncertainty.

The core of probabilistic inference is to compute some desired probability from other known probabilities. We generally compute conditional probabilities which represent _the agent's beliefs given the evidence_. When an agent observes new evidence, _it must update its beliefs_.

The other key concept to remember is that _all models are wrong (but some are useful)_. Your agent never has an accounting of every variable or interaction. The best we can do is act rationally in response to the information we do have.


#discussion(vspace: 0pt)[
  Card deck example. We have prior beliefs about the probabilities of certain events, but we want to be able to change those beliefs in response to new information.
]


== Bayes Rule

Note that there are two different ways to factor a joint distribution of two variables:
$
  P(a,b) = P(a | b)P(b) = P(b | a)P(a)
$

Rewriting this we can work between different "directions" of conditioning:
$
  P(x|y) = (P(y|x)P(x))/P(y)
$

This is _Bayes Rule_ and might be the single most important formula in all of AI and Machine Learning. This is because we can use Bayes rule to build agents which _update their beliefs in response to data_.
$
  P("cause"|"evidence") = (P("evidence"|"cause")P("cause"))/P("evidence")
$

We call the standalone $P("cause")$ term the _prior_ which represents the agents prior belief about an unseen variable before getting any evidence. We call $P("cause"|"evidence")$ the _posterior_ which represents the new belief the agent has about the variable updated in response to evidence. We refer to the $P("evidence" | "cause")$ term as the _likelihood_ which measures how well a model explains the data.


#discussion()[
  Suppose there is a rare disease, $italic("Senioritis")$ where $P(italic("Senioritis")) = 0.01$. A symptom of senioritis is not studying, and so we can have conditional probabilities:
  $
    & P(italic("study") | italic("senioritis")) = 0.1 \
    & P(italic("study") | not italic("senioritis")) = 0.9 \
  $
  If we know that a student did not study, what is the probability that they have senioritis?
]



== Choosing Priors

A big component of Bayesian modeling is _choosing appropriate priors_. The effect of priors on analysis is one of the big differences between the Bayesian approach and the more common frequentist approach to probability (with the interpretation of what probability even is being the other big difference). We can use priors to encode pre-existing or expert knowledge about a domain, but be careful as biased and wrong priors can make learning and inference either much slower (i.e. needing more data to converge to the "right" posterior) or even just wrong (consider what setting a prior probability to $0$ or $1$ will do).

The general best method for coming up with priors when you don't have any special external knowledge to encode, is to precisely encode this lack of understanding as a "flat prior". However, this can be tricker than it appears as it depends on the parameter space as well as the effect of those parameters on the data transformations they correspond to. A more principled approach is to use what are called "Jefferys Priors", which are priors which is proportional to the square root of the determinant of the Fisher information matrix of the parameters ($p(theta) prop sqrt(|I(theta)|)$) which has the special property of being _invariant under a change of coordinates for $theta$_.
