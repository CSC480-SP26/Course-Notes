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
  abstract: [],
  bib: bibliography("refs.bib"),
  serif: true,
  exam: false,
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]

= Part 1: Search Fundamentals

Q1: List and explain the components that formally define a search problem.
The six components are: 
  (1) States which are the set of all possible configurations the problem can be in (the state space). 
  (2) Initial state which is the starting configuration the agent begins in. 
  (3) Goal state or the the target configuration (or a goal test that determines whether a given state satisfies the goal). 
  (4) Actions. The set of possible moves available to the agent in each state.
  (5) Transition model which defines the result of applying an action in a state, mapping (state, action) ==> successor state. 
  (6) Cost function which assigns a numeric cost to each action or path, used to evaluate the expense of reaching the goal.

Q2: For each of the following search strategies, state whether it is complete and whether it is optimal. (Assume a finite branching factor and non-negative edge costs.)
#table(
  columns: 3,
  align: (left, center, center),
  stroke: 0.5pt,

  [*Strategy*], [*Complete?*], [*Optimal?*],

  [Depth-First Search (Graph)], [Yes (finite state space)], [no],
  [Breadth-First Search (Graph)], [Yes (finite branching)], [Only if step costs are equal],
  [Uniform Cost Search (Graph)], [Yes (if step costs > 0)], [Yes],
  [Astar Tree Search (admissible h)], [Yes], [Yes],
  [Astar Graph Search (consistent h)], [Yes], [Yes],
)
Q3: In your own words, explain why Breadth First Search is optimal only when all step costs are equal, whereas Uniform Cost Search is optimal for any non-negative step costs.
BFS expands nodes fat increments of height/level, exploring the finds the shallowest areas first. If all step costs are equal, the shallowest path is also the cheapest. But if step costs vary, a deeper path might have lower total cost. UCS expands nodes in order of cumulative path cost, so it always expands the cheapest cost node next, guaranteeing it finds the lowest-cost path regardless of how costs are distributed.