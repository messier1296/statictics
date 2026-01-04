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


= 確率変数と母関数

#v(2em)

== 累積分布関数と生存関数

#v(2em)

#frame("累積分布関数", [
  確率変数$X$の*累積分布関数*$F(x)$は$F(x) = P(X<=x)$で表される.$X$が離散確率変数であれば$F(t) = limits(sum)_(x<=t) p(x)$となり,連続確率変数であれば$F(t) = integral_(-infinity)^t f(x) d x$となる.
])

連続な場合$f(x) = F'(x)$で確率密度関数を得られ,離散の場合$p(x) =F(x) - F(x-)$で確率関数を得られる.($F(x-) = limits(lim)_(t arrow x) F(t)$)

#cut()

#frame("生存関数", [
  確率変数$X$をあるものの寿命を表すとする.このとき$S(x) = 1 - F(x)$は時刻$x$でまだ生きている確率を示し,$S(x)$を*生存関数*と呼ぶ.
])

#frame("ハザード関数", [
  $
    h(x) = f(x) / (1- F(x)) = (-log(S(x)))'
  $
  を*ハザード関数*と呼ぶ.ハザード関数はある時刻$x$で生存しているもののうちその後短時間に死亡するものの割合を示す.
])

ハザード関数は機械がどのぐらいの期間で壊れるかや人間の寿命などを計算する際に用いられる.

#v(4em)

== 同時確率密度関数
#v(2em)

#frame("同時確率関数",[
    $X,Y$を確率変数とするとき,$X=x$,$Y=y$となる確率を
    $
    p(x,y) = P(X=x,Y=y)
    $
    と表し,*同時確率変数*と呼ぶ
])

また$X<=x$,$Y<=y$となる確率
$
F(x,y) = P(X <= x, Y <= y) = sum_(x' <= x, y'<= y) p(x',y')
$
を*累積分布関数*と呼ぶ.

$P(X=x) = limits(sum)_y P(X=x,Y=y)$であるから
$
p_X (x) = sum_y p(x,y)
$
である.$X$のみの分布を*周辺分布*とよび,$p_X (x)$を*周辺確率関数*と呼ぶ.また$X=x$が与えられたときに$Y=y$となる条件付き確率は
$
P_(Y|X) (y|x) = p(x,y) / (p_X (x))
$
であり$P_(Y|X)(y|x)$を*条件付き確率関数*と呼ぶ.

n個の確率変数$X_1 dots X_n$についても同時確率関数$p(x_1 dots x_n)$などは同様に定義される.

#cut()

連続確率変数の場合を考える.$X,Y$を連続確率変数として$F(x,y) = P(X <= x, Y<= y)$を累積分布関数とする.
#frame("同時確率密度関数",[
    $X,Y$の*同時確率密度関数*$f(x,y)$は$F(x,y)$を$x,y$でそれぞれ偏微分して
    $
    f(x,y) = partial ^2 / (partial x partial y) F(x,y)
    $
])
と定義される.
重積分を考えると
$
P(x_1 < X <= x_2,y_1 < Y <= y_2) = integral_(x_1) ^x_2 integral_(y_1) ^y_2 f(x,y) d x d y
$
で長方形領域の確率が与えられる.

$X$の*周辺確率密度関数*は
$
f_X (x) = integral_(-infinity) ^infinity f(x,y) d y
$
で与えられ,$X=x$を所与としたときの$y$の*条件付き確率密度関数*は
$
f_(Y|X) (y|x) = f(x,y) / (f_X (x))
$
で与えられる.
$n$個の連続確率変数についても2変数の場合と同様に
$
F(X_1 dots X_n) = P(X_1 <= x_1 dots X_n <= x_n)\
f(x_1 dots x_n) = partial^n / ( partial x_1 dots partial x_n) F(x_1 dots x_n)
$
で与えられる.

#cut()

三変数$X,Y,Z$について
$
f_(X,Y|Z) (x,y|z) = f_(X|Z) (x,z) f_(Y|Z) (y,z)
$
が成り立つとき$Z=z$のもとで$X,Y$は条件付き独立である.

#v(4em)

== 母関数

#v(2em)

#frame("確率母関数",[
  $X$の確率母関数を
  $
  G(s) = E[s^X] = sum_(k=0) ^infinity s^k p(k)
  $
  と定義する
])

$G(1) = 1$であるため収束半径は1以上であり$|s| <= 1$の範囲で常に$G(s)$は収束する.それ以外の範囲では収束が保証されないがここでは右辺が収束すると仮定する.()
Gを微分すると$G'(s) = E[X s ^ (X-1)],G''(s) = E[X(X-1) s^(X-2)]$
である.ここで$s=1$とすると
$
G'(1) = E[X],G''(1) = E[X(X-1)]
$
となる.

これから$X$の期待値と分散は
$
E[X] = G'(1) V[X] = G''(1) + G'(1) -(G'(1))^2
$
となる.

#frame("モーメント母関数",[
  モーメント母関数$m(theta)$は確率母関数に置いて$s = e^theta$とおいたもので
  $
  m(theta) = E[e^(theta X) ] = G(e^theta)
  $
  で与えられる.
])

確率母関数は$limits(sum)_(k=0) ^infinity s^k p(k)$というべき級数の形で得られる一方モーメント母関数は
$
m(theta) = integral_infinity ^infinity e^(theta x) d x 
$
という積分で得られる.このような違いから両者は同じ母関数ではあるがモーメント母関数は主に連続確率変数に用いられる.

モーメント母関数を微分すると$m'(theta) = E[X e ^theta X],m''(theta) = E[X^2 e^theta X]$となり$theta = 0$を代入すると
$
m'(0)  = E[X] , m''(0) = E[X^2] ... m^((k)) = E[X^k] 
$
のように原点周りのモーメント(積率)が得られる.

モーメントは物理学のモーメントを抽象化した概念で,力学では原点から距離$x$の場所に質量$m$の物体がある時原点周りの力のモーメントが$x m$と表現される.これを用いると
$
  ("重心")  = (sum x_i m_i) / (sum m_i)
$
$
  E[X] = sum x_i p(x_i)
$
のように確率では$sum p(x_i) = 1$なため分母が省略されているが力学の重心と確率の平均が対応している.

モーメント母関数では$0$を含むある開区間のすべての$theta$について$m(theta)$を定める広義積分,あるいは無限和が収束すると仮定する.

ここで広義積分の収束問題を回避するために$theta$に純虚数$i t$を代入した$phi(t) = m(i t)$を*特性関数*と呼ぶ.

これらの母関数の性質として
+ 確率分布と1対1対応
+ 独立な変数の和が母関数の積に対応

という2つの性質が重要である.

ex)

+ ある確率分布$X$のモーメント母関数が正規分布のモーメント母関数と一致するとき$X$は正規分布と一致するといえる
+ 独立な確率変数$X_1,X_2$のモーメント母関数を$m_1(theta),m_2(theta)$とするとき$X_1 + X_2$のモーメント母関数$m(theta)$は$m(theta) = m_1(theta) m_2(theta)$のようにそれぞれのモーメント母関数の積で表される
$
(m(theta) = E[e^(theta(X_1 + X_2))] = E[e^(theta X_1) e^(theta X_2)] = E[e^(theta X_1)] E[e^(theta X_2)] = m_1(theta) m_2(theta))
$