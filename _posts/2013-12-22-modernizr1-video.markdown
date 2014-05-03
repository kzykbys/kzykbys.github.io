---
title: "Modernizr1 [ video ]"
layout: "post"
date: "2013-12-22 05:22:00"
categories: [HTML5]
---

Modernizr で video タグのサポートチェックの方法。 

{% highlight javascript linenos %}
if (Modernizr.video) { //*0
     // let's play some video! but what kind?
     if (Modernizr.video.webm) { // *1
     // try WebM
     } else if (Modernizr.video.ogg) { // *2
     // try Ogg Theora + Vorbis in an Ogg container
     } else if (Modernizr.video.h264){ // *3
     // try H.264 video + AAC audio in an MP4 container
     }
}
{% endhighlight %}

0 . check for HTML5 video support

1 . WebM is a newly open-sourced (and non-patent-encumbered) video codec that will be included in the next version of
major browsers, including Chrome, Firefox, and Opera.

2 . Mozilla Firefox and other open source browsers

3 . Safari, iPhone etc 

{% highlight javascript linenos %}
// 1
function supports_webm_video() {
     if (!supports_video()) { return false; }
     var v = document.createElement("video");
     return v.canPlayType('video/webm; codecs="vp8, vorbis"’);
}
{% endhighlight %}

{% highlight javascript linenos %}
// 2
function supports_ogg_theora_video() {
 if (!supports_video()) { return false; }
 var v = document.createElement("video");
 return v.canPlayType('video/ogg; codecs="theora, vorbis"');
}
{% endhighlight %}

{% highlight javascript linenos %}
// 3
function supports_h264_baseline_video() {
     if (!supports_video()) { return false; }
     var v = document.createElement("video");
     return v.canPlayType('video/mp4; codecs="avc1.42E01E, mp4a.40.2"');
}
{% endhighlight %}

各関数が、各ブラウザが対応しているビデオフォーマットに対応しているかチェックしている。return文の canPlayType() 関数は、true か false を返すのではなく、下記のように String を返す。

"probably" if the browser is fairly confident it can play this format<br />
"maybe”    if the browser thinks it might be able to play this format<br />
""               (an empty string) if the browser is certain it can’t play this format<br />