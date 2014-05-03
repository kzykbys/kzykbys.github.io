---
title: "Net::SMTPAuthenticationError: 534-5.7.9 Please log in with your web  browser and then try again."
layout: "post"
date: "2013-11-30 07:17:00"
categories: [Ruby on Rails]
---

RoR にて、ユーザー登録時に確認メールをユーザーのアドレスに Gmail から送信する機能を実装しました。その後、何度かテストをしていると、

>> Net::SMTPAuthenticationError: 534-5.7.9 Please log in with your web browser and then try again.

特にコードに問題はないはずにもかかわらず、上記のようなエラーを吐き出しました。

僕の場合、 ブラウザで Gmail にアクセスし、コンフィグ等に入力し、ユーザーへメールを送信する役目を担っている Gmail アカウントへログインすれば問題はすぐ解決しました。