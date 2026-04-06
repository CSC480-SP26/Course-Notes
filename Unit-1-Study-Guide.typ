#import "wdf.typ": *

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

= Part 1: Search Fundamentals

Q1: List and explain the components that formally define a search problem. #sidenote[AIMA Chapter 3.1 Page 83]

#v(2cm)

Q2: For each of the following search strategies, state whether it is complete and whether it is optimal. (Assume a finite branching factor and non-negative edge costs.)
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

Q3: In your own words, explain why Breadth First Search is optimal only when all step costs are equal, whereas Uniform Cost Search is optimal for any non-negative step costs.

#v(2cm)

Q4: Explain the difference between tree search and graph search. Why might tree search expand the same state more than once, and what mechanism does graph search use to prevent this? #sidenote[AIMA Chapter 3.3 Page 92]

#pagebreak()

Q5: Consider the following graph. All edges are undirected. The start state is S and the goal state is G.

#figure(
  image("Graph.png"),
  caption: [Search graph],
)

(a) Give the order in which nodes are expanded using Breadth First Search. Break ties alphabetically.

#v(2cm)

(b) Give the order in which nodes are expanded using Depth First Search. Break ties alphabetically.

#v(2cm)

(C) Give the order in which nodes are expanded using Uniform Cost Search. Break ties alphabetically.

#pagebreak()
= Part 2: Search with Heuristics

Q6: A robot navigates a grid. Its state is represented as (row, col). The start is (0, 0) and the goal is (3, 4). The robot can move up, down, left, or right with cost 1 per step.

(a) What is the value of the Manhattan distance heuristic from the goal to the start (ie: h(start))?

#v(2cm)

(b) Suppose an obstacle blocks the direct path so the shortest actual path has cost 9. Does A-star with the Manhattan distance heuristic still find the optimal path? Why or why not?

#v(4cm)

Q7: A heuristic h1 returns 0 for every state. A heuristic h2 returns the Manhattan distance.

(a) Are both admissible? Explain your answer. #sidenote[AIMA Chapter 3.5 Page 104]

#v(2cm)

(b) Which one causes A-star to expand fewer nodes, and why?

#v(2cm)

(c) If we define h3(n) = max(h1(n), h2(n)), is h3 admissible? Is it at least as informative as h1 and h2 individually?

#v(4cm)

Q8: Jeffrey Armstrong claims: "If a heuristic is inadmissible, A-star will never find the optimal solution." Is this claim always true, sometimes true, or always false? Provide a brief justification or counterexample.

#v(4cm)

Q9: Give them a situation and have them come up with states and a heuristic

#pagebreak()

= Part 3: Adversarial Search

Q10: Define the following terms in the context of adversarial search: #sidenote[AIMA Chapter 6.1 Page 193]

(a) Zero-sum game

#v(2cm)

(b) Terminal state

#v(2cm)

(c) Utility function

#v(2cm)

Q11: Explain why Minimax is equivalent to choosing the optimal strategy in a two-player zero-sum game where both players play perfectly. What assumption about the opponent makes Minimax appropriate? #sidenote[AIMA Chapter 6.2 Page 194]

#v(4cm)

Q12: Compare and contrast Minimax and Expectimax. When would you choose Expectimax over Minimax, and what changes in the game tree structure? #sidenote[AIMA Chapter 6.5 Page 211]

#v(4cm)
