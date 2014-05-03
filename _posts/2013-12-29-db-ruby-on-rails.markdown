---
title: "ワイルドカードを使ってDBの検索 [ Ruby on Rails ]"
layout: "post"
date: "2013-12-29 22:50:00"
categories: [Ruby on Rails]
---

大量のモデルからワイルドカードを使って特定のモデルを検索したいことがあると思います。以下、その方法のメモです。

{% highlight ruby linenos %}
@mathList = Course.find(:all, :conditions => ["name like ?", "MATH%"]) %>
{% endhighlight %}

上記のように like を使います。この例では、ある大学の授業から授業名に MATH が入っているモデルを抽出しています。最後の % もポイントですね。