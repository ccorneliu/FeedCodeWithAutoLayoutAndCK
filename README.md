# FeedCodeWithAutoLayoutAndCK
This is the demo code used for my presentation about ComponentKit (in Romanian)

Purpose of this project
-----------------------
I tried to showcase the basics of ComponentKit.

Also you can compare the performance between AutoLayout complex views and views built with ComponentKit.

How?

I created to similar somewhat complex UIs with AutoLayout and then used ComponentKit to create the same views. In order to compare the two, you can profile the project and run the "Core Animation" instrument, on your device. You will notice the framerate difference, while scrolling the list.

To switch between AutoLayout and ComponentKit, please just set the appropriate Initial View Controller in the storyboard (it's in the View project group).

![](https://github.com/ccorneliu/FeedCodeWithAutoLayoutAndCK/blob/master/storyboardScreenshot.png)

Disclaimer
----------
0. Sorry, I didn't use proper source control.
0. I consider View Controllers part of the View, because, generally, they're very coupled with the views in iOS architecture. I used an MVVM architecture, in this project. The architecture of the project is not perfectly designed, I could've used maybe a couple of more protocols, but I focused on showcasing the basics of ComponentKit.
