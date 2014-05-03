---
title: "Ajaxによるページ部分更新 [ Ruby on Rails ]"
layout: "post"
date: "2013-12-26 03:14:00"
categories: [Ruby on Rails]
---

Ajax を使ってウェブサイトの一部分のみを更新する方法です。Ajaxを使うことにより、ページ遷移をなしで、DBと通信しながらページコンテンツの一部を変更することができます。今回は、\<select\>の\<option\>が変更されるたびにページの一部を変更するという機能を実装してみます。実装方法は違うかもしれませんが、http://www.assist.org/web-assist/welcome.html と同じような処理です。 

### htmlページの準備

まずは、DBとの通信のトリガーになる\<select\>をページに追加します。ユーザーがページの\<select\>を変更すると、\<select\>のonchange()が起動します。onchange()からのちほど作成するカスタム関数を呼び出し、その関数からDBとの通信を発動します。そして、ページのコンテンツを変更します。

{% highlight erb linenos %}
# test.html.erb
<%= collection_select(:major, :id, @majors, :id, :name,  {:prompt => "Please select your major"},{:onchange => "changeMajor()" }) %>
{% endhighlight %}

これにより、 @majors に格納されている major モデルの id と name がそれぞれ value と\<option\>\</option\>に動的に記述されます。valueはサーバーに送信される値で、\<option\>\</option\>はページに表示される文字列です。ここでは :prompt オプションにより何も表示されていない時には “Please select your major” と表示されるます。onchange() メソッドではこれから自分で作成する changeMajor()メソッドを\<select\>の\<option\>が変更されるたびに呼び出されます。また\<select\>のhtml属性idはmajor_idとなります。

{% highlight erb linenos %}
# test.html.erb 
<div id="classList" style="display: inline;">
    <%= render :partial => 'classList_body' %>
</div>  
{% endhighlight %}

この箇所がDBとの通信が終わった時に変更される箇所です。のちほど _classList_body.html.erb というファイルは作成します。\<select\>が変更されDBとの通信ごとに_classList_body.html.erb が新しくレンダリングされるということですね。

### onchange で呼ばれる Javascript 関数の準備

{% highlight javascript linenos %}
// test.html.erb 
// onchange メソッド
function changeMajor(){
     var select = document.getElementById('major_id');
     var options =  document.getElementById('major_id').options;
     var value = options.item(select.selectedIndex).value;
     var universityID = <%= @student.universities.first.id %>;
 
     $.ajax({
          url: "/students/listEachClass",
          type: "POST",
          data: 'id=<%= @student.id %>&majorID=' + value + '&universityID=' + universityID
     })
} 
{% endhighlight %}

これが呼び出されるchangeMajor()メソッドです。ポイントは後半の$.ajaxですね。送信するurlと通信方法の指定、そしてコントローラー側が受け取る値をdataで指定しています。前半のJSはもう少しスマートな方法がありそうですね。。。JSはいつもやっつけになってしまいます。

### 通信ごとに呼ばれるパーシャルの準備

{% highlight erb linenos %}
#_classList_body.html.erb  
<p><%= @universityID %></p>
<p><%= @majorID %></p> 
{% endhighlight %}

今回はとてもシンプルです。この@universityID と@majorID はコントローラーで作成される変数？です。onchagenメソッドで選択されている\<select\>の値がサーバーに送信され、コントローラーで作成された変数を後ほど作成するJavascriptファイルからこのパーシャルをレンダリングする際に、それらの値を渡すことで、このパーシャルの中で使うことができます。

### Javascriptファイルの準備

{% highlight erb linenos %}
# listEachClass.js.erb
# 上記のtest.html.erbがあるviewフォルダにこのファイルを作成
$("#classList").html("<%= escape_javascript(render 'classList_body', :majorID => @majorID, :universityID => @universityID) %>");
{% endhighlight %}

ここでは上記の test.html.erb で指定した id=classList \<div\>に 2 で作成したパーシャルをレンダリングするということを記述しています。render する際に、コントローラーで作成された変数をパーシャルで使えるように渡しています。

### コントローラーの準備

{% highlight ruby linenos %}
def listEachClass
    puts "==== Here is the listEachClass!! ===="
    @majorID = params[:majorID].to_i
    @universityID = params[:universityID].to_i
 
    puts @majorID
    puts @universityID
end 
{% endhighlight %}

コントローラーはみなさん思い思いの処理をしていただければいいと思います。params[:majorID] やparams[:universityID] と記述することにより、1で作成したchangeMajor()のdataで渡された値を参照することができます。ここでは単に数値にしてそれをログに表示させているだけです。何もしていませんね。

以上です。