---
title: "Naked domain problem | Heoku - Godaddy |"
layout: "post"
date: "2013-12-02 08:05:00"
categories: [Tips]
---

Recently I'm developing RoR application on Heroku. In this post, I'd like to share how to solve naked domain problem in my environment (Heroku and Goddady ).

Naked domain problem is big concern. Basically, naked domain is like example.com. It doesn't have www prefix. We sometimes can't use our website when we access the naked domain without www. To solve this problem on Heroku, we should follow some steps. In my case, I got domain from Godaddy. So, I'm gonna show how to do that in this situation.

### Set up ( Heroku )

In your command line, type

{% highlight ruby linenos %}
$ heroku domains:add www.example.com
$ heroku domains:add example.com
{% endhighlight %}

Also, you can check the result by typing

{% highlight ruby linenos %}
$ heroku host www.example.com
$ heroku host example.com
{% endhighlight %}

### Set up ( Goddady )

Ⅰ. "Visit My Account" and "Launch" Domains row

Ⅱ. Choose your domain which you want to solve naked domain problem

Ⅲ. In the "Domain Details", find "Forwarding" row and click "Manage"

Ⅳ. Type like "www.example.com"

That's it. After a few minutes, your naked domain problem is solved.