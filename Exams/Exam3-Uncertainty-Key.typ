
#import "../wdf.typ": *

#show: template.with(
  title: [
    Exam 3: Uncertainty
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


= Probability

#question(
  points: 0.5,
)[Agents frequently use Bayes rule to estimate the probability of hypotheses given evidence:

  $
    P(H|"evidence") = (P("evidence"|H)P(H))/P("evidence")
  $
  In order to update our beliefs, the term $P("evidence")$ is needed, yet is rarely something that can be measured directly. Instead it is calculated by marginalizing over all possible hypotheses. Which sample space(s) describe the set over which we will sum in order to calculate $P("evidence")$?]
#columns(2)[
  #answer[$qed$] The sample space of the _prior_: $Omega_("prior")$

  #checkbox() The sample space of the _posterior_: $Omega_("posterior")$

  #colbreak()
  #checkbox() The sample space of the _likelihood_: $Omega_("likelihood")$

  #checkbox() The sample space of the _joint distribution_: $Omega_("joint")$
]

#answer[$Omega_("prior")$: To compute $P("evidence")$, we marginalize over all possible hypotheses, $P("evidence") = sum_H P("evidence"|H) dot P(H)$. The index of this sum is $H$, which ranges over every hypothesis the agent considers plausible(the domain of the prior $P(H)$). We weight each hypothesis by its prior probability, multiply by the likelihood of observing the evidence under that hypothesis, and sum the results. This produces the total (marginal) probability of the evidence, which is sometomes referred to as  the _normalizing constant_#sidenote[https://en.wikipedia.org/wiki/Normalizing_constant#Bayes'_theorem] of Bayes' rule, ensuring the posterior sums to one.]

#answer[$Omega_("posterior")$: The posterior $P(H|"evidence")$ is the quantity we are _trying to compute_; it cannot be defined until $P("evidence")$ is already known. Using the posterior's sample space to calculate $P("evidence")$ is circular.]

#answer[$Omega_("likelihood")$: The likelihood $P("evidence"|H)$ is a function of $H$ for a fixed observation, but its not a proper probability distribution over $H$(it doesnt need sum to one over the hypotheses). Describing the sum as ranging over "the likelihood's sample space" confuses the variable the likelihood is conditioned on ($H$) with the variable it is a distribution over (evidence). We can think of the likelihood as tool used inside the sum, as opposed to the structure that defines what we sum over.]

#answer[$Omega_("joint")$: It is true that we can write $P("evidence") = sum_H P("evidence", H)$, where $P("evidence", H)$ is the joint, so the joint distribution is part of the calculation. However, the sample space we are summing over in that expression is still just $H$(ie $Omega_("prior")$). The full joint sample space $Omega_("joint")$ is the Cartesian product $Omega_("evidence") times Omega_("prior")$, consisting of all pairs of a possible evidence value and a possible hypothesis. If we actually summed over that entire space we would compute $sum_("e", H) P("e", H) = 1$, which is just the total probability mass of the joint, always 1 regardless of what was observed. So what we do is fix the observed evidence and sum only over $H$(which is $Omega_("prior")$). In the end, the joint gives a valid formula, but $Omega_("joint")$ is not the correct description of the summation domain.]

#pagebreak()

#question(
  points: 0.6,
)[Let us imagine a scenario where we have some conditional distributions describing a fire alarm system. We have the variables: $F$ representing if there is a fire, $S$, representing if there is smoke, $A$ representing if there is an alarm, $H$ representing if the house is hot, $E$ representing if there is an earthquake, and $C$ representing if someone called 911. We will model the problem to include the following statements:
  #columns(2)[
    - $P(S|F) > P(S)$ (i.e. Fire makes smoke more likely.)
    - $P(H|F) > P(H)$ (i.e. Fire makes heat more likely.)
    - $P(A|E) > P(A|S) > P(A)$ (i.e. Smoke and earthquakes make alarms more likely.)
    #colbreak()
    - $F tack.t.double E$ (i.e. Fires occur independently of Earthquakes.)
    - $P(C|not A) =0$ (i.e. Someone only calls 911 if there is an alarm.)

  ]

  We start, like all good Bayesians, with some baseline prior distribution of how likely all of the variables are to be true.
]
#subquestion()[
  Now imagine we observe that someone has called 911. Qualitatively, what would we expect this observation to do to our estimation of the probability of there being an earthquake? (i.e. Should it go up/down?)
]

#answer[P(E) goes up. Since $P(C | not A) = 0$, observing $C = "true"$ tells us with certainty that $A = "true"$. The alarm has two possible causes: an earthquake ($E$) and smoke ($S$, which itself is caused by fire $F$). Before any observation both were considered unlikely at baseline; observing that the alarm is on is evidence in favor of _both_ causes. By Bayes rule, $P(E | A) > P(E)$ because $E$ is one of the explanations for why $A$ occurred. The same logic raises $P(F)$ (through $S$). So our estimate of $P(E)$ increases.]

#v(0.5fr)

#subquestion()[
  We then observe that, in addition to the call, the house is also hot. Qualitatively, what would we expect _this new observation_ to do to our _previous estimation _of the probability of there being an earthquake? (i.e. Should it go up/down?)
]

#answer[P(E) goes back down (relative to our previous estimate after observing $C$). This is the _explaining away_ effect. After observing the alarm (via $C$), both $E$ and $F$ were candidate explanations. Now we additionally observe $H = "true"$. Since $P(H | F) > P(H)$, heat is direct evidence for fire, so $P(F | A, H)$ increases substantially. Crucially, $F$ and $E$ are marginally independent ($F tack.t.double E$), but they are _not_ independent given their common effect $A$: once we know the alarm fired, evidence that $F$ caused it makes $E$ less necessary as an explanation. Formally, $P(E | A, H) < P(E | A)$ because $F$ (now strongly supported by $H$) already accounts for $A$, leaving less probability mass for $E$ to explain. The alarm is "explained away" by the fire evidence, so our earthquake estimate falls back toward the prior.]

#v(0.5fr)


#pagebreak()
= Bayes Nets
#question(
  points: 0.6,
)[Consider the following provided conditional probability tables for the binary random variables $X, Y, W, " and" Z$. Circle the any/all of the Bayes Net(s) below that could represent a joint distribution consistent with the provided conditional probabilities _*using the fewest possible edges*_. ]
#figure()[
  #columns(4)[
    #table(
      columns: 2,
      align: (center, center),
      stroke: 0.5pt,
      [$X$], [$P(X)$],
      [0], [0.75],
      [1], [0.25],
    )
    #colbreak()
    #table(
      columns: 3,
      align: (center, center),
      stroke: 0.5pt,
      [$X$], [$W$], [$P(W|X)$],
      [0], [0], [0.4],
      [0], [1], [0.6],
      [1], [0], [0.4],
      [1], [1], [0.6],
    )
    #colbreak()
    #table(
      columns: 3,
      align: (center, center),
      stroke: 0.5pt,
      [$X$], [$Y$], [$P(Y|X)$],
      [0], [0], [0.3],
      [0], [1], [0.7],
      [1], [0], [0.1],
      [1], [1], [0.9],
    )
    #colbreak()
    #table(
      columns: 3,
      align: (center, center),
      stroke: 0.5pt,
      [$Z$], [$W$], [$P(W|Z)$],
      [0], [0], [0.2],
      [0], [1], [0.8],
      [1], [0], [0.8],
      [1], [1], [0.2],
    )
  ]
  #v(3em)

  #columns(3)[
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <y>, "->"),
      edge(<y>, <z>, "->"),
    )
    #v(3em)

    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <w>, "->"),
      edge(<x>, <y>, "->"),
      edge(<z>, <w>, "->"),
    )
    #v(3em)
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <z>, "->"),
      edge(<w>, <y>, "->"),
    )
    #colbreak()
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <y>, "->"),
    )
    #v(3em)
    #answer[ #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <y>, "->"),
      edge(<w>, <z>, "->"),
    )]
    #v(3em)
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <w>, "->"),
      edge(<y>, <z>, "->"),
    )
    #colbreak()
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <y>, "->"),
      edge(<w>, <y>, "->"),
      edge(<z>, <y>, "->"),
    )
    #v(3em)
   #answer[ #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,

      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <y>, "->"),
      edge(<z>, <w>, "->"),
    )]
    #v(3em)
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [$X$], name: <x>, radius: 1.5em),
      node((1, 0), [$W$], name: <w>, radius: 1.5em),
      node((0, 1), [$Y$], name: <y>, radius: 1.5em),
      node((1, 1), [$Z$], name: <z>, radius: 1.5em),

      edge(<x>, <w>, "->"),
      edge(<z>, <w>, "->"),
    )
  ]


]

#pagebreak()

Three facts from the conditional probability tables drive every decision below:
+ $P(W|X)$ is identical for $X=0$ and $X=1$, so $W tack.t.double X$. Any edge between $X$ and $W$ is wrong.
+ $P(Y|X)$ differs across $X$, so $Y$ depends on $X$. An $X -> Y$ edge is required.
+ $P(W|Z)$ differs across $Z$, so $W$ and $Z$ are dependent. An edge between them (in either direction) is required.

The minimum number of edges is therefore *2*: one $X -> Y$ edge and one $W$-$Z$ edge.

#answer[Graph 5 ($X -> Y$, $W -> Z$) is correct. This graph has two edges, which is the minimum required. The $X -> Y$ edge correctly encodes the fact that $P(Y|X)$ differs across values of $X$, meaning $Y$ is not independent of $X$. Because $P(W|X)$ is the same for both values of $X$, $W$ is independent of $X$ and there is no edge between them. $W$ is therefore a root node, and its marginal distribution can be read directly from the tables as $P(W=0)=0.4$ and $P(W=1)=0.6$. The $W -> Z$ edge encodes the dependency between $W$ and $Z$ that we observe in $P(W|Z)$. In this direction, $Z$ is a child of $W$, so the CPT we need is $P(Z|W)$, which is not given directly but can be derived from $P(W|Z)$ and $P(W)$ via Bayes rule, and the result is consistent with all the provided tables.

Graph 6 ($X -> Y$, $Z -> W$) is correct. This graph also has two edges. The $X -> Y$ edge is correct for the same reason as in Graph 5. In this graph the $W$-$Z$ edge is reversed: $Z$ is the root and $W$ is the child. This means the CPT we need is $P(W|Z)$, which is given directly in the tables, so no derivation is required. To find the marginal distribution of the root $Z$, we marginalize: $P(W=0) = P(W=0|Z=0) dot P(Z=0) + P(W=0|Z=1) dot P(Z=1) = 0.2 dot P(Z=0) + 0.8 dot P(Z=1) = 0.4$, which solves to $P(Z=1) = 1/3$. There is again no $X$-$W$ edge, preserving $W tack.t.double X$. Graphs 5 and 6 represent the same set of conditional independencies and both produce joint distributions consistent with all four tables. The direction of the $W$-$Z$ edge cannot be determined from the given CPTs alone, so both are valid.

Graph 1 ($X -> Y$, $Y -> Z$) is wrong. This graph uses two edges but assigns them to the wrong variables. The $X -> Y$ edge is correct. The second edge is $Y -> Z$, which places $Z$ as a child of $Y$. The problem with this is that $W$ is left completely disconnected from the rest of the graph. A node with no edges is independent of every other variable in the network. However, the table $P(W|Z)$ shows that $W$ and $Z$ are dependent, since the distribution of $W$ changes depending on the value of $Z$. Because this graph cannot represent any dependency between $W$ and $Z$, it is inconsistent with the provided tables.

Graph 2 ($X -> Y$ only) is wrong. This graph uses only one edge, which is fewer than the minimum of two. The single $X -> Y$ edge correctly captures the dependence of $Y$ on $X$, but both $W$ and $Z$ are left as isolated root nodes with no edges between them. Two nodes with no connecting path are marginally independent in a Bayes net. However, $P(W|Z)$ varies with $Z$, which is direct evidence that $W$ and $Z$ are not independent. This graph therefore cannot be consistent with the tables.

Graph 3 ($X -> Y$, $W -> Y$, $Z -> Y$) is wrong. This graph uses three edges, and we have established that two are sufficient, so it violates the "fewest possible edges" requirement and can be eliminated on that basis alone. Additionally, the structure is problematic in its own right: making $Y$ a child of $W$, $X$, and $Z$ simultaneously turns $Y$ into a collider node. A collider creates a dependency between its parents conditioned on it, meaning that observing $Y$ would make $W$ and $Z$ dependent even if they are marginally independent. This induced dependency is not supported by the CPTs and would make the graph encode a different joint distribution than intended.

Graph 4 ($X -> W$, $X -> Y$, $Z -> W$) is wrong. This graph uses three edges, so it is immediately eliminated by the minimality requirement. Beyond the edge count, the $X -> W$ edge is structurally incorrect. That edge asserts that the distribution of $W$ depends on the value of $X$. The CPT $P(W|X)$ shows the opposite: $W$ has the same distribution whether $X=0$ or $X=1$, which means $W tack.t.double X$. No graph that includes an $X$-$W$ edge can be consistent with this independence.

Graph 7 ($X -> Z$, $W -> Y$) is wrong. This graph uses two edges, so it is not eliminated by the minimality requirement, but neither edge is correct. The $X -> Y$ edge that every valid graph must include is missing. Instead, $X$ is connected only to $Z$, and $W$ is connected only to $Y$. Because there is no directed path from $X$ to $Y$, the graph implies that $Y$ and $X$ are independent. The CPT $P(Y|X)$ directly contradicts this: the distribution of $Y$ shifts substantially between $X=0$ and $X=1$, so $Y$ must depend on $X$. This graph is therefore inconsistent with the provided tables.

Graph 8 ($X -> W$, $Y -> Z$) is wrong. This graph has two edges but both are wrong. The $X -> W$ edge asserts that $W$ depends on $X$, but $P(W|X)$ is constant, so $W tack.t.double X$ and this edge should not exist. The $Y -> Z$ edge creates a dependency between $Y$ and $Z$, but the tables give no CPT relating $Y$ and $Z$ directly, and there is no evidence such a dependency is required. Furthermore, the $X -> Y$ edge required by $P(Y|X)$ is absent, and the $W$-$Z$ dependency required by $P(W|Z)$ is also unrepresented. This graph fails on every count.

Graph 9 ($X -> W$, $Z -> W$) is wrong. The $X -> W$ edge is again incorrect for the same reason as in Graphs 4 and 8: $P(W|X)$ is constant, so $W tack.t.double X$. The $Z -> W$ edge is correct in isolation since $P(W|Z)$ shows that $W$ depends on $Z$. However, the required $X -> Y$ edge is entirely absent. $Y$ has no parents and no edges into it, making it a root with a fixed marginal distribution. This contradicts $P(Y|X)$, which shows that the distribution of $Y$ changes with $X$. So while one of the two edges is correct, the other is wrong and the required $X -> Y$ edge is missing.
]

#pagebreak()


#question(
  points: 0.6,
)[Consider the following Bayes Net. For the nodes $B$ and $E$ we will be adding to a set $Z$ of nodes which will effect the conditional independence of the nodes $B$ and $E$ (i.e. whether the network ensures $B tack.t.double E | Z$).]


#figure(
  diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,

    node((0, 0), [$A$], name: <a>),
    node((0, 1), [$D$], name: <d>),

    node((1, 0), [$B$], name: <b>),
    node((1, 1), [$E$], name: <e>),

    node((2, 0), [$C$], name: <c>),
    node((2, 1), [$F$], name: <f>),

    node((3, 0), [$G$], name: <g>),
    node((3, 1), [$H$], name: <h>),

    edge(<a>, <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<c>, <g>, "->"),
    edge(<g>, <h>, "->"),
    edge(<c>, <f>, "->"),
    edge(<d>, <c>, "->"),
    edge(<d>, <e>, "->"),
    edge(<e>, <f>, "->"),
    edge(<f>, <g>, "->"),
  ),
)
#subquestion()[What is the _smallest_ set of nodes $Z$ that we can condition on such that  $B tack.t.double E | Z$?]

#answer[$Z = emptyset$ (the empty set). To check whether $B tack.t.double E$ holds we enumerate every undirected path between $B$ and $E$ and verify that each one is blocked. There are exactly three such paths:

+ $B -> C <- D -> E$: the node $C$ has two arrows pointing into it from $B$ and from $D$, forming a V-shape where $C$ sits at the bottom with both edges directed inward. This makes $C$ a common effect (sometimes called a collider#sidenote[https://en.wikipedia.org/wiki/Bayesian_network#Structure_learning]) on this path, since $C$ is jointly caused by both $B$ and $D$. A common effect blocks a path when neither it nor any of its descendants is conditioned on. With $Z = emptyset$, $C$ is not conditioned on and neither are its descendants $F$, $G$, $H$. Path blocked.

+ $B -> C -> F <- E$: the node $F$ has two arrows pointing into it from $C$ and from $E$, again a V-shape with both edges directed into the center node, making $F$ a common effect on this path. $F$ and its descendants $G$, $H$ are not in $Z$. Path blocked.

+ $B -> C -> G <- F <- E$: the node $G$ has two arrows pointing into it from $C$ and from $F$, making $G$ a common effect. $G$ and its only descendant $H$ are not in $Z$. Path blocked.

Every path is blocked, so $B tack.t.double E$ holds without conditioning on anything at all.]

#subquestion()[After conditioning on Z from the previous question, which additional _individual nodes_ could be added to $Z$ such that B and E _would no longer be ensured to be conditionally independent when adding that single node?_ That is, name all nodes, X, such that $B tack.t.double E | (Z union {X})$ ceases to hold.]

#answer[$C$, $F$, $G$, and $H$ each break the independence. Adding any of these to $Z$ activates at least one of the three paths because each one is either a common effect on a path or a descendant of a common effect, and the rule is that conditioning on a common effect or any of its descendants opens the path.

- Adding $C$: On path 1 ($B -> C <- D -> E$), $C$ is once again a common effect with both arrows pointing inward. Placing $C$ in $Z$ opens path 1. The only other internal node on that path, $D$, is a common cause and is not in $Z$, so nothing else blocks the path. Path 1 becomes active.

- Adding $F$: $F$ is a descendant of $C$ (via $C -> F$), so conditioning on $F$ also opens path 1 through the descendant rule. On path 2 ($B -> C -> F <- E$), $F$ is itself a common effect with arrows coming in from both $C$ and $E$, so placing $F$ in $Z$ opens path 2 directly as well. On path 3, $F$ appears as a causal chain (one arrow in, one arrow out), so path 3 remains blocked, but paths 1 and 2 are now active.

- Adding $G$: $G$ is a descendant of both $C$ and $F$ (via $C -> G$ and $F -> G$), opening paths 1 and 2 through the descendant rule. On path 3 ($B -> C -> G <- F <- E$), $G$ is once again a common effect with arrows coming in from both $C$ and $F$, so placing $G$ in $Z$ opens path 3 directly. All three paths become active.

- Adding $H$: $H$ is a descendant of $G$, which is itself a descendant of $C$ and $F$. Because $H$ is therefore a descendant of all three common effects across the three paths, conditioning on $H$ opens all three paths simultaneously.

Adding $A$ or $D$ does not break independence. $A$ is not on any path between $B$ and $E$ and is not a descendant of any common effect. $D$ is a common cause ($C <- D -> E$, with both arrows pointing outward from $D$) on path 1, so conditioning on $D$ only further blocks path 1 rather than opening it, and the other two paths remain blocked by their common effects.]

#subquestion()[After adding all of the nodes found from the previous question to Z, does there exist another single node that when _also_ added to Z, makes B and E once again conditionally independent? If so what is that node?]

#answer[Yes: adding $D$ restores independence. With $Z = {C, F, G, H}$, we re-examine the three paths.

- Path 1 ($B -> C <- D -> E$): $C$ is a common effect and is now in $Z$, so that V-shape is open. $D$ is a common cause with both arrows pointing outward and is not in $Z$, so nothing on this path blocks it. Path 1 is active.

- Path 2 ($B -> C -> F <- E$): $C$ appears on this path as a causal chain. The arrows at $C$ go $B -> C -> F$, meaning one arrow comes in and one goes out. $C$ is in $Z$, and conditioning on a causal chain blocks the path. Path 2 is blocked.

- Path 3 ($B -> C -> G <- F <- E$): $C$ is once again a causal chain on this path ($B -> C -> G$, one in and one out). $C$ is in $Z$. Path 3 is blocked.

Only path 1 remains active. The only internal node on path 1 that is not yet in $Z$ is $D$, a common cause with both arrows pointing outward. Conditioning on a common cause blocks the path, so adding $D$ to $Z$ blocks path 1. With $Z = {C, F, G, H, D}$, all three paths are blocked and $B tack.t.double E | {C, F, G, H, D}$ holds.]



#question(
  points: 0.5,
)[Using the same Bayes net as the previous question, what are the _Markov Blankets_ of each of the nodes?]
#columns(2)[
  #subquestion()[Markov Blanket of $A$: #answer[$\{B\}$]
  ]
  #subquestion()[Markov Blanket of $B$: #answer[$\{A, C, D\}$]
  ]
  #subquestion()[Markov Blanket of $C$: #answer[$\{B, D, E, F, G\}$]
  ]
  #colbreak()
  #subquestion()[Markov Blanket of $D$: #answer[$\{B, C, E\}$]
  ]
  #subquestion()[Markov Blanket of $E$: #answer[$\{C, D, F\}$]
  ]
  #subquestion()[Markov Blanket of $F$: #answer[$\{C, E, G\}$]
  ]
]

#v(1fr)




#pagebreak()


= Sampling
Let us return to the emergency response problem from the start of the exam. For the following questions consider the Bayes net with the provided conditional probability tables for the binary random variables representing a model of emergency response: Fire($F$), Hot($H$), Smoke($S$), Alarm($A$), and Call 911 ($C$). You are a remote emergency response agent, with access to observe the smart thermostat to detect heat, as well access to whether the alarm has gone off.
#figure()[
  #diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,

    node((0, 0), [Fire], name: <fire>),
    node((0.85, 0), [Hot], name: <hot>, fill: luma(85%)),
    node((0, 1), [Smoke], name: <smoke>),
    node((0.85, 1), [Alarm], name: <alarm>, fill: luma(85%)),
    node((1.7, 0), [Earthquake], name: <earthquake>),
    node((1.7, 1), [Call 911], name: <call>),

    edge(<fire>, <hot>, "->"),
    edge(<fire>, <smoke>, "->"),
    edge(<smoke>, <alarm>, "->"),
    edge(<alarm>, <call>, "->"),
    edge(<earthquake>, <alarm>, "->"),
    edge(<earthquake>, <call>, "->"),
  ),
  
]

#question(
  points: 0.6,
)[You detect that the alarm has triggered and it is hot ($H=1, A=1$). You now want to estimate the probability of there having been an earthquake (to manage your response), with the inference query: $P(E=1| H=1,A=1)$, and decide to use sampling to estimate it more quickly than using exact inference.]

#subquestion()[
  Using prior sampling the following samples were generated. However, since your query has conditions, it would have been more efficient to use rejection sampling. Cross out each individual variable sampling calculation (i.e. $X=0$) that could have been avoided if using rejection sampling. Assume variables are sampled in the order listed from left to right.]
#columns(2)[
  $[F=1,#h(0.75em) H=1, #h(0.75em) E=1, #h(0.75em) S=1, #h(0.75em) A=1,#h(0.75em) C=1]$\ #v(
    1pt,
  )
  $[F=1,#h(0.75em) H=0, #h(0.75em) E=1, #h(0.75em) S=0, #h(0.75em) A=1,#h(0.75em) C=0]$\ #v(
    1pt,
  )
  $[F=0,#h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=0, #h(0.75em) A=0,#h(0.75em) C=0]$
  #colbreak()
  $[F=0,#h(0.75em) H=0,#h(0.75em) E=1,#h(0.75em) S=0,#h(0.75em) A=1,#h(0.75em) C=1]$\ #v(
    1pt,
  )
  $[F=0,#h(0.75em) H=1,#h(0.75em) E=0,#h(0.75em) S=0,#h(0.75em) A=0,#h(0.75em) C=1]$\ #v(
    1pt,
  )
  $[F=0,#h(0.75em) H=0,#h(0.75em) E=0,#h(0.75em) S=0,#h(0.75em) A=0,#h(0.75em) C=0]$
]

#answer[In rejection sampling we sample variables left to right and discard everything remaining the moment a sampled evidence variable contradicts the observation ($H=1$, $A=1$).

- Sample 1: nothing crossed out. $H=1$ matches and $A=1$ matches, so the full sample is accepted.
- Sample 2: #strike[$E=1$], #strike[$S=0$], #strike[$A=1$], #strike[$C=0$]. $H=0$ contradicts the evidence at the second variable, so all four remaining draws are wasted.
- Sample 3: #strike[$C=0$]. $H=1$ matches, but $A=0$ contradicts at the fifth variable, so only $C$ is wasted.
- Sample 4: #strike[$E=1$], #strike[$S=0$], #strike[$A=1$], #strike[$C=1$]. $H=0$ contradicts at the second variable.
- Sample 5: #strike[$C=1$]. $H=1$ matches, but $A=0$ contradicts at the fifth variable, so only $C$ is wasted.
- Sample 6: #strike[$E=0$], #strike[$S=0$], #strike[$A=0$], #strike[$C=0$]. $H=0$ contradicts at the second variable.]

#subquestion()[
  To improve efficiency even more, you decide to use likelihood weighting to generate samples. For the following samples, write out the weight of each sample in terms of the conditional probabilities of the Bayes Net.]

Sample 1: $[F=1, #h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=1,#h(0.75em) A=1,#h(0.75em) C=0]$ #h(0.75em) 

Weight: #answer[$P(H=1|F=1) dot P(A=1|S=1,E=0)$]\ #v(1em)
Sample 2: $[F=1, #h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=1,#h(0.75em) A=1,#h(0.75em) C=1]$ #h(0.75em) 

Weight: #answer[$P(H=1|F=1) dot P(A=1|S=1,E=0)$]\ #v(1em)
Sample 3: $[F=0, #h(0.75em) H=1, #h(0.75em) E=1, #h(0.75em) S=0,#h(0.75em) A=1,#h(0.75em) C=1]$ #h(0.75em) 

Weight: #answer[$P(H=1|F=0) dot P(A=1|S=0,E=1)$]\ #v(1em)
Sample 4: $[F=0, #h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=0,#h(0.75em) A=1,#h(0.75em) C=0]$ #h(0.75em) 

Weight: #answer[$P(H=1|F=0) dot P(A=1|S=0,E=0)$]\ #v(1em)

#answer[The weight of each likelihood-weighted sample is the product of the conditional probabilities of the evidence variables given their parents' values in that sample. The evidence variables are $H$ (parent: $F$) and $A$ (parents: $S$, $E$). The non evidence variables $F$, $E$, $S$, and $C$ are sampled freely and do not contribute to the weight. Note that samples 1 and 2 have identical weights because they share the same values of $F$, $S$, and $E$, which are the only variables that determine the weight.]

#subquestion()[
  Based on the likelihood weighted samples, what is the estimated probability for the query $P(E=1| H=1,A=1)$? Write your answer in terms of the weights of the samples: $w_1, w_2, w_3$, and  $w_4$.]

#answer[$
  P(E=1 | H=1, A=1) approx w_3 / (w_1 + w_2 + w_3 + w_4)
$

Only sample 3 has $E=1$. The estimate is the sum of weights of samples consistent with the query ($E=1$) divided by the total weight of all samples. Samples 1, 2, and 4 have $E=0$ and appear in the denominator only.]

#pagebreak()
#question(
  points: 0.5,
)[Let try to approach the same problem as the previous question using Gibbs Sampling. We start with an initialization of\ \
  $[F=1, #h(1em) H=1,#h(1em) E=0, #h(1em) S=1, #h(1em) A=1,#h(1em) C=1]$\ \
  We then choose $S$ as a variable to resample. What is the probability that our resampled value is $S=0$. Write your answer in terms of the conditional distributions of the Bayes Net.
]

#answer[In Gibbs sampling we resample one variable at a time by drawing from its conditional distribution given all other variables held at their current values. With everything else fixed at $[F=1, H=1, E=0, S=1, A=1, C=1]$, we want:

$ P(S=0 | F=1, H=1, E=0, A=1, C=1) $

$S$ is conditionally independent of every variable outside its Markov blanket given its Markov blanket. The Markov blanket of $S$ consists of its parents, its children, and the co-parents of its children:
- Parent of $S$: $F$
- Child of $S$: $A$
- Co-parent of $A$ (i.e. $A$'s other parent): $E$

So $H$ and $C$ drop out, and the expression simplifies to:

$ P(S=0 | F=1, E=0, A=1) $

We then apply Bayes rule to flip the conditioning, since the Bayes net gives us $P(A|S,E)$ and $P(S|F)$ but not $P(S|A,E,F)$ directly:

$ P(S=0 | F=1, E=0, A=1) prop P(A=1 | S=0, E=0) dot P(S=0 | F=1) $

This is the unnormalized probability for $S=0$. We compute the same expression for $S=1$ and divide by the sum of both to normalize, giving the final result:

$
  P(S=0 | F=1,E=0,A=1) = 
$

$
(P(S=0|F=1) P(A=1|E=0,S=0)) / (P(S=0|F=1) P(A=1|E=0,S=0)+P(S=1|F=1) P(A=1|E=0,S=1))
$
]
#v(5fr)

#question(
  points: 0.1,
)[What is the probability that your answer to this question is correct, given that you mark exactly one answer?#footnote()[#answer[Dont worry, any answer will get full credit]]]
#columns(2)[
  #answer[$qed$] $0.25$

  #answer[$qed$] $0.5$

  #colbreak()

  #answer[$qed$] $0$

  #answer[$qed$] $0.25$
]
#v(1fr)

