---
title: "link_to の引数 - routes.rb [ Ruby on Rails]"
layout: "post"
date: "2013-12-12 05:41:00"
categories: [Ruby on Rails]
---

RoRのルーティングに関していくつか新しいことを知ったのでメモ。

### ルーティン情報の表示

{% highlight ruby linenos %}
# routes.rb の情報を表示！！
$ rake routes
{% endhighlight %}


### link_to の引数

よくRoRでリンクを作成するときに <%= link_to “blabla", blabla %> みたいに使う。一つ目の引数はリンクの文字。二つの引数がURLに関するもの。二つ目の引数にいつも何を渡せばいいのか分からなかった。これは、上記の routes.rb の情報を確認するコマンドを打ち、一番左の prefix のカラムの変数？を渡す。resources :blabla で RESTful なモデルを作成した場合は、型が決まっている。[ドキュメント](http://railsdoc.com/references/resources)に詳細あり。
自分で routes.rb の中で match を作成した時には、as: で自分で指定する。例えば、 

{% highlight ruby linenos %}
match 'students/:id/q1' => 'students#q1', via: 'get', as: 'q1'
{% endhighlight %}

とした時には、studentsコントローラーのq1アクションにアクセスする。この最後の as: がポイントで、これにより<%= link_to ~~~ %>で使える値を指定している。この例ならば、 

{% highlight ruby linenos %}
<%= link_to "1st Quoter", q1_path(@current_student) %>
{% endhighlight %}

q1_path として使える。