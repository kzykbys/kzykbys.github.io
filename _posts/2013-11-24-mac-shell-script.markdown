---
title: "Mac 起動時の Shell Script 実行"
layout: "post"
categories: [Tips]
excerpt: "タイトルの通りMac で使えるのちょっとしたテクニックです。最近、ほぼ毎日使う図書館の Wi-fi 使用するために、毎回ユーザーIDとパスワードを入力するがあり、そのユーザーIDが意味のない15桁の数字の羅列で毎回 Sticker からコピペしていたのですが、その手間を省こうと、Mac 起動時にクリップボードにユーザーIDを設定し、起動と同時に使用できるというハックです。"
---

### Mac 起動時に Shell スクリプトを走らせる

タイトルの通りMac で使えるのちょっとしたテクニックです。最近、ほぼ毎日使う図書館の Wi-fi 使用するために、毎回ユーザーIDとパスワードを入力するがあり、そのユーザーIDが意味のない15桁の数字の羅列で毎回 Sticker からコピペしていたのですが、その手間を省こうと、Mac 起動時にクリップボードにユーザーIDを設定し、起動と同時に使用できるというハックです。

まず、Automator を起動し、Workflowを作成します。検索機能から shell 等打ち、” Run Shell Script ”を選択。ウィンドウの右側に Shell の選択とスクリプトを入力する画面が現れるのでそこにスクリプトを入力します。あとは普通に保存。そうするとこのスクリプトを実行してくれるアプリケーションができます。画像の例は本当にシンプルな 0916 という数字をクリップボードに設定してくれるコマンドです。後は Command-v で 0916 という文字をペーストできます。

![](http://1.bp.blogspot.com/-4aayBY6cquU/UpJTEAYzT3I/AAAAAAAAAKs/p-bNzAoRC2E/s1600/Screen+Shot+2013-11-22+at+9.58.23+AM.png)

Spotlight 等から Automator を実行し、workflow を作成。

![](http://3.bp.blogspot.com/-47w_cSalSw4/UpJTERb6ZeI/AAAAAAAAAK0/ZMdupvtdtjI/s1600/Screen+Shot+2013-11-22+at+9.59.21+AM.png)

" Run Shell Script " を選択

![](http://2.bp.blogspot.com/-lD_S-JLdcvQ/UpJTDyvrXuI/AAAAAAAAAKk/wr681-lO59o/s1600/Screen+Shot+2013-11-22+at+10.01.28+AM.png)

右側に現れるこのような画面にコマンド入力

肝心の起動時にこのアプリケーションを起動してくれる設定ですが、 “System Preferences “ から登録したいユーザーを選び、”Login Items” というタブをさらに選択し、左下の ”＋”ボタンから先ほど作成したアプリケーションを登録して完了です。

![](http://1.bp.blogspot.com/-CpGisNkQR-M/UpJTDwHugPI/AAAAAAAAAKw/Bu7KLP2Uvzs/s1600/Screen+Shot+2013-11-22+at+10.13.23+AM.png)

他にもいくつか方法があるみたですが、なかなか自分は上手く行きませんでした。上記の方法なら誰にでも簡単に設定できるのではないでしょうか。セキュリティ上、パスワードを起動時にクリップボードに設定してしまうのは大変危険だと思うので、注意してください。