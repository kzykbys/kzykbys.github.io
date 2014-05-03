---
title: "Ruby on Rails チュートリアル 8 章 （１）| ログイン・ログアウト"
layout: "post"
date: "2013-12-03 23:28:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。ログイン、ログアウト関連。
[http://railstutorial.jp/chapters/sign-in-sign-out?version=4.0#top](http://railstutorial.jp/chapters/sign-in-sign-out?version=4.0#top)

### ログイン・ログアウト機能

８章では、ウェブサービスの基本的な機能、ログイン・ログアウトの実装について解説してくれました。そのまとめです。

ログイン・ログアウトを司るセッションには一般的に３種類ある。ブラウザを閉じると終了する忘却モデル。「パスワードを保存する」チェックボックスを使用してセッションを継続する継続モデル。ユーザーが明示的にログアウトするまで永続する永続モデル。チュートリアルでは、最後の永続モデルの実装。

### セッションを管理するコントローラーの作成 etc

RESTfulなURLを自動生成するため、以下の行をルーティングファイルに追加。このコントローラーはセッションを管理するだけなので、new（ページ表示）、create（セッションスタート - ログイン）、destory（セッションエンド - ログアウト）の３つだけ作成。

{% highlight ruby linenos %}
# routes.rb
resources :sessions, only: [:new, :create, :destroy]
match '/signin',  to: 'sessions#new',  via: 'get'
match '/signout', to: 'sessions#destroy',   via: ‘delete'
{% endhighlight %}

そして、 ログインする際の View を実際に作成します。 View の Sessions フォルダに new.html.erbを作成します。注意点として、 セッションを作成するときには @user 変数のような存在がないため、前の章とは違う形式で form_for を書きます。（ form_tag を使った方が一般的のようですが、未確認。）具体的には、

{% highlight erb linenos %}
<%= form_for(:session, url: sessions_path) do |f| %>
{% endhighlight %}

ここでの sessions_path は /sessions への POST リクエスト。変数を使い、 form_for(@user) のように書くと、Rails は勝手に、/users への POST リクエスト と認識するが、今回のようなケースでは上記のように URL とリソースを指定しなければならない。

そして、コントローラーの作成。比較的わかりやすいと思います。アドレスから Studentモデルを検索し、それを変数に代入。そのアドレスのStudentモデルが存在し、かつ、パスワードが正しければ、if 分の最初のブロックが実行されます。authenticateメソッドは、ユーザー登録時に使った、has_secure_password が提供しています。

{% highlight ruby linenos %}
# sessions_controller.rb
def create
  student = Student.find_by(email: params[:session][:email].downcase)
  if student && student.authenticate(params[:session][:password])
    sign_in student
    redirect_to student
  else
    flash.now[:error] = 'Invalid email/password combination'
    render 'new'
  end
end
{% endhighlight %}

ログイン成功時に実行される sign_in関数をこれから実装していきます。これはログイン状態を永続化し、ユーザーがログアウトするまで、セッションを保持します。また、この関数は、ビューやコントローラー両方から使用する必要があるので、この sign_in 関数を SessionHelper というモジュール（Sessionコントローラー作成時に生成されている）に書き、Application コントローラーにてこれをインクルードする。これにより、コントローラー内でこのヘルパーを使用することができるようになる。ちなみに、ビューはデフォルトで、全てのヘルパーが使える。

{% highlight ruby linenos %}
# application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
end
{% endhighlight %}

そして、永続的なセッションを実装するために cookie を使用します。この cookie の記憶トークンと Student は関連付けられている必要があるので、Student モデルにカラムとインデックスを追加する。

{% highlight ruby linenos %}
# マイグレーションの生成
$ rails generate migration add_remember_token_to_users
 
# [ts]_add_remember_token_to_users.rb
class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end
end
 
# マイグレーションの適応
$ bundle exec rake db:migrate
{% endhighlight %}

続きます。