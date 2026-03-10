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
  exam: false
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]

= What is Artificial Intelligence?

The very first question you should be asking when starting an introduction to some new field of study is: _"What the hell am I getting myself into?"_

This is especially true in a topic as widely discussed, and therefore widely misunderstood, as artificial intelligence. The goal of this course is not to provide you with any once-an-for-all answer to _"What is AI? And how do I build it?"_, as we will see such answers might not be so easy. But perhaps by the end of it you might be able to ask the right questions.

To help us along this journey we will be referencing lots of important and seminal work both historical#sidenote()[Well, at least as historical as anything gets in Computer Science] and contemporary. However our most frequent companion will be the seminal textbook by Stuart Russel and Peter Norvig, _Artificial Intelligence: A Modern Approach_ #cite(<aima>). But do not fear those over 1000(!) pages, the goal of these course notes is to provide a more concise scaffold of the material covered in this course specifically, while gesturing out towards material to check out whenever you want to dive a little bit deeper. That all being said we might as well take a first crack at trying to figure out what we are even talking about with AI.

#colorbox(color: yellow.darken(25%),title: "Artificial Intelligence")[

  Artificial, from the latin _artificium_, meaning: "A work of art, skill, theory, system, or craft".  And Intelligence from the latin _intelligentia_ meaning: "understanding, knowledge, comprehension, or the power of discernment".  And so perhaps #sidenote()[If you will forgive a mild occurrence of the etymological fallacy] we can proffer our first definition of AI that will guide our journey:

  AI is the study of the _*crafting of understanding*_.
]

This is the perspective we will take for the explorations of this course. Our goal being to learn how to design systems for which we can be said to be _crafting_ the ways in which they _understand_ and _reason_.#sidenote()[If you think there has been some slight-of-hand by already attributing properties like _reason_ and _understanding_ to machines right from the outset, you are not alone. The philosophical issues underpinning AI as an endeavor are many and deep, and will be discussed later in the course.] This emphasis on the thoughtful design of systems of thinking formed the heart of the early days of AI as a field, as well as computer science more generally.


= A Brief History of AI

The rest of this document will be laid out much more similarly to how the rest of the course notes for the course will look. I am writing these notes out in order to help keep on-pace and structure my lectures#sidenote()[And of course, since I already know the material what I need in order to stay on top of things is much different than what you need in order to actually learn it.], as well as to provide a study resource and citations and links to relevant external material. What I am _not_ writing is an entire textbook in real time. Therefore you may expect substantially less detail than what is actually covered in class#sidenote()[And it is the _*material covered in class*_, alongside any specifically mentioned readings, that you will be responsible for on the exams.], where you are very much still expected to take your own notes. I hope that these note might help provide the scaffold for your notes in the same way they help scaffold my lecture, and of course if you miss a lecture then these might help point you to thte relevant parts of the book or other sources you can use to catch up. But don't expect to be able to just skim through these notes without coming to class, at least if you want to pass. 

== Thinking about Thinking

- Plato and the reality of concepts 
- Aristotle and logic
- Russel, Wittgenstein, and _Logical Positivism_


== Turing and the Birth of Computing

- Computers as Thinking machines
- Turing Test 

== Early Optimism

- MIT computer vision

== Connectionism, Simulacra, and Cybernetics

- Approaches based on biomorphic design

== The First AI Winter

- Boom/Bust cycle

== Rise of Expert Systems

- Logic based systems
- Search 
- programming systems of knowledge, automatic inference
- labor intensive

== Deep Blue vs Gary Kasparov

- Centrality of game playing
- high point of the "classical" AI

== Machine Learning and the Unreasonable Effectiveness of Data

- Reference the paper
- Machine learning into Deep Learning
- Go, Lee See Dol
- Fuzzy world

== Large Language Models and the Current Frontier

- Essential properties of _scale_
- Have we lost what we were trying to do?


= Intelligent Agents

== Why Agents?

== Model of the Environment

== Model of Action

== Model of Thinking and Decisions

== Rationality

= Exercises

#pagebreak()
