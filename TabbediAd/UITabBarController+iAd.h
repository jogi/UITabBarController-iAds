//
//  UITabBarController+iAds.h
//  TabbediAds
//
//  Created by Vashishtha Jogi on 1/2/12.
//  Copyright (c) 2012 Vashishtha Jogi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface UITabBarController (iAd) <ADBannerViewDelegate>

- (void) showiAds;
- (void) layoutBanner;

@end
