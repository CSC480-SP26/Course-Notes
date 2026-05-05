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

Q5: What is the difference between an _outcome_ and an _event_? Write the formula #sidenote[Equation 2 from lecture] for computing the probability of an event $E$ from a joint distribution.
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
