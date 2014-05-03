---
title: "Ruby on Rails チュートリアル 6 章 ( 1 ) | モデル"
layout: "post"
date: "2013-11-17 23:56:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。今回はモデルに関して。
[http://railstutorial.jp/chapters/modeling-users?version=4.0#top](http://railstutorial.jp/chapters/modeling-users?version=4.0#top)

### 全般

モデルを作成するときのモデル名は単数形。対して、コントローラーは複数形。この generate コマンドの結果として、マイグレーションファイルが作成される。このファイル名の先頭には生成されたときのタイムスタンプも入っている。開発者同士のコンフリクトを防ぐため。

>> $ rails generate model User name:string email:string

マイグレーションを実行するには、

>> $ bundle exec rake db:migrate

ほとんどのマイグレーションは可逆。db:rollback というRakeタスクで変更を取り消せる。これを 「マイグレーションの取り消し (migrate down)」と呼ぶ。

>> $ bundle exec rake db:rollback # migrate down

コンソールをサンドボックスで呼び出すと、そのセッションのデータベースへの変更は終了時にロールバックされる。

>> $ rails console —sandbox

以下のコマンドは、単に開発データベースのデータモデルdb/development.sqlite3がテストデータベースdb/test.sqlite3に反映されるようにするもの。マイグレーション後でたまにRakeタスクが実行できなくなることがあり、多くの人がこれに戸惑います。さらに、テストデータベースはたまに壊れることがあるので、その場合はリセットが必要です。もしテストスイートが理由もなく壊れるようなことがあれば、rake test:prepareを実行して、この問題が解決するか確認。

### バリデーション ( app/models/user.rb )

{% highlight ruby linenos %}
# プレゼンス確認
validates :name, presence: true
{% endhighlight %}

presence: true はハッシュ。メソッドの最後の引数のハッシュは波括弧が要らない。

{% highlight ruby linenos %}
# 長さのチェック 
validates :name,  presence: true, length: { maximum: 50 }
{% endhighlight %}

{% highlight ruby linenos %}
# メールアドレスのチェック 
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
{% endhighlight %}

素晴らしい正規表現エディタ [http://www.rubular.com/](http://www.rubular.com/)

{% highlight ruby linenos %}
# 一意性のチェック 
uniqueness: { case_sensitive: false }
{% endhighlight %}

上記のようなチェックだけでは、アプリケーションのトラフィックが多いとき等に、いくつかのリクエスとがなされ、ほぼ同時にDBに登録されることにより、DB上に同一のレコードが残る可能性がある。これを防ぐには、一意性を保証したいDBのカラムにインデックスを作成し、そのインデックスが一意であることを要求することで解決することができる。

{% highlight ruby linenos %}
# この例では email column にインデックスを追加
$ rails generate migration add_index_to_users_email
{% endhighlight %}

これにより前回のように自動でマイグレーションが作成される。しかし、この場合は自ら未定義のメソッドを定義する必要がある。

{% highlight ruby linenos %}
class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
  end
end
{% endhighlight %}

そしてDBにマイグレーションの適応をする。

さらにメールアドレスの一意性を保証するために、すべてのアドレスを小文字に変換する。これはDBが常に小文字大文字を区別しているとは限らないから。このためにコールバックという、Active Recordオブジェクトが持続している間のどこかの時点で、Active Recordオブジェクトに呼び出してもらうメソッドを使う。

{% highlight ruby linenos %}
# app/models/user.rb
before_save { self.email = email.downcase }
{% endhighlight %}