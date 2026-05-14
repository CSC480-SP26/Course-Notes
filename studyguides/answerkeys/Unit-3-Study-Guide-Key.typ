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
  $E_1$ and $E_2$ are mutually exclusive when they share no outcomes: $E_1 sect E_2 = emptyset$, equivalently $P(E_1 and E_2) = 0$.

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

  So learning that one event occurred would gives insight about the probability of the other.
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
