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

#pagebreak()
= Part II: Horizons and Discounting

Q5: A key structural choice in any MDP is whether the agent acts for a fixed number of steps or indefinitely. #sidenote[08-MDP-Bellman, Page 5]

(a) What is a _finite horizon_ MDP, and why may the optimal policy be _non-stationary_? What is an _infinite horizon_ MDP, and why is the optimal policy _stationary_ in that setting?
#v(3.5cm)

(b) Infinite-horizon MDPs require a discount factor $gamma in [0, 1)$. Using the Robot Vacuum MDP from Q4, demonstrate concretely why $gamma = 1$ causes a problem for two scenarios:

(i) Write the undiscounted total reward for an agent stuck in Broken forever, and for an agent cycling optimally between Clean and Messy forever. Why can these not be compared?
#v(5cm)

(ii) Now consider an agent that repeatedly uses Force from Jammed. 50% of the time it escapes to Clean (positive total reward), and 50% of the time it reaches Broken (negative total reward). Why does this make the expected undiscounted return of Force undefined when $gamma = 1$?
#v(4cm)
#pagebreak()
(c) Discounting is justified two ways. First, as a _preference for sooner rewards_. Second, as a model of _uncertain termination_. Describe both interpretations in your own words.
#v(4cm)

(d) Write a closed-form expression for $V^*("Broken")$ in terms of $gamma$. Show the derivation using the Bellman equation for the absorbing state. What happens to this value as $gamma -> 1$, and why does this matter for Jammed's Force action?
#v(5cm)

(e) The discount parameter $gamma$ directly controls the agent's patience. For the Jammed state specifically:

- When $gamma -> 0$: Write the approximate values of $Q("Jammed", "Reset")$ and $Q("Jammed", "Force")$ (the future terms vanish). Which action does the myopic agent select and why?

- When $gamma -> 1$: Use your closed-form $V^*("Broken")$ from (d) to write $Q^*("Jammed", "Force")$ explicitly. What happens to this Q-value as $gamma -> 1$? Compare to $Q^*("Jammed", "Reset")$ and state which action now dominates.
#v(3.5cm)

#pagebreak()
= Part III: The Bellman Equation

Q6: Define the _optimal value function_ $V^*(s)$ and the _Q-value_ (action-value) $Q^*(s, a)$. #sidenote[Course notes: 08-MDP-Bellman, Page 8]

(a) Write the formula for $Q^*(s, a)$ in full, identifying what each term represents.
#v(2.5cm)

(b) Express $V^*(s)$ in terms of $Q^*(s, a)$. Then write the optimal policy $pi^*(s)$ in terms of $Q^*(s, a)$.
#v(2.5cm)

(c) Combine your answers to derive the _Bellman equation_ for $V^*(s)$. Label which part represents the agent's choice, which part represents the environment's randomness, and which part captures the recursive structure.
#v(2.5cm)

Q7: Using the Robot Vacuum MDP from Q4 with $gamma = 0.9$, perform two rounds of value iteration starting from $V^0(s) = 0$ for all states. The update rule is $V^(k+1)(s) = max_a sum_(s') T(s,a,s')[R(s,a,s') + gamma V^k(s')]$. #sidenote[Course notes: 08-MDP-Bellman, Pages 9--10]

(a) Compute $V^1(s)$ for all four states. Note that Broken has only one action (Wait), so no max is needed there. For Clean and Messy, show both Q-values. For Jammed, compare Reset and Force explicitly.
#v(5cm)
#pagebreak()

(b) Compute $V^2(s)$ for all four states. Again show all Q-values at each non-absorbing state. _Hint: notice how $V^1("Broken") = -20$ now feeds into $Q^2("Jammed", "Force")$ via the $0.5 dot V^1("Broken")$ term._
#v(8cm)

(c) At Jammed, which action did the max select in round 1? Which does it select in round 2? The answer changes, explain intuitively why in terms of what $V^1("Broken")$ contributes to Force's Q-value once it is no longer zero.
#v(3cm)

#pagebreak()
Q8: Now solve for the _true_ $V^*(s)$ directly as a linear system. The optimal policy from Q7 (once estimates settled) is $pi^* = {"Clean": "Patrol", "Messy": "Explore", "Jammed": "Reset"}$. Because the policy is known, substitute the chosen action at each state and drop the $max$(this turns the recursive Bellman equation into a solvable linear system). #sidenote[Course notes: 08-MDP-Bellman, Page 10]

(a) Solve for $V^*("Broken")$. Broken is termial with only Wait available, write $V^*("Broken") = R + gamma dot V^*("Broken")$, then solve for $V^*("Broken")$ in terms of $gamma$. Plug in $gamma = 0.9$.
#v(4cm)

(b) Write the Bellman equation for $V^*("Jammed")$ under Reset. Reset transitions deterministically to Messy, so Broken does _not_ appear here. You will get: $V^*("Jammed") = -5 + 0.9 dot V^*("Messy")$. #sidenote[_Don't this solve yet_, keep this as an expression; you'll substitute it in part (c)]
#v(5.5cm)

(c) Write the Bellman equation for $V^*("Clean")$ under Patrol. Collect $V^*("Clean")$ on the left to get the form: $alpha dot V^*("Clean") = c_1 + beta dot V^*("Messy")$. (Identify $alpha$, $c_1$, $beta$.)
#v(3.5cm)

#pagebreak()

(d) Write the Bellman equation for $V^*("Messy")$ under Explore. The Explore transitions go to Clean (40%), Messy (30%), and Jammed (30%). Substitute your expression from (b) to eliminate $V^*("Jammed")$, then collect $V^*("Messy")$ on the left. You should arrive at: $delta dot V^*("Messy") = c_2 + epsilon dot V^*("Clean")$. (Identify $delta$, $c_2$, $epsilon$.)
#v(3.5cm)

(e) You now have two equations in $V^*("Clean")$ and $V^*("Messy")$ from (c) and (d). Solve this $2 times 2$ linear system (substitute one into the other). Then use (b) to find $V^*("Jammed")$.
#v(5cm)

(f) Verify: compute $Q^*("Jammed", "Force")$ and $Q^*("Messy", "Vacuum")$ using your exact values. Confirm Reset beats Force at Jammed and Explore beats Vacuum at Messy.
#v(3cm)

#pagebreak()
Q9: The structure of the Bellman equation should look familiar from earlier in the course. #sidenote[Course notes: 08-MDP-Bellman, Page 11]

(a) Identify the correspondence between the Bellman equation and an expectimax tree. What do the agent (square) nodes correspond to? What do the Q-state (circle) nodes correspond to?
#v(2.5cm)

(b) Expectimax expands a tree from a single root, which cannot handle cycles without unrolling into an infinite recursion. How does the Bellman equation handle the same problem? What makes it more efficient?
#v(2.5cm)

#pagebreak()