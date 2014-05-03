---
title: "jQuery と Bootstrap で動的なプログレスバー"
layout: "post"
date: "2013-11-26 00:02:00"
categories: [Tips]
---

友達とウェブサイトを作っている中、Bootstrapのプログレスバーの進捗状況を動的に変更したくなったので、jQueryを使って実装してみました。

### Bootstrap プログレスバーの用意

まずは、プログレスバーを用意する必要があります。簡単な例が本家の[サイト](http://getbootstrap.com/components/#progress)にあるので、そちらも参考にしてください。

{% highlight html linenos %}
<div class="container">
  <span class="label label-default" id="labelRequirement">Units Requirement</span>
  <div class="progress progress-striped active ">
    <div class="bar" style="width:0%;"></div>
  </div>
</div>​
{% endhighlight %}

今回は、アメリカの留学生が１学期に取らなくてはならない最低単位数とユーザーの履修予定のクラスの単位数のパーセンテージをバーに表示します。

### jQuery 側の実装

jQuery を使うのはほとんど初めてだったんですが、意外に簡単にできました。

{% highlight javascript linenos %}
<script><!--
    var selectedUnits = 0.0;
    $(".thumbnail").click(function(event){
        var thisUnits = $(this).data(('units'));
        var thisUnitsFloat = parseFloat(thisUnits);
 
        selectedUnits = thisUnitsFloat + selectedUnits;
        console.log("This  Units :" + thisUnitsFloat);
        console.log("Total Units :" + selectedUnits);
 
        var $bar = $(".bar");
        // Minimum requirement is 12 units 
        var percent = Math.round((selectedUnits/12)*100);
        if(percent > 100) percent = 100;
        $bar.width(percent + "%");
        $bar.text(percent + "%");
 
    });
//--></script>
{% endhighlight %}

html側は下記のようになっています。

{% highlight ruby linenos %}
<div class="span4 col-xs-12 col-sm-6 col-md-3 col-lg-4 thumb">
  <a class="thumbnail" data-units="4.0"><img class="img-responsive" src="http://placehold.it/250x200"></a>
</div> 
{% endhighlight %}

まず、\<a\>タグに data-units という属性を追加しておき、ユーザーが履修したいクラスをクリックします。それらの情報を元に、あとどの程度の単位数を履修するべきか計算させ、新しいクラスがクリックされるたびに、バーを動的に更新しています。