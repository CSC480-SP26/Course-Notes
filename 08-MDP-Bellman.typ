
#import "wdf.typ": *

#show: template.with(
  title: [
    Markov Decision Process and The Bellman Equation
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Guest lecture, Samuel Kaplan: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover Markov Decision Processes and the Bellman equation, then show how value iteration and policy iteration use that structure to compute optimal policies.],
  bib: none,
  serif: true,
  exam: false,
)

#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]


= Markov Decision Process

What should an agent do when it doesn't know where it will start, or whether there's an end?

Search and expectimax plan from a single starting state outward through a tree of futures. That works when the world is a one way road. It starts to have problems when:
- States _cycle_ (the agent may return to a state it has already visited)#sidenote[During Lab 1 some of you may have experienced the issue of agents getting stuck in action loops like circling a wall/pillar or moving back and fourth one spot to avoid a goblin]
- Decisions must be made from _any_ state the agent might occupy
- The agent acts continuously, with no clear terminal goal

Instead of a plan, we want a _policy_: a complete prescription for what to do in every possible situation. Markov Decision Processes give us a framework for computing exactly that.

== A totally unrelated example

Suppose it's the night before a given lecture, and our unassuming lecturer was prepping the notes. Our lecturer's goal is to work hard and finish this lecture on time. To help our lecturer out, lets describe this world in three states the lecturer can be in:
- Writing: Actually making progress on the notes.
- Googling: Looking something up "really quickly."
- Doomscrolling: Completely off task, watching videos about whatever the algorithm has decided to serve up tonight.

#figure(caption: [State Transition Diagram for Lecture Preparation],
  diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,
    spacing: 3em,

    node((0, 0), [Writing], name: <w>),
    node((3, 0), [Googling], name: <g>),
    node((6, 0), [Doomscrolling], name: <d>),

    edge(<w>, <w>, "->", bend: -130deg),
    edge(<w>, <g>, "->", bend: 20deg),
    edge(<g>, <w>, "->", bend: 20deg),
    edge(<g>, <d>, "->", bend: 20deg),
    edge(<d>, <d>, "->", bend: -130deg),
  )
)

The lecturer has exactly two actions available in both Writing and Googling: _Focus_ (the safe, steady option) and _Browse_ (the tempting but risky one). From Writing, Focus always keeps you writing. Browse is a coin flip: half the time you find something useful and stay productive, half the time you end up down a Googling rabbit hole. From Googling, Focus gives you even odds of snapping back to Writing or staying stuck. But choosing Browse from Googling? That sends you straight to Doomscrolling, every single time.

A Markov Decision Process gives us the formal language to describe exactly this kind of problem.

#def(term: [Markov Decision Process])[
  A Markov Decision Process (MDP) consists of:
  - A set of _states_ $S$
  - A set of _actions_ $A(s)$ available in state $s in S$
  - A _transition model_ $T(s, a, s') = P(s' | s, a)$: the probability of landing in state $s'$ after taking action $a$ in state $s$
  - A _reward function_ $R(s, a, s')$ giving the immediate reward for each transition #sidenote()[The reward function is sometimes simplified as $R(s)$ or $R(s, a)$ depending on the problem. The full form $R(s, a, s')$ is the most general.]
  - A _discount factor_ $gamma in [0, 1]$ controlling how much future rewards are valued relative to immediate ones #sidenote[The definition writes $gamma in [0,1]$ but finite and infinite horizon problems have different requirements. For infinite horizon problems $gamma = 1$ is not allowed since the sum may diverge, so in practice $gamma in [0,1)$.]
]

Note that for each state-action pair $(s, a)$, the transition probabilities must form a valid probability distribution:
$
  forall s, a: sum_(s') T(s, a, s') = 1
$

For now lets ignore the discount factor and explore our example, the full transition and reward model is:

#figure(
  caption: [Transition model $T(s, a, s')$ and rewards for Lecture Preparation],
  table(
    columns: 6,
    align: center,
    table.header([State], [Action], [$P'($Writing$)$], [$P'($Googling$)$], [$P'($DS$)$], [Reward]),
    [Writing],       [Focus],  [$1.0$], [$0.0$], [$0.0$], [$+1$],
    [Writing],       [Browse], [$0.5$], [$0.5$], [$0.0$], [$+2$],
    [Googling],      [Focus],  [$0.5$], [$0.5$], [$0.0$], [$+1$],
    [Googling],      [Browse], [$0.0$], [$0.0$], [$1.0$], [$-10$],
  )
)

Focus always keeps you on task, from either Writing or Googling it never sends you somewhere worse:
#[
  #set math.equation(numbering: none)
$
  T("Writing",  "Focus", "Writing")  &= 1.0 \
  T("Googling", "Focus", "Writing")  &= 0.5, quad T("Googling", "Focus", "Googling") = 0.5
$
]
Focus yields a modest $+1$ per step. Browse is the risky choice, from Writing it is a coin flip between staying productive and sliding into Googling, and from Googling it sends you straight to Doomscrolling with certainty:
#[
  #set math.equation(numbering: none)
$
  T("Writing",  "Browse", "Writing")  &= 0.5, quad T("Writing",  "Browse", "Googling") = 0.5 \
  T("Googling", "Browse", "DS") &= 1.0
$
]
Browse yields $+2$ from Writing when it goes well, but the catastrophic $R("Googling", "Browse", "DS") = -10$ makes it a bad idea when Googling.

Updating the diagram with rewards on each state and transition probabilities labeled by action:
#figure(caption: [State Transition Diagram with Rewards and Transition Probabilities],
  diagram(
    edge-stroke: 0.75pt,
    node-corner-radius: 10pt,
    node-stroke: 1pt,
    edge-corner-radius: 10pt,
    spacing: 3em,

    node((0, 0), align(center)[Writing], name: <w>),
    node((3, 0), align(center)[Googling], name: <g>),
    node((6, 0), align(center)[Doomscrolling], name: <d>),

    edge(<w>, <w>, "->", [Focus: 1.0], bend: -130deg),
    edge(<w>, <w>, "->", [Browse: 0.5], bend: 130deg),
    edge(<w>, <g>, "->", [Browse: 0.5], bend: 20deg),
    edge(<g>, <w>, "->", [Focus: 0.5], bend: 20deg),
    edge(<g>, <g>, "->", [Focus: 0.5], bend: -130deg),
    edge(<g>, <d>, "->", [Browse: 1.0], bend: 20deg),
    edge(<d>, <d>, "->", [terminal], bend: -130deg),
  )
)

== The Markov Property

The defining feature of a Markov Decision Process is the _Markov property_, in that the future depends only on the _present state_, not on the history of how the agent arrived there.

$
  P(s_(t+1) | s_t, a_t, s_(t-1), a_(t-1), ..., s_0, a_0) = P(s_(t+1) | s_t, a_t)
$

The current state is a sufficient summary of all relevant history. This is the same assumption underlying the Markov Blanket from Bayes Networks, and it is what makes MDPs tractable. Rather than reasoning about arbitrarily long decision histories, we only need to reason about where we are right now.

In our example, whether our poor lecturer spirals from Googling into Doomscrolling depends only on being in the Googling state at that exact moment, not on how many times they have previously cycled between Writing and Googling, or how many hours the deadline has been looming.

== Policy

In a search problem, the solution is a _sequence of actions_. In an MDP, since the environment is stochastic and the agent may find itself in any state, the solution is instead a _policy_.

#def(term: [Policy])[
  A _policy_ $pi: S -> A$ is a mapping from states to actions. The _optimal policy_ $pi^*$ maximizes the expected total discounted reward from any starting state. #sidenote[In modern reinforcement learning, finding $pi^*$ is exactly what systems like AlphaGo and RLHF tuned language models are doing, the "policy" is literally the neural network being trained.]
]

The important difference from search is that the solution to an MDP is a _complete plan for every state_, not just from a single start. Wherever the environment drops us(whether we stayed focused, got distracted, or fell headfirst into a Doomscrolling spiral), a policy tells us what to do next.

#discussion()[
  What is the optimal policy $pi^*$ for this MDP? Is Browse from Googling ever a rational choice given the current model? What would need to change, in the rewards or transition probabilities for it to become so?
]


The optimal policy is to Focus in both Writing and Googling. From Writing, Browse earns a higher immediate reward of $+2$ but risks landing in Googling, from which Browse sends you deterministically into Doomscrolling(a state with no exit and a reward of $-10$ every step for the rest of time). Browse from Googling is therefore _never_ rational under this model as no immediate reward, however large, can outweigh the infinite stream of $-10$ penalties that follows. For Browse from Googling to become rational, the model would need to give Doomscrolling a way out (some non-zero $T($DS, $dot$, Writing$)$), or make the reward from Doomscrolling positive. 


== Horizons

A key structural choice in any MDP is whether the agent acts for a fixed number of steps or indefinitely.

In a _finite horizon_ MDP with horizon $T$, the agent takes exactly $T$ actions. The optimal policy here can be _non-stationary_ in that the right choice at step $t = T - 1$ may differ from the right choice at step $t = 1$, because the agent has less time left to recover from a bad outcome. Our example with a lecture deadline the next day is an example of a finite horizon problem.

In an _infinite horizon_ MDP, the agent acts indefinitely with no fixed endpoint. Here the optimal policy is _stationary_ in that the same action is optimal in a given state regardless of how many steps have already elapsed, since there is no "time remaining" to track. This is a dramatic simplification. The Bellman equation, which we will get tto shortly, applies to the infinite horizon setting.

== Discounting

Infinite horizon MDPs introduce a new problem in that, if the agent collects rewards forever, the sum $sum_(t=0)^infinity R_t$ may diverge. Consider our humble lecturer, if they Focus in Writing indefinitely, collecting $+1$ every step, the undiscounted total is $1 + 1 + 1 + dots = +infinity$. If they instead end up Doomscrolling, the total is $(-10) + (-10) + (-10) + dots = -infinity$. Both diverge, and comparing $+infinity$ to $-infinity$ to decide which policy is better is not meaningful. We cannot say the writing policy is "$+infinity - (-infinity)$ better" than doomscrolling, since that arithmetic is undefined. The solution is the _discount factor_ $gamma in [0, 1)$ that we set aside from the MDP definition. Instead of summing raw rewards, the agent maximizes the total _discounted_ reward:
$
  sum_(t=0)^infinity gamma^t R_t
$
Since rewards are bounded (say $|R_t| <= R_"max"$), this geometric series converges to at most $R_"max" / (1 - gamma)$, so values are always finite and well-defined.

There are two useful ways to think about $gamma$. First, as a _preference for sooner rewards_, a reward of $+1$ now is worth more than a reward of $+1$ next step, just as a dollar today is worth more than a dollar next year. Second, as a model of _uncertain termination_. Imagine that after each step, a coin is flipped, with probability $1 - gamma$ the game simply ends and the agent collects no further reward, and with probability $gamma$ it carries on. The reward at step $t$ is then only collected if the agent survives all $t$ preceding flips, which happens with probability $gamma^t$(the factor multiplying that reward in the discounted sum). 

The parameter $gamma$ directly controls the agent's patience:
- $gamma = 0$: completely myopic, only the immediate reward matters, future consequences are ignored entirely. Think your average gen $alpha$ gremlin hedonistically seeking rewards.
- $gamma -> 1$: increasingly patient, distant future rewards count nearly as much as immediate ones. Think of the lecturer who refuses to Browse from Googling precisely because they know exactly where it leads and they feel the full weight of infinite future procrastination bearing down on each decision.



In our example, the value of being stuck in Doomscrolling forever is:
$
  V("DS") = sum_(t=0)^infinity gamma^t (-10) = (-10) / (1 - gamma)
$
As $gamma -> 1$ this diverges to $-infinity$, which is precisely why $gamma < 1$ is required for infinite horizon problems, without it, values are undefined and no meaningful policy comparison is possible.

#pagebreak()

#discussion()[
  + When $gamma = 0$, what is the optimal action from Writing? From Googling? Now consider any $gamma in (0, 1)$: is there a value of $gamma$ for which Browse from Writing is _not_ optimal?
  + Let $V(s)$ denote the total expected discounted reward from state $s$ under the optimal policy. Write $V("Writing")$ as an equation involving $V("Writing")$ and $V("Googling")$, then do the same for $V("Googling")$. Do you notice anything interesting about these equations?
]

When $gamma = 0$ the agent ignores all future consequences, so from Writing it simply takes whichever action yields the highest immediate reward: Browse ($+2$) beats Focus ($+1$). From Googling, Browse yields $-10$ and Focus yields $+1$, so Focus is the clear choice. The optimal policy when $gamma = 0$ is therefore Browse from Writing and Focus from Googling.

Perhaps surprisingly, Browse from Writing remains optimal for _every_ $gamma in [0, 1)$, as there is no threshold at which Focus becomes preferable. The reason is that Googling under Focus is not a bad state to be in is that it yields $+1$ per step and returns to Writing with probability $0.5$ each step. The extra $+1$ immediate reward from Browse always outweighs the modest cost of occasionally landing in Googling rather than staying in Writing. Browse from Googling, by contrast, is never rational for any $gamma > 0$, since it leads with certainty to Doomscrolling, a state whose value $-10\/(1-gamma)$ is catastrophically negative for any reasonable $gamma$.

Under the optimal policy ($pi^*($Writing$) =$ Browse, $pi^*($Googling$) =$ Focus), the values satisfy:
$
  V("Writing") &= 2 + gamma (0.5 dot V("Writing") + 0.5 dot V("Googling")) \
  V("Googling") &= 1 + gamma (0.5 dot V("Writing") + 0.5 dot V("Googling"))
$

These are two simultaneous linear equations in two unknowns, and they can be solved directly. These equations make each state equal the immediate reward of the optimal action plus the discounted expected value of the states it leads to. This recursive structure, with value defined in terms of other values, is the core concept behind _dynamic programming_#sidenote[Richard Bellmanm, who lends his name to the next section, coined the term "dynamic programming" deliberately to obscure the mathematical research he was doing. https://en.wikipedia.org/wiki/Dynamic_programming#History_of_the_name]. Rather than searching over the exponentially many possible action sequences, dynamic programming breaks the problem into overlapping subproblems and once we know the value of every state, we know the optimal action from every state, and those values can be computed by solving the system of equations above . Generalizing it and using it to compute optimal policies is exactly what we will do next.
#pagebreak()

= The Bellman Equation

In the previous section we wrote down the value equations for Writing and Googling under a specific policy. But there was something unsatisfying about that derivation, we had to know the optimal policy first (Browse from Writing, Focus from Googling) before we could write the equations. In general we do not know the optimal policy, that is precisely what we are trying to find. The Bellman equation gives us a way to express the optimal values without assuming we already know the answer.

== Value and Action-Value

We define $V^*(s)$ as the _optimal value_ of state $s$, the expected total discounted reward an agent collects starting from $s$ and acting optimally from that point forward. This is the quantity we want to compute.

Now, the value of a state depends entirely on what the agent does there. The value of taking a specific action $a$ from state $s$, and then acting optimally afterward, is called the _action value_ or _Q-value_:

#def(term: [Q-value])[
  $
    Q^*(s, a) = sum_(s') T(s, a, s') [R(s, a, s') + gamma V^*(s')]
  $
  The Q-value $Q^*(s, a)$ is the expected discounted reward of taking action $a$ in state $s$ and then following the optimal policy from every subsequent state.
]

The Q-value is the _expected value_ of $(R(s,a,s') + gamma V^*(s'))$ over all possible next states $s'$. The transition probabilities $T(s,a,s')$ sum to 1 over all $s'$ as they are the weights of a probability distribution. Since the agent cannot control which $s'$ it actually lands in, the Q-value must weigh each possible outcome by how likely it is.

The optimal value of a state is then simply the Q-value of the best available action:
$
  V^*(s) = max_a Q^*(s, a)
$

And the optimal policy just picks that best action:
$
  pi^*(s) = arg max_a Q^*(s, a)
$

== The Bellman Equation

Substituting the definition of $Q^*$ into $V^*(s) = max_a Q^*(s, a)$ gives the _Bellman equation_:

#def(term: [Bellman Equation])[
  $
    V^*(s) = max_a sum_(s') T(s, a, s') [R(s, a, s') + gamma V^*(s')]
  $
]

Read this equation carefully. The left-hand side is the value of state $s$. The right-hand side picks the best action (the $max_a$), then takes the expectation over where that action leads (the $sum_(s') T(s,a,s')$), collecting the immediate reward $R$ and the discounted value of the next state $gamma V^*(s')$. $V^*$ appears on both sides as the equation is recursive.


== Value Iteration
This might look circular, but it is not a contradiction. For a finite state space with $gamma < 1$, the Bellman equations have a unique solution. We can find it by treating the right-hand side as an update rule, given any estimate of $V^*$, plug it in to get a better one. Each application is a _Bellman update_, and repeating this process, called _value iteration_, is guaranteed to converge. The reason is $gamma$, as any error in the current estimate gets multiplied by $gamma < 1$ each round, so the gap between the estimate and the true $V^*$ shrinks by at least a factor of $gamma$ with every update. The closer $gamma$ is to 1, the slower the shrinkage, but it always shrinks. This requires knowing $T$ and $R$ upfront, though. When the agent has to learn from experience instead, we need a different approach, which the next lecture will cover.

As an example, let $gamma = 0.9$ and initialize $V^0(s) = 0$ for every state. The first Bellman update substitutes $V^0$ into the right-hand side of the Bellman equation:
#[
  #set math.equation(numbering: none)
  $
    V^1("Writing") &= max cases(
      1 + 0.9 dot 0 = 1 & ["Focus"],
      2 + 0.9(0.5 dot 0 + 0.5 dot 0) = 2 & ["Browse"]
    ) = 2 \
    V^1("Googling") &= max cases(
      1 + 0.9(0.5 dot 0 + 0.5 dot 0) = 1 & ["Focus"],
      -10 + 0.9 dot 0 = -10 & ["Browse"]
    ) = 1 \
    V^1("DS") &= -10 + 0.9 dot 0 = -10
  $
]
With $V^1$ in hand, a second update gives:
#[
  #set math.equation(numbering: none)
  $
    V^2("Writing") &= max cases(
      1 + 0.9 dot 2 = 2.8 & ["Focus"],
      2 + 0.9(0.5 dot 2 + 0.5 dot 1) = 3.35 & ["Browse"]
    ) = 3.35 \
    V^2("Googling") &= max cases(
      1 + 0.9(0.5 dot 2 + 0.5 dot 1) = 2.35 & ["Focus"],
      -10 + 0.9 dot (-10) = -19 & ["Browse"]
    ) = 2.35 \
    V^2("DS") &= -10 + 0.9 dot (-10) = -19
  $
]
Each round the estimates climb toward the true $V^*$. To see where those values land, we can solve the Bellman equations directly as a linear system. DS is absorbing, so its equation has one unknown:
#[
  #set math.equation(numbering: none)
  $
    V^*("DS") &= -10 + 0.9 dot V^*("DS") \
    0.1 dot V^*("DS") &= -10 \
    V^*("DS") &= -100
  $
]
For Writing and Googling we can do something similar, but first we have to deal with the $max$. The full Bellman equation for Writing looks like:
#[
  #set math.equation(numbering: none)
  $
    V^*("Writing") = max cases(
      1 + 0.9 dot V^*("Writing") & ["Focus"],
      2 + 0.9(0.5 dot V^*("Writing") + 0.5 dot V^*("Googling")) & ["Browse"]
    )
  $
]
The $max$ makes this non-linear since we cannot collect terms and solve while there is still a choice embedded in the equation. But if we already know the optimal action at each state, we can drop the $max$ and just write down the equation for that action. We know Browse is optimal from Writing and Focus is optimal from Googling, so the equations become:
#[
  #set math.equation(numbering: none)
  $
    V^*("Writing") &= 2 + 0.9(0.5 dot V^*("Writing") + 0.5 dot V^*("Googling")) \
    V^*("Googling") &= 1 + 0.9(0.5 dot V^*("Writing") + 0.5 dot V^*("Googling"))
  $
]
Both equations share the same weighted average, so let $L = 0.5 dot V^*("Writing") + 0.5 dot V^*("Googling")$:
#[
  #set math.equation(numbering: none)
  $
    L &= 0.5(2 + 0.9 L) + 0.5(1 + 0.9 L) = 1.5 + 0.9 L \
    0.1 L &= 1.5 \
    L &= 15
  $
]
Substituting back: $V^*("Writing") = 2 + 0.9(15) = 15.5$ and $V^*("Googling") = 1 + 0.9(15) = 14.5$.

There is something circular about this. We needed to know the optimal policy (Browse from Writing, Focus from Googling) before we could drop the $max$ and write a linear system, but the whole point was to find the optimal policy in the first place. In this example we could figure out the policy by inspection, but in general that is not possible. Value iteration sidesteps this as it never assumes a fixed policy. It keeps the $max$ in place and just repeatedly applies the full Bellman equation as an update rule. Each round the estimates get closer to $V^*$, and the $max$ at each step naturally selects whichever action looks best given the current estimates.

The absolute values take many rounds to converge, but the relative ordering of actions is often correct early on. After just one update, the Q-values from Writing are $2$ for Browse and $1$ for Focus, so Browse wins. 
The true Q-values are:
$
Q^*("Writing", "Browse") = 15.5 \

Q^*("Writing", "Focus") = 1 + 0.9 dot 15.5 = 14.95
$ 
So Browse still wins. From Googling, round one gives $1$ for Focus and $-10$ for Browse. The true values are:
$
Q^*("Googling", "Focus") = 14.5\
Q^*("Googling", "Browse") = -10 + 0.9(-100) = -100
$
So Focus wins by an even wider margin. Value iteration was converging on the right policy immediately, however it just needs more rounds to get the magnitudes right.


== Expectimax

The structure of the Bellman equation should look familiar. The $max_a$ is an agent node; the agent picks the action that maximizes its value. The $sum_(s') T(s,a,s')[dots]$ is a chance node, where the environment picks the next state according to the transition probabilities. This is the expectimax tree from earlier in the course, but written as a set of equations over all states simultaneously rather than a tree expanded from a single root. The key difference is that the Bellman equation handles cycles: because we write equations for every state at once, we do not need to expand the tree and risk infinite loops.

The circle nodes in the tree below are _Q-states_, with each one representing a specific $(s, a)$ pair, the moment after the agent has committed to an action but before the environment has revealed where it lands. This is the same structure as the chance nodes from expectimax, as the agent controls the edge going into a Q-state (by choosing an action), and the environment controls the edges going out of it (by sampling $s'$ according to $T(s, a, X)$). Agent nodes take a $max$ over their children just as in expectimax, and Q-states take the expectation over theirs.

#figure(
  caption: [Expectimax trees for Writing. Square nodes are agent (max) nodes, circle nodes are Q-states where the environment resolves the outcome.],
  diagram(
    node-stroke: 1pt,
    edge-stroke: 0.75pt,
    node-corner-radius: 4pt,
    spacing: (2.5em, 2.5em),

    // Writing tree
    node((0, 0),    [Writing],  name: <w>,   shape: shapes.rect),
    node((-1, 1),   [Focus],    name: <wf>,  shape: circle),
    node(( 1, 1),   [Browse],   name: <wb>,  shape: circle),
    node((-1, 2),   [Writing],  name: <wfw>, shape: shapes.rect),
    node(( 0.25, 2), [Writing],  name: <wbw>, shape: shapes.rect),
    node(( 1.75, 2), [Googling], name: <wbg>, shape: shapes.rect),

    edge(<w>,  <wf>,  "->", [Focus],  label-side: left),
    edge(<w>,  <wb>,  "->", [Browse], label-side: right),
    edge(<wf>, <wfw>, "->", [$1.0$],  label-side: left),
    edge(<wb>, <wbw>, "->", [$0.5$],  label-side: left),
    edge(<wb>, <wbg>, "->", [$0.5$],  label-side: right),
  )
)

#figure(
  caption: [Expectimax tree for Googling.],
  diagram(
    node-stroke: 1pt,
    edge-stroke: 0.75pt,
    node-corner-radius: 4pt,
    spacing: (2.5em, 2.5em),

 // Googling tree
    node((5, 0),    [Googling], name: <g>,   shape: shapes.rect),
    node((4, 1),    [Focus],    name: <gf>,  shape: circle),
    node((6, 1),    [Browse],   name: <gb>,  shape: circle),
    node((3.3, 2),  [Writing],  name: <gfw>, shape: shapes.rect),
    node((4.7, 2),  [Googling], name: <gfg>, shape: shapes.rect),
    node((6, 2),    [DoomScrolling],       name: <gbd>, shape: shapes.rect),

    edge(<g>,  <gf>,  "->", [Focus],  label-side: left),
    edge(<g>,  <gb>,  "->", [Browse], label-side: right),
    edge(<gf>, <gfw>, "->", [$0.5$],  label-side: left),
    edge(<gf>, <gfg>, "->", [$0.5$],  label-side: right),
    edge(<gb>, <gbd>, "->", [$1.0$],  label-side: right),
  )
)
   
== Applying to the Example

Expanding the Bellman equation directly for each non-terminal state:
#[
  #set math.equation(numbering: none)
  $
    V^*("Writing") = max cases(
      1 + gamma V^*("Writing") & ["Focus"],
      2 + gamma (0.5 dot V^*("Writing") + 0.5 dot V^*("Googling")) & ["Browse"]
    )
  $
  $
    V^*("Googling") = max cases(
      1 + gamma (0.5 dot V^*("Writing") + 0.5 dot V^*("Googling")) & ["Focus"],
      -10 + gamma V^*("DS") & ["Browse"]
    )
  $
]

We already know Browse dominates from Writing and Focus dominates from Googling for all $gamma in [0,1)$, so the $max$ resolves and we recover exactly the simultaneous equations from the previous section. The Bellman equation did not tell us anything we did not already know, but it gives us a general procedure that works even when the optimal policy is not obvious by inspection.


Putting it together, starting from Writing and expanding two full rounds:

#figure(
  caption: [Depth-2 expectimax tree rooted at Writing. Square = agent node, circle = Q-state. W = Writing, G = Googling, D = DS. Probabilities on edges match Table 1; and they are omitted at depth 2 for clarity.],
  diagram(
    node-stroke: 0.8pt,
    edge-stroke: 0.6pt,
    node-corner-radius: 3pt,
    node-inset: 4pt,
    spacing: (0.9em, 1.8em),

    // Level 0: root
    node((6.25, 0), [W],  name: <root>,  shape: shapes.rect),

    // Level 1: Q-states
    node((1.5,  1), [f],  name: <q1f>,   shape: circle),
    node((11,   1), [b],  name: <q1b>,   shape: circle),

    // Level 2: states after round 1
    node((1.5,  2), [W],  name: <w1>,    shape: shapes.rect),
    node((7.5,  2), [W],  name: <w2>,    shape: shapes.rect),
    node((14.5, 2), [G],  name: <g2>,    shape: shapes.rect),

    // Level 3: Q-states
    node((0,    3), [f],  name: <qw1f>,  shape: circle),
    node((3,    3), [b],  name: <qw1b>,  shape: circle),
    node((6,    3), [f],  name: <qw2f>,  shape: circle),
    node((9,    3), [b],  name: <qw2b>,  shape: circle),
    node((13,   3), [f],  name: <qgf>,   shape: circle),
    node((16,   3), [b],  name: <qgb>,   shape: circle),

    // Level 4: leaves
    node((0,    4), [W],  name: <l0>,    shape: shapes.rect),
    node((2,    4), [W],  name: <l1>,    shape: shapes.rect),
    node((4,    4), [G],  name: <l2>,    shape: shapes.rect),
    node((6,    4), [W],  name: <l3>,    shape: shapes.rect),
    node((8,    4), [W],  name: <l4>,    shape: shapes.rect),
    node((10,   4), [G],  name: <l5>,    shape: shapes.rect),
    node((12,   4), [W],  name: <l6>,    shape: shapes.rect),
    node((14,   4), [G],  name: <l7>,    shape: shapes.rect),
    node((16,   4), [D],  name: <l8>,    shape: shapes.rect),

    // Root -> level-1 Q-states (labeled with action)
    edge(<root>, <q1f>,  "->", text(size: 0.75em)[Focus],  label-side: left),
    edge(<root>, <q1b>,  "->", text(size: 0.75em)[Browse], label-side: right),

    // Level-1 Q-states -> level-2 states (probability)
    edge(<q1f>,  <w1>,   "->", text(size: 0.75em)[$1.0$]),
    edge(<q1b>,  <w2>,   "->", text(size: 0.75em)[$0.5$],  label-side: left),
    edge(<q1b>,  <g2>,   "->", text(size: 0.75em)[$0.5$],  label-side: right),

    // Level-2 states -> level-3 Q-states (no label, action implied by circle letter)
    edge(<w1>,   <qw1f>, "->"),
    edge(<w1>,   <qw1b>, "->"),
    edge(<w2>,   <qw2f>, "->"),
    edge(<w2>,   <qw2b>, "->"),
    edge(<g2>,   <qgf>,  "->"),
    edge(<g2>,   <qgb>,  "->"),

    // Level-3 Q-states -> level-4 leaves (no label)
    edge(<qw1f>, <l0>,   "->"),
    edge(<qw1b>, <l1>,   "->"),
    edge(<qw1b>, <l2>,   "->"),
    edge(<qw2f>, <l3>,   "->"),
    edge(<qw2b>, <l4>,   "->"),
    edge(<qw2b>, <l5>,   "->"),
    edge(<qgf>,  <l6>,   "->"),
    edge(<qgf>,  <l7>,   "->"),
    edge(<qgb>,  <l8>,   "->"),
  )
)

== Policy Iteration

Value iteration keeps the $max$ in place and converges by repeating Bellman updates. Policy iteration takes a different route: it alternates between two steps.

_Policy evaluation_ takes a fixed policy $pi$ and solves for $V^pi$ exactly. With the policy fixed, there is no $max$, every state has a single prescribed action, so the Bellman equations become a linear system solvable in one shot (exactly as we did earlier when deriving the true values).

_Policy improvement_ then looks at those values and asks: given $V^pi$, is there any state where a different action would do better? Formally, for each state compute:
$
  pi'(s) = arg max_a sum_(s') T(s, a, s') [R(s, a, s') + gamma V^pi(s')]
$
If $pi' = pi$, the policy is already optimal and we stop. Otherwise set $pi = pi'$ and repeat.

To see this in action, start with $pi^0 = {"Writing": "Focus", "Googling": "Focus"}$, the most conservative possible policy. Evaluating $pi^0$ (with $gamma = 0.9$) gives a linear system with no $max$:
#[
  #set math.equation(numbering: none)
  $
    V^(pi^0)("Writing") &= 1 + 0.9 dot V^(pi^0)("Writing") => V^(pi^0)("Writing") = 10 \
    V^(pi^0)("Googling") &= 1 + 0.9(0.5 dot 10 + 0.5 dot V^(pi^0)("Googling")) => V^(pi^0)("Googling") = 10
  $
]
Now improve. For each state, compute Q-values using $V^(pi^0)$:
#[
  #set math.equation(numbering: none)
  $
    Q("Writing", "Focus")  &= 1 + 0.9 dot 10 = 10 \
    Q("Writing", "Browse") &= 2 + 0.9(0.5 dot 10 + 0.5 dot 10) = 11 -> "Browse wins" \
    Q("Googling", "Focus")  &= 1 + 0.9(0.5 dot 10 + 0.5 dot 10) = 10 \
    Q("Googling", "Browse") &= -10 + 0.9 dot (-100) = -100 -> "Focus wins"
  $
]
The improved policy is $pi^1 = {"Writing": "Browse", "Googling": "Focus"}$. Evaluating $pi^1$ gives $V^(pi^1)("Writing") = 15.5$ and $V^(pi^1)("Googling") = 14.5$ (the same linear system we solved before). Running improvement again produces the same policy, so we stop. Policy iteration found the optimal policy in a single iteration.

Policy iteration and value iteration always converge to the same $V^*$, but they get there differently. Value iteration refines value estimates gradually, with the policy implicitly defined by the $max$ at each step. Policy iteration commits to an explicit policy, evaluates it exactly, then jumps to a strictly better one. Each improvement step is guaranteed to not get worse, and since there are only finitely many policies, the process must terminate.
