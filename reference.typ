#set text(font:"Noto Serif CJK JP")
#set page(numbering: "-1-")
#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif CJK JP"))
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#show heading: set align(center)
#show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
        // 数式の場合はリンク（番号）のみを表示
        link(el.location(), numbering(el.numbering, ..counter(eq).at(el.location())))
    } else {
        it
    }
}

#let cut() = {
    line(length: 100%, stroke: 0.5pt + gray)
}


統計学実践ワークブック

数学の景色

https://mathlandscape.com/bayes-theorem/