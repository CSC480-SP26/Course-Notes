
#import "wdf.typ": *

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
#v(1fr)



#question(
  points: 0.25,
)[  Is the agent best understood as _rational_? If so, in what sense? If not, why not?
]
#v(1fr)



#pagebreak()
= Uninformed Search
#question(
  points: 0.25,
)[In general, under what conditions, if any, is breadth first search an optimal search algorithm?]
#v(1fr)


#question(
  points: 0.25,
)[In a map-coloring problem, the aim is to color in a map of countries using a given set of colors so that no two adjacent countries are the same color. Give a precise formulation of map-coloring as a search problem.]
#v(2fr)

#question(
  points: 0.25,
)[Formulate a precise state space representation for your map coloring search problem. Give a tight upper bound on the size of the state space in terms of the number of countries $K$ and the number of colors $C$.]
#v(1fr)


#question(
  points: 0.25,
)[Give a tight upper bound on the branching factor of the search problem.]
#v(1fr)





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
