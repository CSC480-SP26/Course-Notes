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

Q4: Write the general formula for computing the marginal distribution $P(X = x)$ from a joint distribution $P(X, Y)$.  Explain in your own words what "marginalizing out" $Y$ means.
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

Q10: Define conditional probability $P(a | b)$ and state the formula. Explain why we restrict the sample space to $B$, and why do we then normalize by $P(b)$?
#v(5cm)

Q11: Using the joint distribution from Q3, compute $P("exam" | "weekday")$, the probability that a session is exam-related, given that it falls on a weekday. Show your work using the conditional probability formula.
#v(5cm)

#pagebreak()
Q12: At the start of this unit's exam, professor Wright in all of his mischievous macinations, has devised a meta scheme. He has prepared three piles of exams, pile A, pile B, and pile C. One pile contains an easy version of the exam, with questions ripped right from the study guide; the other two contain a harder version, for which presumaly very few of you will pass... 

At the start of the class, students grab an exam from whichever pile they like and take them face down to their seats. You take from pile A and sit down with your mortified peers.

Sam, having taken all three exams to test them, knows which exam pile is which, and is torn. Not wanting to let the students all take the easy exam for free, but pitying the inevitable torment of the students, has annouced that pile C is one of the _hard exam_ piles. 

You are allowed to get up and swap your exam for one from pile B if you so choose.

(a) Before the Sam's announcement, what is $P("A is easy")$? #sidenote[Each pile is equally likely to be the easy one.]
#v(1.2cm)


(b) Use Bayes' Rule to compute $P("A is easy" | "announces C")$ and $P("B is easy" | "announces C")$.
#v(3.5cm)


(c) Should you swap to pile B? By what factor does switching improve your odds of getting the easy exam?
#v(2cm)

#pagebreak()

Q13: Define _conditional independence_ $(A perp B | C)$. Write the formal condition both in terms of $P(A | B, C)$ and in terms of $P(A and B | C)$.
#v(2cm)

Q14: Explain the difference between general independence ($A perp B$) and conditional independence ($A perp B | C$). 

(a)
#v(1cm)

For each case below, argue whether it is possible and give a brief example or counterexample:

(b) $A$ and $B$ are independent, but not conditionally independent given $C$.
#v(2cm)
(c) $A$ and $B$ are conditionally independent given $C$, but not generally independent.
#v(2cm)

#pagebreak()

= Part : Bayes Nets
Q15: What is a Bayes Net? List its two components. Write the general formula for the joint distribution of $N$ random variables as a product of conditionals according to the Bayes Net.

#v(6cm)

Q16: State the two conditional independence rules that follow directly from a Bayes Net's structure. For each, state the rule formally and explain the intuition in your own words.
#v(6cm)




Q17: Define the Markov Blanket of a node $X$ in a Bayes Net. State the conditional independence property that the Markov Blanket implies.

#pagebreak()
Q18: Name and describe the three canonical triple structures in a Bayes Net. For each, state whether information (influence) flows between the two endpoint nodes when the middle node is (i) unobserved, and (ii) observed.

#v(10cm)

Q19: Describe the D-separation algorithm step by step. What does it mean for two variables $X$ and $Y$ to be d-separated given a set of observed variables $bold(Z)$? What can we conclude probabilistically if they are d-separated?

#v(8cm)

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
#v(4cm)

(b) Compute $P(A = T | B = T)$ and $P(A = T | B = T, C = T)$. Use these to determine whether $A tack.t.double C | B$ holds.
#v(4.5cm)

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

#v(6cm)

#pagebreak()

= Part: Approximate Inference

Q22: This question asks you to reason about the four sampling-based approximate inference methods covered in class: _Prior Sampling_, _Rejection Sampling_, _Likelihood Weighting_, and _Gibbs Sampling_. #sidenote[Course notes: 07-Bayes-Networks, Pages 8--12]

(a) For each pair below, identify which method is more appropriate for the given scenario and explain in 1--2 sentences.

(i) You want to estimate $P(Y | X = x)$ where $P(X = x) approx 0.001$ is very rare. Compare _Prior Sampling_ and _Rejection Sampling_.
#v(7cm)

(ii) You are estimating a posterior in a large Bayes Net where evidence is observed at leaf nodes (no children), and this evidence should substantially update beliefs about root nodes (no parents) several levels above. Compare _Likelihood Weighting_ and _Gibbs Sampling_.
#v(4cm)
#pagebreak()

(iii) You need a quick, simple estimate, the evidence event has probability around 0.15, and the Bayes Net is a short chain. Compare _Rejection Sampling_ and _Likelihood Weighting_.
#v(7cm)

(b) Musty the mustang claims: "Likelihood weighting is always better than rejection sampling because it never wastes a generated sample." Describe a specific network and evidence scenario where likelihood weighting could produce a _higher-variance_ estimate than rejection sampling for the same number of generated samples. (Hint: consider what happens to effective sample size when nearly all sample weights are close to zero.)
#v(4cm)
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
#v(3cm)

(ii) Using likelihood weighting with 10,000 samples, what weight is assigned to each sample with $"Storm" = T$? What weight to each sample with $"Storm" = F$? Use expected sample counts and these weights to estimate $P("Storm" = T | "Delay" = T)$.
#v(4cm)

(iii) For this simple two-node chain, does Gibbs sampling offer any meaningful advantage over likelihood weighting? In what kind of network structure would Gibbs sampling be most beneficial compared to likelihood weighting, and why?
#v(3cm)
