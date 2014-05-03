---
layout: post
title: "Block'c  Modification and Scope"
date: "2013-09-21 05:03:00"
categories: [Objective-c]
---

I often encounter Blocks when I write Objective-C. It's always kind confusing for me. The syntax is awkward and I honestly cannot still understand why using Block is useful. I have read really a helpful book about this topic and I found the different concept of scope in Blocks. I'd like to write down it here. I believe I will be confused about it again.

### 1. Modify Variable in Blocks

To modify variable, we should use "__block" when we declare the variable. Otherwise, our compiler display error if we try to modify variable. 

{% highlight objective-c linenos %}
 __block NSString *blala    = @"Use __block!!";
 NSString         *foolish  = @"Error will couse";
        
 void (^testBlocks)(void)   =
        ^(void){
            
            blala   = @"It's OK.";
            foolish = @"It's not allowed"; // Error
            
        };
{% endhighlight %}

This code doesn't work because we are trying to modify foolish variable. If we comment the variable out, the code works. So, we should add __block at the declaration of this variable to change the value in Blocks.

### 2. Scope of Blocks

The scope of Blocks is more confusing. Let's take a look a simple example.

{% highlight objective-c linenos %}
 NSString *blala = @"BLOCKS!!";
        
 void (^output)(void) =
        ^(void){
            
            NSLog(@"Blala : %@",blala);
            
        };
        
        blala = @"Calm down.";
        
        output(); // Output : BLOCKS!
{% endhighlight %}

If we think blocks is a like function, we expect the out put which is "Calm down.". But actually this code will show "BLOCKS!!". The scope that blocks access is determined at the time blocks is called. Therefore,  in this case ( 1. @"BLOCKS!!" 2. Blocks 3. @"Calm down"), this output is "BLOCKS!!"

I expected that calling this block to show "Calm down". To do so, we should use "__block" again like before.

{% highlight objective-c linenos %}
__block NSString *blala = @"BLOCKS!!";
        
void (^output)(void) =
        ^(void){
            
            NSLog(@"Blala : %@",blala);
            
        };
        
blala = @"Calm down.";
        
output(); // Output : Calm down
{% endhighlight %}

Just by adding __block, we changed the output. 

I hope it was help to understand how block scope is determined and how to change a variable in blocks.