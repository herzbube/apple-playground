//
//  GradientParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "GradientParametersViewController.h"
#import "LinearGradientParametersViewController.h"
#import "RadialGradientParametersViewController.h"
#import "../../Model/Gradient/GradientParameters.h"
#import "../../AutoLayoutUtility.h"

@interface GradientParametersViewController()
@property (weak, nonatomic) IBOutlet UIStackView* titleLabelAndEnabledSwitchStackView;
@property (weak, nonatomic) IBOutlet UISwitch* gradientEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIStackView* gradientParametersStackView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* gradientTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView* containerView;
@property (strong, nonatomic) NSArray* autoLayoutConstraints;
@end

@implementation GradientParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithGradientParameters:(GradientParameters*)gradientParameters
{
  self = [super initWithNibName:@"GradientParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (gradientParameters)
    self.gradientParameters = gradientParameters;
  else
    self.gradientParameters = [[GradientParameters alloc] init];
  self.autoLayoutConstraints = nil;

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Manage child view controllers

- (void) integrateChildViewControllers
{
  if (self.gradientParameters.gradientType == GradientTypeLinear)
    [self integrateLinearGradientParametersChildViewController];
  else
    [self integrateRadialGradientParametersChildViewController];
}

- (void) integrateLinearGradientParametersChildViewController
{
  LinearGradientParametersViewController* linearGradientParametersViewController = [[LinearGradientParametersViewController alloc] initWithLinearGradientParameters:self.gradientParameters.linearGradientParameters];

  [self addChildViewController:linearGradientParametersViewController];
  [linearGradientParametersViewController didMoveToParentViewController:self];

  UIView* linearGradientParametersView = linearGradientParametersViewController.view;
  [self.containerView addSubview:linearGradientParametersView];
  linearGradientParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:linearGradientParametersView];
}

- (void) integrateRadialGradientParametersChildViewController
{
  RadialGradientParametersViewController* radialGradientParametersViewController = [[RadialGradientParametersViewController alloc] initWithRadialGradientParameters:self.gradientParameters.radialGradientParameters];

  [self addChildViewController:radialGradientParametersViewController];
  [radialGradientParametersViewController didMoveToParentViewController:self];

  UIView* radialGradientParametersView = radialGradientParametersViewController.view;
  [self.containerView addSubview:radialGradientParametersView];
  radialGradientParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:radialGradientParametersView];
}

- (void) removeChildViewController
{
  if (self.childViewControllers.count == 0)
    return;

  UIViewController* childViewController = self.childViewControllers.firstObject;

  [childViewController.view removeFromSuperview];
  for (NSLayoutConstraint* autoLayoutConstraint in self.autoLayoutConstraints)
    autoLayoutConstraint.active = NO;
  self.autoLayoutConstraints = nil;

  [childViewController willMoveToParentViewController:nil];
  // Automatically calls didMoveToParentViewController:
  [childViewController removeFromParentViewController];
}

#pragma mark - Switch input actions

- (IBAction) gradientEnabledValueChanged:(UISwitch*)sender
{
  BOOL gradientEnabled = sender.on;

  self.gradientParameters.gradientEnabled = gradientEnabled;
  [self.gradientParameters valuesDidChange];

  [self updateUiVisibility];
}

#pragma mark - Segmented control input actions

- (IBAction) gradientTypeValueChanged:(UISegmentedControl*)sender
{
  GradientType gradientType = (sender.selectedSegmentIndex == 0
                               ? GradientTypeLinear
                               : GradientTypeRadial);
  
  self.gradientParameters.gradientType = gradientType;
  [self.gradientParameters valuesDidChange];

  [self removeChildViewController];
  [self integrateChildViewControllers];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.gradientEnabledSwitch.on = self.gradientParameters.gradientEnabled;
  self.gradientTypeSegmentedControl.selectedSegmentIndex = self.gradientParameters.gradientType;

  [self updateUiVisibility];

  [self removeChildViewController];
  [self integrateChildViewControllers];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.gradientParameters.gradientEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.gradientParametersStackView])
      [self.topLevelStackView insertArrangedSubview:self.gradientParametersStackView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.gradientParametersStackView])
    {
      [self.topLevelStackView removeArrangedSubview:self.gradientParametersStackView];
      [self.gradientParametersStackView removeFromSuperview];
    }
  }
}

#pragma mark - Public API

- (void) hideTitleLabelAndEnabledSwitch
{
  while (self.titleLabelAndEnabledSwitchStackView.arrangedSubviews.count > 0)
  {
    UIView* arrangedSubView = self.titleLabelAndEnabledSwitchStackView.arrangedSubviews.lastObject;

    [self.titleLabelAndEnabledSwitchStackView removeArrangedSubview:arrangedSubView];
    [arrangedSubView removeFromSuperview];
  }
}

@end
