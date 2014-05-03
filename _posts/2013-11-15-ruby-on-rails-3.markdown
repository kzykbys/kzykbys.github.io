---
title: "Ruby on Rails チュートリアル 3 章 | テスト"
layout: "post"
date: "2013-11-15 20:15:00"
categories: [Ruby on Rails]
---

急遽、勉強しなくちゃいけなくなった Ruby on Rails の個人的なまとめ。今回はテストと周り。
[http://railstutorial.jp/chapters/static-pages?version=4.0#top](http://railstutorial.jp/chapters/static-pages?version=4.0#top)

### 準備

プロジェクト作成時に、

>> $ rails new sample_app --skip-test-unit

この --skip-test-unit オプションは 通常作成される test ディレクトリを作成しなくするためのもの。Ruby on Rails チュートリアルでは RSpec というフレームワークを使ってテストしていくため。RSpec というのがよく分かっていないが、英語ぽくテストを記述することができるらしい。例えば、

{% highlight ruby linenos %}
# ダブルクォートの中は無視される
it "should have the content 'Sample App'" do
 visit '/static_pages/home'
 expect(page).to have_content('Sample App')
end
{% endhighlight %}

まずは、通常の Test::Unitではなく、上記の RSpec を使うために、

>> $ rails generate rspec:install

を実行する

また、コントローラー作成時に

>> $ rails generate controller StaticPages home help --no-test-framework

--no-test-framework オプションで、RSpecのテストが自動生成されないようにする。

そして、実際にテストを書くために

>> $ rails generate integration_test static_pages

により、spec/requestsディレクトリにstatic_pages_spec.rbが生成。このファイルに自分の上記のようなテストを記述していく。

### 実行

今回の例だと、

>> $bundle exec respec speck/requests/static_pages.rb

で実行。 すぐにテストに通過したか確認できる。基本、赤文字は失敗、緑はOK。Test-Driven Development: TDDでは、RED/GREEN/REFACTORというサイクルを回していく。まずテストを書き、まだテストに通過できない（赤）コードを書き直してバグ等潰していく（緑）。そして、開発が進むにつれ汚くなっていくコードをREFACTORしていく。

ちなみに、自分の開発環境では、テストを実行しようするとすると、

>> Reason: Incompatible library version: nokogiri.bundle requires version 11.0.0 or later

というエラーが発生した。そこで、

>> $ brew update<br />
>> $ brew uninstall libxml2<br />
>> $ brew install libxml2 --with-xml2-config<br />
>> $ brew link --force libxml2<br />
>> $ brew install libxslt<br />
>> $ brew link --force libxslt<br />
>> $ bundle config build.nokogiri -- --with-xml2-dir=/usr --with-xslt-dir=/opt/local --with-iconv-dir=/opt/local<br />
>> $ bundle install<br />

を実行すると解決。

### 参考

[https://gist.github.com/vparihar01/5856524](https://gist.github.com/vparihar01/5856524)
