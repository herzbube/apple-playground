//
//  SolidColorFillParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "SolidColorFillParametersViewController.h"
#import "../ColorParametersViewController.h"
#import "../ShadowParametersViewController.h"
#import "../../Model/Fill/SolidColorFillParameters.h"
#import "../../AutoLayoutUtility.h"

@interface SolidColorFillParametersViewController()
@property (weak, nonatomic) IBOutlet UIView* colorContainerView;
@property (weak, nonatomic) IBOutlet UIView* shadowContainerView;
@end

@implementation SolidColorFillParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithSolidColorFillParameters:(SolidColorFillParameters*)solidColorFillParameters
{
  self = [super initWithNibName:@"SolidColorFillParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (solidColorFillParameters)
    self.solidColorFillParameters = solidColorFillParameters;
  else
    self.solidColorFillParameters = [[SolidColorFillParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self integrateChildViewControllers];
  [self updateUiWithModelValues];
}

#pragma mark - Manage child view controllers

- (void) integrateChildViewControllers
{
  [self integrateColorParametersChildViewController];
  [self integrateShadowParametersChildViewController];
}

- (void) integrateColorParametersChildViewController
{
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.solidColorFillParameters.colorParameters];

  [self addChildViewController:colorParametersViewController];
  [colorParametersViewController didMoveToParentViewController:self];

  UIView* colorParametersView = colorParametersViewController.view;
  [self.colorContainerView addSubview:colorParametersView];
  colorParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorContainerView withSubview:colorParametersView];
}

- (void) integrateShadowParametersChildViewController
{
  ShadowParametersViewController* shadowParametersViewController = [[ShadowParametersViewController alloc] initWithShadowParameters:self.solidColorFillParameters.shadowParameters];
  [self addChildViewController:shadowParametersViewController];
  [shadowParametersViewController didMoveToParentViewController:self];

  UIView* shadowParametersView = shadowParametersViewController.view;
  [self.shadowContainerView addSubview:shadowParametersView];
  shadowParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.shadowContainerView withSubview:shadowParametersView];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
