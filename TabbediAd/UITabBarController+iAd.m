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
    float height = 0.0;
    ADBannerView *_banner = (ADBannerView *)[self.view viewWithTag:12];
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        _banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        height = bounds.size.height;
    } else {
        _banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
        height = bounds.size.width;
    }
    
    CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:_banner.currentContentSizeIdentifier];
    
    //Get content view
	UIView *_contentView = self.selectedViewController.view;
    
    CGRect contentFrame = _contentView.frame;
    CGRect bannerFrame = _banner.frame;
    
    if (_banner.isBannerLoaded) {
		if (iOS7) {
			contentFrame.size.height = height - bannerSize.height;
			bannerFrame.origin.y = contentFrame.size.height - self.tabBar.frame.size.height;
		} else {
			contentFrame.size.height = height - self.tabBar.frame.size.height - bannerSize.height;
			bannerFrame.origin.y = contentFrame.size.height;
		}
    } else {
		if (iOS7) {
			contentFrame.size.height = height;
			bannerFrame.origin.y = bounds.size.height;
		} else {
			contentFrame.size.height = height - self.tabBar.frame.size.height;
			bannerFrame.origin.y = bounds.size.height;
		}
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


@end
