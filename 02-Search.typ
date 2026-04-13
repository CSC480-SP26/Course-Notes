
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
- Keep track of already explored states (only for graph search)
- Keep track of unexplored states (successors of expanded nodes)
- Choose which unexplored state to expand

= Uninformed Search
Where we can only use the direct information in the search problem to solve it in the most general way possible.

== Depth First Search

- unexplored stack
- *incomplete* in infinite state space
- risk of cycles
- tree to graph search

== Breadth First Search

- unexplored queue
- fewest action optimal


== Uniform Cost Search (Dijkstra's Algorithm)

- unexplored priority queue based on path cost
- lowest cost optimal
$
  p(n') = p(n) + c(n,a,n')
$

= Informed Search
Where we use some additional information to make better choices about which search nodes to explore next
== Heuristics

Help decide which nodes to explore by prioritizing more promising branches.

== A\*

$
  "Priority" = p(n) + h(n)
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

If heuristic is inadmissible, i.e. too high  or _pessimistic_, it may _deprioritize_ actually optimal paths sufficiently to result in a non-optimal path.

=== Semi-Lattice of Heuristics
- Zero heuristic is admissible, equivalent to UCS
- True cost is optimal, but does it help?
#figure(
  caption: [Hierarchy of Admissible Heuristics from zero to the true cost],
  diagram(
    edge-stroke: 1pt,
    node-corner-radius: 5pt,
    edge-corner-radius: 8pt,
    mark-scale: 80%,

    node((0, 0), [_True Cost_], name: <true>),
    node((0, 0.5), [$max(h_a, h_b)$], name: <max>),
    node((1, 1), [$h_b$], name: <b>),
    node((-1, 1), [$h_a$], name: <a>),
    node((0.5, 1.5), [$h_c$], name: <c>),
    node((0, 2), [_Zero_], name: <zero>),

    edge(<true>, <max>, "->"),
    edge(<max>, (-1, 0.5), <a>, "->"),
    edge(<max>, (1, 0.5), <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<a>, <zero>, "->"),
    edge(<c>, <zero>, "->"),
  ),
)


== Consistency
$
  forall n in S, n' in T(n,a)\
  h(n) <= c(n,a,n') + h(n')
$
- Triangle Inequality
- $"Consistent"(h) => "Admissible"(h)$

- The first time we reach a state it will be on an optimal path, so we never have to re-add a state to the frontier.
- Graph search needs consistent, Tree search needs admissible

#let badge(pos, body, ..args) = {
  body = text(size: 10pt, fill: gray.darken(50%), body)
  node(
    (rel: (0, 0.1), to: pos),
    stroke: none,
    fill: none,
    inset: 2pt,
    shape: rect,
    ..args,
    body,
  )
}
#figure(
  caption: [Example of inconsistent heuristic gone wrong in graph search. Go through A\* graph search with the provided inconsistent heuristic. What went wrong?],

  diagram(
    node-stroke: black,
    node((0, 0.5), name: <s>, fill: blue.lighten(80%))[_S_],
    node((1.5, 0), name: <a>)[_A_],
    node((1.5, 1), name: <b>)[_B_],
    node((4, 0), name: <c>)[_C_],
    node((4, 1), name: <g>, fill: green.lighten(80%))[_G_],
    badge(<s.south>)[$h=2$],
    badge(<a.south>)[$h=4$],
    badge(<b.south>)[$h=1$],
    badge((rel: (0.5, -0.1), to: <c.east>))[$h=1$],
    badge(<g.south>)[$h=0$],

    edge(<s>, <a>, "<|-|>", label: [1]),
    edge(<a>, <c>, "<|-|>", label: [1]),
    edge(<s>, <b>, "<|-|>", label: [1]),
    edge(<b>, <c>, "<|-|>", label: [2]),
    edge(<c>, <g>, "<|-|>", label: [3]),
  ),
)

== Designing Heuristics
- Consider relaxed version of problem
- Additional possible actions
- Tends to be consistent


== Suboptimal Search
- Wiggle room, will still find optimal path if either:
  - $h(n)$ is admissible on all states on optimal path, then optimal will be found regardless of value at other states
  - For optimal cost $C^*$, and second best $C^(**)$ with $ h(n) - h^*(n) < C^(**) - C^* $
- Semi-greedy,  $"Priority" = c(n) + W*h(n)$
