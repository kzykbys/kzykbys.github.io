---
title: "Ruby on Rails チュートリアル 6 章 ( 2 ) | モデル"
layout: "post"
date: "2013-11-17 23:56:00"
categories: [Ruby on Rails]
---

### セキュアなパスワード追加

まずはハッシュ関数を使用するためGemfileに以下の行を追加する。

{% highlight ruby linenos %}
# Gemfile
# gem 'bcrypt-ruby', ‘3.0.1'
gem 'bcrypt-ruby', ‘3.1.2
{% endhighlight %}

自分の環境では、3.0.1 では動作せず、 3.1.2をインストールすることにより動作した。
[http://stackoverflow.com/questions/18541062/issues-using-bcrypt-3-0-1-with-ruby2-0-on-windows](http://stackoverflow.com/questions/18541062/issues-using-bcrypt-3-0-1-with-ruby2-0-on-windows)

そしてインストール。

>> $ bundle install

そして、新しいカラム password_digestカラム用のマイグレーションを作成する。

>> $ rails generate migration add_password_digest_to_users password_digest:string

上記のコマンドの最初の引数はマイグレーション名。自由に設定できるが、上のように末尾を_to_usersにしておくことをお勧めします。こうしておくと、usersテーブルにカラムを追加するマイグレーションがRailsによって自動的に作成されるため。２つ目の引数は、作成する属性の名前と型。

### パスワードの確認

パスワードの入力確認は、コントローラーで行うこともできるが、モデルで行うことが慣習になっている。そのために、password属性とpassword_confirmation属性をUserモデルに追加し、レコードをデータベースに保存する前に2つの属性が一致するように要求します。

### ユーザーの作成

>> $ rails console<br />
>> \>\> User.create(name: "Michael Hartl", email: "mhartl@example.com",<br />
>> ?>  password: "foobar", password_confirmation: "foobar”)

db/development.sqlite3 を SQLite Database Browser というソフトを使うことにより、中身を確認することができる。[http://sourceforge.net/projects/sqlitebrowser/](http://sourceforge.net/projects/sqlitebrowser/) 

また、コンソールで、

>> \>\>  user =  User.find_by(email: "mhartl@example.com"<br />
>> \>\> user.password_digest<br />
>> => "$2a$10$kn4cQDJTzV76ZgDxOWk6Je9A0Ttn5sKNaGTEmT0jU7.n…"<br />

このように確認、さらに

>> \>\> user.authenticate("invalid")<br />
>> => false<br />
>> \>\> user.authenticate("foobar")<br />
>> => #<User id: 1, name: "Michael Hartl", email: "mhartl@example.com"<br />
created_at: "2013-03-11 20:45:19", updated_at: "2013-03-11 20:45:19",<br />
password_digest: "$2a$10$kn4cQDJTzV76ZgDxOWk6Je9A0Ttn..."]]><br />