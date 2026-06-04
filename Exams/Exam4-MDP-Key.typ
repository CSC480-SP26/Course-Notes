
#import "../wdf.typ": *


#show: template.with(
  title: [
    Exam 4: MDPs and RL
  ],
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

#question(points: .3)[
  When modeling a problem as an MDP, we must assume the _Markov Property_ where our transitions and rewards do not depend any previous states before the current state. Why is this assumption required in order for the Bellman Equation to hold?
]

#answer[
  The Bellman equation decomposes the value of a state as
  $V^*(s) = max_a sum_(s') T(s,a,s')[R(s,a,s') + gamma V^*(s')]$

  This decomposition treats $V^*(s')$ as a self-contained quantity, ie the total expected future reward from $s'$ forward. That only makes sense if $s'$ is a _sufficient statistic_ for all future behavior (so knowing $s'$ is all you need to determine what happens next). If the Markov Property did not hold, the transition probabilities and rewards would depend on the full history $(s_0, a_0, s_1, a_1, dots, s_t)$, not just the current state. In that case, $V^*(s')$ could not be defined as a function of $s'$ alone, as two trajectories arriving at the same state $s'$ via different histories could yield different future values, so there would be no single well-defined $V^*(s')$ to substitute into the right-hand side. The recursive structure of the Bellman equation collapses without this guarantee.
]

#question(points: .3)[
  For an arbitrary environment that may have so called "path dependence" or "memory", where the path taken to reach a state may affect the environment at that state, is it _always_ possible to formulate an equivalent MDP? If so, how? If not, why?
]

#answer[
  Yes. The trick is to _bake the history into the state_. If an environment has memory (ie the outcome depends on how you got there, not just where you are), we can define a new, bigger state that includes the relevant past. For example, if the environment only remembers the last two steps, define the state as a pair $(s_(t-1), s_t)$ instead of just $s_t$. Now the new state contains all the information the environment cares about, so the Markov Property holds and we have a valid MDP.

  In the extreme case, the new state is the entire history of states and actions. This always works in principle, but the state space can grow very large (or infinite), making it expensive or impossible to solve in practice. The importat thing is that by encoding history into the state definition, each state becomes independently evaluable thus satisfying the Markov Property by construction.
]

#question(points: 0.3)[
  Is it ever possible to calculate the optimal value function $V^*$ for an _infinite horizon_ MDP with discount factor $gamma=1$. If so, sketch an example. If not, explain why.
]

#answer[
  Yes, if the MDP has an absorbing terminal state that every policy reaches with probability 1. Once the agent enters a terminal state it collects no further reward, so the infinite sum is still finite even with $gamma = 1$.


  #figure(
    diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 10pt,
      node((0, 0), [Start], name: <s>),
      node((3, 0), [Done], name: <d>),
      edge(<s>, <d>, "->", [$+1$]),
      edge(<d>, <d>, "->", [$0$], bend: -130deg),
    )
  )

  The problem with $gamma = 1$ in general is that a policy which never terminates (staying in a rewarding state forever or exploring infinite rewarding states) produces an infinite sum with no meaningful value. Since $gamma$ is one, a non-zero infinite series of rewards will never converge, meaning an unrewarding terminal structure is the only way to get a finte value.
]


#pagebreak()

#v(1em)
#question(
  points: 0.6,
)[Consider an MDP inhabited not only by your agent the robot wizard, but also an evil goblin whose only goal is to minimize the wizard's reward. In this MDP the wizard plays a turn, and then the goblin plays a turn, and the two agents continue to alternate using the same transition function $T$. Let $A$ be the set of actions available to the wizard, and $B$ be the set of actions available to the goblin. The game has an infinite horizon, and uses a single discount factor $gamma$ for both agents. Let $R$ be the utility received by the wizard. ]

#subquestion(points: 0.3)[
  If we assume both the wizard and the goblin are rational and act optimally according to their adversarial goals, which, if any, of the following expressions correctly applies the Bellman equation to update $Q$ values of wizard actions ($Q^*_(w)(s,a)$ being the value of the wizard taking action $a$ in state $s$).

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(a' in A) Q^*_(w)(s',a')]$
  
  #answer[Wrong. The $min$ is taken over $A$, the wizard's own actions, but a rational wizard never minimizes its own reward. This also skips the goblin's turn entirely, treating $s'$ as if the wizard acts next.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')]$
  
  #answer[Wrong. The goblin's turn is ignored completely. This is just standard single agent Bellman.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')$
  
  #answer[Wrong. The transition probability $T(s,a,s')$ is missing as a weight inside the sum, so this is not a valid expected value, each $s'$ is counted equally regardless of how likely it is.]

  #answer[$qed$] $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$
  
  #answer[Correct. After the wizard lands in $s'$, the adversarial goblin picks $b in B$ to minimize the wizard's future reward ($min_(b in B)$), transitioning to $s''$(consider the goblin reward is being added to the wizard reward so the goblin is attempting to minimize the value its adding/giving to the wizard). The wizard then acts optimally from $s''$ ($max_(a' in A)$). Both turns, both transition functions, and both rewards are properly accounted for.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma min_(a' in A) Q^*_(w)(s'',a')])]$
  
  #answer[Wrong. The goblin maximizes ($max_(b in B)$) when it should minimize as the enemy, and the wizard minimizes its own reward ($min_(a' in A)$) when it should maximize. Both operators are flipped.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$
  
  #answer[Wrong. The goblin uses $max_(b in B)$, which would be correct for a _cooperative_ goblin, not an adversarial one. The adversarial goblin should minimize.]

  #v(1em)
  #checkbox() $Q^*_(w)(s,a) =$#blank(width: 39em)

]
#v(1fr)
#pagebreak()

#subquestion(points: 0.3)[
  Now, assume that the goblin's heart has grown three sizes and now has decided to become friendly with the goal of maximizing your utility. If we assume both the wizard and the goblin are rational and act optimally according to their new goals, which, if any, of the following expressions correctly applies the Bellman equation to update $Q$ values of wizard actions ($Q^*_(w)(s,a)$ being the value of the wizard taking action $a$ in state $s$).

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(a' in A) Q^*_(w)(s',a')]$
  
  #answer[Wrong. Minimizes over the wizard's own actions and skips the goblin's turn entirely.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')]$
  
  #answer[Wrong. The goblin's turn is skipped entirely. This models a single-agent MDP with no second player.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')$
  
  #answer[Wrong. Missing $T(s,a,s')$ as a weight, so the sum is not a proper expectation over next states.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$
  
  #answer[Wrong. The goblin uses $min_(b in B)$, meaning it is still acting adversarially. A friendly goblin that wants to maximize the wizard's reward should use $max_(b in B)$.]

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma min_(a' in A) Q^*_(w)(s'',a')])]$
  
  #answer[Wrong. The goblin correctly uses $max_(b in B)$, but the wizard then minimizes its own reward ($min_(a' in A)$), which is never rational.]

  #answer[$qed$] $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$
  
  #answer[Correct. The friendly goblin picks $b in B$ to maximize the wizard's reward ($max_(b in B)$), and the wizard then also acts to maximize from $s''$ ($max_(a' in A)$). Both agents are cooperating, so both use max.]

  #v(1em)
  #checkbox() $Q^*_(w)(s,a) =$#blank(width: 39em)

]
#v(1fr)

#pagebreak()
#question(points: 1.3)[
  Consider an infinite horizon MDP with deterministic transitions on actions ${<-, ->}$, over the network shown below with zero reward at all transitions unless otherwise labeled.


  #figure()[
    #diagram(
      edge-stroke: 0.75pt,
      node-corner-radius: 10pt,
      node-stroke: 1pt,
      edge-corner-radius: 20pt,

      node((0, 0), [$A$], name: <A>),
      node((1, 0), [$B$], name: <B>),
      node((2, 0), [$C$], name: <C>),
      node((3, 0), [$D$], name: <D>),
      node((4, 0), [$E$], name: <E>),
      node((5, 0), [$F$], name: <F>),
      node((6, 0), [$G$], name: <G>),

      node((3, 1), [$Z$], name: <z>),

      edge(<A>, "l,d", <z>, "->", label: [$+100$]),
      edge(<A>, <B>, "<->"),
      edge(<C>, <B>, "<->"),
      edge(<C>, <D>, "<->"),
      edge(<E>, <D>, "<->"),
      edge(<E>, <F>, "<->"),
      edge(<G>, <F>, "<->"),
      edge(<G>, <F>, "->"),
      edge(<G>, "r,d", <z>, "->", label: [$+10$]),
      edge(<z>, "d,l,u", <C>, "->", label: [$-1$]),
      edge(<z>, "d,r,u", <z>, "->", bend: 130deg),
    )
  ]
]
#v(1fr)


#subquestion(points: 0.3)[
  What is the _smallest_ discount factor $gamma_m$, such that the optimal policy may be $pi^(*)(Z) = <-$

  $gamma_m =$
  #answer[
   $(1\/100)^(1\/3) = 1\/root(3, 100)$

    At the threshold, $pi^(*)(Z) = ->$ (stay) gives $V^*(Z) = 0$. 

    For $<-$ to be equally good: $Q(Z, <-) = -1 + gamma dot V^*(C) = 0$, so $V^*(C) = 1\/gamma$. 

    Under the ← policy from $C$, we get $V^*(C) = 100 gamma^2$ (two steps to $A$, then $+100$, with $V^*(Z)=0$). 

    Setting equal: $100 gamma^3 = 1 arrow.r gamma_m = (1\/100)^(1\/3)$.
  ]
]
#v(.25cm)

#subquestion(points: 0.2)[
  In terms of the discount factor $gamma_m$ from the previous question, consider running value iteration. What is the smallest iteration number $k$ (starting from initial values at $k=0$ and results after a single iteration at $k=1$), where $V_(k)(C) > 0$. For this iteration, what is the value of $V_(k)(C)$.

  $k=$#answer[$3$]#h(10em)$V_(k)(C)=#answer[$V_3(C) = root(3, 100)$]$
  #answer[

    The $+100$ reward is two hops from $C$ (via $B$ then $A$). 
    
    Value propagates outward one step per iteration: $k=1$ reaches $A$ ($V_1(A)=100$), $k=2$ reaches $B$ ($V_2(B)=100 gamma_m$), $k=3$ reaches $C$:
    
     $V_3(C) = gamma_m dot V_2(B) = 100 gamma_m^2 = 100 dot (1\/100)^(2\/3) = 100^(1\/3) = root(3,100)$.
  ]
]
#v(.25cm)

#subquestion(
  points: 0.2,
)[Similarly, what is the smallest iteration number $k$, where $V_(k)(F) > 0$. For this iteration, what is the value of $V_(k)(F)$.

  $k=$#answer[2]#h(10em)$V_(k)(F)=$#answer[$root(3, 10)$]
  #answer[

    $F$ is one hop from $G$. At $k=1$, $V_1(G) = 10$. At $k=2$: $V_2(F) = gamma_m dot V_1(G) = 10 gamma_m = 10 dot (1\/100)^(1\/3) = 10^(1\/3) = root(3,10)$.
  ]
]
#v(.25cm)

#pagebreak()

#subquestion(
  points: 0.3,
)[Again using the discount factor $gamma_m$, what is the optimal policy $pi^*$?


  #table(
    columns: 8,
    [$pi^(*)(A)$],
    [$pi^(*)(B)$],
    [$pi^(*)(C)$],
    [$pi^(*)(D)$],
    [$pi^(*)(E)$],
    [$pi^(*)(F)$],
    [$pi^(*)(G)$],
    [$pi^(*)(Z)$],

    [$<-$],
    [$<-$],
    [$<-$],
    [$<-$],
    [$->$],
    [$->$],
    [$->$],
    [$<-$],
  )
  #answer[
    The indifference boundary falls at chain position $p = 3.75$ (between $D$ and $E$). Label the chain $A=0, B=1, dots, G=6$. From position $p$, going left collects $+100$ at step $p$ (value $100 gamma^p$); going right collects $+10$ at step $6-p$ (value $10 gamma^(6-p)$). Setting equal: $100 gamma^p = 10 gamma^(6-p) arrow.r gamma^(6-2p) = 10$. At $gamma_m$ this gives $p = 3.75$, so $A, B, C, D$ ($p <= 3$) go $<-$ and $E, F, G$ ($p >= 4$) go $->$. $Z$ is at indifference and takes $<-$.
  ]
  ]

#subquestion(
  points: 0.3,
)[If we decide to increase $gamma$, as $gamma$ approaches 1, what does the optimal policy converge to?

  #table(
    columns: 8,
    [$pi^(*)(A)$],
    [$pi^(*)(B)$],
    [$pi^(*)(C)$],
    [$pi^(*)(D)$],
    [$pi^(*)(E)$],
    [$pi^(*)(F)$],
    [$pi^(*)(G)$],
    [$pi^(*)(Z)$],

    [$<-$],
    [$<-$],
    [$<-$],
    [$<-$],
    [$<-$],
    [$->$],
    [$->$],
    [$<-$],
  )
  #answer[
    $F$ and $G$ go right as the $Z$ shortcut(through z that is) nets $+9$ ($+10$ then $-1$) and still routes to $C$ and $A$, so they collect both the bonus _and_ the $+100$. All other states go left since heading toward $A$ directly is faster or the detour to $Z$ is too long to justify.
  ]
]
#v(1fr)



#pagebreak()
#question(points: 1)[
  After fighting goblins all quarter the robot wizard decides to have a fun summer break and go to a water park. At the park are multiple ladders set up in sequence to progressively higher slides. The slides are fun and give a reward of $+32$, but the ladders are tough to climb and have a reward of $-2$, and are also slippery with a chance of falling (which we can model as a single state where we need to call the robot paramedics) with a reward of $-128$. The problem is that the wizard does not know the probability of falling, and so is unsure if it should risk the ladder. Luckily, it can use reinforcement learning to find out. For this problem we may assume a discount of $gamma=1$, and we will use the following two episodes (sequences of samples of the form $(s,a,s',r)$):

  #columns(2)[
    Episode 1:\
    $("Ground", "Climb", "Platform" 1, -2)$\
    $("Platform" 1, "Climb", "Platform" 2, -2)$
    $("Platform" 2, "Slide", "Pool", +32)$
    #colbreak()
    Episode 2:\
    $("Ground", "Climb", "Platform" 1, -2)$\
    $("Platform" 1, "Climb", "Fall", -128)$
  ]

]
#v(1fr)



#subquestion(points: 0.3)[
  What are the values of the states: Ground, Platform 1, and Platform 2, after performing Temporal-Difference Learning with a learning rate of $alpha = 0.5$ using _only episode 1_.
]

#answer[    TD update: $V(s) <- V(s) + alpha[r + gamma V(s') - V(s)]$. All values start at 0, $gamma=1$, $alpha=0.5$.
]

$V("Ground")=$ #answer[$(G, C, P_1, -2)$: $V(G) <- 0 + 0.5[-2 + 0 - 0] = bold(-1)$]

$V("Platform" 1)=$ #answer[$(P_1, C, P_2, -2)$: $V(P_1) <- 0 + 0.5[-2 + 0 - 0] = bold(-1)$]

$V("Platform" 2)=$#answer[$(P_2, S, "Pool", +32)$: $V(P_2) <- 0 + 0.5[32 + 0 - 0] = bold(16)$]
  

#v(1fr)


#subquestion(points: 0.3)[
  What are the values of the states: Ground, Platform 1, and Platform 2, after performing Temporal-Difference Learning with a learning rate of $alpha = 0.5$ using _episode 1 followed by episode 2_.
]
  #answer[    Starting from Episode 1 values ($V(G)=-1$, $V(P_1)=-1$, $V(P_2)=16$, $V("Fall")=0$):]

$V("Ground")=$#answer[$(G, C, P_1, -2)$: $V(G) <- -1 + 0.5[-2 + (-1) - (-1)] = -1 + 0.5(-2) = bold(-2)$]

$V("Platform" 1)=$#answer[$(P_1, C, "Fall", -128)$: $V(P_1) <- -1 + 0.5[-128 + 0 - (-1)] = -1 + 0.5(-127) = bold(-64.5)$]

$V("Platform" 2)=$#answer[    $V("Platform" 2) = 16$ unchanged (not visited in Episode 2)]
  


#v(.15cm)

#subquestion(points: 0.3)[
  What are the values of the following state/action pairs after performing Q-Learning with a learning rate of $alpha = 0.5$ using _episode 1 followed by episode 2_.

#answer[Q-Learning update: $Q(s,a) <- Q(s,a) + alpha[r + max_(a') Q(s',a') - Q(s,a)]$. All Q values start at 0.


   _ Episode 1:_
    - $(G, C, P_1, -2)$: $Q(G,C) <- 0 + 0.5[-2 + 0] = -1$
    - $(P_1, C, P_2, -2)$: $Q(P_1,C) <- 0 + 0.5[-2 + 0] = -1$
    - $(P_2, S, "Pool", +32)$: $Q(P_2,S) <- 0 + 0.5[32 + 0] = 16$

    _Episode 2_ (note: $max Q(P_1, dot) = max(Q(P_1,"Climb"), Q(P_1,"Slide")) = max(-1, 0) = 0$):
    - $(G, C, P_1, -2)$: $Q(G,C) <- -1 + 0.5[-2 + 0 -(-1)] = -1 + 0.5(-1) = bold(-1.5)$
    - $(P_1, C, "Fall", -128)$: $Q(P_1,C) <- -1 + 0.5[-128 + 0 -(-1)] = -1 + 0.5(-127) = bold(-64.5)$

]

  #columns(2)[
    $Q("Ground","Climb")=$#answer[ $-1.5$]

    $Q("Platform" 1,"Climb")=$#answer[ $-64.5$]
    #colbreak()
    $Q("Platform" 1,"Slide")=$#answer[0]
    
    $Q("Platform" 2,"Slide")=$#answer[$16$]
  ]
]
#v(1fr)

#pagebreak()
#subquestion(points: 0.1)[
  Were the methods used in this problem best described as _model based_ or _model free_.


  #checkbox() _model based_ #h(10em)#answer[$qed$] _model free_

  #answer[TD learning and Q-learning both update directly from sampled $(s, a, s', r)$ experience without building an explicit transition model $T(s,a,s')$.#sidenote[Fun Fact! In 2016, an OpenAI agent trained model free on the boat racing game CoastRunners discovered it could outscore every human by driving in circles, catching fire, and respawning to get points(despite never finishing a lap). RL learning is very tricky :) . https://openai.com/index/faulty-reward-functions/]]
  
]
#v(1fr)
#question(points: 0.2)[
  Finally, for guaranteed points, please try your best to draw your version of the robot wizard (maybe even on the water-slide!)
]

#figure(
  image("/figures/wiz_water_slide.png", width: 80%),
  caption: [Have a great summer everyone!],
) <glacier_fig>
#v(5fr)
