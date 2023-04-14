//
//  GradientFillParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "GradientFillParametersViewController.h"
#import "../Gradient/GradientParametersViewController.h"
#import "../../Model/Fill/GradientFillParameters.h"
#import "../../AutoLayoutUtility.h"

@interface GradientFillParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* clipGradientToPathSwitch;
@property (weak, nonatomic) IBOutlet UIView* containerView;
@end

@implementation GradientFillParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithGradientFillParameters:(GradientFillParameters*)gradientFillParameters
{
  self = [super initWithNibName:@"GradientFillParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (gradientFillParameters)
    self.gradientFillParameters = gradientFillParameters;
  else
    self.gradientFillParameters = [[GradientFillParameters alloc] init];

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
  [self integrateGradientParametersChildViewController];
}

- (void) integrateGradientParametersChildViewController
{
  GradientParametersViewController* gradientParametersViewController = [[GradientParametersViewController alloc] initWithGradientParameters:self.gradientFillParameters.gradientParameters];

  [self addChildViewController:gradientParametersViewController];
  [gradientParametersViewController didMoveToParentViewController:self];

  UIView* gradientParametersView = gradientParametersViewController.view;
  [self.containerView addSubview:gradientParametersView];
  gradientParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.containerView withSubview:gradientParametersView];

  [gradientParametersViewController hideTitleLabelAndEnabledSwitch];
}

#pragma mark - Switch input actions

- (IBAction) clipGradientToPathValueChanged:(UISwitch*)sender
{
  BOOL clipGradientToPath = sender.on;

  self.gradientFillParameters.clipGradientToPath = clipGradientToPath;
  [self.gradientFillParameters valuesDidChange];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.clipGradientToPathSwitch.on = self.gradientFillParameters.clipGradientToPath;

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
