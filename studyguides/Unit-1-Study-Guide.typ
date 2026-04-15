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

Q4: What is the difference between a model based agent and a utility based agent?  #sidenote[AIMA Chapter 2.4 Page 69]
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
  diagram(
    node-stroke: 0.5pt,
    node-shape: circle,
    node-inset: 6pt,

    node((0, 1), [*S*], name: <S>),
    node((1, 0), [*B*], name: <A>),
    node((2, 0), [*C*], name: <C>),
    node((1, 2), [*A*], name: <B>),
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

#v(2cm)

(b) Give the order in which nodes are expanded using Depth First Search. Break ties alphabetically.

#v(2cm)

(C) Give the order in which nodes are expanded using Uniform Cost Search. Break ties alphabetically.
#v(2cm)

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

Q15: Using the same robot and grid from Q14: A heuristic h1 returns 0 for every state. A heuristic h2 returns the Manhattan distance.

(a) Are both admissible? Explain your answer. #sidenote[AIMA Chapter 3.5 Page 104]

#v(2cm)

(b) Which one causes A-star to expand fewer nodes, and why?

#v(2cm)

(c) If we define h3(n) = max(h1(n), h2(n)) (using h1 and h2 from Q15), is h3 admissible? Is it at least as informative as h1 and h2 individually?

#v(4cm)

Q16: Jeffrey Armstrong claims: "If a heuristic is inadmissible, A-star will never find the optimal solution." Is this claim always true, sometimes true, or always false? Provide a brief justification or counterexample.

#v(4cm)

Q17: Explain why A-star with a consistent heuristic guarantees that when a node is first expanded in graph search, it has been reached by the optimal path. Why does admissibility alone not guarantee this for A-star graph search?
#v(4cm)


Q18: Jeffery has once again proposed a new heuristic for A-star search that is very accurate but takes O(n^2) time to compute, where n is the problem size. The current heuristic is less accurate but computes in O(1). Under what circumstances would you recommend switching to the more expensive heuristic?
#v(4cm)
#pagebreak()

Q19: The 15-puzzle is a sliding tile game in which one tries to arrange all the tiles in ascending order(See figure 2 below). Two heuristics are proposed for the 15-puzzle :
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


Q20: Musty the mustang is designing an A-star heuristic for the pancake sorting problem: given a stack of N pancakes of distinct sizes, you can insert a spatula at any position and flip all pancakes above it(See figure 3 below). The goal is to sort the stack largest on bottom to smallest on top.


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
For Questions 24-25, use the following game tree.

#let min-node = metadata("min-node")
#let max-node = metadata("max-node")
#let leaf-node = metadata("leaf-node")
#let average-node = metadata("average-node")

#let minimax-tree = tidy-tree-graph.with(
  draw-node: (
    (extrude: -5pt),
    (inset: 1em),
    (stroke: 0.75pt),
    tidy-tree-draws.metadata-match-draw-node.with(
      matches: (
        min-node: (
          (width: 20pt, height: 20pt, shape: shapes.triangle.with(dir: bottom))
        ),
        max-node: (
          (width: 20pt, height: 20pt, shape: shapes.triangle.with(dir: top))
        ),
        leaf-node: (
          (width: 30pt, height: 30pt, shape: rect)
        ),
        average-node: (
          (width: 20pt, height: 20pt, shape: circle)
        ),
      ),
    ),
  ),
  draw-edge: (
    (marks: "->", stroke: 0.5pt),
  ),
  spacing: (45pt, 25pt),
)


#wideblock()[
  #figure(
    caption: [Game Tree for Q24-25],
    minimax-tree()[
      - #max-node
        - #min-node
          - 3 #leaf-node
          - 5 #leaf-node
        - #min-node
          - 2 #leaf-node
          - 8 #leaf-node
        - #min-node
          - 1 #leaf-node
          - 4 #leaf-node
    ],
  )
]


Q24:Compute the Minimax value of the root.
#v(4cm)

Q25: Using the same tree, apply Alpha-Beta Pruning. List which leaf nodes are pruned (not evaluated). Assume children are evaluated left to right.
#v(4cm)

#pagebreak()
For Questions 26, use the following game tree.
#wideblock()[
  #figure(
    caption: [Game Tree for Q26],
    minimax-tree()[
      - #max-node
        - #average-node
          - 3 #leaf-node
          - 5 #leaf-node
        - #average-node
          - 2 #leaf-node
          - 8 #leaf-node
        - #average-node
          - 1 #leaf-node
          - 4 #leaf-node
    ],
  )
]


Q26: Now the second layer nodes are CHANCE nodes (with uniform probability over their children) instead of MIN nodes. Compute the Expectimax value of the root.
#v(3cm)

Q27: In Alpha-Beta pruning, the order in which children are evaluated matters for efficiency but not for correctness. Explain why the final Minimax value is always the same regardless of evaluation order, and describe what child ordering maximizes the number of pruned nodes.
#v(3.5cm)

Q28: Musty is building a chess AI. They argue: "In my experience, opponents frequently play suboptimally and I can rarely predict very well what their next move is likely to be. Since Expectimax accounts for this uncertainty and possiblilty of suboptimal play, it is likely to perform better than Minimax on average." Is this claim always true, sometimes true (if so under what conditions?), or always false? Provide a brief justification or counterexample.



#pagebreak()


For Question 29, use the following game tree. 


#let minimax-tree = tidy-tree-graph.with(
  draw-node: (
    (extrude: -5pt),
    (inset: 1em),
    (stroke: 0.75pt),
    tidy-tree-draws.metadata-match-draw-node.with(
      matches: (
        min-node: (
          (width: 20pt, height: 20pt, shape: shapes.triangle.with(dir: bottom))
        ),
        max-node: (
          (width: 20pt, height: 20pt, shape: shapes.triangle.with(dir: top))
        ),
        leaf-node: (
          (width: 30pt, height: 30pt, shape: rect)
        ),
        average-node: (
          (width: 20pt, height: 20pt, shape: circle)
        ),
      ),
    ),
  ),
  draw-edge: (
    (marks: "->", stroke: 0.5pt),
  ),
  spacing: (15pt, 25pt),
)

#wideblock()[
  #figure(
    caption: [Game Tree for Q29],
    minimax-tree()[
      - #max-node
        - #min-node
          - #max-node
            - 6 #leaf-node
            - 8 #leaf-node
          - #max-node
            - 4 #leaf-node
            - 7 #leaf-node 
        - #min-node
          - #max-node
            - 2 #leaf-node
            - 5 #leaf-node
          - #max-node
            - 9 #leaf-node
            - 1 #leaf-node 
        - #min-node
          - #max-node
            - 12 #leaf-node
            - 3 #leaf-node
          - #max-node
            - 15 #leaf-node
            - 9 #leaf-node 
    ],
  )
]

Q29: Using the above tree, apply Alpha Beta Pruning. List which leaf nodes are pruned (not evaluated). Assume children are evaluated left to right.
