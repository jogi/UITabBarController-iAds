//
//  UITabBarController+iAds.m
//  TabbediAds
//
//  Created by Vashishtha Jogi on 1/2/12.
//  Copyright (c) 2012 Vashishtha Jogi. All rights reserved.
//

#import "UITabBarController+iAd.h"

#define iOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

@implementation UITabBarController (iAd)

- (void)showiAds
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
	ADBannerView *_bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
	_bannerView.frame = CGRectMake(0.0, bounds.size.height, 0.0, 0.0);
    _bannerView.delegate = self;
    _bannerView.tag = 12;
    [self.view addSubview:_bannerView];
}

- (void)layoutBanner
{
    ADBannerView *_banner = (ADBannerView *)[self.view viewWithTag:12];
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    CGSize bannerSize = [_banner sizeThatFits:bounds.size];
    
    //Get content view
	UIView *_contentView = self.selectedViewController.view;
    
    CGRect contentFrame = _contentView.frame;
    CGRect bannerFrame = _banner.frame;
    bannerFrame.size = bannerSize;
    
    if (_banner.isBannerLoaded) {
        CGFloat aTabbarHeight = 0;
        if ([self.selectedViewController isKindOfClass:[UITableViewController class]]) {
            aTabbarHeight = self.tabBar.frame.size.height;
        }
        contentFrame.size.height = contentFrame.size.height - bannerSize.height - aTabbarHeight;
        bannerFrame.origin.y = contentFrame.size.height - aTabbarHeight;
    } else {
        contentFrame.size.height = contentFrame.size.height;
        bannerFrame.origin.y = bounds.size.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _banner.frame = bannerFrame;
		_contentView.frame = contentFrame;
    } completion:^(BOOL finished) {
		[self.view bringSubviewToFront:_banner];
	}];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Did load");
    [self layoutBanner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Did not load");
    [self layoutBanner];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"Did rotate");
	[self layoutBanner];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"View did transtion");
    [self layoutBanner];
}


@end
