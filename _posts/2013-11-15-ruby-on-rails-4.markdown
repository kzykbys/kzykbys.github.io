---
title: "Ruby on Rails チュートリアル 4 章 | Ruby"
layout: "post"
date: "2013-11-15 22:21:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。今回は初めて触るRubyに関して。
[http://railstutorial.jp/chapters/rails-flavored-ruby?version=4.0#top](http://railstutorial.jp/chapters/rails-flavored-ruby?version=4.0#top)

### ハッシュとシンボル

ハッシュにおいてシンボルを使用する際の２つの記法
後者は Ruby1.9 からサポート。どちらもよく使われているので、両方見分けがつけるように。

{% highlight ruby linenos %}
>> h1 = { :name => "Michael Hartl", :email => "michael@example.com" }
=> {:name=>"Michael Hartl", :email=>"michael@example.com"}
>> h2 = { name: "Michael Hartl", email: "michael@example.com" }
=> {:name=>"Michael Hartl", :email=>"michael@example.com"}
>> h1 == h2
=> true
{% endhighlight %}

ハッシュのネストの例

{% highlight ruby linenos %}
>> params = {} # 'params' というハッシュを定義する ('parameters' の略)。
=> {}>> params[:user] = { name: "Michael Hartl", email: "mhartl@example.com" }
=> {:name=>"Michael Hartl", :email=>"mhartl@example.com"}
>> params=> {:user=>{:name=>"Michael Hartl",:email=>"mhartl@example.com"}}
>> params[:user][:email]
=> "mhartl@example.com”
{% endhighlight %}

ハッシュのコンストラクタは、配列等のコンストラクタと違い、デフォルト値を渡す。キーが存在しない場合に使用される。

{% highlight ruby linenos %}
>> h = Hash.new=> {}
>> h[:foo] # 存在しないキー :fooの値にわざとアクセスしてみる
=> nil
>> h = Hash.new(0) # キーが存在しない場合のデフォルト値をnilから0に変更する
=> {}
>> h[:foo]
=> 0
{% endhighlight %}

### 関数

関数の呼び出し方が少しとっつきにくいかった。丸括弧や波括弧を省略するケースがある。

{% highlight ruby linenos %}
#関数呼び出しの丸かっこは省略可能。
stylesheet_link_tag("application", media: "all", "data-turbolinks-track" => true)
stylesheet_link_tag "application", media: "all","data-turbolinks-track" => true
# 最後の引数がハッシュの場合、波括弧は省略可能。
stylesheet_link_tag "application", { media: "all", "data-turbolinks-track" => true }
stylesheet_link_tag "application", media: "all","data-turbolinks-track" => true
{% endhighlight %}

ハッシュの後者のキーが旧式のハッシュロケットになっているのは、シンボルの中ではハイフンを使うことができないため。

### クラス

Rubyの基本クラスを拡張することができる。

{% highlight ruby linenos %}
>> class String
>> # 文字列が回文であればtrueを返す
>> def palindrome?
>> self == self.reverse
>> end
>> end
=> nil
>> "deified".palindrome?
=> true
{% endhighlight %}

アクセッサメソッド

{% highlight ruby linenos %}
class User
  attr_accessor :name, :email
  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end
end
{% endhighlight %}

最初の行の attr_accessor :name, :email は、
アトリビュートアクセサをそれぞれ作成。インスタンス変数のゲッターとセッターメソッド作成する。インスタンス変数は常に @ 記号で始まり、未定義の状態では値が nil になります。

### その他

helpers/application_helper.rb にある、module ApplicationHelper とは、メソッドをまとめるもの。通常、モジュールを書き、それをその都度インクルードする必要があるが、この module ApplicationHelper の中に書くことにより、その必要性がなくなる。Rails が自動的にインクルードし、すべてのビューから参照することができる。