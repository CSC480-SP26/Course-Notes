
#import "wdf.typ": *

#show: template.with(
  title: [
    Search
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover the basic problem structure and algorithms for simple search problems],
  bib: none,
  serif: true,
  exam: false,
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]

= Search Problems

Most simple instance of Agentic Framework with:
- Perfect sense input on state
- Perfect control output of state
- Identifiable binary goal(s)
- Singular agent


#colorbox(title: [Components of Agentic Search Problem])[

  - State space:  $S$
  - Initial state: $s_0 in S$
  - Goal(s): $G subset S$
  - Action space: $A$
  - Available actions (Options): $O : S -> A$
  - Transition function: $T : (S,A) -> S$
    - Where state a state $s$ is mapped to the resultant state after the agent an performs action
    - $T(s,a in O(s)) mapsto s'$
  - Transition cost function $c : (S,A,S) -> RR$
    - For transitions $c(s,a,s')$ where $s' in T(s,a)$, and $a in O(s)$
  - Path: Sequence of actions to go from $s_a mapsto s_b$
  - Solution: Path from initial state to goal, $s_0 mapsto g in G$
]


== Examples of Search Problems
- Route Planning
- Sudoku
- Programming

#colorbox(color: blue, title: "Discussion: ")[
  Come up with other examples of problems that can be viewed as search. What is the state space? What are the transitions? How does one determine a goal? What are the costs?
]

== Difficulty of Search Problems
- Size of Search Space
- Branching Factor
- Solution Depth

== Measures of Performance
- *Completeness*: Will find solution if exists, report failure otherwise
- *Optimality*: Find solution with lowest path cost
- *Performance*: Space and Time Complexity

== Representing Search Problems

#let goal = metadata("goal")
#let visited = metadata("visited")
#let path = metadata("path")
#let unexpanded = metadata("unexpanded")
#let next = metadata("next")


#let search-tree = tidy-tree-graph.with(
  draw-node: (
    (corner-radius: 5pt),
    (inset: 1em),
    (stroke: luma(80%) + 0.75pt),
    (extrude: -2pt),
    tidy-tree-draws.metadata-match-draw-node.with(
      matches: (
        goal: (
          fill: color.rgb("#dffadfff"),
          stroke: color.rgb("#9ffa9fff").darken(20%) + 1.25pt,
        ),
        visited: (stroke: luma(50%) + 0.75pt),
        next: (extrude: (-1, -3)),
        path: (
          stroke: color.rgb("#9ffa9fff").darken(20%) + 1.25pt,
        ),
      ),
      default: (fill: none),
    ),
  ),
  draw-edge: (
    tidy-tree-draws.metadata-match-draw-edge.with(
      matches: (
        path: (
          marks: "->",
          stroke: color.rgb("#9ffa9fff").darken(50%) + 0.5pt,
        ),
        unexpanded: (stroke: luma(50%), marks: "-->"),
      ),
      default: (marks: "->", stroke: luma(30%)),
    ),
  ),
  spacing: (45pt, 25pt),
)


#figure(
  caption: [Representation of search problem with search tree of node expansions. If We have $s_3 in G$ we can see the solution path of $s_0 ->_(a_2)s_2->_(a_1)s_3$, found after having explored $s_1$ and with $s_4$ as the next unexplored node to process.],
  search-tree[
    - $s_0$#path
      + $a_1$
      - $s_1$#visited
      + $a_2$#path
      - $s_2$#path
        + $a_1$ #path
        - $s_3$ #goal
        + $a_2$ #unexpanded
        - $s_4$ #next
  ],
)

== Tasks for Search Solver
- Keep track of explored states
- Keep track of unexplored states
- Choose which unexplored state to expand

= Uninformed Search

== Depth First Search

- unexplored stack
- example
- *incomplete* in infinite state space
- risk of cycles

== Breadth First Search

- unexplored queue
- example


== Uniform Cost Search (Dijkstra's Algorithm)

- unexplored pq
- example


= Informed Search

== Heuristics

Help decide which nodes to explore by prioritizing more promising branches.

== A\*

$
  "Priority" = c(S) + h(s)
$


== Admissibility
For a heuristic to be _admissible_, it must be is an _underestimate_ of the true remaining cost.
$
  h(s) <= c^*(s mapsto g)
$

$"Admissible"(h) => "A* is solution is optimal"$
Let admissible $h$, assume returns path with $C>C^*$. Then there is node $n$ unexpanded on optimal path.
$
  & f(n) > C^* \
  & f(n) = g(n) + h(n) \
  & f(n) = g^*(n) + h(n) \
  & f(n) <= g^* + h^*(n) \
  & f(n) <= C^* \
  & text("Contradiction"), qed
$

== Consistency
$
  forall n in S, n' in T(n,a)\
  h(n) <= c(n,a,n') + h(n')
$
- Triangle Inequality
- $"Consistent"(h) => "Admissible"(h)$

- The first time we reach a state it will be on an optimal path, so we never have to re-add a state to the frontier.


== Suboptimal Search
- Wiggle room:
  - optimal path if $h(n)$ is admissible on all states on path, then optimal will be found regardless of other states
  - optimal path if optimal cost $C^*$, second best $C^2$,$h(n) - h^*(n) < C^2 - C^*$
- Benefits of inadmissible heuristic
- Semi-greedy,  $"Priority" = c(S) + W*h(s)$
