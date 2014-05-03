---
layout: post
title: "Jekyll にて記事の deprecate フラグを立てるプラグインを作成しました"
date: 2014-04-29 00:00:00
categories: [Ruby]
---

最近、ブログを Jekyll で自分のブログを作成しています。それに伴ってプログラミングのライブラリに関する記事等、ある程度時間が立つとその記事の内容を保証できない類の記事を管理するプラグインを書いてみました。

### 使い方

使い方は本当に簡単です。各ポストの任意の箇所に下記のコードを埋め込みます。

>> \{\{ page.date | render_deprecate: 6 \}\}

このコードを例えば記事の一番上に埋め込んでおけば、6ヶ月後に "This article might be too old." と注意書きが表示されます。Jekyll は静的なエンジンなので、自分でビルドした際に指定した月数が経過していれば表示されると思います。

### コード

簡単なコードです。

{% highlight ruby linenos %}
module Jekyll
	module RenderDeprecate
 
  	def render_deprecate(pageTime, numOfMonth)
    
	   	if pageTime == nil
		    return
	   	end
	 
	   	currentMonths = (Time.now.year*12) + (Time.now.mon)
	   	articleMonths = (pageTime.year*12) + (pageTime.mon)   
	   	diffMonth     = currentMonths - articleMonths
	    
	   	if diffMonth >= numOfMonth
		    "<span class=\"deprecate\">This article might be too old.</span>"
	   	else
		    ""
	   	end
 
  	end
   
 end
end
Liquid::Template.register_filter(Jekyll::RenderDeprecate)
{% endhighlight %}
