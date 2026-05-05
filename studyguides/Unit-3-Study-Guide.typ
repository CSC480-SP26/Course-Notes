#import "../wdf.typ": *


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

Q11: Using the joint distribution from Q3, compute $P("exam" | "weekday")$ — the probability that a session is exam-related, given that it falls on a weekday. Show your work using the conditional probability formula.
#v(5cm)

#pagebreak()
Q12: At the start of this unit's exam, professor Wright in all of his mischievous macinations, has devised a meta scheme. He has prepared three piles of exams, pile A, pile B, and pile C. One pile contains an easy version of the exam, with questions ripped right from the study guide; the other two contain a harder version, for which presumaly very few of you will pass... 

At the start of the class, students grab an exam from whichever pile they like and take them face down to their seats. You take from pile A and sit down with your mortified peers.

Sam, having taken all three exams to test them, pitying the inevitable torment of the students, and knowing exactly which piles contain which exams, has annouced that pile C is one of the _hard exam_ piles. 

You are allowed to get up and swap your exam for one from pile B.

(a) Before the Sam's announcement, what is $P("A is easy")$? #sidenote[Each pile is equally likely to be the easy one.]
#v(1.2cm)

(b) Enumerate the three possible states of the world (which pile is easy) and for each, compute the probability that Sam would announce pile C specifically, given what you know about the 3 exams. #sidenote[Hint: if A is easy, the Sam can choose between B and C. If B is easy, what would Sam announce? If C is easy?]

#v(3.5cm)


(c) Use Bayes' Rule to compute $P("A is easy" | "prof announces C")$ and $P("B is easy" | "prof announces C")$.
#v(3.5cm)


(d) Should you swap to pile B? By what factor does switching improve your odds of getting the easy exam?
#v(2cm)

#pagebreak()

Q13: Define _conditional independence_ $(A perp B | C)$. Write the formal condition both in terms of $P(A | B, C)$ and in terms of $P(A and B | C)$.
#v(2cm)

Q14: Explain the difference between general independence ($A perp B$) and conditional independence ($A perp B | C$). For each case below, argue whether it is possible and give a brief example or counterexample:

(a) $A$ and $B$ are independent, but not conditionally independent given $C$.
#v(2cm)
(b) $A$ and $B$ are conditionally independent given $C$, but not generally independent.
#v(2cm)
