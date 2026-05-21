
#import "../wdf.typ": *

#show: template.with(
  title: [
    Exam 2: Uncertainty
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
  In order to update our beleifs, the term $P("evidence")$ is needed, yet is rarely something that can be measured directly. Instead it is calculated by marginalizing over all possible hypotheses. Which sample space(s) describe the set over which we will sum in order to calculate $P("evidence")$?]
#columns(2)[
  #checkbox() The sample space of the _prior_: $Omega_("prior")$

  #checkbox() The sample space of the _posterior_: $Omega_("posterior")$

  #colbreak()
  #checkbox() The sample space of the _likelihood_: $Omega_("likelihood")$

  #checkbox() The sample space of the _joint distribution_: $Omega_("joint")$
]

#v(0.5fr)


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
#v(1fr)

#subquestion()[
  We then observe that, in addition to the call, the house is also hot. Qualitatively, what would we expect _this new observation_ to do to our _previous estimation _of the probability of there being an earthquake? (i.e. Should it go up/down?)
]


#v(1fr)

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
      edge(<w>, <z>, "->"),
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

      edge(<x>, <w>, "->"),
      edge(<z>, <w>, "->"),
    )
  ]


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
#v(1fr)

#subquestion()[After conditioning on Z from the previous question, which additional _individual nodes_ could be added to $Z$ such that B and E _would no longer be ensured to be conditionally independent when adding that single node?_ That is, name all nodes, X, such that $B tack.t.double E | (Z union {X})$ ceases to hold.]
#v(1fr)


#subquestion()[After adding all of the nodes found from the previous question to Z, does there exist another single node that when _also_ added to Z, makes B and E once again conditionally independent? If so what is that node?]
#v(1fr)



#question(
  points: 0.5,
)[Using the same Bayes net as the previous question, what are the _Markov Blankets_ of each of the nodes?]
#columns(2)[
  #subquestion()[Markov Blanket of $A$: #blank()
  ]
  #subquestion()[Markov Blanket of $B$: #blank()
  ]
  #subquestion()[Markov Blanket of $C$: #blank()
  ]
  #colbreak()
  #subquestion()[Markov Blanket of $D$: #blank()
  ]
  #subquestion()[Markov Blanket of $E$: #blank()
  ]
  #subquestion()[Markov Blanket of $F$: #blank()
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
#v(1fr)

#subquestion()[
  To improve efficiency even more, you decide to use likelihood weighting to generate samples. For the following samples, write out the weight of each sample in terms of the conditional probabilities of the Bayes Net.]

Sample 1: $[F=1, #h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=1,#h(0.75em) A=1,#h(0.75em) C=0]$ #h(0.75em) Weight: #blank(width: 15em)\ #v(1em)
Sample 2: $[F=1, #h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=1,#h(0.75em) A=1,#h(0.75em) C=1]$ #h(0.75em) Weight: #blank(width: 15em)\ #v(1em)
Sample 3: $[F=0, #h(0.75em) H=1, #h(0.75em) E=1, #h(0.75em) S=0,#h(0.75em) A=1,#h(0.75em) C=1]$ #h(0.75em) Weight: #blank(width: 15em)\ #v(1em)
Sample 4: $[F=0, #h(0.75em) H=1, #h(0.75em) E=0, #h(0.75em) S=0,#h(0.75em) A=1,#h(0.75em) C=0]$ #h(0.75em) Weight: #blank(width: 15em)\ #v(1em)

#v(1fr)

#subquestion()[
  Based on the likelihood weighted samples, what is the estimated probability for the query $P(E=1| H=1,A=1)$? Write your answer in terms of the weights of the samples: $w_1, w_2, w_3$, and  $w_4$.]
#v(5em)

#v(1fr)

#pagebreak()
#question(
  points: 0.5,
)[Let try to approach the same problem as the previous question using Gibbs Sampling. We start with an initialization of\ \
  $[F=1, #h(1em) H=1,#h(1em) E=0, #h(1em) S=1, #h(1em) A=1,#h(1em) C=1]$\ \
  We then choose $S$ as a variable to resample. What is the probability that our resampled value is $S=0$. Write your answer in terms of the conditional distributions of the Bayes Net.
]


#v(5fr)

#question(
  points: 0.1,
)[What is the probability that your answer to this question is correct, given that you mark exactly one answer?#footnote()[Dont worry, any answer will get full credit]]
#columns(2)[
  #checkbox() $0.25$

  #checkbox() $0.5$

  #colbreak()

  #checkbox() $0$

  #checkbox()$0.25$
]
#v(1fr)

