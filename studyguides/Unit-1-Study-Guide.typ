#import "../wdf.typ": *


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
  abstract: none,
  bib: none,
  serif: true,
  exam: false,
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]
= Part 1: Intelligent Agents
Q1: State the definition of a rational agent.
#v(2cm)

Q2: List the dimensions used to characterize environments, giving both sides of each dimension. #sidenote[AIMA Chapter 2.3 Page 61]
#v(4cm)

Q3: Explain the difference between a reflex agent and a goal based agent. Why can't a reflex agent solve a maze?
#v(3cm)

Q4: What is the difference between a model based agent and a utility based agent?  #sidenote[AIMA Chapter 3.4 Page 69]
#v(3cm)

#pagebreak()

Q5: Classify each of the following environments along dimensions used to characterize environments. 

(a) A chess game against a human opponent
#v(3cm)
(b) A self driving car on a highway
#v(3cm)

(c) A thermostat in a room
#v(3cm)


#pagebreak()

= Part 2: Search Fundamentals

Q6: List and explain the components that formally define a search problem. #sidenote[AIMA Chapter 3.1 Page 83]

#v(2cm)

Q7: For each of the following search strategies, state whether it is complete and whether it is optimal. (Assume a finite branching factor and non-negative edge costs.)
#table(
  columns: 3,
  align: (left, center, center),
  stroke: 0.5pt,

  [*Strategy*], [*Complete?*], [*Optimal?*],

  [Depth-First Search (Graph)], [], [],
  [Breadth-First Search (Graph)], [], [],
  [Uniform Cost Search (Graph)], [], [],
  [A-star Tree Search (admissible h)], [], [],
  [A-star Graph Search (consistent h)], [], [],
)

Q8: In your own words, explain why Breadth First Search is optimal only when all step costs are equal, whereas Uniform Cost Search is optimal for any non-negative step costs.

#v(3cm)

Q9: Explain the difference between tree search and graph search. Why might tree search expand the same state more than once, and what mechanism does graph search use to prevent this? #sidenote[AIMA Chapter 3.3 Page 92]

#pagebreak()

Q10: Consider the following graph. All edges are undirected. The start state is S and the goal state is G.

#figure(
  image("images/Graph.png"),
  caption: [Search graph],
)

(a) Give the order in which nodes are expanded using Breadth First Search. Break ties alphabetically.

#v(2cm)

(b) Give the order in which nodes are expanded using Depth First Search. Break ties alphabetically.

#v(2cm)

(C) Give the order in which nodes are expanded using Uniform Cost Search. Break ties alphabetically.
#v(7cm)

Q11: For each search algorithm (DFS, BFS, UCS), state its time complexity and space complexity in terms of branching factor b, solution depth d, and maximum depth m. 
#v(5cm)


Q12: Which algorithm is most memory efficient, and why?


#pagebreak()
= Part 3: Search with Heuristics

Q13: State the two properties a heuristic must satisfy to be consistent. How does consistency relate to admissibility? #sidenote[AIMA Chapter 3.5 Page 106]

#v(2cm)

Q14: A robot navigates a grid. Its state is represented as (row, col). The start is (0, 0) and the goal is (3, 4). The robot can move up, down, left, or right with cost 1 per step.

(a) What is the value of the Manhattan distance heuristic from the goal to the start (ie: h(start))?

#v(2cm)

(b) Suppose an obstacle blocks the direct path so the shortest actual path has cost 9. Does A-star with the Manhattan distance heuristic still find the optimal path? Why or why not?

#v(2cm)

Q15: A heuristic h1 returns 0 for every state. A heuristic h2 returns the Manhattan distance.

(a) Are both admissible? Explain your answer. #sidenote[AIMA Chapter 3.5 Page 104]

#v(2cm)

(b) Which one causes A-star to expand fewer nodes, and why?

#v(2cm)

(c) If we define h3(n) = max(h1(n), h2(n)), is h3 admissible? Is it at least as informative as h1 and h2 individually?

#v(4cm)

Q16: Jeffrey Armstrong claims: "If a heuristic is inadmissible, A-star will never find the optimal solution." Is this claim always true, sometimes true, or always false? Provide a brief justification or counterexample.

#v(4cm)

Q17: Explain why A-star with a consistent heuristic guarantees that when a node is first expanded in graph search, it has been reached by the optimal path. Why does admissibility alone not guarantee this for A-star graph search?
#v(4cm)


Q18: Jeffery has once again proposed a new heuristic for A-star search that is very accurate but takes O(n^2) time to compute, where n is the problem size. The current heuristic is less accurate but computes in O(1). Under what circumstances would you recommend switching to the more expensive heuristic?
#v(4cm)
#pagebreak()

Q19: Two heuristics are proposed for the 15-puzzle (See figure below):
#figure(
  image("images/15puz.jpg"),
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


Q20: Musty the mustang is designing an A-star heuristic for the pancake sorting problem: given a stack of N pancakes of distinct sizes, you can insert a spatula at any position and flip all pancakes above it(See figure below). The goal is to sort the stack largest on bottom to smallest on top.


#figure(
  image("images/pancakes.png"),
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
For Questions 24-26, use the following game tree. The root is the top node, and the leaf values from left to right are 3, 5, 2, 8, 1, 4. MAX moves first at the root.

#figure(
  image("images/minmax.png"),
  caption: [Game tree for Q24-Q26],
)

Q24: Treating the second layer nodes as MIN nodes, compute the Minimax value of the root.
#v(4cm)

Q25: Using the same tree, apply Alpha Beta Pruning (with the second layer as MIN nodes). List which leaf nodes are pruned (not evaluated). Assume children are evaluated left to right.
#v(4cm)

#pagebreak()

Q26: Now treat the second layer nodes as CHANCE nodes (with uniform probability over their children) instead of MIN nodes. Compute the Expectimax value of the root.
#v(4cm)

Q27: In Alpha Beta pruning, the order in which children are evaluated matters for efficiency but not for correctness. Explain why the final Minimax value is always the same regardless of evaluation order, and describe what child ordering maximizes the number of pruned nodes.
#v(4cm)

Q28: Musty is building a chess AI. They argue: "Since Expectimax accounts for the possibility that the opponent plays suboptimally, it is better than Minimax." Is this claim always true, sometimes true, or always false? Provide a brief justification or counterexample.
