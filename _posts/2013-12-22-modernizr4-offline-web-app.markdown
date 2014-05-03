---
title: "Modernizr4 [ offline web app ]"
layout: "post"
date: "2013-12-22 05:28:00"
categories: [HTML5]
---

オフラインウェブアプリは、名前の通りオフラインでも動的なサイトをオフラインで表示することができます。はじめにユーザーはこの機能が有効になったサイトにアクセスし、オフラインに必要なデータをダウンロードします。これは HTML/JS、画像はもちろんビデオも可能です。そして、ユーザーがオフラインでこのサイトを訪れた場合、ダウンロードされたデータを使用し、サイトを表示します。もしユーザーがオフライン中にデータに変更をした場合、のちのオンラインになった時にサーバーに送信されます。

{% highlight javascript linenos %}
// Modernizr によるサポートチェック
if (Modernizr.applicationcache) {
     // window.applicationCache is available!
} else {
     // no native support for offline :(
     // try a fallback or another third-party solution
}
{% endhighlight %}

{% highlight javascript linenos %}
// 内部
function supports_offline() { 
     return !!window.applicationCache;
}
{% endhighlight %}