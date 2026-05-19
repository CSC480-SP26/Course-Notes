#import "../../wdf.typ": *


#show: template.with(
  title: [
    Probability
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: none,
  bib: none,
  serif: true,
  exam: false,
)

#let answer(body) = text(fill: red, body)

#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]
= Part : Uncertainty and Probability

Q1: What is a random variable? What notation do we use to write the probability that random variable $X$ takes value $x$? What does the symbol $Omega$ denote? #sidenote[AIMA Chapter 12.1 Page 406]

#answer[
  A _random variable_ represents a value corresponding to some aspect of the environment about which we may have uncertainty. Random variables are written with capital letters; their values (drawn from the variable's _domain_) are written in lower case. We write $P(X=x)$ or simply $P(x)$ for the probability that $X$ takes value $x$.

  $Omega$ denotes the _sample space_, or the set of all actually possible values in the domain of the random variable.
]

Q2: State the two properties that any valid probability distribution must satisfy. Why are both necessary? #sidenote[Course notes: 06-Probability, Page 2]

#answer[
  + _Non-negativity_: $forall x quad P(X=x) >= 0$
  + _Normalization_: $sum_x P(X=x) = 1$

  Non-negativity is needed because probabilities represent degrees of belief or expected frequencies. So, a negative probability has no coherent interpretation. Normalization is needed because the distribution must account for every possible outcome(ie the total degree of belief across the entire sample space must be exactly 1).
]

#pagebreak()
Q3: A CSC 480 student logs every study session by day type $D$ and type of work done/studied for $T$. The resulting joint distribution is partially filled in below:

#table(
  columns: 3,
  align: (center, center, center),
  stroke: 0.5pt,
  [*D*], [*T*], [*P(d, t)*],
  [weekday], [homework], [0.28],
  [weekday], [exam],     [0.24],
  [weekday], [project],  [0.16],
  [weekend], [homework], [0.23],
  [weekend], [exam],     [0.05],
  [weekend], [project],  [$p$],
)


(a) What must $p$ be? Why?

#answer[
  $p = 1 - (0.28 + 0.24 + 0.16 + 0.23 + 0.05) = 1 - 0.96 = bold(0.04)$

  All entries of a valid joint distribution must sum to 1 (normalization). With five entries summing to 0.96, the missing entry is forced to be 0.04.
]


(b) Compute the full marginal distributions $P(D)$ and $P(T)$.

#answer[
  Marginal $P(D)$ (sum over all values of $T$):
  - $P("weekday") = 0.28 + 0.24 + 0.16 = bold(0.68)$
  - $P("weekend") = 0.23 + 0.05 + 0.04 = bold(0.32)$

  Marginal $P(T)$ (sum over all values of $D$):
  - $P("homework") = 0.28 + 0.23 = bold(0.51)$
  - $P("exam") = 0.24 + 0.05 = bold(0.29)$
  - $P("project") = 0.16 + 0.04 = bold(0.20)$
]

(c) Compute $P("exam" or "project")$, the probability a randomly chosen session involves either an exam or a project. #sidenote[Note: that exam and project are mutually exclusive outcomes; how does this simplify the calculation compared to the general disjunction formula?]

#answer[
  Since exam and project are mutually exclusive outcomes (a session cannot be both), $P("exam" and "project") = 0$ and the inclusion exclusion formula reduces to simple addition:
  $ P("exam" or "project") = P("exam") + P("project") = 0.29 + 0.20 = bold(0.49) $
]

#pagebreak()

(d) Are $D$ and $T$ independent? Check using the formal definition for at least two outcome pairs and state your conclusion.

#answer[
  Independence requires $P(d,t) = P(d) dot P(t)$ for _all_ pairs.#sidenote[Course notes: 06-Probability, Page 4, Equasion 6] Checking two:
  - (weekday, homework): $P = 0.28$; $P("weekday") dot P("homework") = 0.68 times 0.51 = 0.347 != 0.28$ 
  - (weekend, exam): $P = 0.05$; $P("weekend") dot P("exam") = 0.32 times 0.29 = 0.093 != 0.05$ 

  Both pairs fail, so $D$ and $T$ are not independent.
]

Q4: Write the general formula for computing the marginal distribution $P(X = x)$ from a joint distribution $P(X, Y)$. Explain in your own words what "marginalizing out" $Y$ means.

#answer[
  $ P(X=x) = sum_y P(X=x, Y=y) $

  "Marginalizing out" $Y$ means summing the joint probability over every possible value of $Y$, for each fixed value of $X$. This collapses the two variable joint table into a single variable distribution for $X$ by aggregating over all ways $Y$ could have been, effectively ignoring $Y$.
]

Q5: What is the difference between an _outcome_ and an _event_? Write the formula #sidenote[Course notes: 06-Probability, Page 3] for computing the probability of an event $E$ from a joint distribution.

#answer[
  An outcome is a specific, complete assignment of values to _all_ random variables simultaneously(a single row in the joint distribution table). For variables $D$ and $T$ from Q3, examples of outcomes are ("weekday", "exam") or ("weekend", "homework"). Every entry in the joint table corresponds to exactly one outcome.

  Where as an event is a _set_ of outcomes, that is to say, any subset of the sample space. Events are typically described by a partial assignment, one or more variables are fixed while others are left free. For example, "the session is on a weekday" is an event $E = {("weekday", "homework"), ("weekday", "exam"), ("weekday", "project")}$, it fixes $D = "weekday"$ but leaves $T$ unconstrained. A single outcome like ("weekday", "exam") is technically also an event (a singleton set), but usually we distinguish the two.

  To compute the probability of an event, sum the joint probabilities of every outcome it contains:
  $ P(E) = sum_((x_1, dots, x_N) in E) P(x_1, dots, x_N) $

  So for "the session is on a weekday": $P(E) = 0.28 + 0.24 + 0.16 = 0.68$, which matches the marginal $P("weekday")$ #sidenote[As it should, since marginalizing _is_ computing the probability of that event].
]

#pagebreak()

Q6: Using the joint distribution below, compute the following:

#table(
  columns: 3,
  align: (center, center, center),
  stroke: 0.5pt,
  [*X*], [*Y*], [*P(x, y)*],
  [$a$], [$c$], [0.2],
  [$a$], [$d$], [0.3],
  [$b$], [$c$], [0.4],
  [$b$], [$d$], [0.1],
)

(a) $P(a, c)$

#answer[$P(a, c) = bold(0.2)$. Read directly from the table.]

(b) $P(a)$

#answer[$P(a) = P(a,c) + P(a,d) = 0.2 + 0.3 = bold(0.5)$. Marginalize out $Y$.]

(c) $P(b or d)$

#answer[
  The event "$b$ or $d$" includes all outcomes where $X=b$ _or_ $Y=d$ (or both). By inclusion exclusion:

  $P(b or d) = P(b) + P(d) - P(b "and" d) = (0.4+0.1) + (0.3+0.1) - 0.1 = 0.5 + 0.4 - 0.1 = bold(0.8)$
]

Q7:
Derive a formula for $P(E_1 or E_2)$ in terms of $P(E_1)$, $P(E_2)$, and $P(E_1 and E_2)$. Why would simply computing $P(E_1) + P(E_2)$ give the wrong answer in general? Then extend your formula to $P(E_1 or E_2 or E_3)$.

#answer[
  $ P(E_1 or E_2) = P(E_1) + P(E_2) - P(E_1 and E_2) $

  Simply summing $P(E_1) + P(E_2)$ double counts every outcome in the intersection $E_1 and E_2$, as each such outcome contributes once to $P(E_1)$ and again to $P(E_2)$. Subtracting $P(E_1 and E_2)$ corrects for this.

  Extended by inclusion exclusion:
  $ P(E_1 or E_2 or E_3) = P(E_1)+P(E_2)+P(E_3) $
  $ - P(E_1 and E_2)-P(E_1 and E_3)-P(E_2 and E_3) + P(E_1 and E_2 and E_3) $
]

#pagebreak()

Q8: When are two events $E_1$ and $E_2$ said to be _mutually exclusive_? How does mutual exclusivity simplify the formula from Q7?

#answer[
  $E_1$ and $E_2$ are mutually exclusive when they share no outcomes: $E_1 inter E_2 = emptyset$, equivalently $P(E_1 and E_2) = 0$.

  The disjunction formula then simplifies to:
  $ P(E_1 or E_2) = P(E_1) + P(E_2) $
  since there is no overlap to subtract.
]

Q9: Define independence between events $E_1$ and $E_2$. Write the formal definition using joint probabilities. Then rewrite the definition equivalently using conditional probability.

#answer[
  $E_1$ and $E_2$ are independent, written $E_1 perp E_2$, when:
  $ P(E_1 and E_2) = P(E_1) dot P(E_2) $

  Equivalently, using conditional probability:
  $ P(E_1 | E_2) = P(E_1) quad "and" quad P(E_2 | E_1) = P(E_2) $

  So learning that one event occurred would not give insight about the probability of the other.
]

#pagebreak()

= Part : Conditional Probability and Independence

Q10: Define conditional probability $P(a | b)$ and state the formula. Explain why we restrict the sample space to $B$, and why do we then normalize by $P(b)$?

#answer[
  $ P(a | b) = P(a, b) / P(b) $

  "Given $B$" means we know $B$ has occurred, so we restrict the sample space to only those outcomes in $B$, outcomes inconsistent with $B$ are now impossible. Within that restricted space, we want the share of probability that also has $A$ occurring, which is $P(A and B)$. However, the probabilities over the restricted space no longer sum to 1 (they sum to $P(b)$ instead), so we _normalize_ by dividing by $P(b)$. This ensures the resulting conditional distribution is valid.
]

Q11: Using the joint distribution from Q3, compute $P("exam" | "weekday")$, the probability that a session is exam-related, given that it falls on a weekday. Show your work using the conditional probability formula.

#answer[
  $ P("exam" | "weekday") = P("exam", "weekday") / P("weekday") = 0.24 / 0.68 = 6/17 approx 0.353 $

  From the Q3 table: $P("exam", "weekday") = 0.24$. From Q3(b): $P("weekday") = 0.68$. About 35.3% of weekday sessions are exam-related.
]

#pagebreak()
Q12: At the start of this unit's exam, professor Wright in all of his mischievous macinations, has devised a meta scheme. He has prepared three piles of exams, pile A, pile B, and pile C. One pile contains an easy version of the exam, with questions ripped right from the study guide; the other two contain a harder version, for which presumaly very few of you will pass...

At the start of the class, students grab an exam from whichever pile they like and take them face down to their seats. You take from pile A and sit down with your mortified peers.

Sam, having taken all three exams to test them, knows which exam pile is which, and is torn. Not wanting to let the students all take the easy exam for free, but pitying the inevitable torment of the students, has annouced that pile C is one of the _hard exam_ piles.

You are allowed to get up and swap your exam for one from pile B if you so choose. #answer[#sidenote[The astute among you might have noticed that this is in fact a variation of the classic _Monty Hall_ Problem! Many people have heard explanations as to why they should swap, but don't fully grok why. Should you find yourself in that camp, see the next page for a more intuitive explanation as well as a formal mathmatical explanation.]]

(a) Before the Sam's announcement, what is $P("A is easy")$? #sidenote[Each pile is equally likely to be the easy one.]

#answer[$P("A is easy") = 1/3$]
#v(1.2cm)


(b) Use Bayes' Rule to compute $P("A is easy" | "announces C")$ and $P("B is easy" | "announces C")$.


#answer[
  First, compute the marginal $P("ann. C")$. This is the total probability of the announcement happening across all possible worlds, and appears in the denominator of Bayes' rule, it is also called the _normalizing constant_, because dividing by it ensures our posterior probabilities sum to 1.

  $P("ann. C") = 1/3 dot 1/2 + 1/3 dot 1 + 1/3 dot 0 = 1/6 + 2/6 = 1/2$

  $P("A easy" | "ann. C") = (P("ann. C" | "A easy") dot P("A easy")) / P("ann. C") = (1/2 dot 1/3) / (1/2) = bold(1/3)$

  $P("B easy" | "ann. C") = (P("ann. C" | "B easy") dot P("B easy")) / P("ann. C") = (1 dot 1/3) / (1/2) = bold(2/3)$
]


(c) Should you swap to pile B? By what factor does switching improve your odds of getting the easy exam?

#answer[
  Yes, you should swap to pile B. $P("B easy" | "ann. C") = 2/3$ vs. $P("A easy" | "ann. C") = 1/3$. Switching _doubles_ your probability of getting the easy exam (factor of 2).
]

#pagebreak()
#answer[
==== Explaining Monty Hall Intuitively
#v(.3cm)

Suppose instead of 3 piles there were _1,000_ exam piles, with 1 easy, 999 hard. You pick a random pile, for the sake of this example lets say pile \#2. Your initial probability of holding the easy exam is $1/1000$. Not great, but alas c'est la vie. However, once again, an announcement is made, and this time, it is announced that 998 of the exams you had not selected (say, exams 3-1000) were of the hard pedigree.

Now that 998 hard piles are revealed, the only remaining exams that could be easy are yours and one other.

Ask yourself, why was that one other pile left?

- The easy pile will never be eliminated.
- If your pile happened to be the easy one (probability $1/1000$), any arbitrary hard pile could have been kept.
- If your pile is hard (probability $999/1000$), the easy pile _had_ to be kept (ie there was no other option).

So with probability $999/1000$, the pile that wasn't eliminated is the easy one. You should absolutely swap.

The announcement doesn't reveal or change what you know about your pile, as you already knew some hard piles would be revealed. What it tells you is which pile was _forced_ to be preserved. When only one pile could have been kept, that pile is almost certainly the easy one.

Back to 3 piles, the same logic applies. Your pile A started at $1/3$. After the announcement that C is hard, A is still $1/3$, you learned nothing new about your own pile. But all of the remaining probability ($2/3$) is now concentrated entirely in pile B, because if A is hard (which it probably is), announcing C was the only option.


#pagebreak()

==== A More Formal Explanation
#v(.3cm)

Let $E_i$ denote the event "pile $i$ is easy" for $i in {A, B, C}$, and let $R_C$ denote the event "pile C is announced as hard." By assumption, $P(E_A) = P(E_B) = P(E_C) = 1/3$.

We want $P(E_A | R_C)$ and $P(E_B | R_C)$. By Bayes' rule:

$ P(E_i | R_C) = (P(R_C | E_i) dot P(E_i)) / P(R_C) $

The key property is the _likelihood_ $P(R_C | E_i)$, or how probable is it that C would be announced, given each possible world?

- $P(R_C | E_C) = 0$: the easy pile is never announced as hard.
- $P(R_C | E_B) = 1$: B is easy, so only A or C could be announced hard. Assuming your pile (A) would not be announced, C is the only option.
- $P(R_C | E_A) = 1/2$: A is easy, so either B or C could be announced. By symmetry, each is chosen with probability $1/2$.

The normalizing constant is $P(R_C) = 1/3 dot 1/2 + 1/3 dot 1 + 1/3 dot 0 = 1/2$, giving:

$ P(E_A | R_C) = (1/2 dot 1/3) / (1/2) = 1/3 $
$ P(E_B | R_C) = (1 dot 1/3) / (1/2) = 2/3 $

Notice the announcement provides no update to $P(E_A)$, thus it remains $1/3$. This is because $R_C$ was already expected regardless of whether A is easy; it carries no information about your pile. In contrast, all probability previously on $E_C$ gets transferred entirely to $E_B$, doubling it from $1/3$ to $2/3$.

This generalizes cleanly, with $n$ piles, after $n-2$ hard piles are announced, switching gives probability $(n-1)/n$ of the easy exam versus staying at $1/n$. Switching always improves your odds by a factor of $n-1$.
]
#pagebreak()


Q13: Define _conditional independence_ $(A perp B | C)$. Write the formal condition both in terms of $P(A | B, C)$ and in terms of $P(A and B | C)$.

#answer[
  $A perp B | C$ (read: "$A$ is conditionally independent of $B$ given $C$") holds when:
  $ P(A | B, C) = P(A | C) $

  Equivalently, in terms of joint conditional probabilities:
  $ P(A and B | C) = P(A | C) dot P(B | C) $

  In words: once $C$ is known, observing $B$ provides no additional information about $A$. The conditioning context $C$ "screens off" $A$ from $B$.
]

Q14: Explain the difference between general independence ($A perp B$) and conditional independence ($A perp B | C$). For each case below, argue whether it is possible and give a brief example or counterexample:

#answer[
  General independence ($A perp B$) means the two events are independent in the _unconditional_ sense, $P(A and B) = P(A) dot P(B)$ for all values, regardless of any third variable. Neither event gives any information about the other.

  Conditional independence ($A perp B | C$) is weaker in that it only holds _within_ the context of a known $C$. So, $P(A | B, C) = P(A | C)$. Once $C$ is observed, $B$ carries no additional information about $A$. But without knowing $C$, $A$ and $B$ may well be correlated.

]

(a) $A$ and $B$ are independent, but not conditionally independent given $C$.

#answer[
  Possible. Let $A$ = "first fair coin flip is heads" and $B$ = "second fair coin flip is heads." These are flipped independently, so in the unconditional world all four outcomes are equally likely:

  #table(
    columns: 3,
    stroke: 0.5pt,
    align: center,
    [*Flip 1*], [*Flip 2*], [*P*],
    [H], [H], [0.25],
    [H], [T], [0.25],
    [T], [H], [0.25],
    [T], [T], [0.25],
  )

  Knowing flip 1 (A) tells you nothing about flip 2 (B) as it's still 50/50 either way. That's independence: $P(A and B) = 1/4 = P(A) dot P(B) = 1/2 times 1/2$.

  Now define the event $C$ = "both flips show the same result" (HH or TT). Conditioning on $C$ means we _discard_ the mixed outcomes (HT and TH) and only consider:

  #table(
    columns: 3,
    stroke: 0.5pt,
    align: center,
    [*Flip 1*], [*Flip 2*], [*P (given C)*],
    [H], [H], [0.5],
    [T], [T], [0.5],
  )

  In _this_ restricted world, flip 1 and flip 2 are completely locked together. If you learn that flip 1 was heads (A), then flip 2 must also be heads (B), the probability jumps from 1/2 to 1:
  $ P(B = H | A = H, C) = 1 quad != quad P(B = H | C) = 1/2 $

  Why does this happen? $C$ is determined by _both_ flips together. Conditioning on $C$ creates a hidden link in that knowing the result of one flip, combined with the constraint that they must match, forces the other. The conditioning on a shared effect is what manufactures the dependence, this is the same "explaining away" mechanism as the v-structure / common-effect pattern in Bayes Nets.
]

(b) $A$ and $B$ are conditionally independent given $C$, but not generally independent.

#answer[
  Possible. This is the classic common-cause structure. Let $C$ = "it is raining," $A$ = "a person carries an umbrella," $B$ = "the streets are wet."

  Marginally (without knowing $C$), $A$ and $B$ are correlated, seeing someone with an umbrella makes wet streets more likely. They are _not_ independent:
  $P(A and B) != P(A) dot P(B)$

  But once we know $C$ (whether it is raining or not), the correlation evaporates. Rain is the sole driver of both; so knowing the umbrella status adds nothing about street wetness _given_ the rain:
  $P(B | A, C) = P(B | C)$

  So $(A perp B | C)$ but $A perp not B$. This pattern, marginally dependent but conditionally independent given a common cause, is  the structure encoded by a common cause node in a Bayes Net ($A <- C -> B$).
]

#pagebreak()

= Part : Bayes Nets

Q15: What is a Bayes Net? List its two components. Write the general formula for the joint distribution of $N$ random variables as a product of conditionals according to the Bayes Net.

#answer[
  A Bayes Net (or Probabilistic Graphical Model) is a compact representation of a joint distribution that exploits conditional independence. It consists of:
  + A directed acyclic graph (DAG) where each node corresponds to one random variable $X_i$.
  + A conditional probability distribution (CPT) for each node: $P(X_i | "parents"(X_i))$.

  Together these encode the full joint distribution via the chain-rule factorization:
  $ P(X_1, X_2, dots, X_N) = product_(i=1)^N P(X_i | "parents"(X_i)) $

  Variables with no parents appear as $P(X_i)$ (an unconditional prior). The graph structure encodes exactly which conditional independence assumptions are being made as modeling choices.
]

Q16: State the two conditional independence rules that follow directly from a Bayes Net's structure. For each, state the rule formally and explain the intuition in your own words.

#answer[
  Rule 1: Non-descendants given parents

  Each node $X$ is conditionally independent of all of its non-descendants given its parents:
  $ X perp "NonDescendants"(X) | "Parents"(X) $

  Intuition: a node's parents are its direct causes. They fully screen off $X$ from everything further upstream, because any influence an ancestor has on $X$ must pass through $X$'s parents. Once the parents are known, nothing earlier in the graph can add information about $X$.

  Rule 2: All other variables given the Markov Blanket

  Each node $X$ is conditionally independent of all other variables in the network given its Markov Blanket (parents + children + co-parents of children):
  $ X perp "Everything else" | "MB"(X) $

  Intuition: the Markov Blanket is $X$'s complete local neighbourhood. Parents directly cause $X$. Children are directly caused by $X$, but since children also have co-parents, those co-parents can carry indirect information about $X$ through the shared child, so they must be included too. Once the blanket is observed, no path from outside can reach $X$ without passing through it, cutting off all outside influence.
]

Q17: Define the Markov Blanket of a node $X$ in a Bayes Net. State the conditional independence property that the Markov Blanket implies.

#answer[
  The Markov Blanket of node $X$ is the set of:
  - All parents of $X$
  - All children of $X$
  - All other parents of $X$'s children(ie co-parents)

Importantly, $ X perp "all other variables" | "MarkovBlanket"(X) $

  That is, $X$ is conditionally independent of every other node in the network once its Markov Blanket is observed. No information from outside the blanket can reach $X$ without passing through it.
]


Q18: Name and describe the three canonical triple structures in a Bayes Net. For each, state whether information (influence) flows between the two endpoint nodes when the middle node is (i) unobserved, and (ii) observed.

#answer[
  Causal Chain
  #align(center)[#diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 8pt,
    node-stroke: 1pt,
    node((0, 0), [$X_1$], name: <cc1>),
    node((2, 0), [$X_2$], name: <cc2>),
    node((4, 0), [$X_3$], name: <cc3>),
    edge(<cc1>, <cc2>, "->"),
    edge(<cc2>, <cc3>, "->"),
  )]

  - $X_2$ unobserved: path is open. $X_1$ and $X_3$ are correlated. Information flows along the chain.
  - $X_2$ observed: path is closed. $X_1 perp X_3 | X_2$. Once you know the middle link, the two ends carry no information about each other.

  For example, think about how the season ($X_1$) $->$ temperature today ($X_2$ $->$ ice cream sales ($X_3$). Without knowing today's temperature, the season predicts ice cream sales. Once you know the temperature, the season tells you nothing extra.

  #v(0.5em)
  Common Cause

  #align(center)[#diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 8pt,
    node-stroke: 1pt,
    node((2, 0), [$X_2$], name: <cx2>),
    node((0, 1.5), [$X_1$], name: <cx1>),
    node((4, 1.5), [$X_3$], name: <cx3>),
    edge(<cx2>, <cx1>, "->"),
    edge(<cx2>, <cx3>, "->"),
  )]

  - $X_2$ unobserved: path is open. $X_1$ and $X_3$ are correlated through their shared cause.
  - $X_2$ observed: path is closed. $X_1 perp X_3 | X_2$. Once you know the common cause, the two effects become independent.

  An example could be that rain ($X_2$) $->$ umbrella ($X_1$) and rain ($X_2$) $->$ wet streets ($X_3$). Without knowing whether it rained, seeing an umbrella predicts wet streets. Once you know it rained, umbrella status tells you nothing new about the streets.

  #v(0.5em)
  Common Effect (V-structure)

  #align(center)[#diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 8pt,
    node-stroke: 1pt,
    node((0, 0), [$X_1$], name: <vx1>),
    node((4, 0), [$X_3$], name: <vx3>),
    node((2, 1.5), [$X_2$], name: <vx2>),
    edge(<vx1>, <vx2>, "->"),
    edge(<vx3>, <vx2>, "->"),
  )]

  - $X_2$ unobserved: path is closed. $X_1 perp X_3$. The two causes are independent when you haven't seen the effect.
  - $X_2$ observed (or any descendant of $X_2$): path is open. $X_1$ and $X_3$ become dependent. This is explaining away that knowing the effect and one cause shifts your belief about the other cause.

  Consider the example from the lecture notes, burglary ($X_1$) and earthquake ($X_3$) are independent events. But if the alarm ($X_2$) is going off, learning there was an earthquake makes a burglary less likely, the earthquake already explains the alarm. This is the only structure where observation _opens_ a path rather than closing one.
]

Q19: Describe the D-separation algorithm step by step. What does it mean for two variables $X$ and $Y$ to be d-separated given a set of observed variables $bold(Z)$? What can we conclude probabilistically if they are d-separated?

#answer[
  D-separation algorithm to determine whether $X tack.t.double Y | bold(Z)$ must hold:

  + Shade all observed nodes $bold(Z)$ in the graph.
  + Enumerate all undirected paths between $X$ and $Y$.
  + For each path, decompose it into overlapping triples and check whether every triple is open:
    - Causal chain or Common cause with middle node unshaded: open.
    - Causal chain or Common cause with middle node shaded: closed (blocked).
    - Common effect (v-structure) with middle node unshaded and no shaded descendant: closed.
    - Common effect (v-structure) with middle node shaded (or shaded descendant): open.
  + A path d-connects $X$ and $Y$ if every triple along it is open.
  + If no path d-connects $X$ and $Y$, then $X$ and $Y$ are d-separated given $bold(Z)$.

  If $X$ and $Y$ are d-separated given $bold(Z)$, then the Bayes Net guarantees $X tack.t.double Y | bold(Z)$, they are conditionally independent. (Note: d-connection does not guarantee dependence; it only means the network does not enforce independence.)
]

#pagebreak()
Q20: Consider the following BayesNet:

#figure(
  diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,

    node((0, 0), [$H$], name: <h>),
    node((2, 0), [$L$], name: <l>),
    node((0, 1), [$I$], name: <i>),
    node((2, 1), [$M$], name: <m>),
    node((0, 2), [$J$], name: <j>),
    node((1, 2), [$K$], name: <k>),
    node((1, 3), [$N$], name: <n>),

    edge(<h>, <i>, "->"),
    edge(<i>, <j>, "->"),
    edge(<i>, <k>, "->"),
    edge(<l>, <k>, "->"),
    edge(<l>, <m>, "->"),
    edge(<j>, <n>, "->"),
    edge(<m>, <n>, "->"),
  ),
)

For each of the following, determine whether the conditional independence _must_ hold. Apply D-separation to justify your answer.

$
  & H tack.t.double L \
  & H tack.t.double L | K \
  & H tack.t.double N \
  & H tack.t.double N | J \
  & J tack.t.double M \
  & J tack.t.double M | N \
  & K tack.t.double M \
  & K tack.t.double M | L \
  & K tack.t.double N | I, L \
$

#answer[
  The network has two v-structures: $I -> K <- L$ and $J -> N <- M$. All analysis uses d-separation: shade conditioning variables, then check every undirected path for a blocking triple.

  #v(0.4em)
  *$H tack.t.double L$: HOLDS.*

  Every path from $H$ to $L$ passes through an unobserved collider:
  - $H -> I -> K <- L$: v-structure at $K$, $K$ unobserved $->$ blocked.
  - $H -> I -> J -> N <- M <- L$: v-structure at $N$, $N$ unobserved $->$ blocked.

  All paths blocked; $H$ and $L$ are d-separated.

  #v(0.4em)
  *$H tack.t.double L | K$: does NOT hold.*

  Conditioning on $K$ activates the v-structure $I -> K <- L$ (observing a collider opens the path). The path $H -> I -> K <- L$ is now active. $H$ and $L$ are not d-separated.

  #v(0.4em)
  *$H tack.t.double N$: does NOT hold.*

  The path $H -> I -> J -> N$ is a chain with all middle nodes ($I$, $J$) unobserved, every triple is open. $H$ is a direct ancestor of $N$ with an unblocked causal path.

  #v(0.4em)
  *$H tack.t.double N | J$: HOLDS.*

  Conditioning on $J$:
  - $H -> I -> J -> N$: $J$ is an observed chain node (middle of $I -> J -> N$) $->$ blocked.
  - $H -> I -> K <- L -> M -> N$: v-structure at $K$, $K$ unobserved $->$ blocked.

  All paths blocked; d-separated.

  #v(0.4em)
  *$J tack.t.double M$: HOLDS.*

  Both paths between $J$ and $M$ pass through unobserved colliders:
  - $J <- I -> K <- L -> M$: v-structure at $K$, $K$ unobserved $->$ blocked.
  - $J -> N <- M$: v-structure at $N$, $N$ unobserved $->$ blocked.

  All paths blocked; d-separated.

  #v(0.4em)
  *$J tack.t.double M | N$: does NOT hold.*

  Conditioning on $N$ activates the v-structure $J -> N <- M$. The path $J -> N <- M$ is now active. This is explaining away: knowing the effect $N$ induces a dependence between its two causes $J$ and $M$.

  #v(0.4em)
  *$K tack.t.double M$: does NOT hold.*

  The path $K <- L -> M$ is a common-cause structure with $L$ unobserved, the triple $K <- L -> M$ is open. $K$ and $M$ share the common cause $L$ and are marginally correlated.

  #v(0.4em)
  *$K tack.t.double M | L$: HOLDS.*

  Conditioning on $L$:
  - $K <- L -> M$: $L$ is an observed common-cause node $->$ blocked.
  - $K <- I -> J -> N <- M$: v-structure at $N$, $N$ unobserved $->$ blocked.

  All paths blocked; d-separated. Once $L$ is known, $K$ and $M$ carry no information about each other.

  #v(0.4em)
  *$K tack.t.double N | I, L$: HOLDS.*

  Conditioning on both $I$ and $L$ blocks the only two paths:
  - $K <- I -> J -> N$: $I$ is an observed common-cause node $->$ blocked.
  - $K <- L -> M -> N$: $L$ is an observed common-cause node $->$ blocked.

  All paths blocked; d-separated. Note that conditioning on $I$ alone leaves the second path open, and conditioning on $L$ alone leaves the first path open, both must be observed simultaneously to achieve d-separation.
]



#pagebreak()
Q21: The following joint distribution is defined over three binary random variables $A$, $B$, $C$ (values T and F): #sidenote[Course notes: 07-Bayes-Networks, Pages 3--5]

#table(
  columns: 4,
  align: (center, center, center, center),
  stroke: 0.5pt,
  [*A*], [*B*], [*C*], [*P(A, B, C)*],
  [T], [T], [T], [0.36],
  [T], [T], [F], [0.04],
  [T], [F], [T], [0.01],
  [T], [F], [F], [0.09],
  [F], [T], [T], [0.09],
  [F], [T], [F], [0.01],
  [F], [F], [T], [0.04],
  [F], [F], [F], [0.36],
)

(a) Compute $P(A = T)$, $P(C = T)$, and $P(A = T, C = T)$. Are $A$ and $C$ marginally independent? Justify using the definition of independence.

#answer[
  Marginalizing from the table:
  - $P(A=T) = 0.36 + 0.04 + 0.01 + 0.09 = 0.50$
  - $P(C=T) = 0.36 + 0.01 + 0.09 + 0.04 = 0.50$
  - $P(A=T, C=T) = P(T,T,T) + P(T,F,T) = 0.36 + 0.01 = 0.37$

  Independence requires $P(A=T, C=T) = P(A=T) dot P(C=T)$, but:
  $ P(A=T) dot P(C=T) = 0.50 times 0.50 = 0.25 quad \
  != quad 0.37 = P(A=T, C=T) $

  Thus $A$ and $C$ are not marginally independent.
]

(b) Compute $P(A = T | B = T)$ and $P(A = T | B = T, C = T)$. Use these to determine whether $A tack.t.double C | B$ holds.

#answer[
  First compute the needed marginals from the table:
  - $P(B=T) = 0.36 + 0.04 + 0.09 + 0.01 = 0.50$
  - $P(A=T, B=T) = 0.36 + 0.04 = 0.40$
  - $P(B=T, C=T) = 0.36 + 0.09 = 0.45$

  $ P(A=T | B=T) = P(A=T, B=T) / P(B=T) = 0.40 / 0.50 = 0.80 $
  $ P(A=T | B=T, C=T) = P(A=T, B=T, C=T) / P(B=T, C=T) = \
  0.36 / 0.45 = 0.80 $

  Since $P(A=T | B=T) = P(A=T | B=T, C=T) = 0.80$, observing $C$ provides no additional information about $A$ once $B$ is known. $A tack.t.double C | B$ holds.
]

#pagebreak()

(c) For each of the four Bayes Net structures below, determine whether it _could_ correctly represent the joint distribution above. Use D-separation to state the key independence claims the structure makes, compare them to your results from (a) and (b), and justify your conclusion.

#grid(
  columns: (1fr, 1fr),
  align: center,
  gutter: 1.5em,
  [
    *(i)*
    #figure(
      diagram(
        edge-stroke: 0.75pt,
        node-corner-radius: 10pt,
        node-stroke: 1pt,
        node((0, 0), [$A$], name: <a1>),
        node((1, 0), [$B$], name: <b1>),
        node((2, 0), [$C$], name: <c1>),
        edge(<a1>, <b1>, "->"),
        edge(<b1>, <c1>, "->"),
      ),
    )
  ],
  [
    *(ii)*
    #figure(
      diagram(
        edge-stroke: 0.75pt,
        node-corner-radius: 10pt,
        node-stroke: 1pt,
        node((1, 0), [$B$], name: <b2>),
        node((0, 1), [$A$], name: <a2>),
        node((2, 1), [$C$], name: <c2>),
        edge(<b2>, <a2>, "->"),
        edge(<b2>, <c2>, "->"),
      ),
    )
  ],
  [
    *(iii)*
    #figure(
      diagram(
        edge-stroke: 0.75pt,
        node-corner-radius: 10pt,
        node-stroke: 1pt,
        node((0, 0), [$A$], name: <a3>),
        node((2, 0), [$C$], name: <c3>),
        node((1, 1), [$B$], name: <b3>),
        edge(<a3>, <b3>, "->"),
        edge(<c3>, <b3>, "->"),
      ),
    )
  ],
  [
    *(iv)*
    #figure(
      diagram(
        edge-stroke: 0.75pt,
        node-corner-radius: 10pt,
        node-stroke: 1pt,
        node((0, 0), [$A$], name: <a4>),
        node((1, 0), [$C$], name: <c4>),
        node((2, 0), [$B$], name: <b4>),
        edge(<a4>, <c4>, "->"),
        edge(<c4>, <b4>, "->"),
      ),
    )
  ],
)

#answer[
  Parts (a) and (b) established two things that any valid Bayes Net for the given data must reproduce in that, $A$ and $C$ are not marginally independent (they are correlated when $B$ is unknown), and $A tack.t.double C | B$ (they become independent once $B$ is observed). So:

  #v(0.5em)
  (i) $A -> B -> C$ which is valid.

  This is a causal chain. To check whether $A$ and $C$ are marginally independent, we apply d-separation with no variables shaded. The only path between $A$ and $C$ runs $A -> B -> C$, which is a head-to-tail configuration at $B$. Since $B$ is unobserved, this triple is open, meaning $A$ and $C$ are d-connected. They are (possibly) dependent. This is consistent with part (a). Now shade $B$ and repeat. The same path $A -> B -> C$ now passes through an observed head-to-tail node, which closes it. With every path blocked, $A tack.t.double C | B$ holds, consistent with part (b). Both facts match, so this structure is valid.

  #v(0.5em)
  (ii) $B -> A$, $B -> C$ (common cause) which is valid.

  Here $B$ is a common cause of both $A$ and $C$. Without observing $B$, the only path between $A$ and $C$ is $A <- B -> C$, a tail-to-tail configuration at $B$. An unobserved tail-to-tail node leaves the path open, so $A$ and $C$ are d-connected and (possibly) dependent which is consistent with part a. Once $B$ is shaded, the tail-to-tail node is now observed, which blocks the path and gives $A tack.t.double C | B$ meaning its consistent with part b. Importantly, despite having completely different causal semantics from structure (i), the d-separation properties are identical.

  #v(0.5em)
  (iii) $A -> B <- C$ (common effect / v-structure) which is invalid.

  This is a v-structure at $B$. The difference from the other structures is that d-separation rules are inverted at b. When $B$ is unobserved (and has no observed descendants), the path $A -> B <- C$ is blocked, not open. This means the structure claims $A$ and $C$ are marginally independent so they carry no information about each other as long as $B$ is unknown. But part (a) showed $A$ and $C$ are not marginally independent ($P(A=T, C=T) = 0.37 != 0.25 = P(A=T) dot P(C=T)$). This is a direct contradiction, so no choice of CPTs for this structure can reproduce the given distribution. The structure is invalid.

  #v(0.5em)
  (iv) $A -> C -> B$ which is invalid.

  This is a causal chain, but with the variables in a different order. $A$ causes $C$, which in turn causes $B$. To check whether this structure encodes $A tack.t.double C | B$, consider all paths between $A$ and $C$ when $B$ is shaded. The direct edge $A -> C$ is itself a path between $A$ and $C$, and it does not pass through $B$ at all (no amount of conditioning on $B$ can block a path that doesn't involve $B$). So $A$ and $C$ remain d-connected given $B$, meaning this structure does not encode $A tack.t.double C | B$. Since part b confirmed that $A tack.t.double C | B$ holds in the data, the structure contradicts the distribution and is invalid. (What this structure actually encodes is $A tack.t.double B | C$, since once $C$ is known it screens off $A$ from $B$ along the only path $A -> C -> B$. But that is a different conditional independence that the data does not require.)
]

#pagebreak()

= Part: Approximate Inference

Q22: This question asks you to reason about the four sampling-based approximate inference methods covered in class: _Prior Sampling_, _Rejection Sampling_, _Likelihood Weighting_, and _Gibbs Sampling_. #sidenote[Course notes: 07-Bayes-Networks, Pages 8--12]

(a) For each pair below, identify which method is more appropriate for the given scenario and explain in 1--2 sentences.

(i) You want to estimate $P(Y | X = x)$ where $P(X = x) approx 0.001$ is very rare. Compare _Prior Sampling_ and _Rejection Sampling_.

#answer[
  Rejection sampling is probably preferable because it can terminate a sample early the moment an evidence variable is drawn inconsistently, wasting less computation per rejected sample. However, both methods ultimately rely on generating samples that happen to have $X = x$, so with $P(X=x) approx 0.001$ roughly only 1 in 1,000 samples will be useful either way. Neither method is truly appropriate for very rare evidence, but likelihood weighting would be the right tool here.
]

(ii) You are estimating a posterior in a large Bayes Net where evidence is observed at leaf nodes (no children), and this evidence should substantially update beliefs about root nodes (no parents) several levels above. Compare _Likelihood Weighting_ and _Gibbs Sampling_.

#answer[
  Gibbs sampling is more appropriate. In likelihood weighting, root/ancestor variables are always sampled from their priors without being directly informed by downstream evidence, so the evidence only enters through sample weights, so the upstream sampling distribution itself is never updated. Gibbs resamples each variable conditioned on its full Markov blanket(which includes its children), allowing leaf node evidence to propagate backward and directly adjust beliefs about root nodes.
]

#pagebreak()

(iii) You need a quick, simple estimate, the evidence event has probability around 0.15, and the Bayes Net is a short chain. Compare _Rejection Sampling_ and _Likelihood Weighting_.

#answer[
  At $P(E) approx 0.15$, about 1,500 of every 10,000 prior samples would pass rejection which is a reasonable acceptance rate(it really depends but thats probably fine). Rejection sampling is simpler to implement and practical at this evidence probability. Likelihood weighting is strictly more efficient (in that it uses all samples with weights) but the gain is small for a short chain at this evidence rate, so rejection sampling's simplicity is often preferred.
]

(b) Musty the mustang claims: "Likelihood weighting is always better than rejection sampling because it never wastes a generated sample." Describe a specific network and evidence scenario where likelihood weighting could produce a _higher-variance_ estimate than rejection sampling for the same number of generated samples. (Hint: consider what happens to effective sample size when nearly all sample weights are close to zero.)

#answer[
  The claim can fail when the evidence has very low conditional probability given typical prior samples. Suppose we have the network $"Studied" -> "Failed"$, where 99% of students study ($P("Studied"=T) = 0.99$), students who studied rarely fail ($P("Failed"=T | "Studied"=T) = 0.001$), and students who didn't study almost always fail ($P("Failed"=T | "Studied"=F) = 0.99$). We want to estimate $P("Studied" | "Failed" = T)$ using 10,000 samples.

  With likelihood weighting, every sample first draws Studied from its prior, then locks $"Failed" = T$ and assigns a weight equal to $P("Failed"=T | "Studied")$. Because 99% of students study, about 9,900 of our 10,000 samples will have Studied = T, but each of those receives weight 0.001, essentially nothing. The remaining $~100$ samples have Studied = F and each receives weight 0.99, so nearly all the influence on the final estimate comes from those 100 samples. If those 100 happen to be unrepresentative (which is likely, since 100 is a small number), the estimate will be way off.

  With rejection sampling, we generate a full sample (draw Studied from its prior, then draw Failed from its conditional) and keep it only if $"Failed" = T$. Since $P("Failed"=T) approx 0.99 times 0.001 + 0.01 times 0.99 approx 0.011$, only about 110 of 10,000 samples survive, but each survivor is an equally weighted, unbiased draw from the true posterior. So there is no weight skew.

  In this case both methods end up with roughly the same number of truly informative samples (~100-110), so likelihood weighting's "no wasted samples" advantage evaporates. And because likelihood weighting concentrates all its influence on those $~100$ high weight survivors while the other 9,900 samples contribute nearly nothing, its variance can actually be higher than rejection sampling's uniformly weighted survivors.
]

#pagebreak()

(c) Consider the following Bayes Net and the query $P("Storm" | "Delay" = T)$: 

#figure(
  diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,
    node((0, 0), [Storm], name: <st>),
    node((0, 1), [Delay], name: <dl>),
    edge(<st>, <dl>, "->"),
  ),
)

with $P("Storm" = T) = 0.05$, $P("Delay" = T | "Storm" = T) = 0.90$, and $P("Delay" = T | "Storm" = F) = 0.05$.

(i) Using prior sampling with 10,000 samples, approximately how many samples would be consistent with the evidence $"Delay" = T$? Of those consistent samples, how many would you expect to have $"Storm" = T$?

#answer[
  $ P("Delay"=T) =\
   P("Storm"=T) dot P("Delay"=T | "Storm"=T)\
   + P("Storm"=F) dot P("Delay"=T | "Storm"=F) $
  $ = 0.05 times 0.90 + 0.95 times 0.05 = 0.045 + 0.0475 = 0.0925 $

  Expected samples with Delay = T: $0.0925 times 10,000 = 925$ samples.

  Of those 925:
  - $P("Storm"=T, "Delay"=T) = 0.05 times 0.90 = 0.045 => 450$ samples with Storm = T.
  - The remaining $925 - 450 = 475`$ samples have Storm = F.
]

(ii) Using likelihood weighting with 10,000 samples, what weight is assigned to each sample with $"Storm" = T$? What weight to each sample with $"Storm" = F$? Use expected sample counts and these weights to estimate $P("Storm" = T | "Delay" = T)$.

#answer[
  Delay is the evidence variable, so it is set to T rather than sampled. Storm is sampled normally with $~500$ samples with Storm = T, $~9,500$ with Storm = F.

  Each sample's weight $= P("Delay"=T | "Storm")$:
  - Storm = T: weight $= 0.90$
  - Storm = F: weight $= 0.05$

  Weighted counts:
  - Storm = T: $500 times 0.90 = 450$
  - Storm = F: $9,500 times 0.05 = 475$ #h(1em) Total: $925$

  $ P("Storm"=T | "Delay"=T) approx 450 / 925 approx 0.486 $

  True value= $(0.90 times 0.05) / 0.0925 = 0.045 / 0.0925 approx 0.486$ 
]

(iii) For this simple two-node chain, does Gibbs sampling offer any meaningful advantage over likelihood weighting? In what kind of network structure would Gibbs sampling be most beneficial compared to likelihood weighting, and why?

#answer[
  For this two-node chain, Gibbs sampling offers no meaningful advantage over likelihood weighting. Storm has no other relatives whose values could influence it beyond what Delay already provides through weights; both methods converge to the same estimate with comparable effort here.

  Gibbs sampling is most beneficial over likelihood weighting in large, densely connected networks where evidence is at intermediate or leaf nodes and should update beliefs about ancestor variables. Because Gibbs resamples each variable conditioned on its full Markov blanket, including its children, evidence "flows both ways"(ie downstream observations directly reshape the sampling distribution of upstream variables). Likelihood weighting cannot do this as ancestors are always drawn from their priors regardless of what is observed below, so the evidence signal is absorbed into weights rather than into the samples themselves.
]
