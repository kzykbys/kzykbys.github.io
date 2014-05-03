---
title: "Modernizr3 [ web worker ]"
layout: "post"
date: "2013-12-22 05:27:00"
categories: [HTML5]
---

Web worker はブラウザがバックグランドで Javascript を実行する方法です。これにより、複数のスレッドを同時に起動させ、複雑な計算や、リクエスを送ったり、ローカルストレージにアクセスすることができます。

{% highlight javascript linenos %}
if (Modernizr.webworkers) {
     // window.Worker is available!
} else {
     // Your browser supports web workers.
     // no native support for web workers :(
     // try a fallback or another third-party solution 
}
{% endhighlight %}

内部は、

{% highlight javascript linenos %}
function supports_web_workers(){
     return !!window.Worker;
}
{% endhighlight %}