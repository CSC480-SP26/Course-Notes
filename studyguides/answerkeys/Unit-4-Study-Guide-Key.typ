#import "../../wdf.typ": *


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

#let answer(body) = text(fill: red, body)

#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]
= Part I: Markov Decision Processes

Q1: #sidenote[08-MDP-Bellman, Pages 1-2]
(a) Define a Markov Decision Process. List all five components, give the mathematical notation for each, and explain what each one represents.

#answer[
  An MDP is a formal model of sequential decision-making under uncertainty. The five components are:

  - $S$: the set of all possible _states_ the agent can be in.
  - $A$: the set of all possible _actions_ the agent can take.
  - $T(s, a, s')$: the _transition model_, the probability of landing in state $s'$ after taking action $a$ in state $s$.
  - $R(s, a, s')$: the _reward function_, the immediate numeric payoff received when transitioning from $s$ to $s'$ via action $a$.
  - $gamma in [0, 1)$: the _discount factor_, which controls how much the agent values future rewards relative to immediate ones.
]

(b) Then write the distribution constraint that the transition model must satisfy for every state action pair $(s, a)$, and explain why it is necessary.

#answer[
  For every state-action pair $(s, a)$:
  $ sum_(s') T(s, a, s') = 1 $

  This is necessary because $T(s, a, dot)$ is a probability distribution over next states. Every action must lead _somewhere_ with total probability 1, the agent cannot disappear into the void, and probability that sums to less than 1 would leave unaccounted outcomes.
]

Q2: State the Markov property formally. What does it say about the relationship between the future state and the full history of past states and actions? Why does this property make MDPs tractable? What concept from Bayes Networks captures the same idea? #sidenote[08-MDP-Bellman, Page 3]

#answer[
  Formally:
  $ P(S_(t+1) | S_t, A_t, S_(t-1), A_(t-1), dots, S_0, A_0) = P(S_(t+1) | S_t, A_t) $

  The next state depends only on the _current_ state and action, not on the full history of how you got there. This makes MDPs tractable because the agent only needs to remember the current state to act optimally; there is no need to store or reason over an exponentially growing history. The equivalent concept in Bayes Networks is _conditional independence_ (or d-separation): $S_{t+1}$ is conditionally independent of all earlier states and actions given $S_t$ and $A_t$.
]


Q3: What is a _policy_? How does it differ from a _plan_ as computed in a search problem? Explain the difference between the two as it pretains to MDP solution spaces. #sidenote[08-MDP-Bellman, Page 4]

#answer[
  A _policy_ $pi: S -> A$ is a function that specifies which action to take in every possible state. A _plan_ from search is a fixed sequence of actions computed for a deterministic path (like a grocery list, do step 1, then step 2, etc.).

  In a stochastic MDP, you don't know which state you'll end up in after an action, so a fixed action sequence breaks down immediately when the environment surprises you. A policy handles this by providing a contingency plan for every state: wherever the MDP dumps you, the policy tells you what to do. Plans are open-loop; policies are closed-loop.
]

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

#answer[
  Row sums: Patrol: $0.7+0.3+0+0=1$, Charge: $1+0+0+0=1$, Vacuum: $0.6+0.35+0.05+0=1$, Explore: $0.4+0.3+0.3+0=1$ , Reset: $0+1+0+0=1$, Force: $0.5+0+0+0.5=1$, Wait: $0+0+0+1=1$.

  Broken is the absorbing (terminal) state, it transitions to itself with probability 1 and offers no escape. The robot is gone. Forever. Sad.
]

(b) For each non-absorbing state, identify the "safe" action and the "risky" action. Justify using the transition model.
 For Jammed specifically, note that Force has a positive immediate reward (+1) but non-zero Broken probability.
 Reset has a negative reward (−5) but a guaranteed non-catastrophic outcome. Why might Reset still be preferred at high $gamma$?

#answer[
  - Clean: safe = Charge (deterministically stays Clean, $P'("Broken")=0$); risky = Patrol (30% chance of landing in Messy).
  - Messy: safe = Vacuum (at most 5% chance of Jammed, 0% Broken); risky = Explore (30% chance of Jammed).
  - Jammed: safe = Reset (guaranteed non-catastrophic/always lands in Messy); risky = Force (50% chance of Broken, which is a death sentence).

  Reset is preferred at high $gamma$ because a patient agent (high $gamma$) cares deeply about the future. Broken carries a massive negative value that never stops hurting, $V^*("Broken") = -200$ at $gamma = 0.9$. The one-time cost of $-5$ from Reset is trivial compared to the 50% chance of inheriting $-200$ from Force. Immediate rewards matter less and less as $gamma -> 1$.
]

(c) When $gamma -> 0$#sidenote[Gen $alpha$ ipad goblin] (completely myopic), what action does the agent take from each non-absorbing state? Show the Q-value comparisons that support each choice.

#answer[
  When $gamma -> 0$, all future value terms vanish and $Q(s,a) approx R(s,a)$:

  - Clean: $Q("Clean", "Patrol") approx 3$ vs $Q("Clean", "Charge") approx 1$ -> Patrol wins.
  - Messy: $Q("Messy", "Vacuum") approx 5$ vs $Q("Messy", "Explore") approx 8$ -> Explore wins.
  - Jammed: $Q("Jammed", "Reset") approx -5$ vs $Q("Jammed", "Force") approx +1$ -> Force wins.

  The myopic agent at Jammed picks Force solely for the $+1$ immediate reward, completely ignoring that it has a 50% chance of destroying the robot. Classic.
]

(d) For Messy, write $Q^*("Messy", "Explore")$ in terms of $V^*("Clean")$, $V^*("Messy")$, and $V^*("Jammed")$.
For Jammed, write both $Q^*("Jammed", "Reset")$ and $Q^*("Jammed", "Force")$ in terms of $V^*("Clean")$, $V^*("Messy")$, and $V^*("Broken")$. Argue qualitatively which action dominates at Jammed as $gamma -> 1$.

#answer[
  $ Q^*("Messy", "Explore") = \
  8 + gamma(0.4 dot V^*("Clean") + 0.3 dot V^*("Messy") + 0.3 dot V^*("Jammed")) $

  $ Q^*("Jammed", "Reset") = -5 + gamma dot V^*("Messy") $

  $ Q^*("Jammed", "Force") = 1 + gamma(0.5 dot V^*("Clean") + 0.5 dot V^*("Broken")) $

  As $gamma -> 1$: $V^*("Broken") = -20/(1-gamma) -> -infinity$. The $0.5 dot V^*("Broken")$ term drags $Q^*("Jammed", "Force")$ to $-infinity$. Meanwhile, $Q^*("Jammed", "Reset")$ stays finite (Messy has a real value). Reset dominates completely at high $gamma$.
]

#pagebreak()
= Part II: Horizons and Discounting

Q5: A key structural choice in any MDP is whether the agent acts for a fixed number of steps or indefinitely. #sidenote[08-MDP-Bellman, Page 5]

(a) What is a _finite horizon_ MDP, and why may the optimal policy be _non-stationary_? What is an _infinite horizon_ MDP, and why is the optimal policy _stationary_ in that setting?

#answer[
  A _finite horizon_ MDP has the agent act for exactly $H$ steps. The optimal policy can be non-stationary because time to deadline changes the decision calculus, being in state $s$ with 10 steps left warrants different behavior than being in $s$ with 1 step left (near the end you might take risks you'd never take otherwise).

  An _infinite horizon_ MDP has the agent act indefinitely. The optimal policy is stationary because the situation looks identical at every time step, infinite horizon remains infinite regardless of when you check, so the same state always calls for the same action.
]

(b) Infinite-horizon MDPs require a discount factor $gamma in [0, 1)$. Using the Robot Vacuum MDP from Q4, demonstrate concretely why $gamma = 1$ causes a problem for two scenarios:

(i) Write the undiscounted total reward for an agent stuck in Broken forever, and for an agent cycling optimally between Clean and Messy forever. Why can these not be compared?

#answer[
  - Stuck in Broken: $-20 + (-20) + (-20) + dots = -infinity$.
  - Cycling optimally (alternating Patrol and Explore): $+3 + 8 + 3 + 8 + dots = +infinity$.

  Both sums diverge, one to $-infinity$, one to $+infinity$. The problem is that _any_ policy with a repeating positive reward diverges to $+infinity$ and any with a repeating negative reward diverges to $-infinity$. You cannot rank or compare policies since the return of almost every policy is just $plus.minus infinity$. The comparison has no meaning.
]

(ii) Now consider an agent that repeatedly uses Force from Jammed. 50% of the time it escapes to Clean (positive total reward), and 50% of the time it reaches Broken (negative total reward). Why does this make the expected undiscounted return of Force undefined when $gamma = 1$?

#answer[
  The 50% branch leading to Clean eventually produces $+infinity$ total reward (infinite positive cycles). The 50% branch leading to Broken produces $-infinity$. The expected undiscounted return is:
  $ 0.5 dot (+infinity) + 0.5 dot (-infinity) = infinity - infinity $

  This is an indeterminate form, mathematically undefined. The agent literally cannot decide whether Force is a good idea.
]
#pagebreak()
(c) Discounting is justified two ways. First, as a _preference for sooner rewards_. Second, as a model of _uncertain termination_. Describe both interpretations in your own words.

#answer[
  - _Preference for sooner rewards_: A reward received now is worth more than the same reward received later (consider interest rates or opportunity costs). Discounting by $gamma^t$ bakes this in, each time step into the future, rewards are worth $gamma$ times less. This matches how real agents (and companies, and people) actually behave.

  - _Uncertain termination_: Suppose at each time step there's a fixed probability $(1-gamma)$ that the interaction ends permanently (the robot gets turned off, the game ends, the episode terminates). Then $gamma$ is the survival probability per step. The expected reward of a future payoff is naturally weighted by the probability that you're still around to receive it, which is exactly $gamma^t$ after $t$ steps.
]

(d) Write a closed-form expression for $V^*("Broken")$ in terms of $gamma$. Show the derivation using the Bellman equation for the absorbing state. What happens to this value as $gamma -> 1$, and why does this matter for Jammed's Force action?

#answer[
  Broken has only Wait available and self-loops with reward $-20$:
  $ V^*("Broken") = -20 + gamma dot V^*("Broken") $
  $ V^*("Broken") (1 - gamma) = -20 $
  $ V^*("Broken") = frac(-20, 1 - gamma) $

  At $gamma = 0.9$: $V^*("Broken") = -20/0.1 = -200$.

  As $gamma -> 1$: $V^*("Broken") -> -infinity$. This matters enormously for Force at Jammed: $Q^*("Jammed", "Force")$ contains a $0.5 gamma dot V^*("Broken")$ term, which diverges to $-infinity$. The more the agent cares about the future, the more catastrophic landing in Broken becomes.
]
#pagebreak()

(e) The discount parameter $gamma$ directly controls the agent's patience. For the Jammed state specifically:

- When $gamma -> 0$: Write the approximate values of $Q("Jammed", "Reset")$ and $Q("Jammed", "Force")$ (the future terms vanish). Which action does the myopic agent select and why?

- When $gamma -> 1$: Use your closed-form $V^*("Broken")$ from (d) to write $Q^*("Jammed", "Force")$ explicitly. What happens to this Q-value as $gamma -> 1$? Compare to $Q^*("Jammed", "Reset")$ and state which action now dominates.

#answer[
  $gamma -> 0$:
  $ Q("Jammed", "Reset") approx -5, quad Q("Jammed", "Force") approx +1 $
  Myopic agent picks Force, it only sees the immediate $+1$ vs $-5$ and has no idea it's playing Russian roulette with the motor.

  $gamma -> 1$:
  $ Q^*("Jammed", "Force") = 1 + gamma lr((0.5 dot V^*("Clean") + 0.5 dot frac(-20, 1-gamma))) $
  $ = 1 + 0.5 gamma V^*("Clean") - frac(10 gamma, 1 - gamma) $

  As $gamma -> 1$, the $-10 gamma/(1-gamma)$ term $-> -infinity$, so $Q^*("Jammed", "Force") -> -infinity$.

  Meanwhile $Q^*("Jammed", "Reset") = -5 + gamma V^*("Messy")$ stays finite. Reset completely dominates as $gamma -> 1$.
]

#pagebreak()

(f) Now suppose every non-Broken state receives a _living reward_ of $r_L = -1$ on every step, added on top of the action rewards already in the table. How does this change the agents urgency to escape Jammed compared to its urgency to avoid reaching Broken in the first place?

#answer[
  The living reward of $-1$ applies to every step spent in Clean, Messy, or Jammed, but _not_ Broken, which is terminal and earns no living reward. This creates two distinct effects:

  Urgency to escape Jammed increases. Each step in Jammed now costs an extra $-1$ on top of the action reward. The effective reward of Reset becomes $-5 + (-1) = -6$ and Force becomes $+1 + (-1) = 0$. More importantly, every step of delay compounds: the agent bleeds $-1$ per step regardless of which recovery action it eventually takes, adding time pressure that did not exist before.

  Urgency to avoid Broken is unchanged. $V^*("Broken")$ is unaffected because Broken is excluded from the living reward, the per-step penalty never applies there. The catastrophic sink $V^*("Broken") = -20/(1-gamma)$ remains exactly the same.

  Net effect is the living reward makes lingering in Jammed more costly, so the agent is pushed to escape sooner. The absolute incentive to avoid Broken does not change, but the relative cost of staying Jammed has risen, making prompt escape via Reset even more attractive relative to gambling on Force.
]

Q6: Consider the Roomba MDP from Q4 with no discounting ($gamma = 1$) and a finite horizon of $h = 3$ steps. At each step the agent picks an action and receives the listed reward; after 3 steps the episode ends and no further reward is collected. #sidenote[Course notes: 08-MDP-Bellman, Page 5]

(a) At $h = 0$ steps remaining, $V_0(s) = 0$ for all states. Using the backward induction formula $V_k(s) = max_a sum_(s') T(s, a, s')[R(s, a, s') + V_(k-1)(s')]$, compute $V_1(s)$ for all four states. Show the Q-values for each available action.

#answer[
  With $V_0 = 0$ everywhere and $gamma = 1$, each Q-value reduces to the expected immediate reward (all future value terms are zero):

  *Clean:* $Q_1("Patrol") = 3$, $quad Q_1("Charge") = 1$ $->$ $V_1("Clean") = 3$ (Patrol)

  *Messy:* $Q_1("Vacuum") = 5$, $quad Q_1("Explore") = 8$ $->$ $V_1("Messy") = 8$ (Explore)

  *Jammed:* $Q_1("Reset") = -5$, $quad Q_1("Force") = 0.5(1) + 0.5(1) = 1$ $->$ $V_1("Jammed") = 1$ (Force)

  *Broken:* $Q_1("Wait") = -20$ $->$ $V_1("Broken") = -20$
]
#pagebreak()

(b) Compute $V_2(s)$ using your $V_1$ values. At Jammed, does the same action win as in step (a)?

#answer[
  *Clean:*
  $ Q_2("Patrol") = \
  0.7(3 + V_1("Clean")) + 0.3(3 + V_1("Messy")) =\
   0.7(6) + 0.3(11) = 4.2 + 3.3 = 7.5 $
  $ Q_2("Charge") = 1.0(1 + V_1("Clean")) = 1 + 3 = 4 $
  $V_2("Clean") = 7.5$ (Patrol)

  *Messy:*
  $ Q_2("Vacuum") = 0.6(5+3) + 0.35(5+8) + 0.05(5+1) = \
  4.8 + 4.55 + 0.3 = 9.65 $
  $ Q_2("Explore") = 0.4(8+3) + 0.3(8+8) + 0.3(8+1) =\
   4.4 + 4.8 + 2.7 = 11.9 $
  $V_2("Messy") = 11.9$ (Explore)

  *Jammed:*
  $ Q_2("Reset") = 1.0(-5 + V_1("Messy")) = -5 + 8 = 3 $
  $ Q_2("Force") = 0.5(1 + V_1("Clean")) + 0.5(1 + V_1("Broken")) =\
   0.5(4) + 0.5(-19) = 2 - 9.5 = -7.5 $
  $V_2("Jammed") = 3$ (Reset), _action changed_ from Force to Reset.

  *Broken:* $V_2("Broken") = -20 + V_1("Broken") = -20 + (-20) = -40$

  No, the winning action at Jammed flipped, with 1 step left Force wins (immediate $+1 > -5$), but with 2 steps left Reset wins because Force's 50% chance of landing in Broken (worth $-20$ with one step left) drags its Q-value to $-7.5$.
]
#pagebreak()

(c) Compute $V_3(s)$. Does the optimal action at Jammed depend on how many steps remain? What does this concretely illustrate about why finite-horizon optimal policies are _non-stationary_?

#answer[
  *Clean:*
  $ Q_3("Patrol") = 0.7(3 + 7.5) + 0.3(3 + 11.9) = \
  0.7(10.5) + 0.3(14.9) = 7.35 + 4.47 = 11.82 $
  $ Q_3("Charge") = 1 + 7.5 = 8.5 $
  $V_3("Clean") = 11.82$ (Patrol)

  *Messy:*
  $ Q_3("Vacuum") = 0.6(5+7.5) + 0.35(5+11.9) + 0.05(5+3) = \
  7.5 + 5.915 + 0.4 = 13.815 $
  $ Q_3("Explore") = 0.4(8+7.5) + 0.3(8+11.9) + 0.3(8+3) =\
   6.2 + 5.97 + 3.3 = 15.47 $
  $V_3("Messy") = 15.47$ (Explore)

  *Jammed:*
  $ Q_3("Reset") = -5 + V_2("Messy") = -5 + 11.9 = 6.9 $
  $ Q_3("Force") = 0.5(1 + V_2("Clean")) + 0.5(1 + V_2("Broken")) =\
   0.5(8.5) + 0.5(-39) = 4.25 - 19.5 = -15.25 $
  $V_3("Jammed") = 6.9$ (Reset)

  *Broken:* $V_3("Broken") = -20 + (-40) = -60$

  Yes, the optimal action at Jammed depends on how many steps remain: Force is optimal at $k=1$ but Reset is optimal at $k=2$ and $k=3$. This concretely illustrates non-stationarity, the same state (Jammed) calls for a different action depending on _when_ in the episode the agent finds itself. In an infinite-horizon MDP, the same state always calls for the same action; here the time-to-end changes what is rational.
]

#pagebreak()
= Part III: The Bellman Equation

Q7: Define the _optimal value function_ $V^*(s)$ and the _Q-value_ (action-value) $Q^*(s, a)$. #sidenote[Course notes: 08-MDP-Bellman, Page 8]

(a) Write the formula for $Q^*(s, a)$ in full, identifying what each term represents.

#answer[
  $ Q^*(s, a) = sum_(s') T(s, a, s') lr([R(s, a, s') + gamma V^*(s')]) $

  - $T(s,a,s')$: probability the environment transitions to $s'$ (not the agent's choice)
  - $R(s,a,s')$: immediate reward for that transition
  - $gamma V^*(s')$: discounted value of the optimal future starting from $s'$
]

(b) Express $V^*(s)$ in terms of $Q^*(s, a)$. Then write the optimal policy $pi^*(s)$ in terms of $Q^*(s, a)$.

#answer[
  $ V^*(s) = max_a Q^*(s, a) $
  $ pi^*(s) = op("argmax")_a Q^*(s, a) $
]

(c) Combine your answers to derive the _Bellman equation_ for $V^*(s)$. Label which part represents the agent's choice, which part represents the environment's randomness, and which part captures the recursive structure.

#answer[
  $ V^*(s) = underbrace(max_a, "agent's choice") underbrace(sum_(s') T(s,a,s'), "environment's randomness") lr([R(s,a,s') + underbrace(gamma V^*(s'), "recursive structure")]) $

  The agent picks the action ($max_a$), the environment rolls the dice ($sum T$), and the future value of the next state feeds back into the current value ($gamma V^*$).
]

Q8: Using the Robot Vacuum MDP from Q4 with $gamma = 0.9$, perform two rounds of value iteration starting from $V^0(s) = 0$ for all states. The update rule is $V^(k+1)(s) = max_a sum_(s') T(s,a,s')[R(s,a,s') + gamma V^k(s')]$. #sidenote[Course notes: 08-MDP-Bellman, Pages 9--10]

(a) Compute $V^1(s)$ for all four states. Note that Broken has only one action (Wait), so no max is needed there. For Clean and Messy, show both Q-values. For Jammed, compare Reset and Force explicitly.

#answer[
  All future values are 0 so every $Q^1$ is just the immediate reward:

  $V^1("Broken") = -20 + 0.9 dot 0 = -20$

  Clean: $Q^1("Patrol") = 3 + 0.9(0) = 3$, $quad Q^1("Charge") = 1 + 0.9(0) = 1$ $->$ $V^1("Clean") = 3$ (Patrol)

  Messy: $Q^1("Vacuum") = 5$, $quad Q^1("Explore") = 8$ $->$ $V^1("Messy") = 8$ (Explore)

  Jammed: $Q^1("Reset") = -5$, $quad Q^1("Force") = 1$ $->$ $V^1("Jammed") = 1$ (Force)
]

(b) Compute $V^2(s)$ for all four states. Again show all Q-values at each non-absorbing state. _Hint: notice how $V^1("Broken") = -20$ now feeds into $Q^2("Jammed", "Force")$ via the $0.5 dot V^1("Broken")$ term._

#answer[
  $V^2("Broken") = -20 + 0.9(-20) = -38$

  Clean:
  $ Q^2("Patrol") = 3 + 0.9(0.7 dot 3 + 0.3 dot 8) =\
   3 + 0.9(2.1 + 2.4) = 3 + 4.05 = 7.05 $
  $ Q^2("Charge") = 1 + 0.9(1.0 dot 3) = 1 + 2.7 = 3.7 $
  $V^2("Clean") = 7.05$ (Patrol)

  Messy:
  $ Q^2("Vacuum") = 5 + 0.9(0.6 dot 3 + 0.35 dot 8 + 0.05 dot 1) =\
  5 + 0.9(1.8 + 2.8 + 0.05) = 5 + 4.185 = 9.185 $
  $ Q^2("Explore") = 8 + 0.9(0.4 dot 3 + 0.3 dot 8 + 0.3 dot 1) =\
   8 + 0.9(1.2 + 2.4 + 0.3) = 8 + 3.51 = 11.51 $
  $V^2("Messy") = 11.51$ (Explore)

  Jammed:
  $ Q^2("Reset") = -5 + 0.9(1.0 dot 8) = -5 + 7.2 = 2.2 $
  $ Q^2("Force") = 1 + 0.9(0.5 dot 3 + 0.5 dot (-20)) =\
   1 + 0.9(1.5 - 10) = 1 - 7.65 = -6.65 $
  $V^2("Jammed") = 2.2$ (Reset)
]

(c) At Jammed, which action did the max select in round 1? Which does it select in round 2? The answer changes, explain intuitively why in terms of what $V^1("Broken")$ contributes to Force's Q-value once it is no longer zero.

#answer[
  Round 1: Force ($1 > -5$). Round 2: Reset ($2.2 > -6.65$).

  In round 1, all future estimates were 0, so $Q^1("Force") = +1$ looked great (only the immediate reward matters). In round 2, $V^1("Broken") = -20$ is plugged in: the $0.5 dot 0.9 dot (-20) = -9$ term drags Force down to $-6.65$. The algorithm has "learned" that half the time Force leads somewhere terrible, and that information propagates backward.
]

#pagebreak()
Q9: Now solve for the _true_ $V^*(s)$ directly as a linear system. The optimal policy from Q8 (once estimates settled) is $pi^* = {"Clean": "Patrol", "Messy": "Explore", "Jammed": "Reset"}$. Because the policy is known, substitute the chosen action at each state and drop the $max$(this turns the recursive Bellman equation into a solvable linear system). #sidenote[Course notes: 08-MDP-Bellman, Page 10]

(a) Solve for $V^*("Broken")$. Broken is termial with only Wait available, write $V^*("Broken") = R + gamma dot V^*("Broken")$, then solve for $V^*("Broken")$ in terms of $gamma$. Plug in $gamma = 0.9$.

#answer[
  $ V^*("Broken") = -20 + gamma V^*("Broken") $
  $ V^*("Broken")(1 - gamma) = -20 $
  $ V^*("Broken") = frac(-20, 1 - gamma) $
  At $gamma = 0.9$: $V^*("Broken") = -20 / 0.1 = -200$.
]

(b) Write the Bellman equation for $V^*("Jammed")$ under Reset. Reset transitions deterministically to Messy, so Broken does _not_ appear here. You will get: $V^*("Jammed") = -5 + 0.9 dot V^*("Messy")$. #sidenote[_Don't this solve yet_, keep this as an expression; you'll substitute it in part (c)]

#answer[
  Under Reset, $T("Jammed", "Reset", "Messy") = 1$:
  $ V^*("Jammed") = -5 + 0.9 dot V^*("Messy") $
  (remember this, it's needed for the next parts.)
]

(c) Write the Bellman equation for $V^*("Clean")$ under Patrol. Collect $V^*("Clean")$ on the left to get the form: $alpha dot V^*("Clean") = c_1 + beta dot V^*("Messy")$. (Identify $alpha$, $c_1$, $beta$.)

#answer[
  Under Patrol, $T("Clean", "Patrol", "Clean") = 0.7$ and $T("Clean", "Patrol", "Messy") = 0.3$:
  $ V^*("Clean") = 3 + 0.9(0.7 dot V^*("Clean") + 0.3 dot V^*("Messy")) $
  $ V^*("Clean") = 3 + 0.63 V^*("Clean") + 0.27 V^*("Messy") $
  $ 0.37 V^*("Clean") = 3 + 0.27 V^*("Messy") $

  So $alpha = 0.37$, $c_1 = 3$, $beta = 0.27$.
]

#pagebreak()

(d) Write the Bellman equation for $V^*("Messy")$ under Explore. The Explore transitions go to Clean (40%), Messy (30%), and Jammed (30%). Substitute your expression from (b) to eliminate $V^*("Jammed")$, then collect $V^*("Messy")$ on the left. You should arrive at: $delta dot V^*("Messy") = c_2 + epsilon dot V^*("Clean")$. (Identify $delta$, $c_2$, $epsilon$.)

#answer[
  Under Explore:
  $ V^*("Messy") =\
   8 + 0.9(0.4 V^*("Clean") + 0.3 V^*("Messy") + 0.3 V^*("Jammed")) $
  Substitute $V^*("Jammed") = -5 + 0.9 V^*("Messy")$:
  $ V^*("Messy") =\
   8 + 0.9(0.4 V^*("Clean") + 0.3 V^*("Messy") + 0.3(-5 + 0.9 V^*("Messy"))) $
  $ = 8 + 0.9(0.4 V^*("Clean") + 0.57 V^*("Messy") - 1.5) $
  $ = 8 + 0.36 V^*("Clean") + 0.513 V^*("Messy") - 1.35 $
  $ 0.487 V^*("Messy") = 6.65 + 0.36 V^*("Clean") $

  So $delta = 0.487$, $c_2 = 6.65$, $epsilon = 0.36$.
]

(e) You now have two equations in $V^*("Clean")$ and $V^*("Messy")$ from (c) and (d). Solve this $2 times 2$ linear system (substitute one into the other). Then use (b) to find $V^*("Jammed")$.

#answer[
  From (c): $V^*("Clean") = (3 + 0.27 M) / 0.37$ where $M = V^*("Messy")$.

  Sub into (d):
  $ 0.487 M = 6.65 + frac(0.36, 0.37)(3 + 0.27 M) $
  $ 0.487 M = 6.65 + 2.919 + 0.2627 M $
  $ 0.2243 M = 9.569 $
  $ M = V^*("Messy") approx 42.66 $

  $ V^*("Clean") = (3 + 0.27 times 42.66) / 0.37 = 14.52 / 0.37 approx 39.24 $

  $ V^*("Jammed") = -5 + 0.9 times 42.66 approx -5 + 38.39 = 33.39 $
]

#pagebreak()
(f) Verify: compute $Q^*("Jammed", "Force")$ and $Q^*("Messy", "Vacuum")$ using your exact values. Confirm Reset beats Force at Jammed and Explore beats Vacuum at Messy.

#answer[
  $ Q^*("Jammed", "Force") = \
  1 + 0.9(0.5 times 39.24 + 0.5 times (-200)) =\
  1 + 0.9(19.62 - 100) approx -71.34 $
  $V^*("Jammed") approx 33.39 >> -71.34$ -> Reset wins

  $ Q^*("Messy", "Vacuum") =\
   5 + 0.9(0.6 times 39.24 + 0.35 times 42.66 + 0.05 times 33.39) $
  $ = 5 + 0.9(23.54 + 14.93 + 1.67) = 5 + 0.9 times 40.14 approx 41.13 $
  $V^*("Messy") approx 42.66 > 41.13$ -> Explore wins
]

Q10: The structure of the Bellman equation should look familiar from earlier in the course. #sidenote[Course notes: 08-MDP-Bellman, Page 11]

(a) Identify the correspondence between the Bellman equation and an expectimax tree. What do the agent (square) nodes correspond to? What do the Q-state (circle) nodes correspond to?

#answer[
  - Agent (square) nodes ↔ the $max_a$ in the Bellman equation: the agent chooses which action to take.
  - Q-state (circle) nodes ↔ the $sum_{s'} T(s,a,s')[R + gamma V^*(s')]$ part: the expected value over random outcomes of a committed action.

  The Bellman equation is essentially a depth-2 expectimax tree (max over actions, then expectation over transitions), applied at every state simultaneously.
]

(b) Expectimax expands a tree from a single root, which cannot handle cycles without unrolling into an infinite recursion. How does the Bellman equation handle the same problem? What makes it more efficient?

#answer[
  The Bellman equation treats $V^*(s)$ as a variable, not something you expand into a tree. Cycles in the state graph just become self-referential equations, they're resolved by iterative Bellman updates (value iteration) or by solving the linear system directly (policy iteration). Either way, each state is represented once, not expanded infinitely. Expectimax applied naively to a cyclic graph would recurse forever; the Bellman approach breaks the cycle by treating future values as estimates to be updated, not subtrees to be computed.
]

#pagebreak()
= Part IV: Value and Policy Iteration

Q11: Value iteration finds the optimal value function by repeatedly applying the Bellman equation as an update rule, without ever fixing a policy in advance. #sidenote[Course notes: 08-MDP-Bellman, Pages 9--10]

(a) Write the value iteration update rule $V^(k+1)(s)$ in full. Why does keeping the $max$ inside the update rule allow the algorithm to work without knowing the optimal policy ahead of time?

#answer[
  $ V^(k+1)(s) = max_a sum_(s') T(s,a,s') lr([R(s,a,s') + gamma V^k(s')]) $

  The $max$ lets the update evaluate all available actions and commit to the best one at each step, using the current value estimates. No policy needs to be fixed externally, the algorithm implicitly "tries" every action every round and automatically identifies which one looks best given the current $V^k$. As $V^k$ converges to $V^*$, the argmax at each state converges to $pi^*$.
]

(b) Value iteration is guaranteed to converge for any finite state space when $gamma < 1$. Explain the contraction argument: why does each round shrink the error between $V^k$ and $V^*$ by at least a factor of $gamma$? What does this say about convergence speed as $gamma -> 1$?

#answer[
  The Bellman operator $cal(B)$ is a $gamma$-contraction in the max-norm: for any two value functions $U$ and $V$,
  $ ||cal(B) U - cal(B) V||_infinity <= gamma ||U - V||_infinity $

  This follows because the future value terms are scaled by $gamma$ in the update, so any error in $V^k$ can contribute at most $gamma$ times that error to $V^{k+1}$. Applying this repeatedly: $||V^k - V^*||_infinity <= gamma^k ||V^0 - V^*||_infinity$, which shrinks geometrically.

  As $gamma -> 1$, the contraction factor approaches 1, and convergence slows dramatically, you need many more rounds to cut the error by any fixed amount. Near $gamma = 1$ you're waiting a very long time for things to settle down.
]

(c) After convergence, how do you extract the optimal policy $pi^*$ from the converged values $V^*$? Write the formula. Why does this work, even though $pi^*$ was never explicitly tracked during the iterations?

#answer[
  $ pi^*(s) = op("argmax")_a sum_(s') T(s,a,s') lr([R(s,a,s') + gamma V^*(s')]) $

  It works because $V^*$ already encodes optimal future behavior everywhere. Looking one step ahead from fully-converged values gives exactly the same result as looking infinitely far ahead, the values "know" the future. The argmax at each state using $V^*$ is guaranteed to be the optimal action.
]
#pagebreak()

(d) Consider the relationship between value convergence and policy convergence. In the Roomba MDP from Q4, the action selected at Jammed flipped between rounds 1 and 2 of your value iteration (Q8c). Does the policy need to be fully stable for the values to be correct? Explain what "the relative ordering of actions is often correct early on" means in practice.

#answer[
  No, the values don't need a stable policy to be correct; value convergence and policy convergence are separate things. Values converge asymptotically ($V^k -> V^*$), but the implicit policy (argmax of $V^k$) often stabilizes much earlier.

  "Relative ordering is often correct early on" means that even when $V^k$ still has numerical errors relative to $V^*$, the best action at each state is already the right one. In the Roomba example, by round 2 the policy at all three non-absorbing states had already settled to its final form ($pi^* = {"Clean":"Patrol", "Messy":"Explore", "Jammed":"Reset"}$), even though $V^2$ values were far from the true $V^*$ values (e.g., $V^2("Messy") = 11.51$ vs $V^*("Messy") approx 42.66$). In practice this means you can often stop value iteration early once the policy stops changing, even if the values haven't fully converged.
]


Q12: Policy iteration is an alternative algorithm that alternates between two steps: _policy evaluation_ and _policy improvement_. #sidenote[Course notes: 08-MDP-Bellman, Pages 12--13] Describe both steps precisely:

- _Policy evaluation_: Given a fixed policy $pi$, what system of equations do you solve? Why is there no $max$ in this system, and what does that allow you to do?

#answer[
  Given fixed $pi$, solve the linear system:
  $ V^pi(s) = sum_(s') T(s, pi(s), s') lr([R(s, pi(s), s') + gamma V^pi(s')]) quad forall s $

  There is no $max$ because the policy is fixed, every state has exactly one prescribed action, so the "choice" is already made. This turns the Bellman equations into a system of $|S|$ linear equations in $|S|$ unknowns (no nonlinearities from the max), which can be solved exactly via Gaussian elimination or matrix inversion rather than iteratively.
]

- _Policy improvement_: Given the values $V^pi$ from evaluation, how do you compute a new policy $pi'$? Write the formula. What does it mean if $pi' = pi$?

#answer[
  $ pi'(s) = op("argmax")_a sum_(s') T(s, a, s') lr([R(s, a, s') + gamma V^pi(s')]) $

  If $pi' = pi$, then no state has a better action under the current value estimates, the policy is optimal (convergence criterion). You're done.
]
#pagebreak()

Q13: Using the Robot Vacuum MDP from Q4 with $gamma = 0.9$, run one full iteration of policy iteration starting from the all-safe policy $pi^0 = {"Clean": "Charge", "Messy": "Vacuum", "Jammed": "Reset"}$.

(a) _Policy evaluation_: Broken is absorbing with $V^*("Broken") = -200$. For the remaining states, write and solve the three linear equations under $pi^0$. Show how you eliminate variables.

#answer[
  Under $pi^0$:

  Clean (Charge): $V("Clean") = 1 + 0.9 V("Clean")$ -> $0.1 V("Clean") = 1$ -> $V("Clean") = 10$

  Jammed (Reset): $V("Jammed") = -5 + 0.9 V("Messy")$.

  Messy (Vacuum): $V("Messy") = 5 + 0.9(0.6 times 10 + 0.35 V("Messy") + 0.05 V("Jammed"))$

  Substitute $V("Jammed") = -5 + 0.9 V("Messy")$:
  $ V("Messy") = 5 + 0.9(6 + 0.35 V("Messy") + 0.05(-5 + 0.9 V("Messy"))) $
  $ = 5 + 0.9(5.75 + 0.395 V("Messy")) $
  $ = 10.175 + 0.3555 V("Messy") $
  $ 0.6445 V("Messy") = 10.175 $
  $ V("Messy") approx 15.79 $

  $V("Jammed") = -5 + 0.9 times 15.79 approx 9.21$

  Summary: $V^(pi^0)("Clean") = 10$, $V^(pi^0)("Messy") approx 15.79$, $V^(pi^0)("Jammed") approx 9.21$, $V^(pi^0)("Broken") = -200$.
]

(b) _Policy improvement_: Using your $V^(pi^0)$ values, compute all Q-values for every non-absorbing state. Fill in the table:

#table(
  columns: 3,
  align: (center, center, center),
  stroke: 0.5pt,
  [*State*], [*Action*], [$Q(s, a)$ under $V^(pi^0)$],
  [Clean],  [Patrol],  [#answer[$3 + 0.9(0.7 times 10 + 0.3 times 15.79) approx 13.56$]],
  [Clean],  [Charge],  [#answer[$1 + 0.9 times 10 = 10$]],
  [Messy],  [Vacuum],  [#answer[$approx 15.79$ (self-consistent with policy eval)]],
  [Messy],  [Explore], [#answer[$8 + 0.9(0.4 times 10 + 0.3 times 15.79 + 0.3 times 9.21) approx 18.35$]],
  [Jammed], [Reset],   [#answer[$-5 + 0.9 times 15.79 approx 9.21$]],
  [Jammed], [Force],   [#answer[$1 + 0.9(0.5 times 10 + 0.5 times (-200)) = -84.5$]],
)
#v(0.5cm)

#answer[
  Improved policy $pi^1 = {"Clean": "Patrol", "Messy": "Explore", "Jammed": "Reset"}$.

  This differs from $pi^0$ at Clean (Charge -> Patrol) and Messy (Vacuum -> Explore). Jammed stays on Reset, Force is $-84.5$ vs Reset's $9.21$, not even close.
]

(c) If $pi^1 != pi^0$, one more round of policy evaluation is required. Assuming the policy has stabilized after this round, how would you verify that $pi^1$ is optimal without running another improvement step?

#answer[
  Compute the exact values $V^(pi^1)$ for the new policy (solve the linear system under Patrol/Explore/Reset). Then for every non-absorbing state, verify that the current policy action achieves the maximum Q-value (ie check that no other action would be preferred)
  $ pi^1(s) = op("argmax")_a sum_(s') T(s,a,s')[R(s,a,s') + gamma V^(pi^1)(s')] quad forall s $
  If the improvement step would reproduce $pi^1$ unchanged, the policy is optimal. In this MDP, $pi^1$ is in fact $pi^*$ (it matches the policy we solved for in Q9).
]

Q14: Compare and contrast value iteration and policy iteration. #sidenote[Course notes: 08-MDP-Bellman, Page 13]

(a) Both algorithms are guaranteed to converge to the same $V^*$ and $pi^*$. Describe the key structural difference in _how_ each algorithm reaches that result. In one sentence each: what does value iteration commit to at each step, and what does policy iteration commit to?

#answer[
  Value iteration commits to a new _value function_ estimate at each step, it updates every $V(s)$ using a max over all actions, without ever pinning down a specific policy.

  Policy iteration commits to a specific _policy_ at each step, it fully evaluates that policy (exactly), then improves it, alternating between the two.
]
#pagebreak()
(b) Policy iteration is often said to converge in fewer _iterations_ than value iteration, even though each iteration of policy iteration is more expensive. Explain why:

- Policy iteration converges in a finite number of iterations (hint: what is the bound, and why must it terminate?).
- Value iteration converges asymptotically but may take many rounds before $V^k$ is close enough to $V^*$ to extract the correct policy.

#answer[
  Policy iteration must terminate in at most $|A|^(|S|)$ iterations (the number of distinct policies). Each improvement step strictly improves the policy (or terminates), so no policy is ever repeated, the algorithm can't cycle. With a finite set of policies, it must halt.

  Value iteration never fixes a policy, it updates real-valued estimates that converge asymptotically. Each round shrinks the error by $gamma$, but when $gamma$ is close to 1 this is slow, and many rounds may pass before the implicit policy (argmax from $V^k$) stabilizes. You might need hundreds of rounds to get close enough to $V^*$ that the argmax produces the correct action everywhere.
]

(c) Value iteration requires knowing $T$ and $R$ upfront. What algorithmic family handles the case where the agent must _learn_ these from experience instead of having them given?

#answer[
  Reinforcement Learning (RL): the agent learns $T$ and/or $R$ from experience rather than being handed a model.
]

#pagebreak()
= Part V: Reinforcement Learning

Q15: Reinforcement learning addresses the setting where the agent still has an MDP but does not know $T$ or $R$. #sidenote[Course notes: 09-Reinforcement-Learning, Page 1] List the four components of the MDP that still exist in the RL setting. What is the one critical difference from the planning setting?

#answer[
  The four components that still exist: $S$ (states: the agent can observe its current state), $A$ (actions: the agent knows what it can do), $gamma$ (discount factor: a design choice baked in by the engineer), and $r$ (observed rewards: the agent sees the reward signal after each transition).

  The critical difference is that $T$ and $R$ are unknown. The agent cannot compute $sum_{s'} T(s,a,s')[...]$ because it doesn't have access to the transition model or the full reward function. It must learn about the world by actually doing stuff and seeing what happens.
]

Q16: Distinguish _offline_ learning from _online_ learning. In your own words illustrate the difference? Which mode do value iteration and policy iteration belong to, and why?

#answer[
  Offline learning separates the "learning" phase from the "acting" phase, you collect data (or are given a model), learn from it, and then deploy. Online learning interleaves learning and acting, every action produces new experience that immediately informs the next decision.

  Offline is like studying a textbook before an exam (you acquire knowledge first, then apply it). Online is like learning a new job by actually doing it (you learn and act simultaneously, every day).

  Value iteration and policy iteration are offline, they require the complete model $T$ and $R$ to be known in advance. They do all computation before the agent takes a single action in the world.
]

Q17: What are the three central challenges of online RL. Explain them in your own words.

#answer[
  + Unknown transitions: The agent doesn't know $T$, it must figure out what happens when it takes actions through trial and error.
  + Unknown rewards: The agent doesn't have $R$ upfront, it only sees rewards as it goes, and must infer the reward structure from experience.
  + Exploration vs. exploitation: To learn effectively, the agent needs to try different actions (explore), but to earn reward, it should do what it already thinks is best (exploit). Balancing these is the core tension of online RL, exploring too little means missing better strategies, but exploring too much wastes reward on suboptimal actions.
]

#pagebreak()
Q18: In model-based RL the agent estimates the MDP from observed experience, then solves it with standard planning. #sidenote[Course notes: 09-Reinforcement-Learning, Pages 2--3]

(a) Define what a _sample_ and an _episode_ are in this context.

#answer[
  A _sample_ is a single observed transition: $(s, a, r, s')$, the agent was in state $s$, took action $a$, received reward $r$, and ended up in state $s'$. One step of interaction.

  An _episode_ is a complete trajectory from the starting state to a terminal state: a sequence of samples $(s_0, a_0, r_0, s_1, a_1, r_1, dots, s_n)$ where $s_n$ is terminal. One run of the game from start to finish.
]

(b) Describe the three-step model-based RL procedure. Be precise about how the transition counts are converted into a valid distribution and when the discount factor $gamma$ enters.

#answer[
  + Collect samples by acting in the environment (following some policy, possibly random, possibly current best-guess).
  + Estimate the model: compute $hat(T)(s, a, s') = "count"(s, a, s') \/ "count"(s, a)$ (normalize transition counts to get a valid probability distribution summing to 1). Similarly estimate $hat(R)(s, a, s')$ as the average observed reward for each $(s,a,s')$ tuple.
  + Solve the estimated MDP using standard planning (value iteration or policy iteration) with $hat(T)$ and $hat(R)$ in place of $T$ and $R$. $gamma$ enters only at this step, it's used by the Bellman equation in the planning algorithm.

  The agent then acts under the computed policy, collects more samples, and repeats.
]

(c) Musty the mustang claims: "When estimating $hat(T)(s, a, s')$ from experience, you must keep samples grouped by episode, mixing transitions across episodes gives you a corrupted transition function." Is Musty correct? Cite the concept that justifies your answer. Then identify one situation where Musty _would_ be right and episode boundaries do matter.

#answer[
  Musty is wrong. Samples can be lumped together freely, there is no need to keep episodes separate. The justification is the Markov property, since $P(s_{t+1} | s_t, a_t)$ depends only on the current state and action, not on when in the episode the transition occurred or what happened before it, every $(s, a, s')$ observation is an equally valid draw from the same distribution. Pooling all transitions and counting them together gives the correct empirical estimate.

  Episode boundaries do matter when computing returns for direct evaluation, since you need to know the full sequence of rewards from each visit to a state through to the end of the episode. They also matter if terminal states need special handling, you should not count the transition from a terminal state back to the start of the next episode as a real transition in the MDP.
]
#pagebreak()

Q19: Consider the following four episodes in an MDP with states $A, B, C, D, E$ and terminal $T$:

#table(
  columns: 2,
  align: (left, left),
  stroke: 0.5pt,
  [*Episode*], [*Trace*],
  [1], [$B arrow.r C, -1 quad C arrow.r D, -1 quad D arrow.r T, +10$],
  [2], [$B arrow.r C, -1 quad C arrow.r D, -1 quad D arrow.r T, +10$],
  [3], [$E arrow.r C, -1 quad C arrow.r D, -1 quad D arrow.r T, +10$],
  [4], [$E arrow.r C, -1 quad C arrow.r A, -1 quad A arrow.r T, -10$],
)

(a) From these samples, estimate $hat(T)(C, "down", D)$ and $hat(T)(C, "down", A)$. Show your count-based calculation.

#answer[
  From state $C$ with action "down", transitions occur in all four episodes (C is visited in each).
  - $C -> D$: episodes 1, 2, 3 -> 3 times.
  - $C -> A$: episode 4 -> 1 time.
  - Total from $(C, "down")$: 4 transitions.

  $ hat(T)(C, "down", D) = 3/4 = 0.75 $
  $ hat(T)(C, "down", A) = 1/4 = 0.25 $
]

(b) Estimate $hat(R)(D, "exit", T)$ and $hat(R)(A, "exit", T)$.

#answer[
  $D -> T$: observed in episodes 1, 2, 3. Reward each time: $+10$. Average: $hat(R)(D, "exit", T) = +10$.

  $A -> T$: observed in episode 4. Reward: $-10$. Average: $hat(R)(A, "exit", T) = -10$.
]

(c) Given these estimates and assuming $gamma = 0.9$, what is the model-based agent's optimal policy? (You do not need to solve the full linear system, reason qualitatively from the reward structure.)

#answer[
  Going through $D$ pays $+10$ at terminal; going through $A$ pays $-10$. With $gamma = 0.9$ the agent heavily weighs these future rewards. From $C$, action "down" leads to $D$ (75% chance of $+10$ at terminal) vs $A$ (25% chance of $-10$), still clearly good in expectation.

  Optimal policy: from $B$ or $E$, go to $C$ (the only option shown). From $C$, take "down" (expected positive terminal reward dominates). The agent should try to route through $D$, not $A$.
]

#pagebreak()
Q20: Model-free RL avoids storing a full transition model by learning values directly from samples. #sidenote[Course notes: 09-Reinforcement-Learning, Pages 4--5] With that in mind, what are the three ways to compute an expected value $E[X]$. Write all three formulas and identify which corresponds to the model-based, model-free, and exact approaches.

#answer[
  + Exact (requires knowing $P$): $E[X] = sum_x x dot P(X = x)$. Used in planning when the full distribution is known.

  + Model-based estimate (requires estimated $hat(P)$): $E[X] approx sum_x x dot hat(P)(X = x)$. Build $hat(P)$ from counts, then compute the expectation analytically using the model.

  + Sample average / model-free: $E[X] approx frac(1, N) sum_(i=1)^N x_i$ where $x_i$ are observed samples. No model needed, just average what you see. This is the model-free approach, and it works by the law of large numbers as $N -> infinity$.
]

Q21: Describe _Direct Evaluation_. What policy does the agent follow, what does it record, and how does it produce $hat(V)^pi$? State the key weakness of direct evaluation that motivates TD learning.

#answer[
  In direct evaluation the agent follows a fixed policy $pi$ and runs complete episodes to completion. For each episode, it records the actual total discounted return from every state visited. After many episodes, $hat(V)^pi(s)$ is estimated as the average total return across all episodes that passed through state $s$.

 its weakness is direct evaluation ignores the Markov structure of the MDP. It treats each state independently, the value of $s$ is estimated only from episodes that actually visit $s$, with no information shared between states. This is very sample-inefficient, especially for states visited rarely. TD learning fixes this by bootstrapping, updating $hat(V)(s)$ immediately using the observed next state's current estimate, propagating information backward through the MDP without waiting for complete episodes.
]

Q22: _Temporal-Difference Learning_ (TD learning) fixes the weakness you identified in (Q21). Write:

(a) The formula for the _sample value_ $V^pi_"sample"(s)$ implied by a single transition $(s, a, s', r)$.

#answer[
  $ V^pi_"sample"(s) = r + gamma hat(V)^pi(s') $

  This is the immediate reward plus the discounted current estimate of the next state, a one-step lookahead bootstrapped from the existing value function.
]
#pagebreak()

(b) The exponential moving-average update rule for $hat(V)^pi(s)$. Identify the _learning rate_ $alpha$ and explain what it controls. What does the update reduce to when $alpha = 0$? When $alpha = 1$?

#answer[
  $ hat(V)^pi(s) <- (1 - alpha) hat(V)^pi(s) + alpha dot V^pi_"sample"(s) $

  $alpha in (0, 1]$ is the learning rat, it controls the tradeoff between retaining prior estimates and incorporating new samples. High $alpha$ trusts recent experience; low $alpha$ is more conservative and averages over a longer history.

  - $alpha = 0$: no learning at all, the estimate never changes regardless of observed samples.
  - $alpha = 1$: complete overwrite, the estimate is replaced entirely by the most recent sample, discarding all prior experience.
]

(c) Why does TD learning converge faster than direct evaluation? What structural fact about MDPs does it exploit that direct evaluation ignores?

#answer[
  TD learning exploits the Markov property. Because the next state $s'$ fully summarizes the future, the estimate $hat(V)(s')$ is a useful proxy for future returns even without completing the episode. Every single transition immediately updates $hat(V)(s)$, and information propagates backward through the state space step by step, you don't need to wait for the episode to end.

  Direct evaluation ignores this structure entirely: it waits for complete episodes and estimates each state's value from scratch, treating different states as unrelated. TD learning shares information across states through the bootstrapped update, converging in far fewer samples.
]

Q23: Q-learning extends TD learning to learn optimal policies without a fixed policy. #sidenote[Course notes: 09-Reinforcement-Learning, Pages 5--6]

(a) Explain why TD learning cannot be directly used to find an _optimal_ policy. What would you have to do each time the policy changes under pure TD learning?

#answer[
  TD learning estimates $hat(V)^pi$, the value function for the _specific policy $pi$_ currently being followed. If you want to improve the policy (like in policy iteration), you'd need to re-run TD learning from scratch every time you change $pi$, because the old $hat(V)^pi$ estimates are now stale and wrong under the new policy. In an online setting where the policy changes frequently, this is completely impractical.
]
#pagebreak()

(b) Write the Q-learning update rule for a transition $(s, a, s', r)$. Label every term.

#answer[
  $ underbrace(Q(s,a), "new estimate") <- underbrace((1-alpha), "keep old") dot underbrace(Q(s,a), "old estimate") + underbrace(alpha, "step size")dot\
   lr([underbrace(r, "immediate reward") + underbrace(gamma, "discount") underbrace(max_(a') Q(s', a'), "optimal future")] )$
]

(c) Compare the Q-learning update to the TD learning update. What single structural change makes Q-learning _off-policy_ while TD learning is _on-policy_? Where does the $max$ appear, and why does that matter?

#answer[
  TD update: $hat(V)^pi(s) <- (1-alpha) hat(V)^pi(s) + alpha[r + gamma hat(V)^pi(s')]$

  Q-learning update: $Q(s,a) <- (1-alpha) Q(s,a) + alpha[r + gamma max_{a'} Q(s',a')]$

  The single structural change is the $max_{a'}$ in the Q-learning target. TD learning uses $hat(V)^pi(s')$, the value of the next state under the current policy $pi$, so it only learns about what $pi$ would do. Q-learning uses $max_{a'} Q(s',a')$, the best possible Q-value at $s'$ regardless of what policy is being followed. This decouples learning from the behavior policy: the agent can wander around doing anything (exploring randomly, following a suboptimal policy) and still accumulate updates that converge to the optimal Q-values.
]

(d) Once Q-values have converged, how do you extract the policy $pi(s)$? Write the formula.

#answer[
  $ pi(s) = op("argmax")_a Q(s, a) $

  Just take the greedy action at each state, whichever action has the highest converged Q-value.
]

(e) Q-learning is guaranteed to converge to the optimal policy given two conditions. State both conditions. Why does "it does not matter how you select actions" hold in the limit, even if early actions are suboptimal?

#answer[
  + Every state-action pair $(s,a)$ must be visited infinitely often (sufficient exploration, you can't learn about an action you never try). #sidenote[Yes, you do have to try the obviously bad action infinitely many times. For science.https://xkcd.com/242/]
  + The learning rate $alpha$ must satisfy the Robbins-Monro conditions: $sum_t alpha_t = infinity$ and $sum_t alpha_t^2 < infinity$ (e.g., $alpha_t = 1/t$).

  "It does not matter how you select actions" holds because over an infinite horizon, every $(s,a)$ pair accumulates infinitely many updates regardless of the exploration strategy. The finitely many "bad" updates from early suboptimal behavior become negligible against the infinite stream of converging updates. Any exploration strategy that satisfies condition 1 will eventually drive Q-values to $Q^*$.
]
#pagebreak()

(f) An agent doing Q-learning in an unknown environment with states $A, B, C$, terminal $T$, and actions $arrow.l$ and $arrow.r$ observes the following repeating sequence (with $alpha = 0.5$, $gamma = 0.9$, all Q-values initialized to 0):

#table(
  columns: 4,
  align: (center, center, center, center),
  stroke: 0.5pt,
  [*s*], [*a*], [$s'$], [*r*],
  [$A$], [$arrow.r$], [$B$], [0],
  [$B$], [$arrow.r$], [$C$], [0],
  [$C$], [$arrow.l$], [$T$], [1],
)

After which sample does $Q(C, arrow.l)$ first become nonzero? After which sample does $Q(B, arrow.r)$ first become nonzero? Trace the update for each.

#answer[
  Number samples sequentially (1 = first $A arrow.r B$, 2 = first $B arrow.r C$, 3 = first $C arrow.l T$, then 4,5,6 on the second pass, etc.).

  Sample 1 ($A,arrow.r,B,0$): $Q(A,arrow.r) <- 0.5 dot 0 + 0.5(0 + 0.9 dot 0) = 0$. No change.

  Sample 2 ($B,arrow.r,C,0$): $Q(B,arrow.r) <- 0.5 dot 0 + 0.5(0 + 0.9 dot max_a Q(C,a)) = 0$. No change ($Q(C,dot)$ still all zero).

  Sample 3 ($C,arrow.l,T,1$): $T$ is terminal so $max_a Q(T,a) = 0$. $Q(C,arrow.l) <- 0.5 dot 0 + 0.5(1 + 0.9 dot 0) = 0.5$. $Q(C,arrow.l)$ first becomes nonzero after sample 3.

  Sample 4 ($A,arrow.r,B,0$): no change.

  Sample 5 ($B,arrow.r,C,0$): $Q(B,arrow.r) <- 0.5 dot 0 + 0.5(0 + 0.9 dot max_a Q(C,a)) = 0.5(0.9 dot 0.5) = 0.225$. $Q(B,arrow.r)$ first becomes nonzero after sample 5.

  The reward signal propagates backward one step per pass through the sequence, it reaches $C$ on pass 1, then reaches $B$ on pass 2.
]

(g) An agent ran Q-learning for 10,000 steps but Q-values have not converged. Three classmates each suspect a different exploration strategy is the cause. For each diagnosis below, state whether the classmate is correct and explain why in one sentence:

- Musty used a fully _greedy_ strategy: always pick $arg max_(a') Q(s, a')$ from the current estimates.
- Jeffery used a _fixed optimal policy_ $pi^*$: always take the action known to be best from a separate planner.
- Sam used _$epsilon$-greedy_ with $epsilon = 0.05$: pick randomly 5% of the time, greedily otherwise.

#answer[
  _Musty (greedy), Correct diagnosis._ A fully greedy strategy never explores: once Q-values tip in any direction, the agent keeps exploiting those estimates and never visits state-action pairs whose current Q-value is not the highest, violating the "every $(s,a)$ visited infinitely often" convergence requirement.

  _Jeffery (fixed $pi^*$), Correct diagnosis._ Following a fixed policy (even an optimal one) covers only the state-action pairs that policy visits; all off-path $(s,a)$ pairs are never sampled, so Q-values for those pairs never update and the algorithm cannot converge globally.

  _Sam ($epsilon$-greedy, $epsilon = 0.05$), Incorrect diagnosis._ $epsilon$-greedy with any fixed $epsilon > 0$ guarantees that every action is selected with positive probability at every state on every visit, satisfying the infinite-visitation condition; Q-values are guaranteed to converge to $Q^*$ given appropriate learning rates.
]

Q24: Your robot has finished collecting experience and the environment is no longer accessible, you have only a fixed dataset of stored episodes. For each algorithm, answer: (1) Can it continue improving using only the stored dataset? (2) Can it produce an optimal policy $pi^*$ from that dataset alone?

#table(
  columns: 3,
  align: (center, center, center),
  stroke: 0.5pt,
  [*Algorithm*], [(1) Improves from fixed dataset?], [(2) Produces $pi^*$?],
  [Model-based RL], [#answer[Yes]], [#answer[Yes]],
  [Direct Evaluation], [#answer[Yes]], [#answer[No]],
  [TD Learning], [#answer[Yes]], [#answer[No]],
  [Q-Learning], [#answer[Yes]], [#answer[Yes]],
)
#v(0.5cm)

#answer[
  All four algorithms can extract information from a fixed dataset: model-based RL builds $hat(T)$ and $hat(R)$ from the stored transitions; direct evaluation and TD learning average returns or bootstrap over stored samples; Q-learning applies its update rule to stored $(s,a,r,s')$ tuples.

  Direct evaluation and TD learning converge to $V^pi$, the value function of the _behavioral policy_ that generated the data, not the optimal policy, without interacting with the environment they cannot evaluate actions the behavior policy never took, so they cannot identify $pi^*$. Model-based RL builds a full transition model from the data and then runs planning to optimality; Q-learning's $max_{a'}$ target bootstraps toward the optimal Q-values regardless of the behavior policy, so both can produce $pi^*$ from the same fixed dataset.
]
