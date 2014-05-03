---
title: "多対多の関係の構築 [ Ruby on Rails]"
layout: "post"
date: "2013-12-07 07:00:00"
categories: [Ruby on Rails]
---

Ruby on Rails での多対多の関係の作り方。なぜか初めてやったとき尋常なくハマってしまったので。多対多とは、例えば、アイテムモデルがカテゴリに属し、さらにいくつかのカテゴリに属す可能性がある時のような関係です。

### 中間モデルの作成

この多対多の関係を作成するには、まず、中間モデルを作成し、この中間モデルがそれぞれのレコードで対応するアイテムとカテゴリを保存しておきます。そのため、まず下記のようにその中間モデルを作ります。

{% highlight ruby linenos %}
$ rails g migration CreateCategoryItems
{% endhighlight %}

{% highlight ruby linenos %}
# 生成されたマイグレーションファイル
class CreateCategoryItems < ActiveRecord::Migration
  def change
    create_table : category_items do |t|
      t.integer :item_id, :null=> false;
      t.integer :category_id, :null=> false;
 
      t.datetime :create_at
      t.datetime :update_at
    end
  end
end
{% endhighlight %}

{% highlight ruby linenos %}
# その中間モデルファイルも作成
class CategoryItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :category
end
{% endhighlight %}

### 各モデルの関連付け

上記のように中間モデルを作成したら、次は具体的な多対多の関係になる２つのモデルを関連付けていきます。 

{% highlight ruby linenos %}
# item.rb
# Relationship with Category
  has_many :category_items 
  has_many :categories, :through => :category_items 
{% endhighlight %}

{% highlight ruby linenos %}
# major.rb
# Relationship with Item
  has_many :category_items 
  has_many :items, :through => :category_items 
{% endhighlight %}

これだけで多対多のモデル関係ができました。実際に成功したか確認するには、コンソールで、下記のように入力し、エラーがでなければ大丈夫でしょう。マイグレーションを適応するのを忘れずに。

{% highlight ruby linenos %}
$ rails c 
$ i = Item.first
$ i.categories.count
{% endhighlight %}