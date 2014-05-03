---
title: "Unsign と Sign の注意点"
layout: "post"
date: "2014-03-31 06:01:00"
categories: [C]
---

"[Expert C Programming](http://www.amazon.com/gp/product/0131774298)" を読んでいてunsign と sign を扱うときにおもしろかった違いがあったのでメモ。

ご存じの通り、unsign と sign の数字は、MSB をプラスかマイナスかを表現するために使用するかどうかの違いです。仮に 8 bits で数字を表現することを考えてみると、unsign は 8bits 全てを正の数を表すために使用します。そのため、8bits で表すことができる範囲は、0 から 255 です。一方、sign は MSB で符号を示します。MSB がセットされていれば、その 8bits で表された数字は負です。範囲は、-128 から 127 です。そこで、下記のような C のプログラムを見てみると、

{% highlight c linenos %}
#include <stdio.h>
 
int array[] = {23, 34, 12, 17, 204, 99, 16};
#define TOTAL_ELEMENTS (sizeof(array) / sizeof(array[0]))
 
int main(int argc, const char * argv[])
{
 
    int d = -1;
     
    if(d <= TOTAL_ELEMENTS){ // false
        /*
         * This if statement is false, because the logical statement
         * compares two values as unsign integer. sizeof() return unsign value.
         * In 8 bits, -1 is 11111111b, FFh and  255 decimal number.
         * So, it compares 255d and 7 (the number of elements). => false
         */
        printf("Invalid\n");
    }
     
    if(d <= (int) TOTAL_ELEMENTS){ // true
        /*
         * We cast unsign integer into sign integer.
         * In this context, -1 is literally -1. 
         * So, it compares -1 and 7 (the number of elements). => true
         */
        printf("Expected Result.\n");
        printf("TOTAL_ELEMENTS : %lu\n", TOTAL_ELEMENTS);
    }
    return 0;
}
{% endhighlight %}

一つ目の if 文は false を返します。sizeof が unsign integer を返すので、この比較は unsign で実行されます。-1 は、0xFF、十進数で 255であり、配列の要素数より大きいです。そのため、この if 文の中は実行されません。
二つ目の if 文は、unsign integer である、TOTAL_ELEMENTS をキャストし、sign integer として扱うため、期待している結果が表示されます。

アセンブリの勉強をしている時などに、unsign と sign の数字というのは、知識としてあったのですが、C の中でも気をつけないとハマる可能性があるという教訓でした。 

*** 

<iframe src="http://rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=komchax-22&o=9&p=8&l=as1&m=amazon&f=ifr&ref=tf_til&asins=4756116396" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
