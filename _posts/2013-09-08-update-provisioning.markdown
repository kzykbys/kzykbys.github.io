---
layout: post
title: "Update Provisioning"
date: "2013-09-08 19:24:00"
categories: [Objective-c]
---

One of my struggles was adding my second test iOS device to test my app by using Push Notification. I hope that this short instruction will help you.

As you know, using Push Notification require App ID without wild card and Provisioning file of it. When you add your test iOS device, you need to update this Provisioning file. I didn't know that it has to be like that. So, Xcode keep sending me an error like this :

"The entitlements specified in your application’s Code Signing Entitlements file do not match those specified in your provisioning profile."

> 0xE8008016

To avoid this error, we should update our Provisioning file. To do so, go to Apple developer website, edit the Provisioning file using Push Notification, add your new test device, download it and copy it into ~/Library/MobileDevice/Provisioning Profiles.

![](http://1.bp.blogspot.com/-Rtv--iBGpzo/UizNJ4pqzKI/AAAAAAAAAI0/M9GwMkoZrP0/s1600/Provision1.png)

![](http://2.bp.blogspot.com/-GWFRaI77-zk/UizNS1xZK6I/AAAAAAAAAI8/rzUDv9mIw4s/s1600/Provision2.png)

