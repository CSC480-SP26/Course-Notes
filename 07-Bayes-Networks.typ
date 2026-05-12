
#import "wdf.typ": *

#show: template.with(
  title: [
    Bayes Networks
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover the visual language of BayesNets (or Probabilistic Graphical Models), and how they are used to model complex probabilistic relationships.],
  bib: none,
  serif: true,
  exam: false,
)






#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]


= Bayes Networks

If we have a joint distribution for some set of random variables, we can answer any question about probabilities by inference through enumeration. However if there are $n$ random variables, each with a sample space of size $d$, then the joint distribution table must have $d^n$ entries, which in general we cannot hope to keep in memory for any nontrivial problem.

However, if we know something about the domain, and thus the conditional independence of the different variables, we can save an enormous amount of space by _factoring_ the joint distribution in terms of conditional distributions. A Bayes Net (or Probabilistic Graphical Model) gives us a _language for specifying a conditional factorization structure of the joint distribution_.

#def(term: "Bayes Net")[
  A Bayes Net consists of:
  + A _directed acyclic graph_ of nodes, where each node corresponds to a single random variable ($X$).
  + A _conditional probability distribution_ for each node $P(X | "parents"(X))$

  Which together encode all of the information of the entire joint distribution (i.e. how the joint distribution factorizes in terms of conditional distributions)

  Thus for the set of $N$ random variables, the joint distribution can be written as
  $
    P(X_1, X_2, ..., X_N) = product_(i=1)^N P(X_i | "parents"(X_i))
  $
]


The structure of a Bayes net graph encodes the conditional independence of the constituent variables. It is these conditional independence assumptions that allows the storage of multiple small probability tables instead of one huge table.

While encoding conditional independence and conditional distributions, remember that there is no sense in which edges in a Bayes Net must refer to a _causal_ relationship, just that there is _some_ relationship. Furthermore, these decisions about relationships (or lack thereof) are all _modeling choices_ that enable real world problem solving. But since *all models are wrong*, since they are necessarily simplifications, we must very carefully interrogate these simplifications.

#discussion(vspace: 0pt)[
  Consider two models of the same two variables, rain and traffic. In one model we draw both variables as disconnected and independent. In the other we model rain as linked toward traffic. If an agent were to use either of those models as part of it's probabilistic reasoning, which might you expect to be more useful? Also consider the other direction, with traffic linked toward rain, what is the difference? Think about _causality_ and how it is useful but not enforced (especially if there may be missing variables).
]

== Example
Consider an example of a Bayes net of slightly expanded problem from the previous lecture. Here the random variables are:
- $B$ : Representing if a burglary occurs
- $E$ : Representing if an earthquake occurs
- $F$ : Representing if a fire occurs
- $S$ : Representing if a smoke occurs
- $A$ : Representing if a the alarm goes off
- $J$ : Representing if Jeff calls 911
- $M$ : Representing if Musty calls 911

#figure(caption: [Example of Bayes Net], diagram(
  edge-stroke: 0.75pt,
  node-corner-radius: 10pt,
  node-stroke: 1pt,
  edge-corner-radius: 10pt,
  node((-1, -0.5), [$B$], name: <b>),
  node((-2, 0.5), [$F$], name: <f>),
  node((-1, 0.5), [$S$], name: <s>),
  node((0, 0), [$A$], name: <a>),
  node((1, -0.5), [$J$], name: <j>),
  node((1, 0.5), [$M$], name: <m>),
  node((2, 0), [$E$], name: <e>),

  edge(<b>, <a>, "->"),
  edge(<f>, <s>, "->"),
  edge(<s>, <a>, "->"),
  edge(<a>, <j>, "->"),
  edge(<a>, <m>, "->"),
  edge(<e>, <m>, "->"),
  edge(<e>, <j>, "->"),
  edge(<e>, <a>, "->"),
))
#discussion()[
  Write out the joint distribution in terms of the conditional distributions according to the provided Bayes Net.
]

#pagebreak()
== Conditional Independence in Bayes Nets

If the conditionals of a Bayes Net do in fact factorize the joint distribution, then the graph structure of the network allows us to make a number of claims of the conditional independence of the variables (this, essentially, is just the interpretation of _what we actually mean when we make a model using a Bayes net_). We have that:
+ Each node is conditionally independent of all ancestor nodes#sidenote()[Importantly, ancestors include _all non descendants_ which could, in principle, be earlier than $X$ in the DAG ordering.] in the graph, given all of its parents.
+ Each node is conditionally independent of _all other variables_ given its _Markov Blanket_

#def(term: [Markov Blanket])[
  A node's Markov blanket is the set of all of a node's parents, children, and other parents of it's children.
]


#figure(caption: [Markov Blanket for $X$], diagram(
  edge-stroke: 1pt,
  node-corner-radius: 10pt,
  node-stroke: 1pt,
  edge-corner-radius: 10pt,
  node((0, 0), [$X$], name: <x>),
  node((-1, -1), [$P$], name: <p1>),
  node((1, -1), [$P$], name: <p2>),
  node((-1, 1), [$C$], name: <c1>),
  node((1, 1), [$C$], name: <c2>),
  node((-2, 0), [$S$], name: <s1>),
  node((2, 0), [$S$], name: <s2>),

  node((0, -1), [...], stroke: none),
  node((0, 1), [...], stroke: none),

  edge(<p1>, <x>, "->"),
  edge(<p2>, <x>, "->"),
  edge(<x>, <c1>, "->"),
  edge(<x>, <c2>, "->"),
  edge(<s1>, <c1>, "->"),
  edge(<s2>, <c2>, "->"),

  edge((rel: (0, -1), to: <p1>), <p1>, "-->"),
  edge((rel: (0, -1), to: <p2>), <p2>, "-->"),
  edge((rel: (0, -1), to: <s1>), <s1>, "-->"),
  edge((rel: (0, -1), to: <s2>), <s2>, "-->"),
  edge(<s1>, (rel: (0, 1), to: <s1>), "-->"),
  edge(<s2>, (rel: (0, 1), to: <s2>), "-->"),
  edge(<c1>, (rel: (0, 1), to: <c1>), "-->"),
  edge(<c2>, (rel: (0, 1), to: <c2>), "-->"),
))

#discussion()[
  Examine the earlier example of the alarm. Note how when writing the joint distribution in terms of the Bayes Net (i.e. $P(x | "parents")$), and then writing the joint in terms of the chain rule (i.e. $P(x | "parents", "ancestors")$), the equation holds precisely as the conditional independence rules above hold.
]

#pagebreak()
= D-separation
D-separation (direct separation) is the process by which we can query the structure of a Bayes Net to answer questions about the conditional independence between arbitrary variables given arbitrary variables. Note that while the topology of the graph can communicate when _variables must be conditionally independent_, it does not enforce the other direction. It is possible that variables which the network considers possibly dependent may be, in reality, conditionally independent.

== Common Structures (Triples)
While there is only two kinds of two variable relationships in a network (connected or disconnected), we can categorize a larger set of three node structures that will help us understand what we are looking at in a Bayes Net.

#figure(
  caption: [Causal Chain Structure],
  diagram(
    edge-stroke: 1pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,
    node((0, 0), [$X_1$], name: <x1>),
    node((1, 0), [$X_2$], name: <x2>),
    node((2, 0), [$X_3$], name: <x3>),

    edge(<x1>, <x2>, "->"),
    edge(<x2>, <x3>, "->"),

    // node((0, 1), [$X_1$], name: <ox1>),
    // node((1, 1), [$X_2$], name: <ox2>, fill: gray.lighten(70%)),
    // node((2, 1), [$X_3$], name: <ox3>),

    // edge(<ox1>, <ox2>, "->"),
    // edge(<ox2>, <ox3>, "->"),
  ),
)

#figure(
  caption: [Common Cause Structure],
  diagram(
    edge-stroke: 1pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,
    node((0, 0), [$X_1$], name: <x1>),
    node((1, -0.35), [$X_2$], name: <x2>),
    node((1, 0.35), [$X_3$], name: <x3>),

    edge(<x1>, <x2>, "->"),
    edge(<x1>, <x3>, "->"),

    // node((2, 0), [$X_1$], name: <ox1>, fill: gray.lighten(70%)),
    // node((3, -0.5), [$X_2$], name: <ox2>),
    // node((3, 0.5), [$X_3$], name: <ox3>),

    // edge(<ox1>, <ox2>, "->"),
    // edge(<ox1>, <ox3>, "->"),
  ),
)

#figure(
  caption: [Common Effect Structure],
  diagram(
    edge-stroke: 1pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,
    node((1, 0), [$X_1$], name: <x1>),
    node((0, -0.35), [$X_2$], name: <x2>),
    node((0, 0.35), [$X_3$], name: <x3>),

    edge(<x1>, <x2>, "<-"),
    edge(<x1>, <x3>, "<-"),

    // node((3, 0), [$X_1$], name: <ox1>, fill: gray.lighten(70%)),
    // node((2, -0.5), [$X_2$], name: <ox2>),
    // node((2, 0.5), [$X_3$], name: <ox3>),

    // edge(<ox1>, <ox2>, "<-"),
    // edge(<ox1>, <ox3>, "<-"),

    node((3, 0), [$X_3$], name: <gx1>),
    node((4.5, 0), [$X_4$], name: <gx4>),
    node((2, -0.35), [$X_1$], name: <gx2>),
    node((2, 0.35), [$X_2$], name: <gx3>),

    edge(<gx1>, <gx2>, "<-"),
    edge(<gx1>, <gx3>, "<-"),
    edge(<gx1>, <gx4>, "-->"),
  ),
)


== D-separation Algorithm
+ Shade all observed nodes ${Z_1,…Z_k}$ in the graph.
+ Enumerate all undirected paths from $X$ to $Y$.
+ For each path:
  + Decompose the path into triples.
  + If all triples are open, the path d-connects $X$ to $Y$.
+ If no path d-connects $X$ and $Y$, then $X tack.t.double Y|{Z_1,…Z_k}$#sidenote(dy: -15em)[You can also derive these triples from the rules where a path is closed if either:
    + The arrows on the path meet either head-to-tail or tail-to-tail at a colored node
    + The arrows meet head-to-head at the node, and neither the node, nor any of its descendants is colored.].

#wideblock()[

  #figure(
    caption: [Open Triples],
    diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 1), [#h(2pt)], name: <x1>),
      node((1, 1), [#h(2pt)], name: <x2>),
      node((2, 1), [#h(2pt)], name: <x3>),

      edge(<x1>, <x2>, "->"),
      edge(<x2>, <x3>, "->"),

      node((3, 1), [#h(2pt)], name: <x4>),
      node((4, 0.75), [#h(2pt)], name: <x5>),
      node((4, 1.25), [#h(2pt)], name: <x6>),

      edge(<x4>, <x5>, "->"),
      edge(<x4>, <x6>, "->"),

      node((6, 1), [#h(2pt)], name: <x7>, fill: luma(85%)),
      node((5, 0.75), [#h(2pt)], name: <x8>),
      node((5, 1.25), [#h(2pt)], name: <x9>),

      edge(<x8>, <x7>, "->"),
      edge(<x9>, <x7>, "->"),

      node((8, 1), [#h(2pt)], name: <x10>),
      node((9.25, 1), [#h(2pt)], name: <x11>, fill: luma(85%)),

      node((7, 0.75), [#h(2pt)], name: <x12>),
      node((7, 1.25), [#h(2pt)], name: <x13>),

      edge(<x12>, <x10>, "->"),
      edge(<x13>, <x10>, "->"),
      edge(<x10>, <x11>, "-->"),
    ),
  )


  #figure(
    caption: [Closed Triples],
    diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 1), [#h(2pt)], name: <x1>),
      node((1, 1), [#h(2pt)], name: <x2>, fill: luma(85%)),
      node((2, 1), [#h(2pt)], name: <x3>),

      edge(<x1>, <x2>, "->"),
      edge(<x2>, <x3>, "->"),

      node((3, 1), [#h(2pt)], name: <x4>, fill: luma(85%)),
      node((4, 0.75), [#h(2pt)], name: <x5>),
      node((4, 1.25), [#h(2pt)], name: <x6>),

      edge(<x4>, <x5>, "->"),
      edge(<x4>, <x6>, "->"),

      node((6, 1), [#h(2pt)], name: <x7>),
      node((5, 0.75), [#h(2pt)], name: <x8>),
      node((5, 1.25), [#h(2pt)], name: <x9>),

      edge(<x8>, <x7>, "->"),
      edge(<x9>, <x7>, "->"),
    ),
  )

]


#discussion()[
  #figure(
    diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,

      node((0, 0), [$A$], name: <a>),
      node((0, 1), [$B$], name: <b>),
      node((-1, 2), [$C$], name: <c>),
      node((1, 2), [$D$], name: <d>),
      node((2, 1), [$E$], name: <e>),
      node((1, 3), [$F$], name: <f>),
      node((0, 3), [$G$], name: <g>),

      edge(<a>, <b>, "->"),
      edge(<b>, <c>, "->"),
      edge(<b>, <d>, "->"),
      edge(<e>, <d>, "->"),
      edge(<d>, <f>, "->"),
      edge(<d>, <g>, "->"),
      edge(<c>, <g>, "->"),
    ),
  )
  For the provided BayesNet, which of the following conditional independences _must_ hold?

  $
    & A tack.t.double F | D \
    & A tack.t.double E \
    & A tack.t.double E | D \
    & A tack.t.double E | F \
    & A tack.t.double E | D , B \
    & A tack.t.double E | D , B \
    & C tack.t.double D \
    & C tack.t.double D | B \
    & C tack.t.double D | B, G \
  $
]


#pagebreak()
= Exact Inference: Variable Elimination
The primary task our agents might have when using Bayes Nets to model the world is _inference_, that is finding some arbitrary new conditional probability from the joint (generally as a result of conditioning on new observation data). We already know how to do this by using the Bayes Net to create the joint distribution and then using inference by enumeration, but this is intractable. Luckily we can do better while maintaining an _exact_ answer (i.e. always precisely the same probability as would be generated by full join inference), using a technique called _Variable Elimination_#sidenote()[While this method is much more efficient than the exponntial inference by enumeration, it is still NP-Hard and so while there are some problems for which it is tractable, often we will need to use approximate solutions which wil be covered next].

#def(term: [Variable Elimination])[
  To _eliminate_ a variable $X$ we simply:
  + Join all _factors_ involving $X$
  + Sum out $X$

  Where a _factor_ is simply an _unnormalized probability_ given by selecting entries from the conditional probability table consistent with the evidence.
]

```py
def eliminate(x: Query, e: Evidence, bn: BayesNet):
  factors = []
  for var in bn.Variables:
    factors = [MAKE_FACTOR(var,e)] + factors
    if is_hidden_variable(var):
        factors = SUM_OUT(var,factors)
  return NORMALIZE(PRODUCT(factors))
```
== Ordering
Note that, like many of the algorithms in this class, there is a component where we need to iterate over the variables in the BayesNet in some non-deterministically defined order. It turns out that the order makes a massive impact on the efficiency of variable elimination, and heuristics are used here to choose what we think will be good orders. Such heuristics include _minimum degree_ where we prioritize eliminating variables which results in constructing the smallest factor possible, and _minimum fill_ which constructs an undirected graph of variable relations and eliminates the variable that would result in the fewest edges added after elimination.

#pagebreak()
== Example
Suppose we have the mode shown below. Where a wizard has an opportunity to take a golden statue from a suspicious pedestal in some ancient ruins. Let us say $T$ is the random variable representing if the wizard takes the statue. Then $B$ is a random variable representing if a boulder falls from the ceiling, $D$ represents darts being shot from the walls, and $E$ represents the wizard escaping the ruins. We then have the BayesNet below:
#figure()[
  #diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,

    node((0, 0), [$T$], name: <t>),
    node((1, -0.35), [$B$], name: <b>),
    node((1, 0.35), [$D$], name: <d>),
    node((2, 0), [$E$], name: <e>),

    edge(<t>, <b>, "->"),
    edge(<t>, <d>, "->"),
    edge(<b>, <e>, "->"),
    edge(<d>, <e>, "->"),
  )
]

This gives us the conditional probability distributions:
$
  P(T), P(B |T), P(D |T), P(E|B,D)
$


Suppose we want to calculate the probability that the wizard took the statue, given that it was able to escape: $P(T | e)$. Using variable elimination we dont have to calculate the whole 16 row joint, instead we can eliminate $B$ then $D$ which is done as follows:
+ Join (multiply) factors involving B, giving:
$ f_1(T,B,D,e) = P(B|T) dot P(e | B,D) $
+ Sum out $B$ from this new factor, leaving $f_2(T,D,e)$
+ Join factors involving $D$ forming:
$
  f_3(T,D,e) = P(D|T) dot f_2(T,D,e)
$
+ Sum out $D$, giving $f_4(T,e)$.
+ Join the remaining factors, which gives:
$
  f_5(T,e) = f_4(T,e) dot P(T)
$
+ Once we have $f_5(T,e)$, we can find $P(T|e)$ by normalizing.


One thing that we can see is how variable elimination improves over inference by enumeration. In inference by enumeration we must first join _all_ of the conditional distributions, then sum out all of the variables:
$
  sum_b sum_d P(T)P(b|T)P(d|T)P(e|b,d)
$

But in variable elimination we are able to simply move the terms that are constant in a sum outside of the sum, reducing the size of the inner tables:

$
  P(T)sum_b P(b|T) sum_d P(d|T)P(e|b,d)
$



// #pagebreak()
// = Approximate Inference: Sampling

// == Monte Carlo Methods

// == Prior Sampling

// == Rejection Sampling

// == Likelihood Weighting

// == Gibbs Sampling



// = Approximate Inference: Variational Inference
