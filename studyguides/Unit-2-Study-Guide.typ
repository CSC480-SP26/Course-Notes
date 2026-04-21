#import "../wdf.typ": *


#show: template.with(
  title: [
    Logical Agents
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


= Part : Knowledge Based Agents
Q: What is a knowledge base? What is a “sentence” in this context?
#v(1.5cm)


Q: What is the difference between knowledge level and implementation level? Why is this distinction important?
#v(1.5cm)

Q: Explain the difference between the declarative approach vs the procedural approach to building agents:
#v(2cm)

Q: Using the PEAS model, describe the environment of a student in CSC480.
(Performance measure, Environment, Actuators, Sensors)
#v(4cm)


Q: Classify the student’s environment in CSC480 using standard environment properties (ie: deterministic vs stochastic, fully vs partially observable, episodic vs sequential... etc).
#v(2cm)



= Part : Propositional Logic
Q: Define Propositional Logic in your own words. #sidenote[AIMA Chapter 7.4 Page 235]
#v(2cm)

Q: What are the five common logical connectives uses in complex sentences and what do they mean?

#v(3cm)


Q: Fill out this truth table:

#table(
  columns: 8,
  align: (left, center, center, center, center, center, center, center),
  stroke: 0.5pt,

  [*P*], [*Q*], [*R*], [*$not$ P*], [*P $or$ Q*], [*Q $and$ R*], [*$not$(P $and$ R)*], [*(P $or$ Q) $and$ $not$ R*],

  [True],  [False], [],      [],      [],      [],      [],      [],
  [False], [],      [True],  [],      [False], [],      [],      [],
  [],      [True],  [False], [],      [],      [False], [],      [True],
  [],      [],      [True],  [True],  [],      [True],  [],      [],
  [True],  [],      [],      [],      [True],  [],      [False], [],
  [],      [False], [False], [],      [],      [False], [True],  [],
  [False], [True],  [],      [],      [],      [],      [],      [True],
  [],      [],      [True],  [],      [True],  [],      [True],  [False],
)


Q: Why is the statement “P $=>$ Q” true when P is false? Then give an example in your own words. #sidenote("Think of the example we talked through during lecture...")

#v(4cm)

#pagebreak()

= Part : Inference

Q: Define soundness and completeness. Why are both important?
#v(3cm)

Q Explain the difference between model checking and theorem proving. When might one be more efficient than the other?
#v(3cm) 


Q: What is _Modus Ponens_? Give an example.
#v(3cm)


Q: What is And-Elimination?
#v(2cm)


