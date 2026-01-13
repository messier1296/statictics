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


= 変数変換

#v(2em)

== 変数変換による確率密度関数の変化


#v(2em)

連続確率変数$X$の確率密度関数を$f(x)$とする.ここで$X$と1対1対応する新たな確率変数$Y = g(X)$について考える.ただし$g(X)$は微分可能で単調増加する関数とする.
$
P(Y <= y) &= P(g(X) <= y)\
&= P(X <= g^(-1) (y))
$
左辺は$Y$の累積分布関数,右辺は$X$の累積分布関数なので
$
F_Y (y) = F_X (g^(-1) (y))
$
両辺を微分して
$
f_Y (y) &= d/ (d y) F_X (g^(-1) (y))\
&= f_X (g^(-1) (y)) d/(d y)g^(-1) (y)\
&= (f_X (g^(-1) (y)))/ (g'(x)) \
&= (f_X (g^(-1) (y))) / abs(g'(g^(-1) (y))) "  (because " x = g^(-1) (y)")"
$
が得られた.単調減少の場合$g'(x) < 0$となるため、一般化して絶対値で表現されている.

#cut()

2変数$X,Y$の確率密度関数を$f(x,y)$とし,変数変換$(Z,W) = (u(X,Y),v(X,Y))$について考える.ただし逆変換$(X,Y) = (s(Z,W),t(Z,W))$が存在するものとする.この変換のヤコビアンは
$
J(z,w) = (partial (x,y) )/ partial(z,w) = det mat((partial s) / (partial z), (partial s) / (partial w);(partial t) / (partial z),(partial t) / (partial w))
$
と計算される.$(Z,W)$の確率密度関数は
$
f_(Z,W) (z,w) = f_(X,Y) (s(z,w),t(z,w)) abs(J(z,w)) 
$
として与えられる.

#v(4em)
== 確率変数の線形結合の分布
#v(2em)

2つの独立な確率変数$X,Y$についてその線形結合$a X + b Y$の分布について考える.$a X + b Y $のモーメント母関数$E[e^(theta(a X + b Y ))] = E[e^(theta a X)] E[e^(theta b Y)]$を計算し,既存の分布のモーメント母関数と一致するか調べる方法がある.しかしこの方法では導出されたモーメント母関数が未知の場合求めたい分布$a X +b Y$を求める事ができない.
そこで先程の変数変換を用いて導出する事ができる.

$Z = a X + b Y ,W = Y$とし$(Z,W)$の分布を考える.逆変換は$(X,Y) = ((Z - b W) / a,W)$でありヤコビアンは
$
J(X,Y) = abs(mat((partial Z)/(partial X),(partial Z) / (partial Y) ; (partial W) / (partial X),(partial W)/ (partial Y))) = abs(mat(a,b;0,1)) = a
$
となる.

$(Z,W)$の確率密度関数は$(X,Y)$が独立なので
$
f_(Z,W) (z,w) =(f_X ((z-b w)/a) f_Y (w) )/ abs(a)
$
になる.
$W$について積分することで$Z$の確率密度関数が得られる
$
f_Z = 1 / abs(a) integral_(-infinity) ^ infinity f_X ((z-b w)/a) f_Y (w)  d w
$

#cut()

積が積み重なることで得られるデータは対数を取ることで正規分布になることがある.この際は*対数変換*を行うとよい.人口,株価,所得などのデータには対数変換が行われる事が多い.目的変数が$x>0$の場合にのみ使える.

裾野が長い極端な分布を正規分布に従うようにする方法としては*べき乗変換*もある.$x^a$という変換をおこなう.
この際$a$の値をどのような値にするかも重要な問題となる.

- ex) 簡単なテストの点数の分布を取りたい場合に$a = 2$の変換を行うことで僅かな点数の違いを大きくして正規分布に近づける.

べき乗変換と対数変換をひとまとめにした変換として*Box-Cox変換*がある.パラメータ$lambda$に対して
$
y(lambda) = cases((x^lambda - 1 )/lambda (lambda eq.not 0),log x (lambda = 0))
$

という変換である.$lambda eq.not 0$の場合$x = 1$周辺を$0$付近にして$x = 1$付近で微分が1になり,$lambda = 0$の場合対数変換と滑らかにつながり微分可能なような変換となっている.最も正規分布に当てはまりのよい$lambda$を探索することでデータにフィットする変換を探索することができる.

確率$p$のような$0$から$1$の値しかとらないものを$-infinity$から$infinity$を取る値に変換したいときは*ロジット変換*$log (p)/(1-p)$を行う.ロジット変換を行った分布に対して線形回帰を行い予測した値を逆変換することで確率に対して回帰を行うという手法がロジスティック回帰である.これは$p$を$a + b x$の*ロジスティック変換* で表すことと同値である.

$
1/ (1 + e^(-(a + b x)))
$

$0$から$1$までの範囲しか取らないものを$-infinity$から$infinity$を取る値に変換する方法として*プロビット変換*がある.プロビット変換は標準正規分布の累積分布関数$Phi(x) = integral_(-infinity) ^ x 1/ sqrt(2 pi) exp(-t^2/2) d t$の逆関数$Phi^(-1)(x) $によって変換する方法である.