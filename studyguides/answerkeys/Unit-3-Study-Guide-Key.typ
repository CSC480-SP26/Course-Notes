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
#v(3cm)

Q2: State the two properties that any valid probability distribution must satisfy. Why are both necessary? #sidenote[Course notes: 06-Probability, Page 2]
#v(3cm)

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
#v(1cm)

#pagebreak()

(b) Compute the full marginal distributions $P(D)$ and $P(T)$.
#v(2cm)

(c) Compute $P("exam" or "project")$, the probability a randomly chosen session involves either an exam or a project. #sidenote[Note: that exam and project are mutually exclusive outcomes; how does this simplify the calculation compared to the general disjunction formula?]
#v(2.5cm)

(d) Are $D$ and $T$ independent? Check using the formal definition for at least two outcome pairs and state your conclusion.
#v(2.5cm)

Q4: Write the general formula for computing the marginal distribution $P(X = x)$ from a joint distribution $P(X, Y)$. Explain in words what "marginalizing out" $Y$ means.
#v(2.5cm)

Q5: What is the difference between an _outcome_ and an _event_? Write the formula #sidenote[Course notes: 06-Probability, Page 3] for computing the probability of an event $E$ from a joint distribution.
#v(2.5cm)

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
#v(1cm)

(b) $P(a)$
#v(1cm)

(c) $P(b or d)$
#v(1.5cm)

Q7: 
Derive a formula for $P(E_1 or E_2)$ in terms of $P(E_1)$, $P(E_2)$, and $P(E_1 and E_2)$. Why would simply computing $P(E_1) + P(E_2)$ give the wrong answer in general? Then extend your formula to $P(E_1 or E_2 or E_3)$.
#v(3.5cm)

Q8: When are two events $E_1$ and $E_2$ said to be _mutually exclusive_? How does mutual exclusivity simplify the formula from Q7?
#v(2cm)

Q9: Define independence between events $E_1$ and $E_2$. Write the formal definition using joint probabilities. Then rewrite the definition equivalently using conditional probability.
#v(2.5cm)

#pagebreak()

= Part : Conditional Probability and Independence

Q10: Define conditional probability $P(a | b)$ and state the formula. Walk through the intuition: why do we restrict the sample space to $B$, and why do we then normalize by $P(b)$?
#v(5cm)

Q11: Using the joint distribution from Q3, compute $P("exam" | "weekday")$, the probability that a session is exam-related, given that it falls on a weekday. Show your work using the conditional probability formula.
#v(5cm)

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
#v(2cm)

Q14: Explain the difference between general independence ($A perp B$) and conditional independence ($A perp B | C$). For each case below, argue whether it is possible and give a brief example or counterexample:

(a) $A$ and $B$ are independent, but not conditionally independent given $C$.
#v(2cm)
(b) $A$ and $B$ are conditionally independent given $C$, but not generally independent.
#v(2cm)
