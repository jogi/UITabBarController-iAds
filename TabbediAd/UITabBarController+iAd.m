//
//  UITabBarController+iAds.m
//  TabbediAds
//
//  Created by Vashishtha Jogi on 1/2/12.
//  Copyright (c) 2012 Vashishtha Jogi. All rights reserved.
//

#import "UITabBarController+iAd.h"

@implementation UITabBarController (iAd)

- (void) showiAds
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    ADBannerView *_bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, bounds.size.height, 0.0, 0.0)];
    _bannerView.delegate = self;
    _bannerView.tag = 12;
    
    [[self view] addSubview:_bannerView];
}

- (void) layoutBanner
{
    float height = 0.0;
    ADBannerView *_banner = (ADBannerView *)[[self view] viewWithTag:12];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        _banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        height = bounds.size.height;
    } else {
        _banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
        height = bounds.size.width;
    }
    
    CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:_banner.currentContentSizeIdentifier];
    
    //Get content view
    UIView *_contentView = [[[self view] subviews] objectAtIndex:0];
    
    CGRect contentFrame = [_contentView bounds];
    CGRect bannerFrame = [_banner bounds];
    
    if (_banner.bannerLoaded) {
        contentFrame.size.height = height - [[self tabBar] bounds].size.height - bannerSize.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        contentFrame.size.height = height - [[self tabBar] bounds].size.height;
        bannerFrame.origin.y = bounds.size.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _banner.frame = bannerFrame;
        [_contentView setFrame:contentFrame];
        [_contentView layoutIfNeeded];
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
