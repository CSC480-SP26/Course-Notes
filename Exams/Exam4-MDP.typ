
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
#v(1fr)


#question(points: .3)[
  For an arbitrary environment that may have so called "path dependence" or "memory", where the path taken to reach a state may affect the environment at that state, is it _always_ possible to formulate an equivalent MDP? If so, how? If not, why?
]
#v(2fr)

#question(points: 0.3)[
  Is it ever possible to calculate the optimal value function $V^*$ for an _infinite horizon_ MDP with discount factor $gamma=1$. If so, sketch an example. If not, explain why.
]
#v(2fr)

#pagebreak()

#v(1em)
#question(
  points: 0.6,
)[Consider an MDP inhabited not only by your agent the robot wizard, but also an evil goblin whose only goal is to minimize the wizard's reward. In this MDP the wizard plays a turn, and then the goblin plays a turn, and the two agents continue to alternate using the same transition function $T$. Let $A$ be the set of actions available to the wizard, and $B$ be the set of actions available to the goblin. The game has an infinite horizon, and uses a single discount factor $gamma$ for both agents. Let $R$ be the utility received by the wizard. ]

#subquestion(points: 0.3)[
  If we assume both the wizard and the goblin are rational and act optimally according to their adversarial goals, which, if any, of the following expressions correctly applies the Bellman equation to update $Q$ values of wizard actions ($Q^*_(w)(s,a)$ being the value of the wizard taking action $a$ in state $s$).

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(a' in A) Q^*_(w)(s',a')]$


  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')]$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma min_(a' in A) Q^*_(w)(s'',a')])]$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$

  #v(1em)
  #checkbox() $Q^*_(w)(s,a) =$#blank(width: 39em)

]
#v(1fr)

#subquestion(points: 0.3)[
  Now, assume that the goblin's heart has grown three sizes and now has decided to become friendly with the goal of maximizing your utility. If we assume both the wizard and the goblin are rational and act optimally according to their new goals, which, if any, of the following expressions correctly applies the Bellman equation to update $Q$ values of wizard actions ($Q^*_(w)(s,a)$ being the value of the wizard taking action $a$ in state $s$).

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(a' in A) Q^*_(w)(s',a')]$


  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')]$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')R(s,a,s') + gamma max_(a' in A) Q^*_(w)(s',a')$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma min_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma min_(a' in A) Q^*_(w)(s'',a')])]$

  #checkbox() $Q^*_(w)(s,a) = sum_(s')T(s,a,s')[R(s,a,s') + gamma max_(b in B) sum_s'' (T(s',b,s'')[R(s',b,s'')+ gamma max_(a' in A) Q^*_(w)(s'',a')])]$

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

  $gamma_m =$#blank()
]
#v(1fr)

#subquestion(points: 0.2)[
  In terms of the discount factor $gamma_m$ from the previous question, consider running value iteration. What is the smallest iteration number $k$ (starting from initial values at $k=0$ and results after a single iteration at $k=1$), where $V_(k)(C) > 0$. For this iteration, what is the value of $V_(k)(C)$.

  $k=$#blank()#h(10em)$V_(k)(C)=$#blank()
]
#v(1fr)

#subquestion(
  points: 0.2,
)[Similarly, what is the smallest iteration number $k$, where $V_(k)(F) > 0$. For this iteration, what is the value of $V_(k)(F)$.

  $k=$#blank()#h(10em)$V_(k)(F)=$#blank()

]
#v(1fr)


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

    [#v(2em)#h(5em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(5em)],
  )]
#v(1fr)

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

    [#v(2em)#h(5em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(4em)],
    [#h(5em)],
  )
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

  #columns(3)[
    $V("Ground")=$#blank(width: 5em)
    #colbreak()
    $V("Platform" 1)=$#blank(width: 5em)
    #colbreak()
    $V("Platform" 2)=$#blank(width: 5em)
  ]
]
#v(1fr)


#subquestion(points: 0.3)[
  What are the values of the states: Ground, Platform 1, and Platform 2, after performing Temporal-Difference Learning with a learning rate of $alpha = 0.5$ using _episode 1 followed by episode 2_.

  #columns(3)[
    $V("Ground")=$#blank(width: 5em)
    #colbreak()
    $V("Platform" 1)=$#blank(width: 5em)
    #colbreak()
    $V("Platform" 2)=$#blank(width: 5em)
  ]
]
#v(1fr)


#subquestion(points: 0.3)[
  What are the values of the following state/action pairs after performing Q-Learning with a learning rate of $alpha = 0.5$ using _episode 1 followed by episode 2_.

  #columns(2)[
    $Q("Ground","Climb")=$#blank(width: 5em)

    $Q("Platform" 1,"Climb")=$#blank(width: 5em)
    #colbreak()
    $Q("Platform" 1,"Slide")=$#blank(width: 5em)

    $Q("Platform" 2,"Slide")=$#blank(width: 5em)
  ]
]
#v(1fr)

#subquestion(points: 0.1)[
  Were the methods used in this problem best described as _model based_ or _model free_.


  #checkbox() _model based_ #h(10em)#checkbox() _model free_
]
#v(1fr)
#question(points: 0.2)[
  Finally, for guaranteed points, please try your best to draw your version of the robot wizard (maybe even on the water-slide!)
]
#v(5fr)
