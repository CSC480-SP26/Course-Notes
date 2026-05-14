
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


#pagebreak()
= Approximate Inference

When reasoning with Bayes Nets, our primary task is probabilistic inference, or updating and calculating probabilities in response to new observations to condition on. We can do this exactly by inference by enumeration (exponentially hard), or by variable elimination (NP-Hard). However, since the Bayes Net itself is ultimately just an approximation, perhaps we can find solutions that are approximate themselves with respect to the Bayes Net instead of needing to find the exact solution. We do this by simply counting samples from our Bayes Net conditional distribution, and counting up those samples, which ends up being massively more efficient than exact solutions in most contexts and frequently serves as a good enough approximation. #sidenote()[We will discuss some of the situations where sampling either does not produce a good approximation or has other computational limitations, and how to address them. However I also want to point you towards other approximate inference techniques outside of the scope of the course that do not rely on sampling, such as _Variational Inference_, which is a core method for most contemporary deep learning and generative models that uses training parametrized approximations rather than sampling. ]

== Monte-Carlo Methods

Our core idea for finding an approximation of an inferred probability is to use a class of solution called a Monte-Carlo method #sidenote()[In the literature you will also see reference to MCMC or Markov Chain Monte-Carlo which is the more well defined generalization of this kind of method. The approaches we will be discussing are special cases of MCMC, such as Gibbs sampling being a spacial case of the Metropolis-Hastings algorithm.].

Monte Carlo methods take as the starting point that doing probabilistic inference is hard, because reasoning about the relations of information between whole probability distributions and transformations on probability distributions requires doing computational work for not just single values, but for the full sets of vales that the probability distribution covers in the sample space. Instead what we can do is simply sample individual values from our distributions, do whatever transformations need to be done on those values, and then count up the samples to get estimates of the final distribution. The work now becomes much simpler, computation now is over concrete rather than distributional variables, and can scale to whatever degree of accuracy is needed by generating a higher number of samples, which in general may be much smaller than the exponential work needed to perform exact inference. Furthermore, samples can often be generated and processed massively in parallel.

#discussion(
  vspace: 17em,
)[Recall the definition of what we think of as computationally hard, but not impossible, problems in NP#sidenote()[Obsiously assuming P $!=$ NP]. Loosely, the class of NP is all problems for which we can check a _specific_ solution easily, but it is hard to generate a _general_ solution. Consider how the Monte-Carlo approach might relate to such problems, where we can easily generate and work with _samples_ and count them up as an estimate of the general solution _distribution_.]

== Prior Sampling
The primary thing that makes Monte-Carlo methods possible for us, is that given a Bayes Net, we can easily generate samples. For instance, consider the following simple network.

#figure()[
  #diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,

    node((0, 0), [$A$], name: <a>),
    node((1, 0), [$B$], name: <b>),
    edge(<a>, <b>, "->"),
  )
]

For this network we must have the conditional distributions: $P(A), P(B|A)$. From these distributions we can very easily generate a sample of the joint distribution by first sampling the unconditioned variable $A$ from $P(A)$ yielding some value $a$, then using that sampled value to condition for a sample of $B$ from $P(B | A=a)$ yielding $b$. This pair, $(a,b)$, is now a sample from the joint distribution $P(A,B)$, and with enough samples the count frequencies will converge to the true distribution (assuming our sampling is unbiased).

This is essentially all we need for Monte-Carlo approximate inference, the rest is just optimizations.

== Rejection Sampling
The first optimization we can do is noticing that if we have some _evidence_ that we want to condition our final distribution on, then samples that do not agree with the evidence don't help us at all. For instance, imagine in the previous example we wanted to query $P(B | A=a)$. Then every time we sampled a value $A!=a$, the resultant joint from sampling $P(B|A)$ is wasted work. Therefore we can use _rejection sampling_ to throw out any sample early once we learn that it is inconsistent with the conditioning of our query.

== Likelihood Weighting
The next optimization we can notice is that, depending on the actual probability of the conditional distributions "upstream" in a network, some joint outcomes can end up being very rare. But if we are interested in inference related to those rare outcomes, this would mean having to generate a very large number of samples in order to get enough samples in our relevant "end state".

A first crack at this might say, instead of sampling and then rejecting samples, if we have a fixed evidence condition, just set the value to that condition (i.e., just set $A=a$ and only generate samples for $P(B|a)$. In fact, this would work for our simple example. However, in general, this can sometimes result in biased estimates. We can see this by considering a set of sample variables $Z_1, ... Z_n$ and a set of evidence variables $E_1, ... E_m$. Then the joint distribution which we are trying to approximate is $P(Z_1,...,Z_n,E_1,...,E_m)$. However is we simply set the values of the evidence directly we have
$
  & P(Z_1,...,Z_n,E_1,...,E_m) = product_(i=1)^(n) P(Z_i | "Parents"(Z_i))
$
Which is actually missing the sometimes important information of the conditional distributions of the evidence, $P(E_j | "Parents"(E_j))$. Think back to just applying Bayes rule, we cannot just throw out the evidence term $P(E)$, even if we actually know what the evidence is.

We can solve this problem through  _likelihood weighting_, which works by setting a weight for each sample which is the probability of the observed evidence variables given the sample values. This way every conditional distribution contributes to the joint, where the weights serve to replace otherwise missing information. We can see how for a sample, the _weighted frequency_ becomes the true joint probability:
#wideblock()[
  $
    & P(z_1,...,z_n,e_1,...,e_m) = [product_(i=1)^(n) P(z_i | "Parents"(z_i))] dot [product_(i=1)^(m) P(e_i | "Parents"(e_i))]
  $
]

The algorithm for likelihood weighting, informally, proceeds as:
+ Initialize weight of a sample to $1$
+ For each of the variables in the Bayes Net in order, either:
  + If it is not an evidence variable, simply sample the value based on the conditional distribution of the variable.
  + If it is an evidence variable, set the value of the sample to the evidence value, and then multiply the weight of the sample by the conditional distribution of the evidence variable.
+ In the final inference probability aggregation calculation, weight each sample using its weight value.

While this is much better than rejection sampling, we still have the issue of generating accurate estimates of small probabilities. Instead of simply throwing away a large number of samples, we end up where for those probabilities we still only have a small number of highly weighed samples which dominate the estimate and thus using an effectively small sample with higher variance.

#discussion(vspace: 3em)[
  Recall the model of diagnosis for senioritis:
  $
    & P(italic("senioritis")) = 0.01 \
    & P(italic("study") | italic("senioritis")) = 0.1 \
    & P(italic("study") | not italic("senioritis")) = 0.9 \
  $
  We have the corresponding network now:
  #figure()[
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,

      node((0, 0), [Senioritis], name: <a>),
      node((1, 0), [Study], name: <b>),
      edge(<a>, <b>, "->"),
    )
  ]
  For the query, $P("Senioritis"|"Study")$, if we generate 1000 samples, how many do we expect to have senioritis? What are their weights? What about samples without senioritis? What are thier weights? When calculating the final probability, what is the expected "effective" sample size (which we can think of as the sum of the weights)?

]

== Gibbs Sampling
The fourth and final approach we will cover to sample based approximate inference is fairly different to the other approaches, but frequently much more efficient for really complex interconnected networks. Instead of starting from the "top" of the network and sampling through, for Gibbs sampling we will do operations over the whole network in a more distributed style. This may allow us to have the influence of evidence "flow both ways" where in likelihood weighting the evidence influences choices of children, but does not effect the samples of parents even though the evidence does give us information about the parents. For Gibbs sampling we want to consider the evidence when we sample _every variable_.

To do this we start by setting all of the variables in the network to completely random values (entirely ignoring the conditional distributions). We then repeatedly choose one variable at a time (not in any kind of deterministic topological order), clear its current value, and resample the value given the current assigned values of its markov blanket. Note that this is _the whole markov blanket_, not just the parents, since we are treating all variables in the network as conditions, and thus we need to condition on the whole set of conditional variables to isolate the sampled variable from the rest of the network. Luckily this generalization of the provided Bayes Net conditionals can be calculated once before the sampling process using only the set of local conditional distributions of the blanket.
This can be written as :
#wideblock()[
  $
    P(x_i | x_1,...,x_N) &= 1/Z p(x_i | "parents"(x_i)) product_(j in "children"(x_i)) p(x_j | "parents"(x_j))\
    Z &= sum_(x_i) p(x_i|"parents"(x_i))product_(j in "children"(x_i)) p(x_j | "parents"(x_j))
  $
]

Over many iterations, our samples will eventually converge to the correct distribution#sidenote()[Except in some pathological cases which can generally be addressed by performing Gibbs sampling multiple times with different initializations.]. We can see how evidence can be accounted for by simply setting the evidence variables to the evidence values and never selecting evidence variables to resample from. Since we are including all of the relevant conditional distributions at each resample we do not have the same problem as naive sampling from above (since for each actual resample we are treating the whole rest of the network as fixed conditional anyway.) You can also notice how each sample is built from the previous sample in a "chain", which is _precisely_ the chain in Markov Chain Monte Carlo methods of this this is an example.

Note that there are a few important caveats to this distribution.
+ The resultant samples are _highly dependent_ (since each sample will only differ from the previous sample in precisely one variable). This is sometimes addressed with _subsampling_ where we only include every $k^("th")$ sample in our final sample set.
+ It requires a "burn in" period where the initial samples are very unlikely due to the random initialization
+ Gibbs relies on being able to explore the whole sample space eventually  (and in principle visit each node infinitely many times). Since the initialization is a random and unlikely value, and each update only updates a single variable, if variables are strongly correlated enough to effectively "wall off" certain regions of the joint, convergence may be impossible or highly unlikely. This is frequently a consequence of the "curse of dimensionality".

However, in the limit of a large number of samples#sidenote()[Of course, with such methods what constitutes a sufficiently large sample for representativeness and convergence is not generally known ahead of time and so may be an issue.] (and frequently with the ability to throw out some predetermined amount of the initial samples) this still acts as a valid sampler.


#discussion()[
  Consider a two variable joint distribution where the probability distribution is uniform over a finite "checkerboard" in a continuous domain. What might be an issue with Gibbs sampling for this problem?
]


#discussion()[
  Consider a joint distribution over 100-bit vector where the probability distribution is uniform over all vectors except for the zero vector which has probability $1/2$. What happens with Gibbs sampling when we have a value in the nonzero region? What about the zero region? What does this imply about the effectiveness of Gibbs sampling in this context?
]
