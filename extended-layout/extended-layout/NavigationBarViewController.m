//
//  NavigationBarViewController.m
//  extended-layout
//
//  Created by Patrick Näf Moser on 05.03.22.
//

#import "NavigationBarViewController.h"
#import "AppDelegate.h"

@interface NavigationBarViewController ()
@property int numberOfNavigationBars;
@property UIBarPosition navigationBarPosition;
@end

@implementation NavigationBarViewController

- (instancetype) initWithNumberOfNavigationBars:(int)numberOfNavigationBars
{
  self = [super init];

  self.numberOfNavigationBars = numberOfNavigationBars;
  self.navigationBarPosition = UIBarPositionTop;

  return self;
}

- (void) viewDidLoad
{
  [super viewDidLoad];

  self.title = @"Navigation bar - NavigationBarViewController";

  // ----------------------------------------
  // Navigation bars
  // ----------------------------------------
  NSMutableArray* navigationBars = [NSMutableArray array];

  CGRect navigationBarFrame = CGRectMake(100, 100, 100, 100);
  for (int indexOfNavigationBar = 0; indexOfNavigationBar < self.numberOfNavigationBars; indexOfNavigationBar++)
  {
    UINavigationBar* navigationBar = [[UINavigationBar alloc] initWithFrame:navigationBarFrame];
    NSString* title = [NSString stringWithFormat:@"Bar %d", (indexOfNavigationBar + 1)];
    UINavigationItem* navigationItem = [[UINavigationItem alloc] initWithTitle:title];
    [navigationBar pushNavigationItem:navigationItem animated:NO];

    navigationBar.delegate = self;

    [navigationBars addObject:navigationBar];
  }

  // ----------------------------------------
  // Buttons
  // ----------------------------------------
  AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];
  UIAction* action;

  action = [UIAction actionWithTitle:@"translucent (navigation bar)"
                               image:nil
                          identifier:nil
                             handler:^(UIAction* action)
  {
    for (UINavigationBar* navigationBar in navigationBars)
    {
      if (navigationBar.translucent == YES)
        navigationBar.translucent = NO;
      else
        navigationBar.translucent = YES;
    }
  }];
  UIButton* translucentNavigationBarButton = [UIButton buttonWithType:UIButtonTypeCustom
                                                        primaryAction:action];

  action = [UIAction actionWithTitle:@"Bar position Top/TopAttached"
                               image:nil
                          identifier:nil
                             handler:^(UIAction* action)
  {
    if (self.navigationBarPosition == UIBarPositionTop)
      self.navigationBarPosition = UIBarPositionTopAttached;
    else
      self.navigationBarPosition = UIBarPositionTop;

    // See method documentation why we do this
    [appDelegate updateBarsInViewController:self bySwitchingTabInTabBarController:self.tabBarController];
  }];
  UIButton* navigationBarPositionButton = [UIButton buttonWithType:UIButtonTypeCustom
                                                     primaryAction:action];

  action = [UIAction actionWithTitle:@"UIRectEdgeAll"
                               image:nil
                          identifier:nil
                             handler:^(UIAction* action)
  {
    self.edgesForExtendedLayout = UIRectEdgeAll;
    // See method documentation why we do this
    [appDelegate updateBarsInViewController:self bySwitchingTabInTabBarController:self.tabBarController];
  }];
  UIButton* uiRectEdgeAllButton = [UIButton buttonWithType:UIButtonTypeCustom
                                             primaryAction:action];

  action = [UIAction actionWithTitle:@"UIRectEdgeNone"
                               image:nil
                          identifier:nil
                             handler:^(UIAction* action)
  {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // See method documentation why we do this
    // TODO: For some reason this has no effect after we set UIRectEdgeNone.
    // The user has to manually switch the tab to see the effect. After setting
    // UIRectEdgeAll this always works.
    [appDelegate updateBarsInViewController:self bySwitchingTabInTabBarController:self.tabBarController];
  }];
  UIButton* uiRectEdgeNoneButton = [UIButton buttonWithType:UIButtonTypeCustom
                                              primaryAction:action];

  // ----------------------------------------
  // View hierarchy
  // ----------------------------------------
//  [self.view addSubview:navigationStackView];
  for (UINavigationBar* navigationBar in navigationBars)
  {
    [self.view addSubview:navigationBar];
  }
  [self.view addSubview:translucentNavigationBarButton];
  [self.view addSubview:navigationBarPositionButton];
  [self.view addSubview:uiRectEdgeAllButton];
  [self.view addSubview:uiRectEdgeNoneButton];

  // ----------------------------------------
  // Auto Layout
  // ----------------------------------------
  CGFloat spacing = 10;

  NSLayoutXAxisAnchor* predecessorXAxisAnchor = self.view.safeAreaLayoutGuide.leftAnchor;
  CGFloat multiplier = 1.0 / navigationBars.count;
  for (UINavigationBar* navigationBar in navigationBars)
  {
    navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [navigationBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [navigationBar.leftAnchor constraintEqualToAnchor:predecessorXAxisAnchor].active = YES;
    [navigationBar.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor multiplier:multiplier constant:0].active = YES;

    predecessorXAxisAnchor = navigationBar.rightAnchor;
  }

  NSArray* buttonOrder = @[translucentNavigationBarButton, navigationBarPositionButton, uiRectEdgeAllButton, uiRectEdgeNoneButton];
  UIView* verticalPredecessorView = navigationBars.lastObject;
  for (UIButton* button in buttonOrder)
  {
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button.topAnchor constraintEqualToAnchor:verticalPredecessorView.bottomAnchor constant:spacing].active = YES;
    [button.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:spacing].active = YES;

    verticalPredecessorView = button;
  }
}

- (UIBarPosition) positionForBar:(id<UIBarPositioning>)bar
{
  return self.navigationBarPosition;
}

@end
