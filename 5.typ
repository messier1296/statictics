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
  P (Y= y) = binom(n, y) p^y q^(n-y),y = 0,1,dots,n
$
となる.

期待値,分散,確率母関数は
$
  E[Y] = n p, V[Y] = n p q, G(s) = (p s + q)^n
$
である.


$ G(s) = E[s^Y] = E[s^(X_1) dots s^(X_n)] = E[s^(X_1) dots s^(X_n)] = E[s^(X_1) ] times dots times E[s^(X_n)] = (E[s^(X_1)])^n = (p s + q)^n $によって求まる.

二項分布には再生性と呼ばれる以下の性質がある.

$Y_1 ~ B i n(n_1,p),Y_2~B i n(n_2,p)$で$Y_1,Y_2$が独立ならば$Y_1 + Y_2 ~ B i n(n_1 + n_2,p)$となる.

これは$Y_1 + Y_2$の確率母関数が$E[s^(Y_1 + Y_2)] = E[s^(Y_1)]E[s^(Y_2)] = (p s + q)^(n_1 +n_2)$となり$B i n(n_1 + n_2,p)$の確率母関数に一致することからわかる.

== 超幾何分布

総数$N$,当たりの数が$M$の抽選を$n$回行い当たりの数を確率変数$X$で表現することを考える.
$n = 1$の場合$B i n(1,N/M)$のベルヌーイ分布となることがわかる.

$n eq.not 1$の場合復元抽出なら二項分布$B i n(n,N/M)$となる.
非復元抽出の場合の$X$の分布を*超幾何分布*といい,$H G(N,M,n)$で表す.
確率変数は
$
  P(X = x) = (binom(M, x) binom(N-M, n-x)) / binom(N, n)
$
となる.
分母は$N$個のなかから$n$個引くときの組み合わせの総数,分子は$M$個の当たりから$x$個引く組み合わせと$N-M$個の外れから$n-x$個引く組み合わせの積である.

この確率関数において$M/N,n$を一定の状態で$N arrow infinity$とすると二項分布に収束する.

#v(2em)

証明
$
  P(X =x) &= (binom(M, x) binom(N-M, n-x)) / binom(N, n) \
  &= M! /(x! (M-x)!) times (N-M)!/((n-x)!{N-M - (n-x)}!) times (n!(N-n)!)/ N!\
  &= binom(n, x) M! /(M-x)! times (N-M)!/{N-M - (n-x)}! times (N-n)!/ N\
  &= binom(n, x) times (M dots (M-x + 1) times (N-M)dots {N-M-(n-x) + 1}) /( N dots (N - n + 1))\
  &= binom(n, x) times (M / N dots (M/ N-x/N + 1/N) times (1-M/N)dots {1-M/N-(n/N-x/N) + 1/N}) /( 1 dots (1 - n/N + 1/N))\
  N arrow infinity &= binom(n, x) (M / N)^x (1-M/N)^(1-x)\
$

$M/N$を$p$と置くとこれは$B i n(n,p)$の確率関数となる.$qed$

$H G(N,M,n)$の期待値と分散は
$
  E[Y] = n M/N,#h(2em)V[Y] = n M/N (1-M/N) times (N-n)/(N-1)
$

導出

$X = X_1 + X_2 + dots X_n$とする.
$X_i (1<=i<=n)$は$i$回目の抽選で当たりが出れば$1$,外れが出れば$0$となる.
$E[X] = E[X_1 + X_2 + dots + X_n] = E[X_1] + E[X_2] + dots + E[X_n]$であり各$X_i$において当たりが出る確率はすべて等しく$M/N$である.
$E[X_i] = M/N$となるため$E[X] = n M/N$である.

$
  V[X] & = E[X^2] -E[X]^2 \
       & = E[X(X-1)] - E[X]^2 + E[X]
$

$E[X(X-1)]$について考える.
$
  X^2 & = (limits(sum)_(i=1)^n X_i) (limits(sum)_(j=1)^n X_j) \
      & = limits(sum)_(i=1)^n X_i^2 + limits(sum)_(i eq.not j) X_i X_j \
$
$X_i =0$または$1$なので$X_i^2 = X_i$
よって
$
  E[X(X-1)] = limits(sum)_(i eq.not j) E[X_i X_j]
$

$E[X_i X_j]$は「$i$回目も$j$回目も当たりを引く確率」なので
$
  E[X_i X_j] & = P(X_i = 1) P(X_j = 1|X_i = 1) \
             & = M/N (M-1) /(N-1)
$

$i eq.not j$は異なる$i,j$の選び方なので
$
  E[X(X-1)] & = n(n-1) M/N (M-1) /(N-1)
$

以上より
$
  V[X] & = n(n-1) M/N (M-1) /(N-1) - (n M/N)^2 + n M/N \
       & = n M/N (1-M/N) times (N-n)/(N-1)
$

== ポアソン分布

二項分布を用いて以下の事象を考えるとする.

- ex) 一日にある地点で事故が起こる確率を$p$とする.この地点で一年間に事故が起こる回数$x$の確率変数を求めたい.(一日に事故が起こるのは一回までである.)

この事象について素朴に考えると以下のような確率関数になる.
$
  P(X = x) = binom(365, x) p^x (1-p)^(365-x)
$



現実には1日に2回以上事故が起きる可能性もあり、時間は連続的である.
より厳密に議論するために、期間を1日単位ではなく、時間、分、秒……と無限に細かく分割すること（$n arrow infinity$）を考える.

このとき、分割を細かくしても1年間の平均事故発生件数は変わらない.
二項分布 $B i n(n,p)$ の期待値は $n p$ であるため,この期待値 $n p = lambda$ を一定に保った状態で $n arrow infinity$ （それに伴い $p = lambda/n arrow 0$）とする極限を考えればよい.

$
  P(X = x) & = binom(n, x)p^x (1-p)^(n-x) \
           & = binom(n, x) (lambda/n)^x (1-lambda/n)^(n-x) \
           & = 1/x! (n(n-1) dots (n - x + 1))/n lambda^x (1-lambda/n)^(n-x) \
           & = lambda^x / x! e^(-lambda) (n arrow infinity)
$

こうして得られた$X$の分布は*ポアソン分布*$P o(lambda)$である.

ポアソン分布の確率母関数は
$
  G[s] & = E[s^X] \
       & = e^(-lambda) limits(sum)_(x=0)^infinity (lambda s)^x/ x! \
       & = e^(lambda (s-1))
$

である.

$
  G'(s) = lambda e^lambda(s-1),#h(3em),G''(s) = lambda^2 e^lambda(s-1)
$

を用いるとポアソン分布の期待値と分散は
$
  E[X] = lambda,#h(2em) V[X] = lambda
$
である.

ポアソン分布にも二項分布と同様の再生性がある.($Y_1 ~ P o(lambda_1) ,Y_2~P o(lambda_2)$で$Y_1,Y_2$が独立なとき$Y_1 + Y_2 ~ P o(lambda_1 + lambda_2)$)

== 幾何分布

成功確率$p(0<p<1)$,失敗確率$q = 1-p$とする.このような独立なベルヌーイ試行を繰り返したとき初めて成功するまでに起こる失敗の回数を$X$とする.
$X$の分布を*幾何分布*といい$G e o(p)$で表す.

確率関数は
$
  P(X = x) = p q^x,x = 0,1,2dots
$

のように等比数列で表される.

確率母関数は
$
  G(s) & = E[s^X] \
       & =limits(sum)_(x=0)^infinity s^x p q^x \
       & =p / (1-q s),|s| < 1/q
$
である.

$
  G'(s) = p q /(1-q s)^2
  #h(2em)
  G''(s) = (2 p q^2) /(1-q s)^3
$
より期待値と分散は
$
  E[X] = q/p
  #h(2em)
  V[X] = q/p^2
$

幾何分布の*無記憶性*と呼ばれる性質として$X~G e o(p)$のとき
$
  P(X>= t_1 + t_2 |X>= t_1) = P(X>=t_2)
  #h(2em)
  t_1,t_2 = 0,1,2dots
$
がある.
これは未来の試行の確率はそれまでの結果に依存せず決定されるということである.

証明

$P(X>=x)$は$x$回連続で失敗する確率なので
$
  P(X >= x) = q^x
$
である.

$
  P(X >= t_1 + t_2|X>=t_1) & = P(X>=t_1 + t_2) / P(X>=t_1) \
                           & = q^(t_1 + t_2) / q^(t_1) \
                           & = q^(t_2) \
                           & = P(X >= t_2)
                             #h(2em)
                             qed
$


== 負の二項分布

$0<p<1$とし$r$は正の整数とする.
成功確率$p$の独立なベルヌーイ試行を繰り返し行い,$r$回目の成功が起こった時点でそれまでに起きた失敗の回数を$X$とする.
$X$の分布を*負の二項分布*といい,$N B(r,p)$と表す.
特に$N B(1,p)$は幾何分布$G e o(p)$である.

確率関数は$q = 1-p$を用いて
$
P(X=x) =attach(H,bl:r,br:x) p^r q^x
$

で表される.
ここで$attach(H,bl:r,br:x)$は$r$個の異なるものの中から重複を許して$x$個取り出す組み合わせ(重複組み合わせ)の総数である.
これは非負整数$x_1 +  dots + x_r = x$の解の総数に等しい.
具体的には
$
attach(H,bl:r,br:x) = attach(C,bl:x+r-1,br:x) = ((y+r - 1)(y+r-2) dots (r+1)r) / y! 
$
である.
$r + x -1$回の試行で正解が$r-1$回,失敗が$x$回起こり,$y+r$回目の試行で成功が起こる場合の組み合わせを求めれば良い.
これは「一回目の成功より前」,「一回目の成功と二回目の失敗の間$dots$「$r-1$回目の成功より後」のように$r$個の異なる期間の中から重複を許して$y$個の失敗を挿入すると考えるとわかりやすい.

*負の二項分布*の確率母関数は

$
G(s) &= E[s^X]\
&= limits(sum)_(x=0) ^infinity  s^x  attach(C,bl:x+r-1,br:x) p^r q^x\
&= p ^r limits(sum)_(x=0) ^infinity attach(C,bl:x+r-1,br:x) (q s)^x\
&= (p / (1-q s) )^r limits(sum)_(x=0) ^infinity attach(C,bl:x+r-1,br:x) (1-q s) )^r (q s)^x\
&= (p / (1-q s) )^r
$

最後の式変形は$q s = p',1-q s = q'$と置くと$limits(sum)_(x=0) ^infinity attach(C,bl:x+r-1,br:x) q'^r p'^x$となり負の二項分布の総和の形になりこれは$1$であることを利用している.

$X_1 dots X_r$が互いに独立に幾何分布$G e o(p)$に従うとき$X_1 + dots + X_r$の分布$N B(r,p)$に従うことが予想される.
$X_1 + dots X_r$の確率母関数は二項分布のときと同様にして$E[s^(X_1 + dots X_n)] = E[s^(X_1)]^r = (p / (1-q s) )^r$である.
幾何分布の確率母関数と一致することからこの2つは一致することがわかった.

負の二項分布の期待値,分散は
$
E[Y] = (r q) / p 
#h(2em)
V[Y] = (r q)/p^2
$
である.

$X_1 + dots + X_r ~ G e o(p) i.i.d$に対して$X = X_1 + dots + X_r$となることと$E[X_1] = q/ p ,V[X_1] = q/p^2$であることからわかる.