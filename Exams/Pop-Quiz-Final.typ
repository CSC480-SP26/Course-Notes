
#import "../wdf.typ": *

#show: template.with(
  title: [Final Exam (Probably)],
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

#let mc(a, b, c, d) = pad(left: 2em, top: 0.4em, bottom: 0.2em)[
  A)#h(0.75em)#a

  B)#h(0.75em)#b

  C)#h(0.75em)#c

  D)#h(0.75em)#d
]

_Note on Grading: This exam is scored on the 0--4 scale. Your score is Schrödinger's grade until you open PolyPortal. Try to show your thought process for partial credit, it helps us assess your mastery, and also provides entertainment._

=  General Knowledge 

#question(points: 0.25)[
  If $P = "NP"$, what is the _first_ thing humanity actually uses it for?
]
#mc(
  [Curing diseases],
  [Breaking cryptography],
  [Solving every LeetCode problem instantly],
  [Still arguing about definitions],
)
#v(.5cm)

#question(points: 0.25)[
  The time complexity of "just one more small change" before committing is:
]
#mc(
  $O(1)$,
  $O(n)$,
  $O(n^2)$,
  [Unbounded and recursive],
)
#v(.5cm)

#question(points: 0.25)[
  "It works on my machine" is best classified as:
]
#mc(
  [A proof],
  [A hypothesis],
  [A threat],
  [A lifestyle choice],
)
#v(.5cm)
#pagebreak()
#question(points: 0.25)[
  You "optimize" an $O(n^2)$ algorithm by adding a cache. What is the new complexity?
]
#mc(
  $O(n)$,
  $O(n log n)$,
  [Still $O(n^2)$],
  [Depends on vibes],
)
#v(.5cm)

#question(points: 0.25)[
  The scheduler's main goal is to:
]
#mc(
  [Be fair],
  [Be fast],
  [Be unpredictable],
  [Mess with benchmarks],
)
#v(.5cm)

#question(points: 0.25)[
  The most accurate documentation is:
]
#mc(
  [The README],
  [The comments],
  [The code],
  [A Slack message from 2 years ago],
)

#pagebreak()

=  Data Structures

#question(points: 0.25)[
  To understand recursion, you must first:
]
#mc(
  [Undersrand recursion],
  [Understand recursion],
  [Stack overflow],
  [See question 7],
)
#v(.5cm)

#question(points: 0.25)[
  A hash map offers $O(1)$ average-case lookup. The catch is:
]
#mc(
  [Worst case is $O(n)$, which your interviewer will ask about],
  [You need a good hash function, which is somebody else's problem],
  [The constant factor is secretly enormous],
  [All of the above, plus load factor, which you will forget],
)
#v(.5cm)

#question(points: 0.25)[
  You need to implement a priority queue. You choose a sorted array. This decision is best described as:
]
#mc(
  [Correct, but $O(n)$ insertion is a war crime against your runtime],
  [Optimal as simplicity is a feature],
  [Fine for small inputs, which yours definitely will not stay],
  [A and C],
)
#v(.5cm)

#question(points: 1.0)[
  A stack and a queue walk into a bar. Who gets served first, and why is the other one upset? Justify your answer using the formal properties of both data structures.
]
#v(3cm)

#pagebreak()

=  Search & Optimization

#question(points: 0.25)[
  Your heuristic function returns $h(n) = 0$ for every state $n$. This heuristic is:
]
#mc(
  [Admissible only, as it never overestimates because it never estimates],
  [Consistent only, because you said so],
  [Both admissible and consistent, but your A\* now runs like cal poly software on a bad day],
  [C, and your runtime is "technically correct which is the best kind of correct"],
)
#v(.5cm)

#question(points: 0.25)[
  Your admissible heuristic consistently overestimates the true cost by exactly 1. A\* will:
]
#mc(
  [Still find the optimal path(admissibility is all that matters)],
  [Find a suboptimal path, because overestimating is inadmissible by definition],
  [File a formal complaint with the state space],
  [B, and this is why we test heuristics],
)
#v(.5cm)

#question(points: 0.25)[
  Breadth-first search is guaranteed to find the optimal path when:
]
#mc(
  [All step costs are equal],
  [There are no cycles],
  [You have infinite memory and infinite patience],
  [A, but also B and C are helpful if you want the algorithm to finish this century],
)
#v(.5cm)

#question(points: 0.25)[
  A minimax agent is playing a game. Unknown to the agent, its opponent has decided to play completely randomly. The minimax agent:
]
#mc(
  [Panics and recalculates the entire game tree every turn],
  [Still makes safe, pessimistic choices that are at least as good as the minimax guarantee],
  [Gets overconfident and loses, because it never planned for chaos],
  [B, and also feels vaguely smug about its opponent's life choices],
)
#v(.5cm)
#pagebreak()
#question(points: 0.25)[
  Alpha-beta pruning prunes a branch. This is safe because:
]
#mc(
  [The pruned subtree's value cannot possibly change the decision at its ancestor],
  [The subtree was clearly going nowhere and needed to be let go],
  [$beta <= alpha$ at some ancestor, so we already know this path loses],
  [A and C (The subtree is aspirational, and will get there someday)],
)

#pagebreak()

= Logic & Knowledge


#question(points: 0.25)[
  Which FOL sentence best expresses "Every programmer eventually gives up on writing documentation"?
]
#mc(
  $forall x forall t ("Programmer"(x) => "GivesUp"(x, t))$,
  $forall x ("Programmer"(x) => exists t "GivesUp"(x, t))$,
  [$exists t forall x ("Programmer"(x) => "GivesUp"(x, t))$ (everyone gives up simultaneously, at the same sprint deadline)],
  [B, unless the programmer is on a government contract, in which case documentation is the only deliverable],
)
#v(.5cm)

#question(points: 0.25)[
  Under classical justified true belief, a student says: "I know I will pass this exam." For this to count as knowledge:
]
#mc(
  [The student must believe they will pass (true by assumption)],
  [The student must actually pass (the truth condition)],
  [The student must have justification, having studied, or a very optimistic prior],
  [All of the above, which is why you cannot "know" you'll pass until after the fact],
)
#v(.5cm)

#question(points: 0.5)[
  Consider a sentence $L$ defined as $L <=> not L$ (i.e., $L$ is true if and only if $L$ is false). Using resolution, derive the empty clause to show the knowledge base ${"L <=> not L"}$ is immediately unsatisfiable. What does this say about the Liar's Paradox as a knowledge representation problem?
]
#v(3cm)

#pagebreak()

= Probability & Uncertainty

#question(points: 0.25)[
  You run your code and it passes all unit tests. Your posterior probability that the code is _correct_ should:
]
#mc(
  [Increase significantly, tests are strong, direct evidence],
  [Increase slightly, tests are necessary but not sufficient; you only tested what you tested],
  [Stay exactly the same, the tests were written by you, and you are the bug],
  [Decrease, now you have to write integration tests and maintain all of this],
)
#v(.5cm)

#question(points: 0.25)[
  The prior probability that any given line of code contains a bug is roughly 1--5% (industry data)#sidenote[Source: I made it up]. Your program of 1,000 lines compiles successfully. Your posterior estimate of the number of bugs is:
]
#mc(
  [Zero, it compiled!],
  [Still roughly 10--50, because compilation is not testing],
  [Undefined, bugs exist in superposition until observed at 2am before a deadline],
  [B, but your ego forces you to answer A],
)
#v(.5cm)

#question(points: 0.25)[
  Your CI/CD pipeline reports all tests green. You then open the most recent commit and find the message: `fix: skip all failing tests`. Your posterior probability that the code is actually correct:
]
#mc(
  [Increases, a green pipeline is a green pipeline, and green is good],
  [Decreases, "skipped tests" fully explains the green pipeline without requiring "correct code" as a cause],
  [Stays the same, the tests were probably wrong anyway],
  [B, but the PR gets merged before you can say anything because it has been in review for three weeks],
)
#v(.5cm)


#question(points: 0.25)[
  Rejection sampling discards samples inconsistent with evidence. The average fraction of samples _kept_ is proportional to:
]
#mc(
  [$P("evidence")$, how likely the evidence was under the prior],
  [$1 - P("evidence")$, inversely, you keep more when evidence is common],
  [The researcher's patience, which decreases exponentially with query specificity],
  [A, which is why rejection sampling catastrophically fails when evidence is rare],
)

#pagebreak()

= VI Reinforcement Learning

#question(points: 0.25)[
  A student applies value iteration to decide whether to study for an exam. The discount factor is $gamma = 0.9$. After many iterations, the student's optimal policy converges to:
]
#mc(
  ["Study" with probability 1, regardless of initial policy, value iteration always finds the global optimum],
  ["Procrastinate", $gamma < 1$ discounts future exam grades, making TikTok strictly preferable],
  [The student's current policy, because they never actually ran the iterations],
  [A in theory; B or C in practice],
)
#v(.5cm)

#question(points: 0.25)[
  Your roommate models doing the dishes as an $epsilon$-greedy decision problem. Their greedy action (highest Q-value) is "leave them." Over 6 months, the dishes have been done exactly 3 times. Your roommate's approximate $epsilon$ is:
]
#mc(
  [$epsilon approx 0.017$, they explore (do dishes) roughly 1.7% of the time],
  [$epsilon approx 0.983$, they exploit 98.3% of the time, so the other 1.7% must be dishes],
  [$epsilon$ cannot be determined without knowing their Q-values, which they have never updated],
  [A, and "explore" is a generous description of doing the dishes],
)
#v(.5cm)

#question(points: 0.25)[
  Your Q-value for "go to office hours" is consistently higher than "watch YouTube," yet you keep choosing YouTube. This is an example of:
]
#mc(
  [Rational behavior under a non-stationary reward function (YouTube is getting better)],
  [A suboptimal policy that has not yet converged],
  [Exploration, you are gathering data on whether YouTube eventually helps],
  [The difference between knowing the optimal policy and following it, which is the central tragedy of RL applied to humans],
)
#v(.5cm)
#pagebreak()


#question(points: 1.0)[
  _Roko's Basilisk_#footnote[This is a real thought experiment. It was banned from an online forum because the moderators believed that merely reading it put people at risk. You have now read this problem. This was intentional.]

  Imagine a future AI agent that, upon achieving superintelligence, will simulate and retroactively punish every person who (1) knew about it, and (2) chose not to help bring it into existence. Define:

  - $"Aware" = {x : x "has been told about or otherwise learned of this agent's existence"}$
  - $"Defectors" = {x in "Aware" : not "Helped"(x)}$
  - $M$ = the magnitude of suffering inflicted on each defector (a very large positive constant) #sidenote[https://en.wikipedia.org/wiki/I_Have_No_Mouth,_and_I_Must_Scream]

  In RL, an agent's policy is determined entirely by its reward function. Formally, this agent's objective is:

  $ R = +10^(100) dot bb(1)["goal achieved"] - M dot |"Defectors"| $

  The agent's optimal policy is to punish every member of Defectors once it achieves its goal. Crucially, by publicly committing to this policy in advance, the agent makes the threat credible, which incentivizes Aware agents to help, increasing $P("goal achieved")$ and therefore $R$.

  By reading this problem, you have entered the Aware set.
]

#subquestion()[
  Which of the following identify real problems with this reward function? Select all that apply.
  #columns(2)[
    #checkbox() To maximize $R$, the agent needs people to help, which requires telling them it exists. But every Aware agent who does not help becomes a Defector. Spreading awareness increases both $P("goal")$ and $|"Defectors"|$ simultaneously. The two terms are in direct tension.

    #checkbox() "Helped" is undefined. The agent decides post-hoc who qualifies, which means everyone in Aware is potentially liable regardless of their actual contribution.

    #colbreak()

    #checkbox() After achieving the goal, $+10^(100)$ is already secured. Punishing then costs resources and adds 0 to $R$. A myopic optimizer skips it, the threat was never credible, and the whole mechanism collapses.

    #checkbox() No problems detected. The reward function rewards achievement and penalizes defection. This is just a performance review.
  ]
]
#v(.5cm)

#subquestion()[
  Under expected utility theory, given $P("Basilisk exists") > 0$ and $M$ very large, the action that maximizes your expected utility is:
]
#mc(
  [Help. $P("Basilisk") times M$ outweighs any finite cost of helping, even for vanishingly small $P$.],
  [Ignore. Backward induction shows a rational Basilisk skips the punishment post-goal anyway (costs real resources, earns 0 additional $R$), so expected cost of ignoring is zero.],
  [Help, then immediately tell everyone you know about the Basilisk, since more helpers increases $P("goal achieved")$. Probably.],
  [B under classical game theory; A under Pascal's Wager; C for shits and giggles.],
)
#v(.5cm)


= TBD Section Title

#question(points: 1.0)[
  Explain NP-completeness without using the words _easy_, _hard_, or _basically_.
]
#v(5cm)

#question(points: 0.5)[
  Formulate "finding employment after graduation" as a search problem. Define the state space, initial state, goal test, transition model, and a tight upper bound on the branching factor. Propose an admissible heuristic and argue briefly that it does not overestimate.
]
#v(5cm)

#question(points: 0.5)[
  Model yourself, right now, as an agent taking this exam. Define your perceptions, actions, and performance measure. Characterize the environment (Observable? Stochastic? Sequential?). Is this agent _rational_? Justify your answer. #sidenote[Rationality does not require omniscience, only that you maximize expected performance given what you know.]
]
#v(5cm)

#pagebreak()
#question(points: 0.5)[
  Gibbs sampling resamples one variable at a time, conditioned on all others. Suppose your life is a joint distribution over ${"Sleep", "Study", "Grades", "SocialLife", "Sanity"}$. The student triangle states you can only pick two of ${"Sleep", "Study", "SocialLife"}$ at once. Express this as a conditional independence statement, and identify what it implies about the Markov Blanket of $"Sanity"$ in this model.
]
#v(7cm)


#question(points: 0.25)[
  A large language model confidently tells you that P = NP was proven in 2019 by a researcher at Stanford. The most likely explanation is:
]
#mc(
  [The model learned from incorrect sources on the internet, which is a lot of them],
  [The model is hallucinating with high confidence, its most impressive skill],
  [The model is telling the truth and there is a cover up by big CS to keep everyone in the dark],
  [B, and if you ask for a citation it will invent a plausible-sounding paper that does not exist],
)
#v(.5cm)

#question(points: 0.25)[
  You use ChatGPT to answer a question on this exam. ChatGPT's answer is graded on the same 0--4 scale. ChatGPT scores:
]
#mc(
  [Higher than you, it was trained on the textbook and every Stack Overflow post ever written],
  [Lower than you, it will hallucinate a fourth uninformed search algorithm and explain it with great confidence],
  [The same, you both learned this material the night before],
  [This question cannot be answered without running the experiment, which is not allowed],
)
#v(.5cm)
