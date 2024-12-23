#let main(doc) = {
  set text(font: "Times New Roman", size: 14pt, lang: "ru", hyphenate: false)
  set page(margin: (
    top: 2cm,
    left: 3cm,
    right: 1cm,
    bottom: 2cm
  ))
  doc
}

#let lb = linebreak(justify: true)

#let print_symbols(..args) = {
  v(-10pt)
  h(-1.25cm)
  "где"
  context {
    h(1.25cm - measure("где").width)
  }
  v(-26pt)
  for (i, arg) in args.pos().enumerate() {
    let res = arg.at(0) + h(7pt) + sym.dash.em + h(7pt) + arg.at(1);
    if i == args.pos().len() - 1 {
      res += "."
    }
    else {
      res += ";"
    }
    par(res, hanging-indent: 1.25cm)
  }
}

#let appendix-num(.., last) = {
  let symbols = "абвгдежиклмнпрстуфхцшщэюя".split("").map(upper)
  symbols.at(last)
}

#let eq-simple(eq) = {
  math.equation(eq, block: true, numbering: none)
}

#let appendix() = {
  outline(target: heading.where(level: 4), title: heading("Приложения", level: 1, outlined: true), fill: none)
  counter(heading.where(level: 4)).update(0)
}

#let template(doc) = {
  set par(first-line-indent: 1.25cm, justify: true, leading: 14pt)
  show raw: it => {
    set par(leading: 4pt)
    set text(size: 10pt, font: "Courier New")
    it
  }
  set page(footer: context[
    #let (num,) = counter(page).get()
    #if num > 1 {
      align(center, counter(page).display(
        "1"
      ))
    }
  ])
  show figure.where(kind: raw): it => {
    set align(left)
    set text(font: "Courier New", size: 10pt)
    set figure(numbering: "A 1")
    set block(breakable: true)
    set figure.caption(position: top)
    show figure.caption: set text(size: 12pt)
    par([#it.caption #rect(width: 100%, stroke: luma(50%), [#it.body])])
  }
  show heading: it => {
    if it.outlined {
      h(1.25cm)
      v(-24pt)
      context {
        let arr = counter(heading).get()
        if it.numbering == none {
          par(align(center, it.body), justify: true)
        } else {
          par(align(left, [#arr.map(str).join(".") #it.body]), first-line-indent: 1.25cm, justify: true)
        }
      }
      h(1.25cm)
      v(-12pt)
    }
    else {
      align(center, it)
      v(24pt)
    }
  }
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    if it.body != [Приложения] {
      pagebreak()
    }
    upper(text(it, size: 18pt))
  }
  show heading.where(level: 2): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    v(18pt)
    it
  }
  show heading.where(level: 3): it => {
    v(18pt)
    it
  }
  // show heading.where(level: 4): set heading(
  //   outlined: false
  // )
  show heading.where(level: 4): it => {
    pagebreak()
    counter(heading.where(level: 4)).step()
    counter("code").update(0)
    align(center, "Приложение " + appendix-num(counter(heading.where(level: 4)).get().first() + 1))
    v(12pt)
    align(center, text(it.body, weight: "regular"))
  }

  show heading.where(numbering: none): set heading(supplement: [Не раздел])
  show heading.where(numbering: none): it => {
    align(center, it)
  }

  set list(indent: 1.25cm, body-indent: 1cm)
  show list: it => {
    for (index, item) in it.children.enumerate() {
      let res = it.marker.at(0) + h(1cm - 4pt) + item.body;
      if index == it.children.len() - 1 {
        res += ".";
      }
      else {
        res += ";";
      }
      par(res, hanging-indent: 2.25cm)
    }
  }

  set enum(indent: 1.25cm, body-indent: 1cm)
  show enum: it => {
    it
    v(-18pt)
    h(1.25cm)
  }
  
  show outline.entry: it => {
    if it.level == 1 {
      upper(it)
    }
    else if it.level == 2 or it.level == 3 {
      it
    }
    else {
      h(1.25cm)
      context {
        let app-num = counter(heading.where(level: 4)).get().first()
        counter(heading.where(level: 4)).step()
        link(query(heading.where(level: 4)).at(app-num).location())[Приложение #appendix-num(app-num + 1) --- #it.element.body]
      }
    }
  }
  
  show outline: set outline(title: align(center, "Содержание"), 
                            target: selector(heading.where(level: 1))
                            .or(heading.where(level: 2))
                            .or(heading.where(level: 3)))
  show outline: it => {
    it
    counter(heading.where(level: 1)).update(0)
  }
  set math.equation(numbering: num => {
    let arr = counter(heading).get()
    if arr.len() >= 2 {
      numbering("(1.1.1)", ..arr.slice(0, 1), num)
    }
    else {
      numbering("(1.1.1)", ..arr, num)
    }
  }, supplement: none)
  set figure(
    supplement: none
  )
  show figure.where(kind: image): it => {
    let arr = counter(heading).get()
    it.body
    set text(size: 12pt, weight: "black")
    v(-12pt)
    [
      Рисунок #arr.slice(0, arr.len()).map(str).join(".").#counter(figure.where(kind: image)).get().first() --- #it.caption
    ]
  }
  show figure.where(kind: table): it => {
    let arr = counter(heading).get()
    set text(size: 12pt)
    align(left, h(-1.25cm) + emph[
      Таблица #arr.slice(0, arr.len()).map(str).join(".").#counter(figure.where(kind: table)).get().first() --- #it.caption
    ])
    v(-10pt)
    it.body
    v(-20pt)
    h(1.25cm)
  }
  show figure.where(kind: table, supplement: [Листинг]): it => {
    it.body
  }
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      show regex("\("): _ => {}
      show regex("\)"): _ => {}
      link(it.target)[#it]
    } else if it.element != none and it.element.supplement == [Листинг] {
      context {
        link(it.target)[#appendix-num(counter(heading.where(level: 4)).at(it.target).first()).#counter("code").at(it.target).first()]
      }
    } else if it.element != none and it.element.body.func() == image {
      context {
        let arr = counter(heading).at(it.target)
        link(it.target)[#arr.slice(0, arr.len()).map(str).join(".").#counter(figure.where(kind: image)).at(it.target).first()]
      }
    } else if it.element != none and it.element.body.func() == table {
      context {
        let arr = counter(heading).at(it.target)
        link(it.target)[#arr.slice(0, arr.len()).map(str).join(".").#counter(figure.where(kind: table)).at(it.target).first()]
      }
    } else {
      it
    }
  }
  show math.equation.where(block: true): it => {
    set block(breakable: true)
    set text(font: "Cambria Math")
    v(14pt)
    it
    h(1.25cm)
  }
  
  doc
}


#let next-page-table(next-page-content: [], label-name, ..table-args) = context {
  show figure.where(kind: table): set block(breakable: true)
  show figure.where(kind: table): set figure(caption: none)
  show figure.where(kind: table): it => {
    align(left, it);
  }
  let columns = table-args.named().at("columns", default: 1)
  let column-amount = if type(columns) == int {
    columns
  } else if type(columns) == array {
    columns.len()
  } else {
    1
  }

  // Counter of tables so we can create a unique table-part-counter for each table
  let table-counter = counter("code")
  table-counter.step()

  // Counter for the amount of pages in the table
  // It is increased by one for each footer repetition
  let table-part-counter = counter("table-part" + str(counter(heading).get().at(3)) + str(table-counter.get().first()))
  show <table-header>: _ => {
    table-part-counter.step()
    set text(font: "Times New Roman", size: 12pt)
    context {
      if table-part-counter.get().first() == 1 {
        emph(next-page-content.at(0))
      }
      else if table-part-counter.get() != table-part-counter.final() {
        v(-6pt)
        emph(next-page-content.at(1))
      }
      else {
        v(-6pt)
        emph(next-page-content.at(2))
      }
    }
  }

  [#figure(table(
    table.header(
      // The 'next page' content spans all columns and has no stroke
      // Must be selectable by the show rule above which hides it at the last page
      table.cell(colspan: column-amount, stroke: none, [#next-page-content <table-header>])
    ),
    ..table-args,
    stroke: luma(50%),
  ), supplement: [Листинг]) #if label-name != none {label-name}]

  // Compensate for the empty footer at the last page of the table
  v(-measure(next-page-content.last()).height)
}

#let simple-code(code-content, name, label: none) = {
  context [
    #let num = appendix-num(counter(heading).get().at(3)) + "." + str(counter("code").get().first() + 1)
  #next-page-table(
    next-page-content: ("Листинг " + num + h(6pt) + sym.dash.em + h(6pt) + name, "Продолжение Листинга " + num, "Окончание Листинга " + num),
    columns: 1,
    label,
    code-content
  )
  ]
}