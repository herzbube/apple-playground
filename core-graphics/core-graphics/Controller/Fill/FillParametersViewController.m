//
//  FillParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "FillParametersViewController.h"
#import "GradientFillParametersViewController.h"
#import "SolidColorFillParametersViewController.h"
#import "../../Model/Fill/FillParameters.h"
#import "../../AutoLayoutUtility.h"

@interface FillParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* fillEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIStackView* fillParametersStackView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* fillTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView* containerView;
@property (strong, nonatomic) NSArray* autoLayoutConstraints;
@end

@implementation FillParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithFillParameters:(FillParameters*)fillParameters
{
  self = [super initWithNibName:@"FillParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (fillParameters)
    self.fillParameters = fillParameters;
  else
    self.fillParameters = [[FillParameters alloc] init];
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
  if (self.fillParameters.fillType == FillTypeSolidColor)
    [self integrateSolidColorFillParametersChildViewController];
  else
    [self integrateGradientFillParametersChildViewController];
}

- (void) integrateSolidColorFillParametersChildViewController
{
  SolidColorFillParametersViewController* solidColorFillParametersViewController = [[SolidColorFillParametersViewController alloc] initWithSolidColorFillParameters:self.fillParameters.solidColorFillParameters];

  [self addChildViewController:solidColorFillParametersViewController];
  [solidColorFillParametersViewController didMoveToParentViewController:self];

  UIView* solidColorFillParametersView = solidColorFillParametersViewController.view;
  [self.containerView addSubview:solidColorFillParametersView];
  solidColorFillParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:solidColorFillParametersView];
}

- (void) integrateGradientFillParametersChildViewController
{
  GradientFillParametersViewController* gradientFillParametersViewController = [[GradientFillParametersViewController alloc] initWithGradientFillParameters:self.fillParameters.gradientFillParameters];

  [self addChildViewController:gradientFillParametersViewController];
  [gradientFillParametersViewController didMoveToParentViewController:self];

  UIView* gradientFillParametersView = gradientFillParametersViewController.view;
  [self.containerView addSubview:gradientFillParametersView];
  gradientFillParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:gradientFillParametersView];
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

- (IBAction) fillEnabledValueChanged:(UISwitch*)sender
{
  BOOL fillEnabled = sender.on;

  self.fillParameters.fillEnabled = fillEnabled;

  [self updateUiVisibility];
}

#pragma mark - Segmented control input actions

- (IBAction) fillTypeValueChanged:(UISegmentedControl*)sender
{
  FillType fillType = (sender.selectedSegmentIndex == 0
                       ? FillTypeSolidColor
                       : FillTypeGradient);

  self.fillParameters.fillType = fillType;

  [self updateUiVisibility];

  [self removeChildViewController];
  [self integrateChildViewControllers];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.fillEnabledSwitch.on = self.fillParameters.fillEnabled;
  self.fillTypeSegmentedControl.selectedSegmentIndex = self.fillParameters.fillType;

  [self updateUiVisibility];

  [self removeChildViewController];
  [self integrateChildViewControllers];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.fillParameters.fillEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.fillParametersStackView])
      [self.topLevelStackView insertArrangedSubview:self.fillParametersStackView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.fillParametersStackView])
    {
      [self.topLevelStackView removeArrangedSubview:self.fillParametersStackView];
      [self.fillParametersStackView removeFromSuperview];
    }
  }
}

@end
