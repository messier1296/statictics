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

= 分布の特性値

#v(4em)

== 確率変数の分布の特性値

#v(2em)

確率変数$X$の確率密度関数を$f(x)$、分布関数を$F_X(x)$とする.

このとき中央値と最頻値は以下のように定義される.

- 中央値 : $F_X(m) = 0.5$ となる $m$ （または $P(X<=m) = 0.5$）
- 最頻値: $f(x)$ が最大となる $x$

また、標準偏差と四分位範囲は以下のように定義される.

- 標準偏差: $sigma = sqrt(V[X])$
- 四分位範囲: 第3四分位数と第1四分位数の差
  $ P(X<=Q_3) = 0.75, quad P(X<=Q_1) = 0.25 "となる" Q_3 - Q_1 $

ここで、分布関数 $F_X(x)$ の逆関数 $F^(-1)(alpha) = op("inf"){x | F_X(x) >= alpha}$ を$X$の*分位点関数*という. これを用いると、四分位範囲は $F^(-1)(0.75) - F^(-1)(0.25)$ と表せる.


$ sqrt(V[X]) / E[X] $
を*変動係数*と定義する. 分散は値の大きさに依存するため、平均値が大きく異なるデータ間では単純比較が難しい. 平均値で割ることでスケールの影響を除き、相対的な散らばりを比較することができる.

// 歪度と尖度
位置の指標や散らばりの指標以外の特性値として、分布の歪みの指標である*歪度*と、分布の裾の重さの指標である*尖度*がある.

$
  "歪度" = (E[(X-mu)^3]) / (V[X]^(3/2)), quad "尖度" = (E[(X-mu)^4]) / V[X]^2
$

で定義される.

歪度は平均周りの3次モーメントを用いるため、分布の非対称性を表す. 分布の裾が右側に長く伸びているほど正の大きな値を取り、左側に伸びているほど負の値を取る.

尖度は4次モーメントを用いるため値は必ず正になり、平均から大きく離れた値の影響を強く受ける. 正規分布では尖度が3になるため、尖度から3を引いた値を*超過尖度*として定義し、正規分布との乖離を表すことがある.

#v(4em)

== 同時分布の特性値

#v(2em)

2つの確率変数$X,Y$の相関を表す指標として*共分散*や*相関係数*がある.
共分散$op("Cov")(X,Y)$は
$
  op("Cov")(X,Y) = E[(X-E[X]) (Y-E[Y])] = E[X Y] - E[X]E[Y]
$
で定義される. 正の相関があるときは共分散は正になり, 負の相関があるときは共分散は負になる.
しかし, 共分散の大きさは元の確率変数の分散に依存しているため, これを基準化した
$
  rho[X,Y] = E[((X-E[X])/ sqrt(V[X])) ((Y-E[Y])/ sqrt(V[Y]))] = (op("Cov")(X,Y)) / sqrt(V[X] V[Y])
$
を*相関係数*という.

相関係数は$[-1,1]$の範囲を取り, 相関係数の絶対値が1であれば$X,Y$には一次式の関係$Y= a X + b$が成り立つ. 一方$X,Y$が独立であれば共分散, 相関係数は0になる.

#cut()

2つの確率変数$X,Y$に別の確率変数$Z$が影響を与えているときに, $X,Y$の相関は強くなりやすい. これを*疑似相関*という. このような場合, $Z$の影響を取り除いた相関を考えたい.
ある変数の影響を除いた相関係数として*偏相関係数*がある. $Z$の影響を取り除いた$X,Y$の偏相関係数は
$
  rho[X,Y|Z] = (rho[X,Y] - rho[X,Z]rho[Y,Z] ) / sqrt((1-rho[X,Z]^2)(1-rho[Y,Z]^2))
$
である.

#cut()

2つの確率変数$X,Y$について一方の変数が与えられたもとでの期待値や分散をそれぞれ*条件付き期待値*, *条件付き分散*という. $X$が与えられたもとでの$Y$の条件付き期待値は
$
  E[Y|X] = integral_(-infinity)^infinity y f_(Y|X) (y) d y
$
であり, $X$が与えられたもとでの$Y$の条件付き分散は
$
  V[Y|X] = E[Y^2|X] - (E[Y|X])^2
$
である.

== 特性値の性質

期待値の性質
$
E[a X + b Y + c] = a E[X] + b E[Y] + c \
$
また$X,Y$が独立のとき
$
E[X Y] = E[X] E[Y]
$

分散の性質

$
V[a X + b] = a^2 V[X], V[X plus.minus Y ] = V[X] + V[Y] plus.minus 2 op("Cov")[X,Y]
$

条件付き期待値の性質
$
E[E[X|Y]] = E[X]
$

$
V[X] = E[V[X|Y]] + V[E[X|Y]]
$

== データの特性値

これまで平均では$bar(x) = 1/n limits(sum)_(i=1) ^n x_i$という算術平均を用いてきたが平均にはこれ以外にもある.

*加重平均*は重み$w_1 dots w_n (w_i > 0,w_1 + dots w_n = 1)$に対する$x_1 dots x_n$の加重平均は$limits(sum)_(i=1) ^ n w_i x_i$として定義される.これは観測値x_iが割合w_iで得られる場合の全平均を計算したものである.

*幾何平均*は$x_1 dots x_n (x_i > 0)$に対して$(x_1 times dots times x_n)^(1/n)$として定義される.

*調和平均*は$x_1 dots x_n (x_i > 0)$に対して$1/x_1 + dots + 1/x_n$の平均$1/n limits(sum)_(i=1) ^ n (1/x_i)$の逆数として定義される

= 平均ベクトルと分散共分散行列

$bold(X) = (X_1 dots X_k) ^ top$をk次元確率ベクトルとする.$mu_i = E[X_i]$を要素とするk次元ベクトル$bold(mu) = (mu_1 dots mu_n)^top$を*期待値ベクトル*あるいは*平均ベクトル*と呼ぶ.また$X_i$と$X_j$の共分散$sigma_(i j) = E[(X_i - E[X_i])(X_j - E[X_j])]$を$(i,j)$要素とする行列
$
Sigma = 
mat(sigma_(1 1) ,sigma_(1 2) ,dots ,sigma_(1 k);
sigma_(2 1) , sigma_(2 2), dots , sigma_(2 k);
dots.v,dots.v, dots.down,dots.v;
sigma_(k 1), sigma_(k 2) ,dots,sigma_(k k);)
$
を*分散共分散行列*とよぶ.分散共分散行列の対角成分は$X_i$の共分散である.同様に対角要素を1として$X_i ,X_j$の相関係数$rho_(i j)$を$(i,j)$要素とする行列を*相関係数行列*あるいは*相関行列*と呼ぶ.
