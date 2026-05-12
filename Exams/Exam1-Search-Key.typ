
#import "../wdf.typ": *

#show: template.with(
  title: [
    Exam 1: Search
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

== Note on Points and Grading
Remember that the grade for your exam will be scored on the coarse 0-4 scale, and so you do not need to score 90+\% to earn an A. My goal is for these questions to be challenging in order to really asses your ability to solve hard problems based on the material. Try to write down your thought process for possible partial credit to help me genuinely assess your mastery of the material, and try to do your best without worrying too much about getting stuck on any given problem. Especially as this is the first exam, there will be plenty of wiggle room.


= Intelligent Agents
In this part, consider the following agentic system: _Imagine a country with an (at least seemingly) functional democracy. We can model as an agent an incumbent politician trying to get re-elected by a voting constituency. The agent does this by creating public policy in response to voter demand_.

#question(
  points: 0.25,
)[  What are the agent's _perceptions_ and _actions_? Does the agent have a measure of _utility/performance_? If so, what is it?
]

#answer[


  _Perceptions_ : Voter Demands, Voter signals,  Polling results 

  _Actions_ : Policy changes, Legislation

  _Utility/Performance_ : re-election results, Polling results 
]

#v(.6fr)

#question(
  points: 0.25,
)[  Is the agent best understood as _rational_? If so, in what sense? If not, why not?
]

#answer[
This is a fairly open ended question, so below are some example answers. Either answer could work, but it depends entirely on how you articulate and defend your response.

The answer we were looking for is yes, the agent would be rational. Theoretically, the agent would do everything in their power to be re-elected, including changing policy in response to voter demand. They would take actions that maximize their preferred outcome, re-election, especially considering that in this example we are assuming an “at least seemingly functional democracy.”

However, given that we currently do not live in an “at least seemingly functional democracy,” it is understandable if one answers no. One could argue that the agent can not observe their entire constituency, nor can they properly evaluate the consequences of their actions on polling numbers. Given the number of factors that affect voter turnout and voter opinions, perhaps the agent is, in fact, acting irrationally #sidenote[https://en.wikipedia.org/wiki/Demagogue]. Moreover, one could argue that, at times, the policy that is best in the long run may run counter to the constituency's immediate demands #sidenote[Sometimes the policy that maximizes long run welfare is politically unpopular in the short run. For example, the Federal Reserve's dual mandate requires it to pursue both maximum employment and stable prices. Raising interest rates to fight inflation may be unpopular because it can slow hiring, increase borrowing costs, and reduce short term economic growth, but it may still be the rational course if the long run goal is price stability and sustainable employment.
https://www.federalreserve.gov/faqs/what-economic-goals-does-federal-reserve-seek-to-achieve-through-monetary-policy.htm
].   

]
#v(1fr)



#pagebreak()
= Uninformed Search
#question(
  points: 0.25,
)[In general, under what conditions, if any, is breadth first search an optimal search algorithm?]

#answer[ BFS is optimal when all costs are uniform/equal.]

#v(.5fr)


#question(
  points: 0.25,
)[In a map-coloring problem, the aim is to color in a map of countries using a given set of colors so that no two adjacent countries are the same color. Give a precise formulation of map-coloring as a search problem.]

#answer[This question asks for a precise formulation, which you'll recall is given by six components. #sidenote[AIMA Chapter 3.1 Page 83] Before defining those components I would first define what we are given:#sidenote[We can just make an adjacency matrix, our definition is what we choose]
$
  K = {"Countries"}, "The set of all countries"\ 
  C = {"Colors"}, "The set of all colors"\
  "Adj"  subset.eq "K"times"K", "an adjacency matrix of the countries" 
$
  

  (1) A state is a partial assignment $s: K' -> C$ for some $K' subset.eq K$. The state space is all such partial assignments: $cal(S) = {s mid(|) s: K' -> C, K' subset.eq K}$. This includes incomplete colorings, not just valid complete ones, otherwise there would be nothing to search through.

  (2) $S_0 = emptyset$, Initial state: the empty assignment, where no country has been colored yet.

  (3) Goal, given a state $s$, the goal is achieved iff $s: K -> C$ and $forall (k_i, k_j) in "Adj": s(k_i) != s(k_j)$ (no two adjacent countries share a color).

  (4) Actions: in state $s$, the available actions are pairs $(k, c)$ where $k in K$ is uncolored in $s$ and $c in C$ such that $forall k' in K "colored in" s: (k', k) in "Adj" => s(k') != c$ (the chosen color is consistent with all already colored neighbors).

  (5) $T(s, (k, c)) = s union {k |-> c}$, Transition model: applying action $(k, c)$ in state $s$ extends the partial assignment by mapping country $k$ to color $c$.

  (6) $"Cost"(s, (k, c), s') = 1$, Cost function: each coloring action costs 1 (uniform). Map coloring is a satisfaction problem in that any valid complete coloring is acceptable, so path cost simply counts steps taken.

  This is a very formal set theory formulation, other forumlations may also be correct based on how you defined each component.
]



#question(
  points: 0.25,
)[Formulate a precise state space representation for your map coloring search problem. Give a tight upper bound on the size of the state space in terms of the number of countries $K$ and the number of colors $C$.]

#answer[There are $K$ countries, each with $C+1$ possible states (uncolored, or one of $C$ colors), giving $(C+1)^K$. Also, $C^K$ is acceptable if $C$ includes uncolored. Either is correct as long as it is consistent with your state definition.]

#question(
  points: 0.25,
)[Give a tight upper bound on the branching factor of the search problem.]


#answer[$C dot K$: an action is a pair $(k, c)$, where we choose an uncolored country and a color. The maximum number of such pairs occurs at the first step, where all $K$ countries are uncolored and all $C$ colors are available, giving $C dot K$ possible actions.]




#pagebreak()
= Informed Search
In this section, consider the state space shown below. Node $A$ is the start state and $G$ is the goal state. Transitions available at each state (note directionality) are shown with associated costs. Two different heuristics, $h_1$ and $h_2$ are described with their values at each state, as well as a candidate heuristic $h_3$ with not all values determined.
#figure()[
  #grid(
    columns: 2,
    gutter: 5em,
    diagram(
      node-stroke: 0.5pt,
      node-outset: 3pt,
      node((0, 0), [A], name: <a>),
      node((1, -1), [B], name: <b>),
      node((1, 1), [C], name: <c>),
      node((2, 0), [D], name: <d>),
      node((3, -1), [E], name: <e>),
      node((3, 1), [F], name: <f>),
      node((4, 0), [G], name: <g>),

      edge(<a>, <b>, "->", label: [1]),
      edge(<a>, <c>, "->", label: [4]),
      edge(<b>, <c>, "<->", label: [1], label-pos: 0.4),
      edge(<b>, <d>, "->", label: [5]),
      edge(<c>, <d>, "->", label: [3]),
      edge(<d>, <e>, "->", label: [8]),
      edge(<d>, <f>, "->", label: [3]),
      edge(<d>, <g>, "->", label: [9]),
      edge(<e>, <g>, "->", label: [2]),
      edge(<f>, <g>, "->", label: [5]),
    ),
    table(
      columns: 4,
      align: left,
      stroke: none,
      column-gutter: 1em,
      table.header([Node], [$h_1$], [$h_2$], [$h_3$]),
      table.hline(),
      [A], [9.5], [10], [10],
      [B], [9], [12], [?],
      [C], [8], [9], [9],
      [D], [7], [8], [7],
      [E], [1.5], [1], [1.5],
      [F], [4], [4.5], [4.5],
      [G], [0], [0], [0],
    ),
  )
]


#question(
  points: 0.25,
)[Is $h_1$ admissible and/or consistent? What about $h_2$?]
#v(1fr)

#question(
  points: 0.25,
)[What is the order of search expansions of A\* _tree search_ using heuristic $h_2$.]
#v(1fr)

#question(
  points: 0.25,
)[What range of possible values for $h_3(B)$ (i.e. the interval $[0,infinity)$ for all non-negative numbers, or $nothing$ for the empty set) would make $h_3$ _admissible_?]
#v(1fr)

#question(
  points: 0.25,
)[What range of possible values for $h_3(B)$ would make $h_3$ _consistent_?]
#v(1fr)

#question(
  points: 0.25,
)[What range of possible values for $h_3(B)$ would make the node expansion order of A\* _graph search_ using heuristic $h_3$ start in order: $A, C, B, D$.]
#v(1fr)





#pagebreak()
= Game Search
#question(
  points: 0.25,
)[Draw the smallest possible game tree on which $alpha beta$ will prune at least one leaf node. Make sure to clearly state your search order, label the leaves with values, and mark the edges for the branch or branches that will be pruned.]
#v(1.5fr)

#question(points: 0.25)[
  Imagine an agent is playing a game and choosing actions based on minimax. However, _unbeknownst to the agent_, their opponent has decided to play suboptimally. Would the actions chosen by the minimax agent in this scenario be better described as _optimistic_ or _pessimistic_? Are there scenarios where the secretly suboptimal adversary will score better than an optimal adversary?
]
#v(1fr)

#pagebreak()
For the following questions consider a game with a complex mixture of maximizing, minimizing, and chance nodes (where all chance outcomes are equally likely). In this game, all possible utilities are values in the range $[0,10]$,  and each non-terminal node has at most three successors. When traversing the game tree below, use a left to right tie-breaking order.
#figure()[
  #minimax-tree(spacing: (60pt, 5pt))[
    - #max-node
      - 2 #leaf-node
      - #min-node
        - 2 #leaf-node
        - #average-node
          - 9 #leaf-node
          - 1 #leaf-node
      - #average-node
        - 2 #leaf-node
        - #min-node
          - 4 #leaf-node
          - #max-node
            - 5 #leaf-node #highlight-node
            - 6 #leaf-node

  ]
]

#question(
  points: 0.25,
)[What is the game utility value at the root node of the above tree?]
#v(0.5fr)

#question(
  points: 0.25,
)[Is pruning possible in this game? If not, briefly explain why. If so, cross out the branches that can be pruned.]
#v(1fr)

#question(
  points: 0.25,
)[Whether or not pruning can occur, you can always still calculate values for $alpha$ and $beta$ representing the best expected fallback scores for the maximizer and minimizer respectively at a given search node. What are the values for $alpha$ and $beta$ _after_ processing the highlighted node?]
#v(1fr)
