#import "@preview/drafting:0.2.2": *

#let sans-fonts = (
  "Fira Sans",
  "Helvetica",
)

#let serif-fonts = (
  "EB Garamond",
)

#let fullwidth = state("fullwidth", false)

#let template(
  title: none,
  title-short: none,
  authors: none,
  authors-short:none,
  date: datetime.today().display("[day] [month repr:long] [year]"),
  abstract: none,
  title-extra: none,
  title-page: false,
  toc: false,
  full: false,
  header: true,
  footer: true,
  header-content: none,
  footer-content: none,
  bib: none,
  serif: false,
  exam: false,
  doc,
) = {
  // Full width or with right margin
  let right-margin = {
    if full { 0.7in } else { 3in }
  }
  let left-margin = 0.7in
  let margin-diff = right-margin - left-margin
  let wideblock(content) = block(width: 100% + margin-diff, content)

  // Update full width state used by note and notecite functions
  fullwidth.update(full)

  // Functions
  let titleblock(title, authors, date, abstract) = {
    wideblock([
      #set align(left)
      #if exam {
        columns(2,gutter: 1em)[
          #if title != none { [#text(
              size:18pt,
              weight: "semibold",
              [#title]) \ \ ] }
          #if authors != none { [
            #v(-1.5em)
            #text(
              size:11pt,
              weight: "medium",
              [#authors]) \ \ ] }

          #colbreak()

          #text(size:12pt,[
              #text(weight:"medium",style:"italic")[Name:]
              #box(width: 1fr, line(length: 100%, stroke: (thickness:1pt, dash:"dashed") ))

              #text(weight:"medium",style:"italic")[CalPoly Email:]              #box(width: 1fr, line(length: 100%, stroke: (thickness:1pt, dash:"dashed") ))

          ])
        ]
        v(-1em)
        line(length: 100%, stroke: 0.5pt)
        v(-1.25em)

        line(length: 100%, stroke: 0.5pt)

        v(-2.5em)
      } else {

        if title != none { [#text(
            size:18pt,
            weight: "semibold",
            [#title]) \ \ ] }
        if authors != none {
          if type(authors) == array and authors.len() == 2 {
            [#authors.join(", ", last: " and ") \ ]
          } else if type(authors) == array {
            [#authors.join(", ", last: ", and ") \ ]
          } else if type(authors) == str {
            [_#authors _ \ ]
          }
        }
        if title-extra != none { [#text(size:10pt,[#title-extra]) \ ] }
        if date != none { [#text(size:10pt,[#date]) \ ] }
        if abstract != none { [\ #text(size:10pt,weight: "semibold", style: "italic")[Abstract] \ #abstract \ ] }
        if toc { [\ #outline(indent: 1em, title: none, depth: 2) ] }

        // v(-1em)
        line(length: 100%, stroke: 0.5pt)
        v(-1.25em)
        line(length: 100%, stroke: 0.5pt)
        v(-2.5em)

    }
    ])


    if title-page{
      pagebreak()
    }
  }

  let headerblock(title, authors, date, header-content) = if header and header-content != none {
    header-content
  } else if header {
    set text(
      size: 8pt,
      weight: "light")
    wideblock({
      if counter(page).get().first() > 1 [

        #if title-short != none {
            [#emph[#title-short]]
        } else {
            [#emph[#title]]

        }
        #h(1fr)
        #if authors-short != none {
            [#emph[#authors-short]]
        } else {
            [#emph[#authors]]

        }
        #h(5pt) #emph[#date]

      ]
    })
  } else { none }

  let footerblock(footer-content) = if footer and footer-content != none {
    footer-content
  } else if footer {
    set text(size: 8pt)
    wideblock({
      set align(right)
      emph(counter(page).display("1/1", both: true))
    })
  } else { none }

  // Metadata
  if authors != none {
    set document(title: title, author: authors)
  } else {
    set document(title: title)
  }

  set text(font: if serif{serif-fonts} else {sans-fonts}, fill: luma(15%))

  show ref: set text(blue)
  show link: set text(blue)

  set par(justify: true, spacing: 1.5em)


  set cite(style: "association-for-computing-machinery")
  show bibliography: set par(spacing: 1em)

  set enum(indent: 1em)
  set list(indent: 1em)
  show enum: set par(spacing: 1.25em)
  show list: set par(spacing: 1.25em)

  set math.equation(numbering: "(1)", supplement: none, number-align: bottom)

  show raw: set text(ligatures: true, font: "Fira Code")
  show raw.where(block: false): box.with(
    fill: luma(95%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: true): block.with(
    fill: luma(95%),
    inset: 1em,
    radius: 0pt,
    stroke: (left: (
            thickness: 0.25em,
            paint: luma(25%),
            )),
    width: 100%,

  )

  // Equation and figure references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.target)[(#it)]
    } else if it.element != none and it.element.func() == figure {
      link(it.target)[#it.element.numbering]
    } else {
      it
    }
  }

  // Section headings
  set heading(numbering: (..numbers) =>
      if numbers.pos().len() <=  1 {
        return numbering("I \t", ..numbers)
      }, supplement: none)
  show heading.where(level: 1): it => {
    v(1.2em, weak: true)
    text(size: 14pt, weight: "semibold", it)
    v(0.5em, weak: true)
    line(length: 100%, stroke: 0.5pt)
    v(1em, weak: true)
  }
  show heading.where(level: 2): it => {
    v(1.2em, weak: true)
    text(size: 12pt, weight: "medium",style: "italic", it)
    v(1em, weak: true)
  }
  show heading.where(level: 3): it => {
    v(1.2em, weak: true)
    text(size: 12pt, fill: luma(40%),weight: "medium",style:"italic", it)
    v(1em, weak: true)
  }

  set page(
    paper: "us-letter",
    margin: (
      left: left-margin,
      right: right-margin,
      top: 1in,
      bottom: 0.75in,
    ),
    header: context { headerblock(title, authors, date, header-content) },
    footer: context { footerblock(footer-content) },
    footer-descent: 55%,
  )

  // Title block
  titleblock(title, authors, date, abstract)
  v(1.5em)

  // Using drafting package
  set-page-properties(
    margin-right: right-margin - left-margin,
    margin-left: left-margin * 1.2,
  )
  set-margin-note-defaults(
    stroke: none,
    side: right,
  )

  doc

  if bib != none { wideblock(bib) }
}

#let notecounter = counter("notecounter")
/// A sidenote.
///
/// Places a sidenote at the right margin.
/// If `full` template option is set to `true`, becomes a footnote instead.
///
/// - `dy: auto | length = auto` Vertical offset.
/// - `numbered: bool = true` Insert a superscript number.
/// - `body: content` Required. The content of the sidenote.
#let sidenote(dy: auto, numbered: true, body) = context {
  if fullwidth.get() and not numbered {
    footnote(body, numbering: _ => [])
    counter(footnote).update(n => n - 1)
  } else if fullwidth.get() {
    footnote(body)
  } else {
    if numbered {
      notecounter.step()
      context super(notecounter.display())
    }
    text(size: 9pt, margin-note(
      if numbered {
        text(size: 14pt, {
          context super(notecounter.display())
        })
        body
      } else {
        body
      },
      dy: dy,
    ))
  }
}

/// A sidenote citation.
///
/// Places a sidenote at the right margin.
/// If `full` template option is set to `true`, becomes a footnote instead.
/// Only display when `bibliography` is defined.
///
/// - `dy: auto | length = auto` Vertical offset.
/// - `form: none | str = "normal"` Form of in-text citation.
/// - `style: [csl] | auto | bytes | str = auto` Citation style.
/// - `supplement: content | none = none` Citation supplement.
/// - `key: cite-label` Required. The citation key.
#let sidecite(dy: auto, form: "normal", style: auto, supplement: none, key) = context {
  show cite: it => {
    show regex("\[\d\]"): set text(blue)
    it
  }
  let elems = query(bibliography)
  if elems.len() > 0 {
    cite(key, form: form, style: style, supplement: supplement)
    sidenote(
      cite(key, form: "full"),
      dy: dy,
      numbered: false,
    )
  }
}

/// Wideblock
///
/// Wrapped content will span the full width of the page.
///
/// - `content: content | none` Required. The content to span the full width.
#let wideblock(content) = context {
  if fullwidth.get() {
    block(width: 100%, content)
  } else {
    block(width: 100% + 2in, content)
  }
}

//Function to insert TODO
#let todo(body, inline: false, big_text: 40pt, small_text: 15pt, gap: 2mm) = {
  if inline {
    set text(fill: red, size: small_text, weight: "bold")
    box([TODO: #body
    #place()[
      #set text(size: 0pt)
      #figure(kind: "todo", supplement: "", caption: body, [])
    ]])
  }
  else {
    set text(size: 0pt) //to hide default figure text, figures is only used for outline as only headings and figures can used for outlining at this point
    figure(kind: "todo", supplement: "", outlined: true, caption: body)[
      #block()[
        #set text(fill: red, size: big_text, weight: "bold")
        ! TODO !
      ]
      #v(gap)
      #block[
        #set text(fill: red, size: small_text, weight: "bold")
        #body
      ]
      #v(gap)
    ]
  }
}

//Function to insert TODOs outline
#let todo_outline = outline(
    title: [TODOs],
    target: figure.where(kind: "todo")
)



#let colorbox(body,color: luma(25%),title:none) = {
  box(
    width: 100%,
    inset: (left: 1em, bottom: 1em, rest: 1em, ),
    stroke: (left: (
            thickness: 0.25em,
            paint:color,
            )),
    radius: 0.0em,
    fill: color.lighten(95%),[
      #text(fill: color,style: "italic",weight: "semibold",size: 11pt,title)
      #text(body,9pt)

    ]
  )
}



// Exam stuff
//
//
#let question-number = counter("question-number")
#let question-point = state("question-point", 0)

#let question-numbering(..args) = {
  let nums = args.pos()
  if nums.len() == 1 {
    numbering("1. ", nums.last())
  }
  else if nums.len() == 2 {
    numbering("(a) ", nums.last())
  }
  else if nums.len() == 3 {
    numbering("(i) ", nums.last())
  }
}


#let question(
    points: none,
    solution: none,
    solution-color: green.darken(20%),
    body) = {
  question-number.step(level: 1)

  question-point.update(p =>
    {
      if points == none { 0 }
      else { points }
    })

  context {
      v(0.1em)
      {
        question-number.display(question-numbering)
        if(points != none) {

          [(#emph[#points points])]
          h(0.2em)
        }
      }
      // set text(..__g-question-text-parameters)
      body
      if solution != none {
        linebreak()
        text(fill:solution-color)[#solution]
      }
  }
}



#let subquestion(
    points: none,
    solution: none,
    solution-color: green.darken(20%),
    body) = {
  question-number.step(level: 2)
  let sub-question-points = 0
  if points != none { sub-question-points = points }
  question-point.update(p => p + sub-question-points)

  context {
    set par(hanging-indent: 0.7em)
      v(0.1em)
      {
        question-number.display(question-numbering)
        if(points != none) {

          [(#emph[#points points])]
          h(0.2em)
        }
      }
      // set text(..__g-question-text-parameters)
      body
      if solution != none {
        linebreak()
        text(fill:solution-color)[#solution]
      }
  }
}
