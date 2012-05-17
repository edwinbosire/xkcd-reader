//
//  AppDelegate.m
//  xkcd
//
//  Created by Denis on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "favouriteViewController.h"

#import "AllComicsViewController.h"

#import "FlurryAnalytics.h"

#warning FLURRY KEY IS MISSING
#define kFLURRY_KEY @"PUT-YOUR-FLURRY-KEY-HERE"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navigationalController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
 
    UIViewController *favouriteVC = [[favouriteViewController alloc] initWithStyle:UITableViewStylePlain];
    UIViewController *allComicsVC = [[AllComicsViewController alloc] initWithNibName:@"AllComicsViewController" bundle:nil];
    
    navigationalController = [[UINavigationController alloc] initWithRootViewController:allComicsVC];
    UINavigationController *favouriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favouriteVC];
    
    UITabBarItem *updatesItem = [[UITabBarItem alloc] initWithTitle:@"Comics" image:[UIImage imageNamed:@"chats.png"] tag:1];
    [navigationalController setTabBarItem:updatesItem];
    
    UITabBarItem *favItem = [[UITabBarItem alloc] initWithTitle:@"Favourites" image:[UIImage imageNamed:@"favstar.png"] tag:1];
    [favouriteNavigationController setTabBarItem:favItem];
    
    navigationalController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    favouriteNavigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationalController,favouriteNavigationController, nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [self customizeNavigation];
    
    [FlurryAnalytics startSession:kFLURRY_KEY];
    
    return YES;
}


- (void)customizeNavigation{
    
    UIImage *navBarImage = [UIImage imageNamed:@"nav-bar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage 
                                       forBarMetrics:UIBarMetricsDefault];
    
    UIImage *barButton = [UIImage imageNamed:@"nav-bar-btn.png"];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [UIImage imageNamed:@"back-btn-big.png"];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal 
                                                    barMetrics:UIBarMetricsDefault];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tab-bar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"menu-bar-item-bg.png"]];
    
    UIImage *minImage = [UIImage imageNamed:@"slider-fill.png"];
    UIImage *maxImage = [UIImage imageNamed:@"slider-bg.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"slider-cap.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage 
                                       forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage 
                                       forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage 
                                forState:UIControlStateNormal];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
