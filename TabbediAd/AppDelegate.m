//
//  AppDelegate.m
//  TabbediAd
//
//  Created by Vashishtha Jogi on 1/2/12.
//  Copyright (c) 2012 Vashishtha Jogi. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "TableViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2, *viewController3;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
    } else {
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
    }
    viewController3 = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, [[UINavigationController alloc] initWithRootViewController:viewController3], nil];
	self.tabBarController.delegate = self;
	if ([self.tabBarController.tabBar respondsToSelector:@selector(setTranslucent:)]) {
		// tab bar looks ugly without view controller behind when it is translucent
		self.tabBarController.tabBar.translucent = NO;
	}
    self.window.rootViewController = self.tabBarController;
    
    [self.tabBarController showiAds];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	[self.tabBarController layoutBanner];
}
@end
