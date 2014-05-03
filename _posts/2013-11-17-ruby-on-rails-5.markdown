---
title: "Ruby on Rails チュートリアル 5 章 | アセットパイプライン"
layout: "post"
date: "2013-11-17 18:44:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。今回はアセットパイプライン関係。
[http://railstutorial.jp/chapters/filling-in-the-layout#top](http://railstutorial.jp/chapters/filling-in-the-layout#top)

Rails 3.0と、その後のバージョンの最も大きな違いの1つは、CSS、JavaScript、画像などの静的コンテンツの生産と管理を大幅に強化する「アセットパイプライン」です。アセットパイプラインは、Railsの流儀を守りながら多大な変化をもたらしますが、一般的なRails開発者の視点からは、アセットディレクトリ、マニフェストファイル、プリプロセッサエンジンという、3つの主要な機能が理解の対象。

### アセットディレクトリ

| file | desc |
| --- | --- | 
| app/assets | 現在のアプリケーション固有のアセット| 
| lib/assets | あなたの開発チームによって作成されたライブラリ用のアセット| 
| vendor/assets | サードパーティのアセット| 

### マニフェストファイル

適切にアセットディレクトリにファイルを配置すれば、マニフェストファイルによって一つにファイルのように扱うことができる。 実際にまとめるのは Sprokects gem の役割。app/assets/stylesheets/application.css はマニフェストファイルの例。

>> *= require_tree .

はapp/assets/stylesheetsのサブディレクトリを含む全ての CSS をインクルードする。ドットも必須。

>> *= require_self

application.css自身の CSS 記述もインクルードする。

### プリプロセッサエンジン

必要なアセットをディレクトリに配置してまとめた後、Railsはさまざまなプリプロセッサエンジンを介してそれらを実行し、ブラウザに配信できるようにそれらをマニフェストファイルを用いて結合し、サイトテンプレート用に準備します。Railsは、どのプリプロセッサを使用するかを、ファイル名の拡張子を使用して判断します。最も一般的な拡張子は、Sass用の.scss、CoffeeScript用の.coffee、埋め込みRuby (ERb) 用の.erbです。

### その他

この章を読みながら、ローカルを作業していた時は問題なかったが、Heroku にデプロイした時にCSS等が効かなかった。その時にこのページを参考にし、いくつかの修正をするとローカルと同じ結果を得ることができた。
[http://stackoverflow.com/questions/18839662/invalid-css-on-rails-app-michael-hartl-tutorial](http://stackoverflow.com/questions/18839662/invalid-css-on-rails-app-michael-hartl-tutorial)

config/environments/production.rb を以下のように変更

{% highlight ruby linenos %}
# Do not fallback to assets pipeline if a precompiled asset is missed.
# config.assets.compile = false
{% endhighlight %}

{% highlight ruby linenos %}
# Generate digests for assets URLs.
# config.assets.digest = true
{% endhighlight %}