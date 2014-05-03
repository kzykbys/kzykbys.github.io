---
title: "Modernizr2 [ local strage ]"
layout: "post"
date: "2013-12-22 05:24:00"
categories: [HTML5]
---

ローカルストレージはウェブサイトがデータをユーザーのコンピュータに保存し、のちに取り出す方法です。似たものにクッキーがありよく使われていますが、クッキーとの違いは、保存できる容量が HTML5 の ストレージの方が 5M と多く、またクッキーと違い、毎度の通信でデータがサーバーに送られることがありません。これは帯域の節約や、セキュリティの観点からも好ましいです。

{% highlight javascript linenos %}
if (Modernizr.localstorage) {
     // window.localStorage is available!
 
} else {
     // no native support for local storage :(
     // try a fallback or another third-party solution
}
{% endhighlight %}

内部では、

{% highlight javascript linenos %}
function supports_local_storage() {
     try {
         return 'localStorage' in window && window['localStorage'] !== null;
     } catch(e){
         return false;
     }
}
{% endhighlight %}

このように処理しています。古い Firefox のバグにより Exception をスローする場合があるので、try-catch 文を使っています。Javascript はケースセンシティブなので、Modernizr の localstorage と DOM プロパティの localStorage に違いに注意。
