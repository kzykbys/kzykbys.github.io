---
title: "Machine Learning 概要 "
layout: "post"
date: "2014-03-31 05:57:00"
categories: [Machine Learning]
---

最近、機械学習に関心があります。機械学習を利用したツイッタークライアントとか作ってみたいな。機械学習の有名な本、"Learning From Data" の著者の授業が [Youtube](https://www.youtube.com/playlist?list=PLD63A284B7615313A) で受けることが出来ます。また、Caltech のサイトには、パワポ資料等もあります。その授業の中で機械学習の概要が解説されていたので、本格的に勉強を初めて見る前に、個人的にまとめてみました。ほとんど Wikipedia からの転載です。ちょっとずつ追記あり。

![](http://4.bp.blogspot.com/-NQNeUxSUJn0/UziEBI240bI/AAAAAAAAAQ8/n53_AuEKl1M/s3200/Screen+Shot+2014-03-30+at+1.52.00+PM.png)

Map of Machine Learning [ http://work.caltech.edu/library/181.pdf ]

### Paradigms

1 . Supervised 

>> Supervised Learning とは、機械学習においてラベル化されたデータセットからある関数を推測するタスクのこと。このデータセットを解析し、関数を作成し、その関数を新しいデータをマッピングするために使用される。ラベル化されたとは、事前にデータセットに属性を付与して置くということ。例えば、顔認識の際、事前にアルゴリズムに「顔である」とラベル化された写真と、「顔でない」というラベル化されたデータを与えておく。その後、新しい未知のデータをこのラベル化された事前データを基に推測するというもの。

2 . Unsupervised 

>> Unsupervised Learning とは、隠された構造をラベル化されていないデータから発見すること。顔認識の例だと、データセットである写真群が与えられるが、どの写真が顔で、どの写真が風景ということは明示的に示されない。その代わり、このパラダイムでは、顔にある目といった特徴等を cluster する。cluster とは、あるグループに分類すること。Unsupervised Learning は Supervised Learning の precursor になり得る。

3 . Reinforcement 

>> Reinforcement Learning とは、プログラムが、ある環境においてある累積的な報酬の概念・意向を最大化するように行動すること。Reinforcement Learning に関連したテクニックの多くは dynamic programming (動的計画法) に関係しています。Supervised Learning との違いは、input/outputの正しいペアが存在しないということ。赤ちゃんが熱いカップに触ることにより、湯気が出ているカップは触るべきではないということを学ぶプロセスに似ている。触るたびに、「熱く触れない」、「この温度なら大丈夫」とフィードバックがあるが、絶対的、普遍的な「触るべき」、「触るべきでない」と言うことは難しい。強いゲームプログラム等を作成する時に有効な手法。

4 . Active 

>> Active Learning とは、Semi-Supervised Learning の特殊なケース。ラベル化されていないデータが豊富にあるが、それをラベル化することが難しい場合に使われる。Active Learning は、ラベルを能動的に user/teacher から得る。あるコンセプトを学習するための数は、Supervised Learning より少ない。能動的にデータセットを得ることで、ひとつひとつのデータの価値を最大化するからです。[Akinator](http://jp.akinator.com/) や[二十の質問](http://ja.wikipedia.org/wiki/%E4%BA%8C%E5%8D%81%E3%81%AE%E8%B3%AA%E5%95%8F)が良い例。

5 . Online 

>> Online Machine Learning とは、ある時点のある事象に関して学ぶ誘導のモデル。このパラダイムのゴールは、ある事象に対してラベルを予測すること。予測が行われた後に、正しい結果と確認することができれば、それが将来の予測に使用される。また、計算能力やストレージの制約がある場合にも活用される。

### Theory

1 . VC

>> VC dimension とは、統計的分類アルゴリズムの能力の指標。アルゴリズムが shatter できる最大のセットの基数として定義される。基数 (Cardinality)とは、セットの要素数。

2 . Bias−variance 

>> Bias–variance tradeoff とは、Bias と Variance を同時に最小化する問題のこと。Bias とは、訓練データの違いに対してどれほど、正確性を保てるか。Variance とは、モデルが訓練データの違いにどの程度敏感に反応するか。この問題は、Supervised Learning において、大きな関心。

3 . Complexity          

4 . Bayesian

### Techniques

1 . Models

- Linear
- Neural networks
- SVM (support vector machine)
- Nearest neighbors
- RBF               
- Gaussian processes
- SVD
- Graphical models 

2 . Methods 

- Regularization
- Validation
- Aggregation
- Input processing