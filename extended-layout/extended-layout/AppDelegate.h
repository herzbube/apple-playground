//
//  AppDelegate.h
//  extended-layout
//
//  Created by Patrick Näf Moser on 05.03.22.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate*) sharedAppDelegate;

@property (strong, nonatomic) UIWindow* window;

@property (strong, nonatomic) UIColor* defaultWindowBackgroundColor;
@property (strong, nonatomic) UIColor* defaultTabBarControllerViewBackgroundColor;
@property (strong, nonatomic) UIColor* defaultNavigationControllerViewBackgroundColor;
@property (strong, nonatomic) UIColor* defaultTableViewControllerViewBackgroundColor;
@property (strong, nonatomic) UIColor* defaultNavigationBarBackgroundColor;
@property (strong, nonatomic) UIColor* defaultTabBarBackgroundColor;

@property (strong, nonatomic) UIColor* customWindowBackgroundColor;
@property (strong, nonatomic) UIColor* customTabBarControllerViewBackgroundColor;
@property (strong, nonatomic) UIColor* customNavigationControllerViewBackgroundColor;
@property (strong, nonatomic) UIColor* customTableViewControllerViewBackgroundColor;
@property (strong, nonatomic) UIColor* customNavigationBarBackgroundColor;
@property (strong, nonatomic) UIColor* customTabBarBackgroundColor;

- (void) updateBarsInViewController:(UIViewController*)viewController
   bySwitchingTabInTabBarController:(UITabBarController*)tabBarController;

@end

