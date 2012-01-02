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
    ADBannerView *_banner = (ADBannerView *)[[self view] viewWithTag:12];
    
    _banner.currentContentSizeIdentifier = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? 
                                            ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierLandscape;
    
    
    CGRect bannerSize;
    bannerSize.size = [ADBannerView sizeFromBannerContentSizeIdentifier:_banner.currentContentSizeIdentifier];
    
    //Get content view
    UIView *_contentView = [[[self view] subviews] objectAtIndex:0];

    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGRect contentFrame = [_contentView bounds];
    CGRect bannerFrame = _banner.frame;
    
    if (_banner.bannerLoaded) {
        if (bannerFrame.origin.y == bounds.size.height) {
            contentFrame.size.height = bounds.size.height - [[self tabBar] bounds].size.height - bannerSize.size.height;
            bannerFrame.origin.y = contentFrame.size.height;
        }
    } else {
        if (bannerFrame.origin.y < bounds.size.height) {
            contentFrame.size.height = bounds.size.height - [[self tabBar] bounds].size.height;
            bannerFrame.origin.y = bounds.size.height;
        }
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"Rotated");
	[self layoutBanner];
}


@end
