---
title: "Modernizr5 [ Geolocation ]"
layout: "post"
date: "2013-12-22 05:29:00"
categories: [HTML5]
---

位置情報は、あなたがどこにいるか明らかにし、その情報をシェアすることができます。いくつか位置情報を特定する方法があり、IP アドレス、無線LANの接続、電波塔との接続、また GPSハードウェアによる経度緯度の測定等あります。

{% highlight javascript linenos %}
// Modernizr によるサポートチェック
if ( ) {
     // let's find out where you are!
} else {
     // no native geolocation support available :(
     // try geoPosition.js or another third-party solution
}
{% endhighlight %}

{% highlight javascript linenos %}
// 内部
function supports_geolocation() { 
     return 'geolocation' in navigator;
}
{% endhighlight %}