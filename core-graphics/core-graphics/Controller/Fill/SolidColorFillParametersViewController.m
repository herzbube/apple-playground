//
//  SolidColorFillParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "SolidColorFillParametersViewController.h"
#import "../ColorParametersViewController.h"
#import "../../Model/Fill/SolidColorFillParameters.h"
#import "../../AutoLayoutUtility.h"

@interface SolidColorFillParametersViewController()
@property (weak, nonatomic) IBOutlet UIView* containerView;
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
}

- (void) integrateColorParametersChildViewController
{
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.solidColorFillParameters.colorParameters];

  [self addChildViewController:colorParametersViewController];
  [colorParametersViewController didMoveToParentViewController:self];

  UIView* colorParametersView = colorParametersViewController.view;
  [self.containerView addSubview:colorParametersView];
  colorParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.containerView withSubview:colorParametersView];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
