#set text(font: "Noto Serif CJK JP")
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
    link(el.location(), numbering(el.numbering, ..counter(eq).at(el.location())))
  } else {
    it
  }
}
// --- デザイン用の関数定義（カラー対応版） ---
#let frame(title, body, color: eastern) = block(
  fill: color.lighten(95%), // 背景は指定色の95%明度上げ（かなり薄く）
  stroke: (left: 2.5pt + color), // 左線は指定色
  inset: (x: 1.2em, y: 1em),
  width: 100%,
  radius: (right: 4pt),
  below: 1.5em,
  breakable: true,
  [
    // タイトルがある場合、アクセントカラーで表示
    #if title != none [
      #text(fill: color, weight: "bold")[#title]
      #v(0.5em)
    ]
    #body
  ],
)
#let cut() = {
  v(1em)
  line(length: 100%, stroke: 0.5pt + gray)
  v(1em)
}

= 離散型分布

#v(2em)

== 離散一様分布

確率変数$X$が$1,2,dots,K$で等確率を取ることを考える.
$
P(X=1) = P(X=2) = dots = P(X=K) = 1/ K
$
であるとする.
このとき$X$の分布を${1,2,dots,K}$上の*離散一様分布*という.期待値と分散は
$
E[X] = (K + 1) /2 , V[X] = (K^2 - 1)/ 12
$
となる.
確率母関数は
$
G(s) = E[s^X] = (s + s^2 + dots + s^K) / K = (s(1-s^K)) / K(1-s)
$
となる.

#v(2em)

== ベルヌーイ分布

#v(2em)

2つの結果のうちどちらか一方が起こる試行を考える.一方を「成功」もう一方を「失敗」とする.成功確率$p (0 < p < 1)$とする.このような試行を確率$p$の*ベルヌーイ試行*と呼ぶ.
成功確率$p$のベルヌーイ試行に対して確率変数$X$を成功のとき$1$失敗のとき$0$と定義する.$X$はベルヌーイ試行を一回行ったときの成功回数に等しくこの$X$の従う分布を*ベルヌーイ分布*といい,$B i n(1,p)$と表す.

$B i n(1,p)$の確率変数は$q = 1 - p$として
$
P(X = x) = p^x q^(1-x) ,x = 0,1
$
かける.

期待値と分散は
$
E[X] = p, V[X] = p q
$
となる.

確率母関数は
$
G(s) = E[s^X] = p s + q s^0 = p s + q
$
となる

== 二項分布

成功確率$p$のベルヌーイ試行を$n$回行い,$i$回目($1 <= i <= n$)のベルヌーイ試行に対応する確率変数を$X_i$とする.和$X_1 + dots + X_n$は$n$回のうち何回成功したかを表す.ここで$X_1 dots X_n$が独立なときに$Y= X_1 + dots + X_n$の従う分布を成功確率$p$の*二項分布*といい$B i n(n,p)$で表す.

二項分布$B i n(n,p)$の確率関数は$q = 1-p$を用いて
$
P (Y= y) = binom(n,y) p^y q^(n-y),y = 0,1,dots,n
$
となる.

期待値,分散,確率母関数は
$
E[Y] = n p, V[Y] = n p q, G(s) = (p s + q)^n
$
である.


$
G(s) = E[s^Y] = E[s^(X_1) dots s^(X_n)] = E[s^(X_1) dots s^(X_n)] = E[s^(X_1) ] times dots times E[s^(X_n)] = (E[s^(X_1)])^n = (p s + q)^n
$によって求まる. 

二項分布には再生性と呼ばれる以下の性質がある.

$Y_1 ~ B i n(n_1,p),Y_2~B i n(n_2,p)$で$Y_1,Y_2$が独立ならば$Y_1 + Y_2 ~ B i n(n_1 + n_2,p)$となる. 

これは$Y_1 + Y_2$の確率母関数が$E[s^(Y_1 + Y_2)] = E[s^(Y_1)]E[s^(Y_2)] = (p s + q)^(n_1 +n_2)$となり$B i n(n_1 + n_2,p)$の確率母関数に一致することからわかる.