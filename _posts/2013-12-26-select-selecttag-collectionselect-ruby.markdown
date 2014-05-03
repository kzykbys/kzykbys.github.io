---
title: "select, select_tag, collection_select 違い [ Ruby on Rails ]"
layout: "post"
date: "2013-12-26 03:33:00"
categories: [Ruby on Rails]
---

Railsで動的に\<select\>でドロップダウンリストを作成することはよくあると思います。select, select_tag, collection_select の違いが下記のブログ記事が詳しかった。

参考：http://shiningthrough.co.uk/Select-helper-methods-in-Ruby-on-Rails

### select 

通常のドロップダウンリストをDBから情報を取得せずに作成する際に使用します。

### select_tag

こちらもDBからの情報で\<option\>を生成しない時に使用します。こちらはデフォルトの選択された\<option\>を指定したい時や、formで GET によるDBとの通信がある時に使用されます。

selectとselect_tagに違いはドキュメントによると、

>> size属性がつく<br />
>> POSTパラメータがハッシュ形式

ということらしいです。

### collection_select

最後のcollection_selectはドロップダウンリストをDBからの情報を元に作成したいときに使用します。