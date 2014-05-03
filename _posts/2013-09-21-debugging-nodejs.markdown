---
layout: post
title: "Debugging Node.js"
date: "2013-09-21 02:21:00"
categories: [Node.js]
---

Recently I have just started studying Node.js and so I'm a still novice in Node.js. Therefore, there are many bugs in my code. That's why I'd like to write down how to debug Node.js effectively.

### Setting

First, we need to install Node inspector by using npm. You must familiar with it. This tool is so general to use. It's better to add -g option to install globally. And you probably have to execute it on sudo. like :

>> sudo npm install -g node-inspector

That's it. You can use it now.

### How to use

To debug, you add --debug-brk flag when you execute your code. It allow us to use Javascript debugger. After that, run node inspector that you installed awhile ago in different tab or window.

>> node-inspector

You will get a message like Visit http://127.0.0.1:8080/debug?port=5858 to start debugging. So, follow the instruction and then we can see the debug tool. It's so helpful to learn Node.js. It teach us how Node.js is executed.