---
title: "Perceptron (パーセプトロン) [ 機械学習 ]"
layout: "post"
date: "2014-04-05 05:06:00"
categories: [Machine Learning]
---

Perceptron は Supervised Learning における最もシンプルな線形分類アルゴリズムの一つです。あるインプットを取り、アウトプットとして +1 か -1 といったバイナリの結果を返します。この記事は、Perceptron の軽い解説と実装に関して挑戦してみます。言語は、科学計算や図表描写のライブラリが豊富にある Python を使用します。（Python とか洒落たやつだなって嫌煙していたんですが、機会学習の勉強を初めてどうしても避ける事ができませんでした。）

### Perceptron の基本コンセプト

![](http://3.bp.blogspot.com/-CLFNoOju93E/Uz-L9I4xe6I/AAAAAAAAARY/nZ6f5ZJHUfI/s1600/300px-Perceptron.svg.png)

まずは、このアルゴリズムを理解することに必要な基本的な用語等の整理をしてみます。上記の画像のように、Xセットの要素の x1…xN とインプットを取ります。そして、それらに対応した w1…wN とドット積 (dot product) により、バイナリ(+1 か -1)のアウトプットを出します。Perceptron は、Supervised なので、インプットに対応した正しいアウトプットは事前に分かっています。全てのSuperised 関連の学習がそうであるように、インプットにより学習し、未知のアウトプットを予測します。その y を求めるためには、正しい W(w1…N) を求めます。つまり、Perceptron は訓練フェーズを通じて、W を求めることが肝になります。f(x) は numpy.sign(x) 関数を使用します。この関数は、x が 0 より小さいと -1 を返し、x が 0 であれば 0、x が 0 より大きいと +1 を返します。

### Perceptron アルゴリズム

簡単に表に表示できるように、二次元の[-1, 1] × [-1, 1] の範囲に インプットを限定して実装します。コードは、[このサイト](http://datasciencelab.wordpress.com/2014/01/10/machine-learning-classics-the-perceptron/)のプログラムを少しシンプルにしたものです。

{% highlight python linenos %}
import numpy as np
import random
import os, subprocess
import matplotlib.pyplot as plt
  
class Perceptron:
    def __init__(self, N):
        # Random linearly separated data
        xA,yA,xB,yB = [random.uniform(-1, 1) for i in range(4)]
        self.V = np.array([xB*yA-xA*yB, yB-yA, xA-xB])
        self.X = self.generate_points(N)       
        self.w = np.zeros(3)
  
    def generate_points(self, N):
        X = []
        for i in range(N):
            x1,x2 = [random.uniform(-1, 1) for i in range(2)]
            x = np.array([1,x1,x2])
            s = int(np.sign(self.V.T.dot(x)))
            X.append((x, s))
        return X
{% endhighlight %}

まずは、ランダムにインプットを作成します。求めるべきファンクションは np.sign(self.V.T.dot(x)) ですね。よって s には、+1 か -1 が返されます。N はサンプルのサイズです。この例では、あまり考慮に入れていませんが、bias を別に定義することがあります。x0 に固定の 1 を保存してるため、w0 を bias として置き換え、bias を簡単に考慮することができます。

{% highlight python linenos %}
def classification_error(self, vec, pts=None):
        # Error defined as fraction of misclassified points
        if not pts:
            pts = self.X
        M = len(pts)
        n_mispts = 0
        for x,s in pts:
            if int(np.sign(vec.T.dot(x))) != s:
                n_mispts += 1
        error = n_mispts / float(M)
        return error
  
    def choose_miscl_point(self, vec):
        # Choose a random point among the misclassified
        pts = self.X
        mispts = []
        for x,s in pts:
            if int(np.sign(vec.T.dot(x))) != s:
                mispts.append((x, s))
        return mispts[random.randrange(0,len(mispts))]
  
    def pla(self, save=False):
        # Initialize the weigths to zeros
        w = self.w = np.zeros(3)
        X, N = self.X, len(self.X)
        it = 0
        # Iterate until all points are correctly classified
        while self.classification_error(w) != 0:
            it += 1            
            # Pick random misclassified point
            x, s = self.choose_miscl_point(w)
            # Update weights
            w += s*x
 
        self.w = w
        return it
{% endhighlight %}

この部分がこのアルゴリズムの肝になります。pla 関数がその本体です。まずは、調整する W をゼロに初期化します。インプットデータセットが全て正しく分類されるまで while 文で回します。classification_error 関数でエラーがあるか確認し、ループの条件を確認。もしエラーがありループが継続される場合には、choose_miscl_point 関数で間違って分類されている点をランダムに選び、W を更新します。この繰り返しで、正しく分類されるように W 調整し、終了です。実行するには、

{% highlight python linenos %}
# Execute percetron algorithm
p = Perceptron(20)
p.pla()
p.plot(p.generate_points(50), p.w, save=True)
{% endhighlight %}

とすれば OK です。

![](http://2.bp.blogspot.com/-DorLWvft0LU/Uz-NGJR_pPI/AAAAAAAAARk/tzeMyhEFHVc/s1600/Screen+Shot+2014-04-04+at+9.18.40+PM.png)

上記のような結果が得られると思います。実際に結果は、ランダムに生成しているポイントによるので、実行する度に画像とは大きく見栄えが変わります。黒い線はターゲットとなる関数です。理想とする結果です。これを推定した結果が、緑色の線です。トレーニングデータの量を増やすことにより、より精度の高い結果が得られます。黒い理想の線は、全ての点を正確に分類しています。しかし、学習の結果得た緑の線は、大きな点（インプット）は正確に分離していますが、全ての点を綺麗に分類しているわけではありません。これが学習のエラーです。おもしろいですね。リンク先のコードを自分で何度も実行し、コードを変えたりするとたくさん発見があり勉強になりますよ。

*** 

参考

<iframe frameborder="0" marginheight="0" marginwidth="0" scrolling="no" src="http://rcm-fe.amazon-adsystem.com/e/cm?t=komchax-22&amp;o=9&amp;p=8&amp;l=as1&amp;asins=0262018020&amp;ref=tf_til&amp;fc1=000000&amp;IS2=1&amp;lt1=_blank&amp;m=amazon&amp;lc1=0000FF&amp;bc1=000000&amp;bg1=FFFFFF&amp;f=ifr" style="height: 240px; width: 120px;"></iframe>

http://en.wikipedia.org/wiki/Perceptron<br />
http://datasciencelab.wordpress.com/2014/01/10/machine-learning-classics-the-perceptron/<br />
http://glowingpython.blogspot.com/2011/10/perceptron.html


