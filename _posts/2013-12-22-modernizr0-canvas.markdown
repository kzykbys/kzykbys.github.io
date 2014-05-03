---
title: "Modernizr0 [ canvas ]"
layout: "post"
date: "2013-12-22 05:16:00"
categories: [HTML5]
---

Modernizr は MIT ライセンスのオープンソースライブラリ。HTML5/CSS3のサポートがあるかどうかを簡単に判断することができる。

{% highlight html linenos %}
<head>
<meta charset="utf-8">
<title>Dive Into HTML5</title>
<script src="modernizr.min.js"></script>
</head>
{% endhighlight %}

{% highlight javascript linenos %}
if (Modernizr.canvas) {
// let's draw some shapes!
 
} else {
// no native canvas support available :(
 
}
{% endhighlight %}

nomodernizr_init() という関数が、Modernizr というグローバルオブジェクトを作成するので、上記のようにサポートされているか確認する。

内部では、

{% highlight javascript linenos %}
if (Modernizr.canvas) {
function supports_canvas_text() {
 if (!supports_canvas()) { return false; }
 var dummy_canvas = document.createElement('canvas'); var context = dummy_canvas.getContext('2d');
 return typeof context.fillText == 'function’;
}
{% endhighlight %}

このようにダミーの canvas をエレメントを作成し、メソッドがあるか確認している。