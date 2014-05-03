---
title: "Ruby on Rails チュートリアル 8 章 （２）| ログイン・ログアウト"
layout: "post"
date: "2013-12-03 23:45:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。ログイン、ログアウト関連。
[http://railstutorial.jp/chapters/sign-in-sign-out?version=4.0#top](http://railstutorial.jp/chapters/sign-in-sign-out?version=4.0#top)

### 永続モデルのためのトークン

記憶トークンには Rails の標準ライブラリのSecureRandomモジュールのurlsafe_base64メソッドを使う。これは６４種類の文字列から、長さ１６の文字列を返す。流れとしては、

１．ユーザーのブラウザに base64 トークンを保存

２．同時に、DBにもそのトークンを暗号化し、保存

３．ユーザーが再度サイトに来た際には、ブラウザの cookie からトークンを読み込み、暗号化し、DBの既に暗号化されていたトークンを比較

>> トークンの生成

上記までの流れにそえば、とりあえず Student モデルにトークンを保存するカラムは作成されているはずです。ここからは、具体的にトークンを生成をしていきます。

{% highlight ruby linenos %}
# student.rb
# Generate token for Session

before_create :create_remember_token

# Sessions funk
def Student.new_remember_token
	SecureRandom.urlsafe_base64
end

def Student.encrypt(token)
	Digest::SHA1.hexdigest(token.to_s)
end

private

def create_remember_token
	self.remember_token = Student.encrypt(Student.new_remember_token)
end
{% endhighlight %}

モデルの中で、トークンを生成する関数、暗号化する関数、そして、プライベートのそれらの結果を該当の Student モデルに保存しています。self というキーワードを指定し、ローカル変数ではなく、DBにしっかりと保存されるようにする。これらは、before_create により Student を保存する前に実行されます。

>> セッションヘルパー

ここから、先ほどの sign_in 関数の実装です。

{% highlight ruby linenos %}
# sessions_helper.rb
module SessionsHelper
  def sign_in(student)
    remember_token = Student.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    student.update_attribute(:remember_token, Student.encrypt(remember_token))
    self.current_studen = student
  end
end
{% endhighlight %}

この関数はログインに成功するたびに呼ばれることを思い出してください。まず、新しいトークンを生成。暗号化れていないこのトークンを cookie に保存。Student モデルのように暗号化したトークンを DB へ保存。update_attribute 関数により、validation 等を迂回して DB への変更することができる。最後の current_sutdent はこれから実装します。

{% highlight ruby linenos %}
# sessions_helper.rb
def current_student=(student)
  @current_student = student
end
{% endhighlight %}

この current_studen= “関数"は少し特殊です。普通のプログラミング言語では = は関数名に使いませんが、Ruby は使用することができます。これを実装することにより、sign_in関数の代入するように書くことにより、この関数が実行されます。ここでは @current_student というインスタンス変数を設定し、後に使用できるようにしています。

{% highlight ruby linenos %}
# sessions_helper.rb
def current_student
  remember_token = Student.encrypt(cookies[:remember_token])
  @current_student ||= Student.find_by(remember_token: remember_token)
end
{% endhighlight %}

そして、current_studentのゲッターを作成します。attr_accessor でゲッター・セッターを作成すると、セッション情報がその都度新しくなりページを遷移するたびにログアウトしてしまいます。そのため、上記のように、cookie をブラウザから取得し、DBのトークンは暗号化されているので、取得したトークンを暗号化し、 Student モデルを DB から引っ張ってきています。||= は他の言語でもよく使われる += と似ていて、この場合

>> @current_student = @current || Student.find_by(remember_token: remember_token)

と同義になります。つまり、 current_user が存在しない （ nil ）場合にのみ、DB から現在アクセスしているユーザーの情報を取ってくるということです。

また、ユーザーがログインしているか否かを判断する関数を定義します。current_user が nil でない時に（ログインしている）、true を 返します。

{% highlight ruby linenos %}
# sessions_helper.rb
def signed_in?
  !current_user.nil?
end
{% endhighlight %}

後は、ビューで、以下のようにユーザーがログインしているか否か判断し、表示するコンテンツを変更すればそれぽくなります。

{% highlight erb linenos %}
# Each View
<% if signed_in? %>
# サインインしているユーザー用のリンク
<% else %>
#サインインしていないユーザー用のリンク
<% end %>
{% endhighlight %}

あとは、ログアウト機能で終了！