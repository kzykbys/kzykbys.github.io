---
title: "Heroku で css が適応されない問題"
layout: "post"
date: "2013-11-26 01:32:00"
categories: [Ruby on Rails]
excerpt: "ローカル環境で必死にコードを書き完成したと思い、いざデプロイすると動作しなかったり、レイアウトが崩れたりする程ストレスはないです。"
---

### $ rake assets:precompile

ローカル環境で必死にコードを書き完成したと思い、いざデプロイすると動作しなかったり、レイアウトが崩れたりする程ストレスはないです。

ローカルで Rails を書き、Heroku にデプロイすると css が適応されないという問題に出くわしました。調べに調べ、Heroku に関する設定等はチェックしたはずが、なかなか解決できなかったのですが、下記のコマンドを実行するとローカルと同じ環境を再現することに成功しました。

{% highlight ruby linenos %}
# もし Heroku のデプロイに失敗したときは、次のコマンドを試してみて下さい。
$ rake assets:precompile
$ git add .
$ git commit -m "Add precompiled assets for Heroku"
{% endhighlight %}

Herokuにデプロイする時に出る、このメッセージが関係あるのかな。ちょっと分からないです。 

{% highlight ruby linenos %}
-----> Writing config/database.yml to read from DATABASE_URL
             Detected manifest file, assuming assets were compiled locally
{% endhighlight %}

### 参考

[http://railstutorial.jp/book/ruby-on-rails-tutorial?version=4.0](http://railstutorial.jp/book/ruby-on-rails-tutorial?version=4.0)