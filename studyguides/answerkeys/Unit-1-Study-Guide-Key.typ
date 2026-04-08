#import "../../wdf.typ": *


#show: template.with(
  title: [
    Search Algorithms
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [],
  bib: none,
  serif: true,
  exam: false,
)

#let answer(body) = text(fill: red, body)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]
= Part 1: Intelligent Agents
Q1: State the definition of a rational agent.

#answer["  A rational agent is an agent for which, for each possible percept sequence, it should select an action that is expected to maximize its performance measure, given the evidence provided by the percept sequence and whatever built-in knowledge the agent has."]
#v(1cm)

Q2: List the dimensions used to characterize environments, giving both sides of each dimension. #sidenote[AIMA Chapter 2.3 Page 61]
#answer[check the textbook :P]
#v(2cm)

Q3: Explain the difference between a reflex agent and a goal based agent. Why can't a reflex agent solve a maze?

#answer[A reflex agent selects actions based only on the current percept (or current percept + simple condition action rules). It has no internal model of the world and no concept of future consequences. A  goal based agent has explicit goals and uses search or planning to determine which sequence of actions will achieve them. 
]
#v(1cm)

Q4: What is the difference between a model based agent and a utility based agent?  #sidenote[AIMA Chapter 3.4 Page 69]
#answer[check the textbook]

#v(3cm)

#pagebreak()

Q5: Classify each of the following environments along dimensions used to characterize environments. 

(a) A chess game against a human opponent
#answer[
- Fully observable (you see the whole board)

- Multi-agent (you and opponent)

- Deterministic (moves have predictable outcomes)

- Sequential (current moves affect future positions)

- Static (board doesn't change while you think (assuming no clock pressure))

- Discrete (finite number of squares, pieces, and moves)

- Known (rules of chess are fully known)
]
#v(0.5cm)
(b) A self driving car on a highway
#answer[
  - Partially observable (sensors have blind spots, cant see intentions of other drivers)

- Multi-agent (other drivers)

- Stochastic (other drivers and conditions are unpredictable)

- Sequential (decisions now affect future trajectory)

- Dynamic (the world keeps moving while the car deliberates)

- Continuous (positions, speeds, and steering angles are continuous)

- Known, rules of the road are but with unknown agent behaviors]
#v(0.5cm)

(c) A thermostat in a room
#answer[
  - Partially observable (knows current temperature, not heat sources)

- Single-agent

- Mostly deterministic (or mildly stochastic depending on disturbances)

- Sequential (though often modeled episodically)

- Dynamic (temperature changes over time)

- Continuous (temperature values)

- Known (heat modeling is well understood (i think))
]

#v(3cm)


#pagebreak()

= Part 2: Search Fundamentals

Q6: List and explain the components that formally define a search problem. #sidenote[AIMA Chapter 3.1 Page 83]

#answer[
The six components are: 

  (1) States which are the set of all possible configurations the problem can be in (the state space). 

  (2) Initial state which is the starting configuration the agent begins in. 

  (3) Goal state or the the target configuration (or a goal test that determines whether a given state satisfies the goal). 

  (4) Actions. The set of possible moves available to the agent in each state.

  (5) Transition model which defines the result of applying an action in a state, mapping (state, action) ==> successor state. 

  (6) Cost function which assigns a numeric cost to each action or path, used to evaluate the expense of reaching the goal.
]
#v(1cm)
Q7: For each of the following search strategies, state whether it is complete and whether it is optimal. (Assume a finite branching factor and non-negative edge costs.)
#table(
  columns: 3,
  align: (left, center, center),
  stroke: 0.5pt,

  [*Strategy*], [*Complete?*], [*Optimal?*],

  [Depth-First Search (Graph)], answer[Yes (finite state space)], answer[no],
  [Breadth-First Search (Graph)], answer[Yes (finite branching)], answer[Only if step costs are equal],
  [Uniform Cost Search (Graph)], answer[Yes (if step costs > 0)], answer[Yes],
  [Astar Tree Search (admissible h)], answer[Yes], answer[Yes],
  [Astar Graph Search (consistent h)], answer[Yes], answer[Yes],
)

#pagebreak()
Q8: In your own words, explain why Breadth First Search is optimal only when all step costs are equal, whereas Uniform Cost Search is optimal for any non-negative step costs.

#answer[
BFS expands nodes in increments of height/level, exploring the finds the shallowest areas first. If all step costs are equal, the shallowest path is also the cheapest. But if step costs vary, a deeper path might have lower total cost. UCS expands nodes in order of cumulative path cost, so it always expands the cheapest cost node next, guaranteeing it finds the lowest cost path regardless of how costs are distributed.]

#v(1cm)

Q9: Explain the difference between tree search and graph search. Why might tree search expand the same state more than once, and what mechanism does graph search use to prevent this? #sidenote[AIMA Chapter 3.3 Page 92]

#answer[Tree search does not track which states have been visited, so it may expand a state multiple times if it appears via different paths in the search tree. Graph search maintains a closed set (or explored set) of all previously expanded states and skips any state that has already been expanded. This prevents redundant exploration but requires additional memory proportional to the number of explored states.
]

#pagebreak()

Q10: Consider the following graph. All edges are undirected. The start state is S and the goal state is G.

#figure(
  diagram(
    node-stroke: 0.5pt,
    node-shape: circle,
    node-inset: 6pt,

    node((0, 1), [*S*], name: <S>),
    node((1, 0), [*A*], name: <A>),
    node((2, 0), [*C*], name: <C>),
    node((1, 2), [*B*], name: <B>),
    node((1.5, 1), [*D*], name: <D>),
    node((3, 1), [*G*], name: <G>),

    edge(<S>, <A>, "-", [2]),
    edge(<A>, <C>, "-", [3]),
    edge(<C>, <G>, "-", [2]),
    edge(<S>, <B>, "-", [4]),
    edge(<B>, <G>, "-", [5]),
    edge(<D>, <G>, "-", [1]),
    edge(<D>, <B>, "-", [2]),
    edge(<D>, <C>, "-", [2]),
  ),
  caption: [Undirected weighted graph for Q10.],
)

(a) Give the order in which nodes are expanded using Breadth First Search. Break ties alphabetically.

#answer[*S, A, B, C, D, G*]
#v(1cm)

(b) Give the order in which nodes are expanded using Depth First Search. Break ties alphabetically.

#answer[*S, A, C, D, G*]
#v(1cm)

(C) Give the order in which nodes are expanded using Uniform Cost Search. Break ties alphabetically.

#answer[*S, A, B, C, D, G*]
#v(1cm)

Q11: For each search algorithm (DFS, BFS, UCS), state its time complexity and space complexity in terms of branching factor b, solution depth d, and maximum depth m. 

#answer[
#table(
  columns: (auto, auto, auto),
  table.header([*Algorithm*], [*Time*], [*Space*]),
  [DFS], [$O(b^m)$], [$O(b m)$],
  [BFS], [$O(b^d)$], [$O(b^d)$],
  [UCS], [$O(b^(1 + ceil(C^* \/ epsilon))) approx O(b^d)$], [$O(b^(1 + ceil(C^* \/ epsilon))) approx O(b^d)$],
)

Where $b$ = branching factor, $d$ = depth of shallowest solution, $m$ = maximum depth, $C^*$ = cost of optimal solution, and $epsilon$ = minimum step cost.
]
#v(5cm)


Q12: Which algorithm is most memory efficient, and why?

#answer[DFS is the most memory efficient. It only needs to store the current path from root to the deepest expanded node, plus the unexpanded siblings along that path. Which results in O(bm) space complexity (linear in depth). BFS and UCS, however, must store the entire frontier, which grows exponentially with depth (O(b^d)). For deep search problems where memory is the bottleneck, DFS or its variants (like iterative deepening#sidenote[AIMA Chapter 3.4.4 Page 98]) are the only practical options.
]

#pagebreak()
= Part 3: Search with Heuristics

Q13: State the two properties a heuristic must satisfy to be consistent. How does consistency relate to admissibility? #sidenote[AIMA Chapter 3.5 Page 106]

#answer[check the textbook]

Q14: A robot navigates a grid. Its state is represented as (row, col). The start is (0, 0) and the goal is (3, 4). The robot can move up, down, left, or right with cost 1 per step.

(a) What is the value of the Manhattan distance heuristic from the goal to the start (ie: h(start))?

#answer[Manhattan distance = |3 − 0| + |4 − 0| = 3 + 4 = **7**.
]

(b) Suppose an obstacle blocks the direct path so the shortest actual path has cost 9. Does A-star with the Manhattan distance heuristic still find the optimal path? Why or why not?

#answer[The Manhattan distance is admissible. Astar with an admissible heuristic is guaranteed to find the optimal path, even though the optimal cost (9) exceeds the heuristic estimate (7).

Astar will simply expand more nodes before finding the goal. The admissibility guarantee will hold regardless of how loose the estimate is, as long as it never overestimates.
]

Q15: Using the same robot and grid from Q14: A heuristic h1 returns 0 for every state. A heuristic h2 returns the Manhattan distance.

(a) Are both admissible? Explain your answer. #sidenote[AIMA Chapter 3.5 Page 104]

#answer[h1 = 0 is trivially admissible#sidenote[0 <= hstar(n) for all n, since path costs are non-negative]. h2 = Manhattan distance is admissible for grid movement with cost 1 per step, since any path between two points must traverse at least the Manhattan distance in steps.
]

(b) Which one causes A-star to expand fewer nodes, and why?

#answer[h2 causes Astar to expand fewer nodes. A more informative#sidenote[higher valued, still admissible] heuristic focuses the search more tightly toward the goal by giving distant nodes higher f values, deprioritizing them. h1 = 0 makes Astar behave identically to UCS, expanding nodes uniformly outward in all directions with no goal directed steering.
]

#v(3cm)

(c) If we define h3(n) = max(h1(n), h2(n)) (using h1 and h2 from Q15), is h3 admissible? Is it at least as informative as h1 and h2 individually?

#answer[h3 = max(h1, h2) = max(0, Manhattan) = Manhattan. 

Since both are admissible, the max of two admissible heuristics is also admissible. h3 dominates both h1 and h2 because by definition h3(n) >= h1(n) and h3(n) >= h2(n) for all n.
]

Q16: Jeffrey Armstrong claims: "If a heuristic is inadmissible, A-star will never find the optimal solution." Is this claim always true, sometimes true, or always false? Provide a brief justification or counterexample.

#answer[*Sometimes true.* #sidenote[An inadmissible heuristic can still find the optimal solution, however it just isnt guaranteed to. ]


Counterexample: Consider a graph where the heuristic overestimates only at states that arent on the optimal path. Astart may still expand the optimal path first and return it. The point of admissibility is to guarantee optimality. So losing admissibility means losing the guarantee, not necessarily losing optimality on every instance.
]

Q17: Explain why A-star with a consistent heuristic guarantees that when a node is first expanded in graph search, it has been reached by the optimal path. Why does admissibility alone not guarantee this for A-star graph search?

#answer[Consistency ensures that f values along any path are non-decreasing#sidenote[f(n') = g(n') + h(n') >= g(n) + h(n) = f(n)]. This means once a node is expanded, no later path to that same state can have a lower f value, so the first expansion is always optimal.

With merely admissible (but inconsistent) heuristics, f values can decrease along a path. This means a node might be reached via a suboptimal path first (with lower f), get added to the closed set, and then later when a better path arrives, graph search refuses to reexpand it. 

Soooo, Astar graph search with an admissible but inconsistent heuristic can return suboptimal solutions!#sidenote[To fix this, you can either use tree search, allow reexpansion when a better path is found, or insist on consistency.]
]

Q18: Jeffery has once again proposed a new heuristic for A-star search that is very accurate but takes O(n^2) time to compute, where n is the problem size. The current heuristic is less accurate but computes in O(1). Under what circumstances would you recommend switching to the more expensive heuristic?
#v(4cm)
#pagebreak()

Q19: The 15-puzzle is a sliding tile game in which one tries to arrange all the tiles in ascending order(See figure 2 below). Two heuristics are proposed for the 15-puzzle :
#figure(
  image("../images/15puz.jpg"),
  caption: [An Example of the 15 puzzle],
)

h1 = number of misplaced tiles

h2 = sum of Manhattan distances of each tile from its goal position

(a) Prove both are admissible.
#v(3cm)

(b) Prove that h2 dominates h1 (h2(n) >= h1(n) for all n). What does dominance guarantee about the number of nodes expanded?
#v(3cm)

(c) If both are admissible and h2 dominates, why would you ever use h1?
#v(3cm)

(d) A third heuristic h3 is proposed: h3 = Manhattan distance + 2 × (number of tiles that must pass through the center square). Evaluate whether h3 is admissible and whether it dominates h2.
#v(3cm)


Q20: Musty the mustang is designing an A-star heuristic for the pancake sorting problem: given a stack of N pancakes of distinct sizes, you can insert a spatula at any position and flip all pancakes above it(See figure 3 below). The goal is to sort the stack largest on bottom to smallest on top.


#figure(
  image("../images/pancakes.png"),
  caption: [An example of a flip],
)

Musty proposes: h = number of pancakes not in their final position ÷ 2, arguing "each flip can move the spatula through at least 2 pancakes, so we fix at least 2 pancakes per flip."

(a) Identify the flaw in Musty's admissibility argument.
#v(3cm)

(b) Construct a concrete counterexample with 4 pancakes showing the heuristic either overestimates or that their reasoning breaks down.
#v(3cm)

#pagebreak()

(c) Propose a correct admissible heuristic and prove it is admissible.
#v(3cm)

(d) Is your heuristic in (c) more or less informed than the Musty's? Does a more informed heuristic always mean better performance in practice? Explain.
#v(3cm)


#pagebreak()

= Part 4: Adversarial Search

Q21: Define the following terms in the context of adversarial search: #sidenote[AIMA Chapter 6.1 Page 193]

(a) Zero sum game

#v(1cm)

(b) Terminal state

#v(1cm)

(c) Utility function

#v(1cm)

Q22: Explain why Minimax is equivalent to choosing the optimal strategy in a two player zero sum game where both players play perfectly. What assumption about the opponent makes Minimax appropriate? #sidenote[AIMA Chapter 6.2 Page 194]

#v(4cm)

Q23: Compare and contrast Minimax and Expectimax. When would you choose Expectimax over Minimax, and what changes in the game tree structure? #sidenote[AIMA Chapter 6.5 Page 211]

#v(4cm)


#pagebreak()

#pagebreak()
For Questions 24-25, use the following game tree. 
#figure(
  diagram(
    spacing: (1cm, 1.2cm),

    node((3, 0), text(18pt, sym.triangle.t), name: <root>, stroke: none),

    node((1, 1), text(18pt, sym.triangle.b), name: <L>, stroke: none),
    node((3, 1), text(18pt, sym.triangle.b), name: <M>, stroke: none),
    node((5, 1), text(18pt, sym.triangle.b), name: <R>, stroke: none),

    node((0,   2), text(18pt)[#sym.triangle.t #h(0.2em) 3], name: <l1>, stroke: none),
    node((1.4, 2), text(18pt)[#sym.triangle.t #h(0.2em) 5], name: <l2>, stroke: none),
    node((2.2, 2), text(18pt)[#sym.triangle.t #h(0.2em) 2], name: <l3>, stroke: none),
    node((3.8, 2), text(18pt)[#sym.triangle.t #h(0.2em) 8], name: <l4>, stroke: none),
    node((4.6, 2), text(18pt)[#sym.triangle.t #h(0.2em) 1], name: <l5>, stroke: none),
    node((6,   2), text(18pt)[#sym.triangle.t #h(0.2em) 4], name: <l6>, stroke: none),

    edge(<root>, <L>, "-"),
    edge(<root>, <M>, "-"),
    edge(<root>, <R>, "-"),
    edge(<L>, <l1>, "-"),
    edge(<L>, <l2>, "-"),
    edge(<M>, <l3>, "-"),
    edge(<M>, <l4>, "-"),
    edge(<R>, <l5>, "-"),
    edge(<R>, <l6>, "-"),
  ),
  caption: [Game tree for Q24-25. MAX nodes (#sym.triangle.t), MIN nodes (#sym.triangle.b).],
)

Q24:Compute the Minimax value of the root.
#v(4cm)

Q25: Using the same tree, apply Alpha Beta Pruning. List which leaf nodes are pruned (not evaluated). Assume children are evaluated left to right.
#v(4cm)

#pagebreak()
For Questions 26, use the following game tree. 
#figure(
  diagram(
    spacing: (1cm, 1.2cm),

    node((3, 0), text(18pt, sym.triangle.t), name: <root>, stroke: none),

    node((1, 1), text(18pt, sym.circle.stroked), name: <L>, stroke: none),
    node((3, 1), text(18pt, sym.circle.stroked), name: <M>, stroke: none),
    node((5, 1), text(18pt, sym.circle.stroked), name: <R>, stroke: none),

    node((0,   2), text(18pt)[#sym.triangle.t #h(0.2em) 3], name: <l1>, stroke: none),
    node((1.4, 2), text(18pt)[#sym.triangle.t #h(0.2em) 5], name: <l2>, stroke: none),
    node((2.2, 2), text(18pt)[#sym.triangle.t #h(0.2em) 2], name: <l3>, stroke: none),
    node((3.8, 2), text(18pt)[#sym.triangle.t #h(0.2em) 8], name: <l4>, stroke: none),
    node((4.6, 2), text(18pt)[#sym.triangle.t #h(0.2em) 1], name: <l5>, stroke: none),
    node((6,   2), text(18pt)[#sym.triangle.t #h(0.2em) 4], name: <l6>, stroke: none),

    edge(<root>, <L>, "-"),
    edge(<root>, <M>, "-"),
    edge(<root>, <R>, "-"),
    edge(<L>, <l1>, "-"),
    edge(<L>, <l2>, "-"),
    edge(<M>, <l3>, "-"),
    edge(<M>, <l4>, "-"),
    edge(<R>, <l5>, "-"),
    edge(<R>, <l6>, "-"),
  ),
  caption: [Game tree for Q26. MAX nodes (#sym.triangle.t), CHANCE nodes (#sym.circle.stroked).],
)
Q26: Now the second layer nodes are CHANCE nodes (with uniform probability over their children) instead of MIN nodes. Compute the Expectimax value of the root.
#v(4cm)

Q27: In Alpha Beta pruning, the order in which children are evaluated matters for efficiency but not for correctness. Explain why the final Minimax value is always the same regardless of evaluation order, and describe what child ordering maximizes the number of pruned nodes.
#v(4cm)

Q28: Musty is building a chess AI. They argue: "Since Expectimax accounts for the possibility that the opponent plays suboptimally, it is better than Minimax." Is this claim always true, sometimes true, or always false? Provide a brief justification or counterexample.



