---
title: "Change Dynamically Text and Color in iOS"
layout: "post"
date: "2013-09-23 02:11:00"
categories: [Objective-c]
---

I think we often encounter the situation we want to change the text color based on the length of the message in iOS programming. The famous example is twitter. When we type tweet and the tweet is over 140, the counter become red. like there : 

![](http://4.bp.blogspot.com/-pA1aMN-nje0/Uj-eApF_EzI/AAAAAAAAAJU/jsnVbwCPn5A/s1600/1.png)

![](http://2.bp.blogspot.com/-me3klHRsxqo/Uj-eBkurg3I/AAAAAAAAAJc/Xh0S3itJxLc/s1600/2.png)

This twitter editing modal view automatically show the count and change the color based on the user typing.

### How to implement

This is easily accomplished. Here is simple code :

{% highlight objective-c linenos %}
#import "KKViewController.h"

@interface KKViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UILabel     *labelCount;

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Textfield
    self.textfield                 = [[UITextField alloc] init];
    self.textfield.frame           = CGRectMake(10, 100, 300, 30);
    self.textfield.borderStyle     = UITextBorderStyleRoundedRect;
    self.textfield.placeholder     = @"Type message for this people.";
    self.textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textfield addTarget:self
                       action:@selector(textAttributesBasedOnTyping:)
             forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:self.textfield];
    
    // Count Text
    self.labelCount           = [[UILabel alloc] init];
    self.labelCount.frame     = CGRectMake(140, 50, 40, 40);
    self.labelCount.text      = [NSString stringWithFormat:@"%i",140 - [self.textfield.text length]];
    self.labelCount.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8];
    
    [self.view addSubview:self.labelCount];
    
}

-(void)textAttributesBasedOnTyping:(id)sender
{
    if([sender isKindOfClass:[UITextField class]])
    {
        self.labelCount.text     = [NSString stringWithFormat:@"%i",140 - [self.textfield.text length]];
        
        // Change color by the count of text length
        if([self.textfield.text length] <= 140)
        {
            self.labelCount.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8]; // Gray
        }
        else
        {
            self.labelCount.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];  // Red
        }
    }
}

@end
{% endhighlight %}

The point is adding Target ( - (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;) and using "UIControlEventEditingChanged" in my textAttributesBasedOnTyping function. By this code, we can change dynamically the text ( number in this case ) and the color at the same time. It is so convenient. Furthermore, we can add some more effect like the twitter's tweet button in above photos. If we type over 140 characters, we won't be allowed  to tweet it by disable the button. It is helpful to validate something in client side. 

If you have better solution, feel free to tell me. 