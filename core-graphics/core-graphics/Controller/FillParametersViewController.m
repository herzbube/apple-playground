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
@property (weak, nonatomic) IBOutlet UIView* colorParametersContainerView;
@property (weak, nonatomic) IBOutlet UISwitch* fillEnabledSwitch;
@end

@implementation FillParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) init
{
  self = [super initWithNibName:@"FillParametersViewController" bundle:nil];
  if (! self)
    return nil;

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

- (void) integrateChildViewControllers
{
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] init];

  self.fillParameters.colorParameters = colorParametersViewController.colorParameters;
  [colorParametersViewController updateWithHexString:@"0000FFFF"];

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
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.fillEnabledSwitch.on = self.fillParameters.fillEnabled;
}

@end
