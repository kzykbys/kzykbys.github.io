---
title: "Facebook ログイン with Omniauth [ Ruby on Rails ]"
layout: "post"
date: "2013-12-16 18:49:00"
categories: [Ruby on Rails]
---

RailsでのFacebookログインの実装。Facebookログインをサイトに設定することで、ユーザーはワンクリックでユーザー登録を完了することができ、パスワードやE-mailアドレスを入力する必要がなくなることもあるので、かなり楽です。実装も結構簡単でした。

### 準備

>> Gemfile

{% highlight ruby linenos %}
# Gemfile
gem ‘omniauth'
gem 'omniauth-facebook’
{% endhighlight %}

Gemfileを準備し、 $ bundle install . ここまではもうおなじみですね。 

>> Facebook アプリ作成

また、Facebookログインをサイトに組み込むには、Facebook側でアプリを作成し、自分のサイトを登録しておく必要があります。まず、[ここ](https://developers.facebook.com/apps) にアクセスし、アプリを作成します。アプリ作成に関しては特に問題ないと思います。ローカルで動作確認する際には、各アプリ設定ページ中程にある Website with Facebook Login という項目を有効にし、http://localhost:3000/ を設定します。これを忘れると、 Invalid blabala とエラーがでます。設定ページにある ”App ID” と ”App Secret” をあとで使います

![](http://1.bp.blogspot.com/--YZNsLznuAc/Uq9IegmlUfI/AAAAAAAAAME/JAd6BCdKD-0/s1600/Screen+Shot+2013-12-16+at+9.59.10+AM.png)

>> Omniauth.rb

{% highlight ruby linenos %}
#config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, “App ID", “App Secret"
end
{% endhighlight %}

config/initializers/ に上記のファイルを作成します。 

>> routes.rb

{% highlight ruby linenos %}
#config/route.rb
match "/auth/:provider/callback" => "sessions#createByFacebook", via: ‘get'
{% endhighlight %}

上記の match を追加。２つ目のダブルクォートの中身は Facebook からコールバックで自分のサイトに戻ってきた時に処理するコントローラーのアクションを設定しておけば大丈夫だと思います。今回、Facebook の Facebook Login 機能を使って、サイトでユーザー登録とログインがすることができるよう実装してみます。

### 実装

>> コントローラー

今回、コントローラーでは、既に Facebook によりユーザー登録やログインをしたことがあるユーザーか判断し、そうでなければ Facebook から持ってきた情報を使い新しいユーザーを作成します。どちらも場合もユーザー変数を作成し、ログイン・各ユーザーページに遷移します。 

{% highlight ruby linenos %}
#session_controllers.rb
def createByFacebook
     auth = request.env["omniauth.auth”] # FB info like name, email etc
     student = Student.find_by_provider_and_fbid(auth["provider"],auth["uid"]) || Student.create_with_fb(auth,classID)  #*
     sign_in student
     redirect_to student
end 
{% endhighlight %}

一行目は Facebook から取ってきた情報です。これを既存ユーザーかどうか判断する際に追加、また、新規ユーザーを作成する際にはモデルのメソッドに引数として渡し、この情報をもとに新規ユーザーを作成します。コメント * の部分が、上記の 既存のユーザーかどうかの判断するポイントです。

>> モデル

今回は Student というモデルを Facebook 情報を使い作成します。 

{% highlight ruby linenos %}
# Create Account from FB
  def self.create_with_fb(auth,classID) # create new student from FB
 
    s = Student.find_by_email(auth["info"]["email"]) # user registered before
    if s.present?
      s.provider = auth["provider"]
      s.fbid        = auth["uid"]
      s.name     = auth["info"]["name"]
      return s
    else
      newS = Student.new
      newS.provider = auth["provider"]
      newS.fbid        = auth["uid"]
      newS.email      = auth["info"]["email"]
      newS.name     = auth["info"]["name"]
      newS.password = SecureRandom.hex(9)
 
      if newS.save
        if !classID.blank?
          classID.split(",").map{
              |eachclassids|
                ClassStudent.create(student_id: newS.id, klass_id: eachclassids)
          }
        end
      end
 
      return newS
    end
  end
{% endhighlight %}

この箇所はあまり自信がないので問題があったらご指摘いただきたいです。ここでは、ユーザーが Facebook でログインするのは初めてだけど、既にサイトのユーザーだったというケースを E-mail アドレスでチェックしています。もし Facebook に登録されたアドレスが既に存在すれば、Facebook の UID と privider つまり facebook ということを保存しています。正真正銘、新規ユーザーの場合には else 文以下で新規ユーザーを作成しています。僕のケースでは Student が持つクラス（授業名）を登録する際に Student の id が必要でした。そこでまず newS （新しい生徒）を保存して、その後に中間テーブルに student_id と klass_id を登録しました。なんだかあまりかっこよくないです。 いずれの場合にも更新 or 作成したモデルを return し、2.1 のコントローラーに返します。そのモデルを使い、ログイン・各ユーザーページにリダイレクトという流れです。