//
//  PathParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "PathParametersViewController.h"
#import "ArcParametersViewController.h"
#import "RectangleParametersViewController.h"
#import "../Model/PathParameters.h"
#import "../AutoLayoutUtility.h"

@interface PathParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* pathEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIStackView* pathParametersStackView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* pathTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView* containerView;
@property (strong, nonatomic) NSArray* autoLayoutConstraints;
@end

@implementation PathParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithPathParameters:(PathParameters*)pathParameters
{
  self = [super initWithNibName:@"PathParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (pathParameters)
    self.pathParameters = pathParameters;
  else
    self.pathParameters = [[PathParameters alloc] init];
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
  if (self.pathParameters.pathType == PathTypeArc)
    [self integrateArcParametersChildViewController];
  else
    [self integrateRectangleParametersChildViewController];
}

- (void) integrateArcParametersChildViewController
{
  ArcParametersViewController* arcParametersViewController = [[ArcParametersViewController alloc] initWithArcParameters:self.pathParameters.arcParameters];

  [self addChildViewController:arcParametersViewController];
  [arcParametersViewController didMoveToParentViewController:self];

  UIView* arcParametersView = arcParametersViewController.view;
  [self.containerView addSubview:arcParametersView];
  arcParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:arcParametersView];
}

- (void) integrateRectangleParametersChildViewController
{
  RectangleParametersViewController* rectangleParametersViewController = [[RectangleParametersViewController alloc] initWithRectangleParameters:self.pathParameters.rectangleParameters];

  [self addChildViewController:rectangleParametersViewController];
  [rectangleParametersViewController didMoveToParentViewController:self];

  UIView* rectangleParametersView = rectangleParametersViewController.view;
  [self.containerView addSubview:rectangleParametersView];
  rectangleParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:rectangleParametersView];
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

- (IBAction) pathEnabledValueChanged:(UISwitch*)sender
{
  BOOL pathEnabled = sender.on;

  self.pathParameters.pathEnabled = pathEnabled;

  [self updateUiVisibility];
}

#pragma mark - Segmented control input actions

- (IBAction) pathTypeValueChanged:(UISegmentedControl*)sender
{
  self.pathParameters.pathType = (sender.selectedSegmentIndex == 0
                                  ? PathTypeArc
                                  : PathTypeRectangle);
  [self removeChildViewController];
  [self integrateChildViewControllers];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.pathEnabledSwitch.on = self.pathParameters.pathEnabled;
  self.pathTypeSegmentedControl.selectedSegmentIndex = self.pathParameters.pathType;

  [self updateUiVisibility];

  [self removeChildViewController];
  [self integrateChildViewControllers];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.pathParameters.pathEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.pathParametersStackView])
      [self.topLevelStackView insertArrangedSubview:self.pathParametersStackView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.pathParametersStackView])
    {
      [self.topLevelStackView removeArrangedSubview:self.pathParametersStackView];
      [self.pathParametersStackView removeFromSuperview];
    }
  }
}

@end
