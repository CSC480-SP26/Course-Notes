
#import "wdf.typ": *

#show: template.with(
  title: [
    Game Search
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover basic Game Theory and the application of search methods towards games.],
  bib: none,
  serif: true,
  exam: false,
)






#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]



= Games

== Deterministic Games
Search problems where multiple agents have different actions available at different states with different goals. Game is played until it is over where each agent has some valuation of the end state.
=== Zero-Sum
#def()[A game is *zero-sum* when the goals of each agent can be defined in precise opposition to each other (such that increased utility for one agent is mirrored exactly as decreased utility for the opposing agent). ]
=== General-Sum
Non-zero-sum games can have agents with different goals that do not exactly counteract, and thus must be modeled as multi-dimensional utility optimization rather than single utility optimization with minimization and maximization.


= Adversarial Search
In single agent standard search, the value of a state is the best outcome from that state. With adversarial agents the value of state _for an agent_ is the best outcome _for that agent_ at that state.

== Minimax

#def(
  term: "Minimax",
)[Search problem for the *best achievable outcome* for an agent in a *determinisitc zero-sum game* with alternating turns against a *rational adversary*.#sidenote(dy: -20em)[
    #figure(caption: [Minimax Game Tree. Upward facing triangles represent "maximizer" nodes and downward facing triangles represent "minimizer" nodes, while squares represent terminal nodes.], minimax-tree()[
      - #max-node
        - #min-node
          - 10 #leaf-node
          - 2 #leaf-node
        - #min-node
          - 9 #leaf-node
          - 12 #leaf-node
    ])
  ]]

#discussion(
  vspace: 2em,
)[In standard Minimax search, we have to exhaustively search every terminal node. Why? What might happen if we dont?]

#discussion()[What is the best kind of search algorithm to use for Minimax? Why?]


== Alpha-Beta Pruning
Exhaustive search is expensive. Whenever possible we want to avoid having to expand and search nodes that we do not have to.
#wideblock()[
  #figure(
    caption: [Alpha-Beta Justification. Do the nodes with unkown values matter? Why?],
    minimax-tree()[
      - #max-node
        - #min-node
          - 3 #leaf-node
          - 12 #leaf-node
          - 8 #leaf-node
        - #min-node
          - 2 #leaf-node
          - ? #leaf-node
          - ? #leaf-node
        - #min-node
          - 14 #leaf-node
          - 5 #leaf-node
          - 2 #leaf-node

    ],
  )
]



#colorbox(
  color: red,
  title: [$alpha$:],
)[ _Maximizer's best option on path to root._

  We can know at this point in the search that the maximizer can force a score _at least_ this high]
#colorbox(
  color: blue,
  title: [$beta$:],
)[ _Minimizer's best option on path to root._

  We can know at this point in the search that the minimizer can force a score _at most_ this low]

#def(term: [$alpha beta$ Pruning])[
  If we keep track of the highest score a minimizer can force, and the lowest score a maximizer can force, we dont have to calculate the value of branches that we can ensure will never be chosen in the final decision.
]

Just like heuristics in A\*, $alpha beta$ pruning is an example of *metareasoning* or _computing what to compute_#sidenote()[Always in AI there is the adage: "Anything you can do I can do meta"].
Pruning works because it has _no effect_ on minimax value _at the root_ (while intermediate values may be wrong, including children of root), and thus allows correct minimax value computations.
=== Pseudo-code of $alpha beta$ Search
```py
def value(state, α, β):
    if is_terminal(state):
        return utility(state)
    elif agents_turn(state) is MAXIMIZER:
        return max_value(state, α, β)
    elif agents_turn(state) is MINIMIZER:
        return min_value(state, α, β )

def max_value(state, α, β):
    v = -∞
    for successor in transitions(state):
        v = max(v,value(successor, α, β))
        if v >= β:
            return v
        α = max(α,v)
    return v

def min_value(state, α, β):
    v = + ∞
    for successor in transitions(state):
        v = min(v,value(successor, α, β))
        if v <= α:
            return v
        β = min(β,v)
    return v
```
#discussion(vspace: 5em)[What are good initial values for $alpha, beta$?]


#discussion(vspace: 0em)[
  #figure(
    caption: [Alpha-Beta Quiz],
    minimax-tree()[
      - #max-node
        - #min-node
          - 10 #leaf-node
          - 8 #leaf-node
        - #min-node
          - 4 #leaf-node
          - 50 #leaf-node
    ],
  )
  For the above game tree, what are the minimax values at each node, and which branches can be safely pruned?]



#wideblock()[

  #discussion(vspace: 0em)[
    #figure(
      caption: [Alpha-Beta Quiz 2],
      minimax-tree()[
        - #max-node
          - #min-node
            - #max-node
              - 10 #leaf-node
              - 6 #leaf-node
            - #max-node
              - 100 #leaf-node
              - 8 #leaf-node
          - #min-node
            - #max-node
              - 1 #leaf-node
              - 2 #leaf-node
            - #max-node
              - 20 #leaf-node
              - 4 #leaf-node


      ],
    )
    For the above game tree, what are the minimax, alpha, and beta values at each node, and which branches can be safely pruned?

  ]
  #discussion()[Would $alpha beta$ pruning work with BFS/UCS/A\*? Why or why not?]

  #discussion()[Does the order of node exploration matter for the correctness or efficiency of $alpha beta$ pruning? Why?#footnote()[Time complexity with "Perfect Ordering" goes from $O(b^m) mapsto O(b^(m/2))$. This reduction comes from the fact that with optimal pruning, it remains that all of the first player's moves must be studied to find the best one, but for each, only the best second player's move is needed to refute all but the first (and best) first player move.]]




]


#pagebreak()
= Non-Optimal Search
Even with optimization, exhaustive search is often impossible.
== Depth-Limited Search
- Guarantee of optimal play is gone
- Iterative deepening allows for response of some quality at any time.

=== Evaluation _heuristic_
- Replace actual value of terminal positions with a heuristic evaluation of nonterminal states, guessing the minimax value of that state.
- Eval function design massively influences choices

#discussion(
  vspace: 15em,
)[Consider an agent in a grid with the ability to move back and forth, there is a utility increasing resource to its right, and empty space to its left. If using a depth-limited search, and an evaluation function of just the simple achieved utility is the agent may not actually move to gain the resource and instead go back and forth indefinitely. What is the reason this behavior may emerge, and what kind of evaluation function could be substituted to prevent it?
]

- Most frequent style of eval function is a weighted linear sum of features (number of white queens, number of black queens, control of central squares, etc...):
$
  "Eval"(s) = sum_(i=0)^(n) w_i dot f_i (s)
$
- Sometimes can be complex learned function (i.e. NN trained through RL)
- Higher depth can make up for imperfect evaluation. Better evaluation can make up for limited depth. Tradeoff of between the complexity, value, and computational cost of the evaluation function vs raw search depth.
#discussion(
  vspace: 3em,
)[How might a good evaluation function help make alpha-beta pruning more efficient?]

== Expectimax
#def()[If we face of uncertainty, *rationality* means choosing the best choice _on average_]

=== Uncertainty can take many forms, that can combine with each other
- Deterministic environment but a random adversary
- Deterministic adversary but a random environment#sidenote()[You can always model extra changes in the environment as actions by some all powerful God agent, who does, in fact, play dice.]

=== Randomness vs Uncertainty
- Rolling dice
- Unpredictable opponents
- Actions that might fail

=== Expectimax search
- Compute the _average_ score under _optimal_ play
- Still can have Max and Min nodes but add chance nodes
#def(
  term: "Chance Node Value",
)[Utility is the *expected value* of successor nodes over the probability distribution of transitions.#sidenote()[We will learn how to determine such distributions in Unit 3, as well formalizing as the more general underlying problems of rational uncertain actions in Unit 4 as _Markov Decision Processes_.]]
=== Short reminder on probability:
- Random variable: event with unknown outcome
- Probability Distribution: assignment of likelihood to different outcomes
  - All values non-negative
  - Must add to $1$
  - Distribution may change in response to evidence


#wideblock()[
  #figure(
    caption: [Expectimax Example],
    minimax-tree()[
      - #max-node
        - #average-node
          - 3 #leaf-node
          - 12 #leaf-node
          - 9 #leaf-node
        - #average-node
          - 2 #leaf-node
          - 4 #leaf-node
          - 6 #leaf-node
        - #average-node
          - 15 #leaf-node
          - 6 #leaf-node
          - 0 #leaf-node
    ],
  )
]

#discussion(vspace: 7em)[When, if ever, can we prune branches in expectimax?]

== Modeling Assumptions
Expectimax is only every as effective its _modeling assumptions_ that determine how to calculate the probability distribution of successors of a chance node. While expectimax can outperform minimax in the best case, it is very likely to extremely under-perform in the worst case.

#discussion()[ What would it mean for a game agent's design (algorithm choice, evaluation function, etc...) to be optimistic vs pessimistic? Generally is expectimax more optimistic or pessimistic when compared to minimax?
]

#discussion()[Let’s say you know that your opponent is actually running a depth 2 minimax, using the result 80% of the time, and moving randomly otherwise. How would you calculate the expectimax value? What about if instead of depth 2 minimax, your opponent was depth 2 expectimax (with perfect knowledge of it's own strategy and an assumption of rationality of your strategy)?]


== Generalizations
- Mixed node types, multiple agents, non-uniform transitions.
- Non-zero sum, each agent has own independent utility, can give rise to cooperation and competition dynamically.


== Return to Game Theory
Rationality is complicated with uncertainty about the opponent. Sometimes it seems like the "irrational" action can do better because it counteracts your opponent's _expectation of your own rationality_. Such "rock-paper-scissors" situations can be turned in on themselves indefinitely, until they reach an equilibrium.

#def(term: "Nash Equilibrium")[
  A game situation is in _Nash Equilibrium_ when no player can gain by changing their strategy
]
