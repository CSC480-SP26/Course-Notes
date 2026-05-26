

#import "wdf.typ": *

#show: template.with(
  title: [
    Reinforcement Learning
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover a range of the core methods of reinforcement learning: offline model based reinforcement learning, model-free learning, online learning and the exploration/exploitation trade-off, q-learning, and approximate reinforcement learning.],
  bib: none,
  serif: true,
  exam: false,
)






#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]


= Reinforcement Learning
As we have found, Markov Decision Processes provide the mathematical language to describe the behaviour of rational agents acting in an uncertain world. However, we have failed to take into account the _meta-uncertainty_ about the structure of the environment that we most frequently face in practice. That is to say, what do we do if we still have an MDP with:
#columns(2)[
  - States: $S$
  - Actions: $A$
  #colbreak()
  - Transition Model: $T(s,a,s')$
  - Reward Function: $R(s,a,s')$
]

And we want to find an optimal policy $pi(s)$, but _we do not know T or R_. Instead all we have is what the environment tells us, and so while we still need to maximize expected reward, all learning must be based on observed samples of outcomes.


#figure(caption: [Diagram of Classical Reinforcement Learning], diagram(
  edge-stroke: 1pt,
  node-corner-radius: 5pt,
  edge-corner-radius: 8pt,
  mark-scale: 80%,

  node((0.5, 0.1), [_Agent_]),

  node(
    enclose: ((0, 0), (1, 1)),
    stroke: black,
    fill: gray.lighten(95%),
    name: <agent>,
  ),

  node((3.5, 0.1), [_Environment_]),
  node((3.5, 0.65), [#text("?", size: 30pt)]),

  node(
    enclose: ((3, 0), (4, 1)),
    stroke: black,
    fill: gray.lighten(95%),
    name: <env>,
  ),
  edge(<agent>, <env>, "->", label: [Actions: $a$], shift: 0.5),
  edge(<agent>, <env>, "<-", label: [State: $s$\ Reward: $r$], shift: -0.5),
))

== Offline vs Online Learning
Our previous approach to solving MDPs have been _offline_. What this means is that the agent is able to effectively reason about what it expects to happen _beforehand_, and then choose the best option right away. In offline learning an agent already knows not to touch a hot stove. In _online learning_ the agent only knows what it can experience, it must actually touch the stove in order to learn that hard way that it is too hot.

What remains for online reinforcement learning, and the focus of the rest of the notes, are the following components of the problem:
+ How do we learn from the data collected by interacting with the environment
+ How do we act when we dont know much about the environment
+ How can we approximate these procedures in environments where complete models of the states are not possible
#pagebreak()


= Model-based RL
For this part we want to figure out how to learn the relevant components of the MDP from data of actions in the world. In order to do this let us start with the assumption of some history of "episodes" of training data which is a set of traces of samples of what happens by taking an action in a given state:
$
   "sample" & = (s_i,a_i,s_(i+1),r_i) \
  "episode" & = [(s_0,a_0,s_(1),r_0), ...,(s_i,a_i,s_(i+1),r_i),...] \
     "data" & = {"episode 1","episode 2" ...}
$


The model-based approach to reinforcement learning is the most conceptually simple, and in many cases is the best choice#sidenote()[Just because it will take less time to cover does not mean it is any less important, there is lots of ongoing active research in model-based approaches]. All that the agent needs to do is take the sampled training data, and use it to generate an approximate transition function $hat(T)(s,a,s')$#sidenote()[Here using the common notation of a $hat$ over a sample based empirical reconstruction of some uncertain quantity.]. Thus the method is simply described as:
+ Keep track of the counts of each observed transition $(s,a,s',r)$.
+ When calculating an action, normalize the samples so that the transition function is a valid probability distribution.
+ Solve the resulting MDP as normal using value or policy iteration.

#discussion(vspace: 30em)[
  Above I have broken down the sample data by episode (that is by the separate instances of traces of continuous actions and consequences). However, is this always required when using the data to estimate the transitions, or can all of the samples be lumped together? Why or why not? Consider the Markov Property. Additionally, are there other situations where breaking things down by episode is required?
]


#discussion(vspace: 1fr)[
  Consider the following MDP with states $A,B,C,D,E$, and terminal $T$.
  #figure()[
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      spacing: 3em,

      node((-1, 0), [$A$], name: <a>),
      node((0, -1), [$B$], name: <b>),
      node((0, 0), [$C$], name: <c>),
      node((0, 1), [$D$], name: <d>),
      node((1, 0), [$E$], name: <e>),

      edge(<a>, <c>, "<->"),
      edge(<b>, <c>, "<->"),
      edge(<d>, <c>, "<->"),
      edge(<e>, <c>, "<->"),
    )
  ]
  Now consider the following data:
  #columns(4)[
    Episode 1:
    - $B$, down, $C$, -1
    - $C$, down, $D$, -1
    - $D$, exit, $T$, +10
    #colbreak()
    Episode 2:
    - $B$, down, $C$, -1
    - $C$, down, $D$, -1
    - $D$, exit, $T$, +10
    #colbreak()
    Episode 3:
    - $E$, left, $C$, -1
    - $C$, down, $D$, -1
    - $D$, exit, $T$, +10
    #colbreak()

    Episode 4:
    - $E$, left, $C$, -1
    - $C$, down, $A$, -1
    - $A$, exit, $T$, -10
  ]

  Based on this sample data, calculate:
  + The estimated transition function
  + The estimated reward function
  + The optimal policy#sidenote()[Notice how the discount $gamma$ never appears in the sample data. It is purely a function of the optimization calculation and as such is accounted for _after_ reconstructing the MDP model.]

]


= Model-free RL
While the model-based approach gives the benefits of monotonically increasing knowledge of the environment, and thus clear progress towards optimality, sometimes it is not possible to store all of the data involved in the full transition function. In such a situation we can notice that if samples are really representative, we can skip the distribution all together. If the value of an action is the expected value of the results of that action, consider the three scenarios for calculating an expected value:#v(0.5em)
+ Known probability: $E[X] = sum_x P(x) dot x$ #v(1em)
+ Model probability: $hat(P)(x) = ("count"(x))/N wide E[X] approx sum_x hat(P)(x) dot x$ #v(1em)
+ Model-free: $E[X] approx 1/N sum_i x_i$
We can see how if samples appear with the correct frequency, their naive average will converge to the expected value without explicit calculation of the probability itself. This is the core idea of model-free learning.

== Direct Evaluation
The most simple model-free approach is direct evaluation. In direct evaluation we just set some fixed policy $pi$, and have the agent run through many episodes using that policy. Then for each visited state, every time you visit mark the sum of what the discounted rewards turned out to be. Finally average everything out and you have an estimate of the values under that policy: $hat(V)^pi$. This approach, however, has some serious problems. It does not take advantage of the connections between states and so each state must be learned separately and thus it takes a long time. What we want is a way to integrate something like the Bellman equation into this process.
#discussion(vspace: 0pt)[
  Return to the previous example problem for model based learning. Notice how all of the actions in the samples follow a single policy. Calculate the value of that policy based on the provided samples using Direct Evaluation.
]
#discussion()[
  In direct evaluation model-free learning, unlike model-based learning, why does breaking down samples into episodes matter?
]

== Temporal-Difference Learning
Temporal Difference Learning (TDL) provides the better way to estimate the values of states for a fixed policy. The central idea is to update the value $V(s)$ every single time we experience a transition $(s,a,s',r)$, taking into account the Bellman equation of the value combining the transition reward with the value of the outcome.

We first calculate the implied value of a state from the sample $(s,a,s',r)$:
$
  V^(pi)_("sample")(s) = r + gamma hat(V)^(pi)(s')
$

We then keep track of the values of the states we see with an exponential moving average (with parameter $alpha$ which is called the _learning rate_) updating the values with each sample:

$
  & hat(V)^(pi)(s) <- (1-alpha) hat(V)^(pi)(s) + alpha V^(pi)_("sample")(s)
$
Or viewed as an iterative update procedure:
$
  & hat(V)^(pi)_(k+1)(s) = (1-alpha) hat(V)^(pi)_(k)(s) + alpha [r + gamma hat(V)^(pi)_(k)(s')]
$
#discussion(vspace: 5em)[
  Consider the parameter $alpha$. What is it doing in this equation? What would the method reduce to if we set it to the minimum value of $0$? What about the maximum value of $1$? When would we prefer higher or lower values?
]


== Q-Learning
While TDL is an efficient, model-free, method to evaluate a specific policy, if we want to turn these values into an _optimal policy_ we have a major issue. If the TDL values are policy dependent, we would need to recalculate the whole TDL proceedure for each change of the policy to very very slowly improve (with no assurance of finding the optimal policy). Instead we want to find a way to integrate the policy optimization into the whole learning process.

Recall that instead of state values sometimes we prefer to model state-action values, or Q-values. Can we do TDL but for Q-values? The answer is yes, and the method is called Q-learning.

Q-learning is essentially the same as TDL, but instead of using the sample based aggregation to look over q nodes to successor states, we can use the same sample based aggregation to look over state nodes to successor q values. We update Q values using the same pseudo-Bellman and moving average approach as in TDL. So for each sample transition $(s,a,s',r)$ we perform an update:

$
  Q(s,a) <- (1-alpha)dot Q(s,a) + alpha dot [r + gamma dot max_a' Q(s',a') ]
$

Notice how we no longer have to rely on a fixed policy. Our policy consists just of maximizing Q values: $pi(s) = max_a Q(s,a)$.

Amazingly, Q-learning will eventually converge to the optimal policy if ran for long enough (even if earlier policies are suboptimal). This process of learning being relevant between different policies is called _off-policy learning_.

The caveats are that you have to explore the whole space enough, and eventually lower the learning rate enough#sidenote()[But not too quickly or else you wont explore or learn in the early stages!]. But in the limit, it does not matter how you select actions and eventually you will be able to converge to an optimal policy.

#discussion(vspace: 1fr)[
  Imagine an unknown environments with three states $A, B, C$, terminal state $T$, and two actions $<-$ and $->$. An agent acting in this environment has recorded the following episode repeated infinitely:

  #table(
    columns: 5,
    align: left,
    table.header([$s$], [$a$], [$s'$], [$r$], [Iteration Number]),
    [$A$], [$->$], [$B$], [$0$], [$1,10,19,...$],
    [$B$], [$->$], [$C$], [$0$], [$2,11,20,...$],
    [$C$], [$<-$], [$B$], [$0$], [$3,12,21,...$],
    [$B$], [$<-$], [$A$], [$0$], [$4,13,22,...$],
    [$A$], [$->$], [$B$], [$0$], [$5,14,23,...$],
    [$B$], [$<-$], [$A$], [$0$], [$6,15,24,...$],
    [$A$], [$->$], [$B$], [$0$], [$7,16,25,...$],
    [$B$], [$->$], [$C$], [$0$], [$8,17,26,...$],
    [$C$], [$<-$], [$T$], [$1$], [$9,18,27,...$],
  )

  - Based on just these samples, what do you think the MDP would look like? Draw the network, then using a model-based approach calculate the transition functions of the MDP.
  - Now consider an agent doing Q-learning seeing the sequence of samples above. After which iteration (if any) do the following quantities first become nonzero?
    - $Q(A,->) :$
    - $Q(B,->) :$
    - $Q(B,<-) :$
    - $Q(C,->) :$
    - $Q(C,<-) :$




]

= Choosing Actions

== Exploration vs Exploitation

== $epsilon$-Greedy Actions

= Approximate RL
