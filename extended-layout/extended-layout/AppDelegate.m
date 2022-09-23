//
//  AppDelegate.m
//  extended-layout
//
//  Created by Patrick Näf Moser on 05.03.22.
//

#import "AppDelegate.h"
#import "NavigationBarViewController.h"
#import "TableViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  UITableViewController* navigation1RootViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController* tab1RootViewController = [[UINavigationController alloc] initWithRootViewController:navigation1RootViewController];
  tab1RootViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];

  NavigationBarViewController* tab2RootViewController = [[NavigationBarViewController alloc] initWithNumberOfNavigationBars:1];
  tab2RootViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];

  NavigationBarViewController* tab3RootViewController = [[NavigationBarViewController alloc] initWithNumberOfNavigationBars:3];
  tab3RootViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];

  ViewController* navigation4RootViewController = [[ViewController alloc] init];
  UINavigationController* tab4RootViewController = [[UINavigationController alloc] initWithRootViewController:navigation4RootViewController];
  tab4RootViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:3];

  UITabBarController* tabBarController = [[UITabBarController alloc] init];
  tabBarController.viewControllers = @[tab1RootViewController, tab2RootViewController, tab3RootViewController, tab4RootViewController];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = tabBarController;

  // UIWindow automatically adds the root VC's view as a subview to itself.
  // It also manages the layout of that view, so there is no need to use
  // Auto Layout and install constraints in UIWindow. In fact, doing so causes
  // trouble later on during the application's lifetime, when VCs are dismissed
  // after being presented modally. The problem is discussed here:
  // https://stackoverflow.com/q/23313112/1054378

  [self.window makeKeyAndVisible];

  self.defaultWindowBackgroundColor = self.window.backgroundColor;
  self.defaultTabBarControllerViewBackgroundColor = tabBarController.view.backgroundColor;
  self.defaultNavigationControllerViewBackgroundColor = tab1RootViewController.view.backgroundColor;
  self.defaultTableViewControllerViewBackgroundColor = navigation1RootViewController.view.backgroundColor;
  self.defaultNavigationBarBackgroundColor = tab1RootViewController.navigationBar.backgroundColor;
  self.defaultTabBarBackgroundColor = tabBarController.tabBar.backgroundColor;

  self.customWindowBackgroundColor = [UIColor redColor];
  self.customTabBarControllerViewBackgroundColor = [UIColor blueColor];
  self.customNavigationControllerViewBackgroundColor = [UIColor yellowColor];
  self.customTableViewControllerViewBackgroundColor = [UIColor greenColor];
  self.customNavigationBarBackgroundColor = [UIColor purpleColor];
  self.customTabBarBackgroundColor = [UIColor cyanColor];

  self.window.backgroundColor = self.customWindowBackgroundColor;
  tabBarController.view.backgroundColor = self.customTabBarControllerViewBackgroundColor;
  tab1RootViewController.view.backgroundColor = self.customNavigationControllerViewBackgroundColor;
  navigation1RootViewController.view.backgroundColor = self.customTableViewControllerViewBackgroundColor;
  tab2RootViewController.view.backgroundColor = [UIColor orangeColor];
  tab3RootViewController.view.backgroundColor = [UIColor orangeColor];
  tab4RootViewController.view.backgroundColor = [UIColor magentaColor];

  // Override point for customization after application launch.
  return YES;
}

+ (AppDelegate*) sharedAppDelegate
{
  return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}

// This method temporarily switches the tab to another view controller than
// @a viewController, then switches back to @a viewController. This triggers
// various updates to fix the following problems:
// - If participation of the top edge in extended layout changes, then
//   the view is incorrectly displayed, probably because the scroll view
//   inset is not adjusted to reflect the change.
//   Experimentally determined: Switching tabs fixes the problem.
// - If participation of the bottom edge in extended layout changes, then
//   the tab bar is not updated automatically.
//   Experimentally determined: Switching tabs fixes the problem.
// - If the position of a UINavigationBar changes, it is currently not known
//   how to tell the UINavigationBar to re-query its delegate.
//   Experimentally determined: Switching tabs triggers UINavigationBar to
//   re-query its delegate.
- (void) updateBarsInViewController:(UIViewController*)viewController
   bySwitchingTabInTabBarController:(UITabBarController*)tabBarController
{
  for (UIViewController* tabRootViewController in tabBarController.viewControllers)
  {
    if (tabRootViewController == viewController)
      continue;

    tabBarController.selectedViewController = tabRootViewController;
    tabBarController.selectedViewController = viewController;
    break;
  }
}

@end
