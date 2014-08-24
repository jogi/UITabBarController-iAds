UITabBarController+iAds
================
*Simple and easy to use UITabBarController category which adds support for displaying iAds*

There are numerous shared iAds implementations out there including one from [Apple](http://developer.apple.com/library/ios/#samplecode/iAdSuite/Introduction/Intro.html). All of them require a lot of work on your side to get it work. Moreover none of the existing implementations support auto resizing of views upon display of iAd without doing significant amount of changes to the existing code. To over come this I created this category.

Support
================
iOS 5.0+

Usage
================
1. Import ```UITabBarController+iAd.h``` in the AppDelegate and then make a call to ```[self.tabBarController showiAds]```
2. Implement `didSelectViewController` tab bar controller delegate method in AppDelegate and make a call to `layoutBanner`

License
================
[Under a Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/)
