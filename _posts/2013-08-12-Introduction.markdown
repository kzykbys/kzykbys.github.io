---
layout: post
title: "Introction to DropBox SDK"
date: 2013-08-12 00:00:00
categories: [Objective-C]
---

>> {{ page.date | render_deprecate: 6 }}  
  
There are many applications that can communicate with DropBox. DropBox is the most famous storage service mainly because of how easy people can use it. I’m pretty sure that you’ve heard about it and that most of you are also using it. So, it is natural to think of making applications interact with it. I’d like to introduce how to implement DropBox service in your iOS application.

### 1. Introduction

Let’s get started. First of all, you should install the SDK from dropbox. ( The latest one is 1.3.5 ) [https://www.dropbox.com/developers/core/sdks/ios] (https://www.dropbox.com/developers/core/sdks/ios) After that, you should register your application at DropBox developer website. [https://www.dropbox.com/developers/apps] (https://www.dropbox.com/developers/apps) In my case, I want to make an app that makes csv files, gets them and display them. So, it goes like this :

![](/images/2013/08/a.png)

You can get “App key” and “App secret”. We’ll use them when we write code. 

### 2. Setting your app

After you get DropBox SDK, you should integrate it into your app. In Xcode, you add “DropboxSDK.framework”. This can be accomplished by control-click on Project Navigator and “add files to blabla”. Also, DropBox uses “Security.framework” and “QuartzCore.framework” so please add the frameworks from project summary screen. After that, you can finally write your code. It’s fun!!

### 3. Implement DropBox SDK

We add the code to make a session with dropbox:

{% highlight objective-c linenos %}
DBSession* dbSession = [[DBSession alloc] initWithAppKey:@"blabla" //Appkey
                                               appSecret:@"blabla" //secretkey
											        root:@"sandbox"];
[DBSession setSharedSession:dbSession];
{% endhighlight %}

This code is “/* Creating and setting the shared DBSession should be done before any other Dropbox objects are used, perferrably in the UIApplication delegate. */ ”. 

Also, you add this code in your view controller. 

{% highlight objective-c linenos %}
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	if(![[DBSession sharedSession] isLinked])
	{
		[[DBSession sharedSession] linkFromController:self];
	}
}
{% endhighlight %}

There are many people who forget to edit Info.plist file ( I took some time to figure it out too ). In your Info.plist, please add this url scheme :CFBundleURLTypes CFBundleURLSchemes db-YourAPIKEY 

One way of adding this code is to control-click the Info.plist file,“Open as...” and “Source Code”. If you forget this step, this kind of error message will appear:

> [ERROR] DropboxSDK: unable to link; app isn't registered for correct URL scheme

At this time, you can see the login screen to dropbox when you launch your app. If you did it on viewDidLoad function, xcode will warn you about the window hierarchy and you’ll fail to show login screen.

![](/images/2013/08/b.png)

### 4. How to use DropBox SDK

So far we’ve only implemented DropBox SDK. I’d like to show some basic function to be able to use it. First, let’s add delegate and prepare for DBRestClient class. In your viewcontroller, add something like this : 

{% highlight objective-c linenos %}
#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
@interface KKViewController : UIViewController<DBRestClientDelegate>

@property (nonatomic, readonly) DBRestClient *restClient;

@end 
{% endhighlight %}

We added “<DBRestClientDelegate>” and the property. 
After that, write getter to the restClient in your viewcontroller implement file like this : 

{% highlight objective-c linenos %}
// Getter
- (DBRestClient *)restClient
{
	if (!_restClient)
	{
		restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
		_restClient.delegate = self;
	}
	return restClient;
}
{% endhighlight %}



### 5. Some Features

Functions :

Loads metadata for the object at the given root/path and returns the result to the delegate as a dictionary
{% highlight objective-c linenos %}
- (void)loadMetadata:(NSString*)path;
{% endhighlight %}

Uploads a file that will be named filename to the given path on the server. sourcePath is the full path of the file you want to upload. If you are modifying a file, parentRev represents the rev of the file before you modified it as returned from the server. If you are uploading a new file set parentRev to nil.

{% highlight objective-c linenos %}
- (void)uploadFile:(NSString *)filename
            toPath:(NSString *)path
	 withParentRev:(NSString *)parentRev
	      fromPath:(NSString *)sourcePath; 
{% endhighlight %}

Loads the file contents at the given root/path and stores the result into destinationPath

{% highlight objective-c linenos %}
- (void)loadFile:(NSString *)path intoPath:(NSString *)destinationPath;
{% endhighlight %}

This function is for deleting your file.

{% highlight objective-c linenos %}
 - (void)deletePath:(NSString*)path;
{% endhighlight %}

Delegate : 

The delegate provides allows the user to get the result of the calls made on the DBRestClient. Right now, the error parameter of failed calls may be nil and [error localizedDescription] does not contain an error message appropriate to show to the user.

{% highlight objective-c linenos %}
- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata; 
{% endhighlight %}

### 6. End

If you have any corrections or new ideas related to this post, please feel free to share your thoughts. Also, I made a simple application that can communicate with dropbox and show the csv file in collection view. If you’ll check this out, that would be great. [https://github.com/kzykbys/DropBoxAPIwithCollectionView ](https://github.com/kzykbys/DropBoxAPIwithCollectionView ) Thank you.
