#import "../wdf.typ": *


#show: template.with(
  title: [
    Markov Decision Processes
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
= Part I: Markov Decision Processes

Q1: #sidenote[08-MDP-Bellman, Pages 1-2]
(a) Define a Markov Decision Process. List all five components, give the mathematical notation for each, and explain what each one represents. 


#v(4.5cm)



(b) Then write the distribution constraint that the transition model must satisfy for every state action pair $(s, a)$, and explain why it is necessary. 
#v(3.5cm) 

Q2: State the Markov property formally. What does it say about the relationship between the future state and the full history of past states and actions? Why does this property make MDPs tractable? What concept from Bayes Networks captures the same idea? #sidenote[08-MDP-Bellman, Page 3]
#v(4cm)

#pagebreak()

Q3: What is a _policy_? How does it differ from a _plan_ as computed in a search problem? Explain the difference between the two as it pretains to MDP solution spaces. #sidenote[08-MDP-Bellman, Page 4]
#v(3.5cm)

Q4: Consider the following MDP describing a roomba operating in a home. The robot can be in one of four states: 
*Clean* (the floor is tidy), *Messy* (debris has accumulated), *Jammed* (wedged under furniture but potentially recoverable), or *Broken* (the robot has been irreparably damaged). The full transition and reward model is: #sidenote[I made some abbreviations to make it all fit in the table]

#table(
  columns: 7,
  align: (center, center, center, center, center, center, center),
  stroke: 0.5pt,
  [*State*], [*Action*], [$P'$(*Clean*)], [$P'$(*Messy*)], [$P'$(*Jam'd*)], [$P'$(*Broke*)], [*Reward*],
  [Clean],  [Patrol],  [0.7], [0.3], [0.0], [0.0], [+3],
  [Clean],  [Charge],  [1.0], [0.0], [0.0], [0.0], [+1],
  [Messy],  [Vacuum],  [0.6], [0.35], [0.05], [0.0], [+5],
  [Messy],  [Explore], [0.4], [0.3], [0.3], [0.0], [+8],
  [Jammed], [Reset],   [0.0], [1.0], [0.0], [0.0], [$-5$],
  [Jammed], [Force],   [0.5], [0.0], [0.0], [0.5], [$+1$],
  [Broken], [Wait],    [0.0], [0.0], [0.0], [1.0], [$-20$],
)

_Explore_ sends the robot into unexplored territory: 40% of the time it finds a shortcut to a cleaner configuration, 30% of the time it finishes where it started, and 30% of the time it wedges itself under furniture.
 When _jammed_ the robot has two recovery options. _Reset_ where it carefully backs out, always landing in Messy (rewarded with $-5$ for the wasted effort)
  and _Force_ where it tries to muscle free. 50% of the time it succeeds and lands in Clean, but 50% of the time it destroys a motor and the robot enters _Broken_. 
 When _broken_ the robot is beyond repair and is sad.

(a) Verify that the transition probabilities form a valid distribution for each state-action pair. Which state is _absorbing_ (terminal)? 
#v(2cm)
#pagebreak()

(b) For each non-absorbing state, identify the "safe" action and the "risky" action. Justify using the transition model.
 For Jammed specifically, note that Force has a positive immediate reward (+1) but non-zero Broken probability. 
 Reset has a negative reward (−5) but a guaranteed non-catastrophic outcome. Why might Reset still be preferred at high $gamma$?
#v(3cm)

(c) When $gamma -> 0$#sidenote[Gen $alpha$ ipad goblin] (completely myopic), what action does the agent take from each non-absorbing state? Show the Q-value comparisons that support each choice.
#v(2.5cm)

(d) For Messy, write $Q^*("Messy", "Explore")$ in terms of $V^*("Clean")$, $V^*("Messy")$, and $V^*("Jammed")$. 
For Jammed, write both $Q^*("Jammed", "Reset")$ and $Q^*("Jammed", "Force")$ in terms of $V^*("Clean")$, $V^*("Messy")$, and $V^*("Broken")$. Argue qualitatively which action dominates at Jammed as $gamma -> 1$.
