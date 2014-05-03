---
layout: post
title:  "Logistic Regression Algorithm（ロジスティック回帰）[機械学習]"
date:   2014-04-27 17:34:49
categories: [Machine Learning]
---
  
今まで線形モデルの Perceptron[link] と Linear Regression[link] に関して勉強してきました。今回は、新しい線形モデルである Logistic Regression に関して勉強したので、Python で実装しました。

### 導入

Logistic Regression は、 Logistic Regression は Perceptron と Linear Regression のちょうど間に位置すると言ってもいいです。Perceptron は、アウトプットとして、+ か - のようにバイナリの結果を返しました。[ h(x] = sign(w(t)x) ] Liner Regression は、実数の値を返しました。[ h(x) = w(t)x ] これらに対して、今回の新しいモデルである Linear Regression は 0 から 1 の範囲の確率を返します。[ h(x) = theta(w(t)x ] ここでの theta関数は、theta(s) = e^s / 1 + e^s と便宜的に、0 から 1 を返すように設定します。（ロジスティクス関数) x が大きくなればなるほど、アウトプットは 1 に近くなります。逆に小さくなればなるほど、0 に近くなります。

![](http://3.bp.blogspot.com/-hGdelr5rUGA/U1xLvq9htbI/AAAAAAAAASs/Z_kwywA6Uro/s1600/Screen+Shot+2014-04-21+at+11.43.44+AM.png)

次にコスト関数と、その関数の Gradient を見ていきます。まず、コスト関数は、

![](http://3.bp.blogspot.com/-fHn7IldvFGQ/U1xL3L4AU6I/AAAAAAAAAS0/xYBGOCW-WPQ/s1600/Screen+Shot+2014-04-26+at+12.10.57+PM.png)

その Gradient は、確率的勾配降下法というもので、

![](http://1.bp.blogspot.com/-pHSHUjS2jwg/U1xL-bDegYI/AAAAAAAAAS8/CCZsoqBu-sk/s1600/Screen+Shot+2014-04-26+at+12.11.49+PM.png)

です。そもそも確率的勾配降下法とは、Linear Regressioの際に使用した、最急降下法をよりシンプルにしたものです。通常の勾配法では、データ分だけパラメータ（w）を更新するために微分する必要があります。しかし、確率的勾配降下法では、データ分の和を計算する過程を省きます。ここでの”確率的”とは、乱数を使い実行の度に結果が異なるということを表現しています。このアルゴリズムを使用し、パラメータの更新式は、

![](http://1.bp.blogspot.com/-lQ8kkSVfXeI/U1xMFpEuZTI/AAAAAAAAATE/Xm2c1pT38To/s1600/Screen+Shot+2014-04-26+at+12.22.53+PM.png)

となります。

Convex function なので local minimum に収束するこの手法でも global minimum であることが保証されています。また、学習率である eta を少しずつ小さくしていきます。下記のグラフのように、eta が大きいと最適な値を飛ばしてしまい学習が安定せず、小さすぎると非効率です。そのため eta をはじめは 0.1 程度の設定し、学習が進むにつれて小さくするというのが一般的のようです。

![](http://2.bp.blogspot.com/-mwq-AqGG4h8/U1xMLNLzwPI/AAAAAAAAATM/_KXT1ToLnRc/s1600/Screen+Shot+2014-04-26+at+5.04.25+PM.png)

### 実装

Pythonで実装した内容がこちらです。 

{% highlight python linenos %}
#-*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np

# 特徴関数
#
#
def phi(x, y):
    return np.array([x, y, 1])

# シグモイド関数
#
#
def sigmoid(z):
    return 1.0 / (1 + np.exp(-z))

###############################################

# BY using other data set
data = np.loadtxt('ex2data1.txt', delimiter=',')

X = data[:, 0:2]
Y = data[:, 2]
N = Y.size;
w = np.random.randn(3)  # パラメータをランダムに初期化
eta = 0.1 # 学習率の初期値

for i in xrange(400):
    list = range(N)

    np.random.shuffle(list)

    for n in list:
        x_n, y_n = X[n, :]

        t_n = Y[n]

        # 予測確率
        feature = phi(x_n, y_n)
        predict = sigmoid(np.inner(w, feature))
        w -= eta * (predict - t_n) * feature

    # イテレーションごとに学習率を小さくする
    eta *= 0.9

# 図を描くための準備
seq          = np.arange(0, 120, 0.1)
xlist, ylist = np.meshgrid(seq, seq)
zlist        = [sigmoid(np.inner(w, phi(x, y))) for x, y in zip(xlist, ylist)]

# 散布図と予測分布を描画
plt.imshow(zlist, extent=[0,120,0,120], origin='lower', cmap=plt.cm.PiYG_r)
plt.plot(X[Y==0,0], X[Y==0,1], 'x', color='blue')
plt.plot(X[Y==1,0], X[Y==1,1], 'o', color='red')
plt.legend(['Not admitted', 'Admitted'])
plt.show()
{% endhighlight %}

![](http://3.bp.blogspot.com/-cLu3UcoILC0/U1xMXAvIyGI/AAAAAAAAATU/IuOpZkAwkio/s1600/Screen+Shot+2014-04-26+at+5.10.27+PM.png)

### 参考

1. [Gihyo.jp : 第16回　最適化のための勾配法](http://gihyo.jp/dev/serial/01/machine-learning/0016)
2. [Gihyo.jp : 第18回　ロジスティック回帰](http://gihyo.jp/dev/serial/01/machine-learning/0018)
3. [Gihyo.jp : 第19回　ロジスティック回帰の学習](http://gihyo.jp/dev/serial/01/machine-learning/0019)
4. [Gihyo.jp : 第20回　ロジスティック回帰の実装](http://gihyo.jp/dev/serial/01/machine-learning/0020)
5. [Machine Learning with Python - Logistic Regression](http://aimotion.blogspot.com/2011/11/machine-learning-with-python-logistic.html)
6. [Caltech  : Lecture 9 (The Linear Model II )](http://www.amlbook.com/slides/iTunesU_Lecture09_May_01.pdf)