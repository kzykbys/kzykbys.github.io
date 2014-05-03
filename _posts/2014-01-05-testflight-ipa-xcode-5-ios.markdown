---
title: "TestFlight IPA の作成から登録まで ( Xcode 5 ) [ iOS 開発 ]"
layout: "post"
date: "2014-01-05 01:09:00"
categories: [Objective-c]
---

TestFlight は本当に便利です。チームでアプリ開発をする際に、メンバーにアプリの進捗を確認してもらうために自分のパソコンを持ち歩き確認してもらうの面倒です。TestFlight は AppStore に公開する前からメンバーの iPhone 等の端末に開発途中のアプリをダウンロードできるサービスです。このエントリーでは Xcode5 で IPA を作成し、メンバーがアプリをダウンロードできるようになるまでのチュートリアルを簡潔に翻訳してみようと思います。

TestFlight のこのページを見れば全て分かると思うので、英語ができる人はそちらを見たほうが正確だと思います。

### 基本となるアプリの作成

1 . あなたのプロジェクトのためのテンプレートの選択。この例では、シングルビューを選択します。

![](http://2.bp.blogspot.com/-LeVcd6Yi2oA/UsiqrMB4feI/AAAAAAAAAN0/I7LNUqryAMQ/s1600/Screen_Shot_2013-10-14_at_4.46.26_PM.png)

2 . プロダクト名、company identifier、他の設定を入力。プロダクト名と company identifier は Bundle Identifier の生成のために合成されます。これは、アプリをビルド、共有される時、どのプロビジョンファイルが使われるかを決定するために使われます。

![](http://2.bp.blogspot.com/-xirkwLLodyg/UsireEDcB-I/AAAAAAAAAN8/qwnIyLa49ws/s1600/2.png)

3 . 左のドロップダウンメニューのファイルリストにて、あなたのターゲットを選択してください。サマリータブにて、Bundle Identifier がステップ2にもとづき生成されています。

![](http://2.bp.blogspot.com/-hevFELUmhms/Usir-PhrqII/AAAAAAAAAOE/jaB6yiBSl4Q/s1600/3.png)

4 . Build Setting タブを選択、Code Signing までスクロールし、プロビジョンファイルを広げてください。デバッグ、リリースのデフォルトの値に対して、開発用のプロビジョンにデバック、アドホックのプロビジョンにリリースを関連付けます。

![](http://4.bp.blogspot.com/-cj58XmsomFc/UsisjNWbfiI/AAAAAAAAAOM/klVaJOea2cM/s1600/4.png)

5 . 左上のドロップダウンメニューにて Edit Scheme を選択。今までにビルドされた状況により、デフォルトの設定は変えられています。もしシミュレーターかあなたの端末でテストするために Run するとデバッグの設定で実行されます。また、もしアーカイブするとリリースの設定で実行されます。これはアドホックかアップストア向けです。

![](http://1.bp.blogspot.com/-XVEi1pkGhnY/UsitZXrn53I/AAAAAAAAAOU/iFkHrWid_nU/s1600/5.png)

### IPAファイルの生成

一番簡単に TestFlight にアップロードされる IPA を作成する方法は、アプリをアーカイブし Xcode のオーガナイザで生成する方法です。

1 . ビルドターゲットをシミュレーターから iOS Device に変更。

![](http://1.bp.blogspot.com/-sdsgWS4tN9w/UsiuC-W4wMI/AAAAAAAAAOc/S9gy7X9wkNk/s1600/6.png)

2 . Product メニューで、アーカイブを選択。これはアドホックかアップストア用のプロビジョンの設定でビルドします。上記のステップ5で設定した通りです。もしビルドしなかったら、cmd-shift-2 か window - organizer を選択し、何かポップアップが出てきたらそれを許可してください。

3 . オーガナイザのアーカイブタブを選択し、あなたのアプリを選択してください。もし自動で選択されていなかったら、あなたが共有したいアーカイブを選択してください。

![](http://4.bp.blogspot.com/-TSiPgTU0NFU/UsivABUdr-I/AAAAAAAAAOo/7-T77nMhWGk/s1600/7.png)

4 . Distributeボタンをクリックし、次のウィンドウで “Save for Enterprise or Ad-Hoc Deployment” を選択し、next。

![](http://3.bp.blogspot.com/-QECLPZJ82S0/Usiva5sq0iI/AAAAAAAAAOw/ZLHuRoXnAh4/s1600/8.png)

5 . ドロップダウンメニューにて、配布用のプロビジョンファイルを指定。これは上記のステップ5でしたもの。

![](http://4.bp.blogspot.com/-JZtYEdEeclI/UsiwUm9cidI/AAAAAAAAAO8/hqnXZKIa7Rs/s1600/9.png)

6 . IPAを保存し、TestFlight にアップロード。
