//
//  FillParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "FillParametersViewController.h"
#import "ColorParametersViewController.h"
#import "../Model/FillParameters.h"
#import "../AutoLayoutUtility.h"

@interface FillParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* fillEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
@property (strong, nonatomic) IBOutlet UIView* colorParametersContainerView;
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
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.fillParameters.colorParameters];
  
  [self addChildViewController:colorParametersViewController];
  [colorParametersViewController didMoveToParentViewController:self];

  UIView* colorParametersView = colorParametersViewController.view;
  [self.colorParametersContainerView addSubview:colorParametersView];
  colorParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorParametersContainerView withSubview:colorParametersView];
}

#pragma mark - Switch input actions

- (IBAction) fillEnabledValueChanged:(UISwitch*)sender
{
  BOOL fillEnabled = sender.on;

  self.fillParameters.fillEnabled = fillEnabled;

  [self updateUiVisibility];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.fillEnabledSwitch.on = self.fillParameters.fillEnabled;

  [self updateUiVisibility];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.fillParameters.fillEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.colorParametersContainerView])
      [self.topLevelStackView insertArrangedSubview:self.colorParametersContainerView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.colorParametersContainerView])
    {
      [self.topLevelStackView removeArrangedSubview:self.colorParametersContainerView];
      [self.colorParametersContainerView removeFromSuperview];
    }
  }
}

@end
