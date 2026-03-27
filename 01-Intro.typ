#import "wdf.typ": *

#show: template.with(
  title: [
    Introduction to Artificial Intelligence
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: [We will cover some of the historical context of the field of artificial intelligence, as well as some provisional initial conceptions of what it means to design intelligent systems and agents.],
  bib: bibliography("refs.bib"),
  serif: true,
  exam: false,
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]

= What is Artificial Intelligence?

The very first question you should be asking when starting an introduction to some new field of study is: _"What the hell am I getting myself into?"_

This is especially true in a topic as widely discussed, and therefore widely misunderstood, as artificial intelligence. The goal of this course is not to provide you with any once-an-for-all answer to _"What is AI? And how do I build it?"_, as we will see such answers might not be so easy. But perhaps by the end of it you might be able to ask the right questions.

To help us along this journey we will be referencing lots of important and seminal works both historical#sidenote()[Well, at least as historical as anything gets in Computer Science] and contemporary. However our most frequent companion will be the seminal textbook by Stuart Russel and Peter Norvig, _Artificial Intelligence: A Modern Approach_ #cite(<aima>). But do not fear those over 1000(!) pages, the goal of these course notes is to provide a more concise scaffold of the material covered in this course specifically, while gesturing out towards material to check out whenever you want to dive a little bit deeper. That all being said we might as well take a first crack at trying to figure out what we are even talking about with AI.

#colorbox(color: yellow.darken(25%), title: "Artificial Intelligence")[

  Artificial, from the latin _artificium_, meaning: "A work of art, skill, theory, system, or craft".  And Intelligence from the latin _intelligentia_ meaning: "understanding, knowledge, comprehension, or the power of discernment".  And so perhaps #sidenote()[If you will forgive a mild occurrence of the etymological fallacy] we can proffer our first definition of AI that will guide our journey:

  AI is the study of the _*crafting of understanding*_.
]

This is the perspective we will take for the explorations of this course. Our goal being to learn how to design systems for which we can be said to be _crafting_ the ways in which they _understand_ and _reason_.#sidenote()[If you think there has been some slight-of-hand by already attributing properties like _reason_ and _understanding_ to machines right from the outset, you are not alone. The philosophical issues underpinning AI as an endeavor are many and deep, and will be discussed later in the course.] This emphasis on the thoughtful design of systems of thinking formed the heart of the early days of AI as a field, as well as computer science more generally.


= A Brief History of AI

The rest of this document will be laid out much more similarly to how the rest of the course notes for the course will look. I am writing these notes out in order to help keep on-pace and structure my lectures#sidenote()[And of course, since I already know the material what I need in order to stay on top of things is much different than what you need in order to actually learn it.], as well as to provide a study resource and citations and links to relevant external material#sidenote()[In particular much of the focus today will be on AIMA chapters 1, 2]. What I am _not_ writing is an entire textbook in real time. Therefore you may expect substantially less detail than what is actually covered in class#sidenote()[And it is the _*material covered in class*_, alongside any specifically mentioned readings, that you will be responsible for on the exams.], where you are very much still expected to take your own notes. I hope that these note might help provide the scaffold for your notes in the same way they help scaffold my lecture, and of course if you miss a lecture then these might help point you to the relevant parts of the book or other sources you can use to catch up. But don't expect to be able to just skim through these notes without coming to class, at least if you want to pass.

== Thinking about Thinking

=== Logic and Rationality
- Plato and the reality of concepts
- Aristotle and logic
- Russel, Wittgenstein, and _Logical Positivism_

=== The Mind
- Cartesian dualism
- Materialism
- Phenomenology
- Searle, The Chinese Room, and _The Hard Problem of Consciousness_
- Behaviorism, Skinner
- Cognitive Psychology

== Turing and the Birth of Computing
- Godel Incompleteness
- Computers as Thinking machines
- Turing Test
- Cybernetics, Systems Theory, Feedback, and Interdisciplinarity


== Early Optimism
=== Dartmouth AI Summer Project
- McCarthy, Minsky, Rochester, Shannon, 1955#sidenote()[http://jmc.stanford.edu/articles/dartmouth/dartmouth.pdf]
- First use of term Artificial Intelligence:
- _"2 month, 10 man study ... significant advance in one or more of these problems ... over a summer"_
- McCarthy / Minsky divide: Logical vs Connectionist Systems

=== Summer Vision Project
- Papert 1966, MIT#sidenote()[https://dspace.mit.edu/bitstream/handle/1721.1/6125/AIM-100.pdf] #sidenote()[https://philippschmitt.com/archive/computer-vision-history/]
  - _"The construction of a significant part of the visual system"_


#colorbox()[
  #figure(
    image("Figures/mccarthy_1955.png", width: 95%),
    caption: [First page from Proposal for Summer Research Project in Artificial Intelligence. AI involves the corse of every other part of computer science.#sidenote(dy: -20em)[_AI is just the parts of CS we have yet to fully understand_
        + Automatic Computers ⇒ Hardware / Computer Architecture
        + How Can a Computer be Programmed to Use a Language ⇒ PL (LISP : McCarthy 1958) / Formal Methods / NLP
        + Neuron Nets ⇒ Deep Learning
        + Theory of the Size of a Calculation  ⇒ Complexity Theory
        + Self Improvement  ⇒ Machine Learning
        + Abstractions ⇒ Knowledge Representation, OOP/Software Engineering
        + Randomness and Creativity ⇒ Probabilistic and Stochastic Computing] ],
  )
]




== The First AI Winter
- Boom/Bust cycle, the runaway effect of the popular imagination
- Lack of formal treatment of the difficulty of the problems being attempted
- Scale and hardware limitations
- Perceptrons, Minsky, XOR, No Multilayer Backpropagation
- 1974 Lighthill Report


== Rise of Expert Systems
- Attempts to solve more _well defined and limited_ problem with use of _expert background knowledge_
- Knowledge expressible as _rules_
  - #colorbox()[
      *_if_* $M$ is the mass of the whole molecule _*and*_ there are two peaks at $x_1$ and $x_2$ such that
      - $x_1 + x_2 = M + 28$
      - $x_1 − 28$ is a high peak
      - $x_2− 28$ is a high peak
      - At least one of $x_1$ and $x_2$ is high
      *_then_* there is a ketone subgroup.
    ]
- LISP, Symbolic Logic
- Prolog, Logic Programming,
- Second AI Winter

== Games
- Chess, Deep Blue vs Gary Kasparov, 1996
- Jeopardy, IBM Watson vs Ken Jennings, 2011
- Go, Alphago vs Lee Sedol, 2016


== Big Data and Machine Learning

#colorbox()[
  "Every time I fire a linguist, the performance of the speech recognizer goes up" - Frederick Jelinek
]
- Many hard real world problems are hard to explicitly model effectively
- Richard Sutton, The Bitter Lesson #sidenote()[https://www.cs.utexas.edu/~eunsol/courses/data/bitter_lesson.pdf]
- Unreasonable Effectiveness of Data #sidenote()[https://ieeexplore.ieee.org/document/4804817]
- From Machine learning into Deep Learning

== Large Language Models and the Current Frontier

- Language as a general purpose environment
- Essential properties of _scale_
- Have we lost what we were trying to do?

#pagebreak()
= Intelligent Agents


#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#figure(caption: [Basic Components of Agents], diagram(
  edge-stroke: 1pt,
  node-corner-radius: 5pt,
  edge-corner-radius: 8pt,
  mark-scale: 80%,

  node((0.5, 0.1), [_Agent_]),

  node((0.5, 1.25), [Reasoning], name: <reasoning>),
  edge(<reasoning>, <reasoning>, "->", bend: 130deg),

  node(
    enclose: ((0, 0), (1, 2)),
    stroke: black,
    fill: gray.lighten(95%),
    name: <agent>,
  ),

  node((3.15, 0.1), [_Environment_]),
  node((3.15, 1), [#text("?", size: 30pt)]),

  node(
    enclose: ((2.5, 0), (3.75, 2)),
    stroke: black,
    fill: gray.lighten(95%),
    name: <env>,
  ),
  edge(<agent>, <env>, "<-", label: [Perception], shift: 0.5),
  edge(<agent>, <env>, "->", label: [Action], shift: -0.5),

  edge(<env>, <perf>, "=>", label: [Evaluation]),
  edge(<perf>, "lll,u", "=>", label: [#h(12em)Learning]),

  node((3.15, 3), [Performance], stroke: black, name: <perf>),
))

#colorbox(title: [Definition: Rational Agent])[

  A rational agent is an agent for which, for each possible percept sequence, it should select an action that is expected to maximize its performance measure, given the evidence provided by the percept
  sequence and whatever built-in knowledge the agent has.
]

== Kinds of Environment
- Static vs Dynamic
- Fully vs Partially Observable
- Deterministic vs Stochastic
- Discrete vs Continuous
- Single vs Multi-Agent

== Kinds of Agent
- Reflex Agent
- Model Based Agent
  - Atomic, Factored, or Structured State Spaces
- Goal Based Agent
- Utility Based Agent
- Learning Agent

#pagebreak()
= Exercises

== Course Intro Lab Activity
+ Enroll in the course sites (EdStem and Gradescope)
+ Post a short introduction in the "Get to know your class" thread on EdStem
+ Complete the following exercise to show you understand the course grading policy, and test it out on plenty of possible outcomes!
#colorbox(color: green)[
  Write a short python function that takes a list of exam scores, a list of lab scores, and a final project score and outputs a final letter grade in accordance with the Syllabus grading policy.


  ```python
  def grader(exam_scores, lab_scores, final_project):
















    return final_grade


  ```
]

#pagebreak()
