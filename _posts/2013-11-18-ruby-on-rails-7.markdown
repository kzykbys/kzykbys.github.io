---
title: "Ruby on Rails チュートリアル 7 章 | ユーザー登録"
layout: "post"
date: "2013-11-18 20:46:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。
[http://railstutorial.jp/chapters/sign-up?version=4.0#top](http://railstutorial.jp/chapters/sign-up?version=4.0#top)

### ユーザー登録

RESTアーキテクチャ

実際に動的なページを作っていくということは、アプリケーションをRESTアーキテクチャの習慣に従うということ。これを実現するための簡単な方法として、config/routes.rb に以下の行を追加。

{% highlight ruby linenos %}
# config/routes.rb
resources :users
# get "users/new”
{% endhighlight %}

この resouse :users という行だけで、RESTful なすべてのアクションが利用できるようになる。そのため、get “users/new” という行は削除することができる。

![](http://3.bp.blogspot.com/-rwI_hASZkzM/Uop26v4jiBI/AAAAAAAAAKM/eF8NrNdEsgg/s1600/Screen+Shot+2013-11-18+at+10.24.51+AM.png)

### SHOW

まずは、 view を作成する（app/views/users/show.html.erb）。new.html.erb は自動で生成されたが、今回は自分で作成しなければならない。

{% highlight erb linenos %}
# app/views/users/show.html.erb
<%= @user.name %>, <%= @user.email %>
{% endhighlight %}

＠user はインスタンス変数。これをコントローラー内で定義する。

{% highlight ruby linenos %}
# app/controllers/users_controller.rb
def show
  @user = User.find(params[:id])
end
{% endhighlight %}

params[:id] はリクエストの値。users/1 であれば、params[:id] はUser.find(1) に置き換わる。

### NEW and CREATE

まずは view を form_for メソッドを使って実装。もしエラーがある場合は、 shared/error_messages を表示させている。このエラーがあるかどうかは、shared/_error_messagedにて条件分岐をする。慣習的に、複数の controller に渡る view は sharedディレクトリに格納。

{% highlight erb linenos %}
# app/views/users/new.html.erb
<% provide(:title, 'Sign up') %>
<h1>Sign up</h1>
<div class="row"]]
  <div class="span6 offset3"]]
    <%= form_for(@user) do |f| %>
    <%= render 'shared/error_messages' %>
 
    <%= f.label :name %>
    <%= f.text_field :name %>
 
    <%= f.label :email %>
    <%= f.text_field :email %>
 
    <%= f.label :password %>
    <%= f.password_field :password %>
 
    <%= f.label :password_confirmation, "Confirmation" %>
    <%= f.password_field :password_confirmation %>
 
    <%= f.submit "Create my account", class: "btn btn-large btn-primary" %>
  <% end %>
</div>
</div>
{% endhighlight %}

{% highlight erb linenos %}
# app/views/shared/_error_messages.html.erb 
<% if @user.errors.any? %>
  <div id="error_explanation"]]
    <div class="alert alert-error"]]
      The form contains <%= pluralize(@user.errors.count, "error") %>.
    </div>
  <ul>
<% @user.errors.full_messages.each do |msg| %>
<li>* <%= msg %></li>
<% end %>
</ul>
</div>
<% end %>
{% endhighlight %}

form_for メソッドでは user インスタンス変数を使用しているので、それを controller で定義。

{% highlight ruby linenos %}
# app/controllers/users_controller.rb
def new
  @user = User.new
end
{% endhighlight %}

上記で作成したフォームは submit された時に、/users に対してPOST する。RESTアーキテクチャでは、この操作は create アクションにあたる（上の画像）。よって、 controller で以下のように create アクションを作成。

{% highlight ruby linenos %}
def create
  @user = User.new(user_params)
  if @user.save
    redirect_to @user
  else
    render 'new'
  end
end
 
private
def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
{% endhighlight %}

private 関数は、セキュリティ上、全てのパラメータを無条件で受付ないため。もし、ユーザーの作成、保存が成功したらそのユーザーページにリダイレクト。