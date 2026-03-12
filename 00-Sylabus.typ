#import "wdf.typ": *

#show: template.with(
  title: [
    Course Syllabus
  ],
  title-short: none,
  authors: "CSC 480: Artificial Intelligence, Spring 2026",
  authors-short: none,
  title-extra: [Professor Austin P. Wright: Course Notes],
  date: none,
  toc: false,
  full: false,
  header-content: none,
  abstract: none,
  bib: none,
  serif: true,
  exam: false
)


#sidenote(dy: 1.15em, numbered: false)[#outline(depth: 2)]

= Course Information and Contacts

#colorbox()[
*Professor*: _Dr. Austin P. Wright_\
*Email*: `awrigh20@calpoly.edu`\
*Office Hours*: 
- In person at 14-222: Tuesdays 10am-11am, Thursdays 10am-12pm
- By appointment at #link("https://calendly.com/awrigh20-calpoly/30min")[https://calendly.com/awrigh20-calpoly/30min]. 
]
#colorbox()[
*Teaching Assistant*: _Samuel Fox Gar Kaplan_\ 
*Email*: `sfkaplan@calpoly.edu`\
*Office Hours*: TBD. 
]


#colorbox()[
*Gradescope*: https://www.gradescope.com/courses/1266327  |  *Entry Code*: YBKXKB \ 
*EdStem*: https://edstem.org/us/courses/96266/ \
*Canvas*#sidenote()[As you will see in the grading section, you should use extreme caution when looking at the canvas gradebook, but since I know many of you like to use canvas to keep assignment due dates organized I will maintain a minimal canvas site to reference.]: https://canvas.calpoly.edu/courses/181943\
*Course Notes*: https://github.com/CSC480-SP26/Course-Notes  
]

= Course Structure

This course is designed to give you a relatively broad introduction to the field of _Artificial Intelligence_ and the foundational skills to build intelligent systems under a number of different conceptualizations of what that means#sidenote()[It is essential that you also understand what this course is *_not_*. The course is not about large-language models, prompt engineering, or most of the other stuff that is referred to as AI in the popular press. The material for this course predates all of those things, and covers the _classical foundations of intelligent systems_. So while there certainly is overlap and aspects of this course will relate to some of the work in contemporary AI, don't expect this course to teach you anything about how to design or use Chat-GPT.]. As a result this course is broken down into four units which, while connected, have components that are somewhat independent of each other. This is a lot of material, so be prepared for the course to be very fast paced.

== Search

In the first part of the course we will cover the foundational algorithms and techniques that characterize the earliest class of intelligent systems. These are systems which work to break problems down into multiple parts, and search for optimal solutions. Additionally we will study how such systems interact with each other in adversarial and game theoretic situations.

== Logic and Reasoning

In the second part of the course we will cover techniques that characterize a higher level of intelligence in the form of logic and reasoning. This will include an introduction to different forms of propositional and first order logic, as well as how intelligent systems can utilize logical inference and model checking to solve complex problems.

== Uncertainty and Learning 

In the third part of the course we will begin to extend what we have learned about reasoning into reasoning in the presence of uncertainty. This will involve a brief introduction to probabilistic and Bayesian modeling, followed by more depth on how to build intelligent systems that reason with probabilities, as well as learn from data. 

== Agents in the World

In the final part of the course, building on the combination of all the previous parts, we will study the methods for building agents which can reason, act, and learn on the fly in an uncertain environment. This will include the fundamentals of Markov Decision Processes as well as Reinforcement Learning. 


= Assessment and Grading

Your grade for this course will be based on three classes of assessment. Each of the assessments will ultimately be graded on a coarse scale of 0-4, where each value corresponds to the letter grade representing the degree of mastery over the material demonstrated through the assessment#sidenote()[Even when an assessment internally uses some kind of points tabulation, the actual grade will be based on a holistic evaluation of the overall assessment, and so any thresholds used to determine specific assessment grades will vary, but be communicated ahead of time when possible.]. Within such broad categories, there inevitably may be some wiggle room on the borders. Your best bet to get the most out of this wiggle room is surely to regularly come to class, lab, and office hours to participate and get regular feedback. 

#colorbox(title:"Coarse Grading Structure")[

*4 ≡ A *\ _Mastery of the material and full achievement of the learning objectives_ 

*3 ≡ B* \ _Good, if incomplete, understanding of the material and achievement of learning objectives_ 

*2 ≡ C *\ _Sufficient working understanding of the material and achievement of learning objectives_ 

*1 ≡ D *\ _Minimum passing understanding of the material and achievement of learning objective_ 

*0 ≡ F* \ _Insufficient demonstration of understanding of the material or achievement of learning objectives_ 
]

== Unit Exams

At the end of each unit there will ba a short exam#sidenote()[You can think of it as roughly half way between a weekly quiz and a full midterm in terms of scope.] which will be administered in the lab section on the days mentioned in the schedule. Each exam will cover the material for that unit only. For each exam you will be able to bring in one hand written double sided study sheet. The exams are designed to take one hour, and so for those with accommodations for time and a half you have the opportunity to take the exam in the normal lab section. 

I understand that sometimes life happens, maybe you got sick and were not be able to study very well for an exam, or a topic may be difficult and require more time to get a handle on. There are all sorts of reasons why any given exam on any given day may not be representative of what you can do, but I am not really interested in judging the validity of different situations and would prefer everyone get a baseline level of consideration that should cover all but the most exceptional circumstances. *Therefore, at the end of the course you will have an opportunity to re-take up to two of the four exams for full credit.* Make-up exams will cover the same material but with different questions and give you a second opportunity to show mastery over the material with no penalty#sidenote()[Of course, this does not mean you can skip everything. Logistical considerations are such that only two exams can be retaken, and so you cannot just blow everything off until the very end of the quarter. You should still try your best on your first attempts when you can.]. If you have an exceptional circumstance preventing you from making-up a missed exam or you are forced to miss more than two exams please talk to me as soon as possible to figure out what can be done. 

== Labs

Each unit will have an associated lab/mini-project. These are individual assignments and all of the code and writing you do for them must be your own. That being said, you are encouraged to collaborate, work together, and help each-other as long as you ultimately have your own solution#sidenote()[The heuristic to use is that you can talk about the problem and discuss ideas to help each other troubleshoot, debug, or approach the problem right up to where you get the "_Aha!_" moment, whereafter you should be able to act on that insight yourself.]. During the lab sections there will be many intermediate activities and check-ins to help you along. 

Unlike the exams, the labs won't be able to be retaken as we will be going over solutions after the due dates. However, in the same interest of providing built in flexibility, *your lowest grade lab will be dropped*. Similar to the exams, if you have an exceptional circumstance preventing you from being able to submit more than one of the labs on time, again please let me know as soon as possible.


== Final Project

The most interesting single thing you will do in this course will be your final project. In this project you will have substantial freedom to choose what you work on, and more details will be forthcoming later in the quarter. You will complete the final project in teams of 2-4 students, and so I highly recommend you get to know the other students in the class, find anyone with similar interests and get started as early as possible.

== Final Grade

#colorbox()[
*_Pay attention as this is both likely to be very different from other courses you have taken as well as what canvas might tell you_*. In particular if you have any questions refer to the formal treatment as the source of truth.
]

This course covers a multitude of different topics, all of which are equally important foundations for future work in Artificial Intelligence. In particular, strength in one area does not necessarily make up for weaknesses in another. Therefore, in order to receive an $A$ in the course, you are expected to _meet a certain standard across all of the topics covered in the course_. This is done through three mechanisms:

1. You must score at least within one coarse point of your final grade on every included assessment#sidenote()[So in order to earn an $A$ in the course, you must earn at least a $B$ on every included (i.e. not dropped) assessment. To earn a $B$ you must earn at least a $C$ across the board, etc...]
2. Within that limit, your final letter grade will be determined by the median of your assessments
3. Your final project will determine $+$ and $-$ grades

Remember that while in this system you must, by the end of the course, achieve the requisite level across all of your assessments, you have ample opportunity for retakes and drops in order to take any given bad day into account. Additionally your final project can always make a meaningful impact to help your grade, regardless of what you have on the other assessments.
=== A slightly more formal treatment for those interested

In case any of the language is confusing or ambiguous for you, I have sketched out the policy 

Let 
$
E =  {E_i in [0,4] |forall text("units") i}
$
be the set of exam scores for each unit on the coarse grade scale (with re-takes). 

Let 
$
L =  {L_i in [0,4] |forall text("units") i}
$
be the set of lab scores for each unit on the coarse grade scale.

Then we have 
$
L_(text("drop")) = L \\ min(L)
$
as the set of lab scores with the lowest score dropped. 

This gives us the set of assessment scores 
$
G = E union L_text("drop")
$

We can then calculate your final grade $F$ as given by 
$
F = min( min(G) + 1, text("median")(G) ) + (P-text("median")(G))/3 
$
Where $P in [0,4]$ is your final project grade, which is used relative to the standard you have established in the rest of the course to determine "plus and minus" grade modifiers.#sidenote(dy:-5em)[So if your assessment score is a $B$ but your final project is an $A$, this is a $+1$ difference, which corresponds to a $+1/3$ coarse scale effect, resulting your final grade moving up to a $3.overline(33) ≡ B^+$. Alternatively, if you have a $B$ coming in but simply don't do the final project, the $-3$ difference will drop you down to a $C$.] 

#pagebreak()
= Schedule
Below is a tentative schedule for the course. As the quarter progresses things may change, so pay attention to announcements/notifications/emails. Entries in the lab section describe scheduled activity in the lab section, whether it is taking an exam, an exam prep and revision session, lab project check-in meetings, or lab solution overviews.

#table(
  columns: 5,
  table.header(
    [*Week*], [*Date*], [*Unit*], [*Lecture Topics*], [*Lab Session*]
  ),
  [0], [4/2],  [0], [Course Introduction and AI History],      [Course Onboarding],
  [1], [4/7],  [1], [Search],                                  [AI Debate Activity],
  [1], [4/9],  [1], [Game Theory and Adversarial Search ],     [Final Project Speed Dating],
  [2], [4/14], [1], [Search Optimizations ],                   [Lab 1 Check-in],
  [2], [4/16], [1], [Uncertain Search ],                       [Exam 1 Prep],
  [3], [4/21], [2], [Propositional Logic],                     [*_Exam 1_*],
  [3], [4/23], [2], [SAT, Model Checking, DPLL],               [Lab 1 Review],
  [4], [4/28], [2], [First-Order Logic, Inference],            [Lab 2 Check-in],
  [4], [4/30], [2], [Advanced Logic (SMT, Modal, Temporal)],   [Exam 2 Prep],      
  [5], [5/5],  [3], [Probability Preliminaries],               [*_Exam 2_*],
  [5], [5/7],  [3], [Bayesian Networks],                       [Lab 2 Review],
  [6], [5/12], [3], [Markov Models, MCMC],                     [Lab 3 Check-in],
  [6], [5/14], [3], [HMM, Viterbi Algorithm, Particle Filters],[Exam 3 Prep],     
  [7], [5/19], [4], [MDP, Bellman Equation],                   [*_Exam 3_*],
  [7], [5/21], [4], [Temporal-Difference Learning, Q-learning],[Lab 3 Review],
  [8], [5/26], [4], [Reinforcement Learning],                  [Lab 4 Check-in],
  [8], [5/28], [4], [Approximate RL],                          [Exam 4 Prep], 
  [9], [6/2],  [],  [Final Project Review],                    [*_Exam 4_*],
  [9], [6/4],  [],  [Exam Retakes],                            [Exam Retakes],
  [Finals], [6/11], [], [Final Project Presentations],         [],
)

= Resources

== EdStem

The best place to ask questions when working on the labs or studying for the exams or anything else is the EdStem discussion forum for the class. The whole instructional team will try to answer questions as quickly as we can, but most importantly you all can also help each other. This will also be the main place when course announcements and updates will be posted. 

== Course Notes

My goal is to make my course/lecture notes available to you as a study resource in lieu of slides. They will be being updated on the github as I prep in real time. However, it is essential that you realize that these notes are not complete or sufficient to replace you taking notes. In fact they should help you structure your own notes. 

The primary purpose of the course notes is to help _me_ structure and keep on track in lecture, but of course _I already know the material_ and so what I need to have written in order to do lecture is very different than what you need to write to internalize the material for the first time. You are still responsible for the content actually covered in lecture (and any required readings).

== Textbooks

While strictly speaking we do not have a textbook that is required or will be followed directly, there are two textbooks that cover much (but not all) of the material for the course in a fairly strong and rigorous way which can be useful resources in case you miss class or wish to augment the course notes.



- S. Russell and P. Norvig,  _Artificial Intelligence: A Modern Approach, 4th US ed_. Pearson, 2022 [Online].  Available: https://aima.cs.berkeley.edu/

- B. Andrew and S. Richard S, _Reinforcement learning: an introduction_. The MIT Press, 2018. [Online]. Available: http://incompleteideas.net/book/the-book-2nd.html



#pagebreak()
= Policies

== Classroom Conduct

Our classroom and lab are to be places of learning and inclusion. Students of all ages, abilities, background, race, sexual orientations, beliefs, religious affiliations, gender identities, and origins are to be treated with dignity and respect as contributors to our scholarly environment. The recognizing the following points are non-non-negotiable prerequisites to participate in this course:

- _*We recognize that every single student in the class belongs here*_. We all have different backgrounds and experiences and we are not snobs about which backgrounds do or don't count.
- After our work is complete, we prioritize the education of others and actively offer to help, explain, debug, etc. in order to support one another’s learning. We do not share our working solution, but explain the logic/thinking behind our solution and help others recognize errors in their implementation when invited to do so.
- We consistently make the effort to recognize and validate multiple types of contributions to a positive classroom environment.



== Attendance
While attendance is not explicitly tracked, I strongly recommend that you attend every lecture. Anything I say in class is fair game for exams (within reason and unless specified otherwise). If you’re unable to attend class for some reason, drop me a note to let me know. This way if there’s an activity that class period, I can give you an opportunity to make it up.

My goal is for lectures to be interactive which only works when people show up. There will be frequent small group discussions, and I am also likely to call on individual students. If I call on you, it’s totally okay to get an answer wrong or to not know the answer#sidenote()[Indeed, this is probably a sign that I have moved too quickly or been unclear about something. But I can only learn that and make adjustments if people are in class and able to speak up.]. However, if being called on is likely to be uncomfortable or disruptive for you, let me know.

I don’t allow the use of laptops during lecture sessions without special dispensation. There is plenty of evidence that suggests that laptops and other devices are distracting not only to the student using them, but also to those around them. Additionally, taking handwritten notes tends to lead to better learning outcomes#sidenote()[https://journals.sagepub.com/doi/abs/10.1177/0956797614524581]. If you need a laptop to take notes in class, please talk to me.


== Collaboration and Plagiarism 

Although I encourage you to have lively discussions with one another, all work you hand in must be your own work, unless otherwise specified. Programs will be compared using software that can reliably detect similarities in source code. Though you are encouraged to seek help in tutoring and from the TA and instructor, do not look at classmates’ code. Unless explicitly allowed to do so, do not discuss specific implementation of your code. If your program or parts of your program are plagiarized from another student or an unapproved source, you will fail the course and a letter will be put in your file with Cal Poly Judicial Affairs. This includes students who copied and students who were copied from—you are responsible for the privacy of your source code.

== GenAI/LLM Use

The goals for this course are for _you_ to master the material, which can only be done if _you_ are the one doing the work. And so however ironic it may seem, the course policy for this class is that *_you cannot use Generative AI or Large Language Models like Chat-GPT in any substantive capacity for any of the work in this course._* 

On an individual basis, I will occasionally ask you to explain code you’ve written or choices you made. If I ask you to explain what a piece of your code does, and you are unable to do so, that is going to have repercussions on your grade for that assignment.

However, if you feel that these tools help you learn or understand the material, while maintaining your own complete authorship over everything you do, then you may use such tools appropriately to study and work through the course material. However, if you do this be careful. Modern GenAI tools#sidenote()[As opposed to many of the classically intelligent systems we will be studying which can have fairly strong guarantees on "correct" behavior] can be helpful, and often correct, but their core functionality is simply to give you an answer that looks _plausible_, without necessarily caring about _correctness_ or what actually will _help you learn_.


We learn best by struggling and surmounting challenges. Uncritical reliance on GenAI tools will short-circuit this process. Sure, you will get an answer quickly, but the answer is not our objective; our objective is the process that gets us there. (Just like the goal of lifting weights in the gym is not just to have the weights in the air.)

If you do use AI assistants to help you study, you’re encouraged to put them in “study mode” first. Different companies have different names for this:

- “Study mode” in ChatGPT
- “Learning mode” in Claude
- “Guided learning” in Google Gemini

These “modes” nominally do not jump straight to an answer, but try to lead you to an answer while helping you build your understanding. Even still, be very wary of these tools even in a guard-railed state. Think very hard about how if you do not develop the fundamental skills and you need such tools in order to succeed, what your ultimate value is after graduation.



== Note on Internships

Finally I know that due to the short summer caused by the quarter-to-semester transition some of you may have internships that unavoidably start before the end of the quarter. If you are in such a situation we _may_ be able to make appropriate accommodations, but you must talk with me as soon as possible.