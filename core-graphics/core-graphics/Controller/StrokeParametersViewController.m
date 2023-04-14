//
//  StrokeParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 22.03.23.
//

#import "StrokeParametersViewController.h"
#import "ColorParametersViewController.h"
#import "ShadowParametersViewController.h"
#import "../Model/StrokeParameters.h"
#import "../AutoLayoutUtility.h"
#import "../Converter.h"

@interface StrokeParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* strokeEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIStackView* strokeParametersStackView;
@property (weak, nonatomic) IBOutlet UITextField* lineWidthTextField;
@property (weak, nonatomic) IBOutlet UISlider* lineWidthSlider;
@property (weak, nonatomic) IBOutlet UIView* colorContainerView;
@property (weak, nonatomic) IBOutlet UIView* shadowContainerView;
@end

@implementation StrokeParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithStrokeParameters:(StrokeParameters*)strokeParameters
{
  self = [super initWithNibName:@"StrokeParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (strokeParameters)
    self.strokeParameters = strokeParameters;
  else
    self.strokeParameters = [[StrokeParameters alloc] init];

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
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.strokeParameters.colorParameters];

  [self addChildViewController:colorParametersViewController];
  [colorParametersViewController didMoveToParentViewController:self];

  UIView* colorParametersView = colorParametersViewController.view;
  [self.colorContainerView addSubview:colorParametersView];
  colorParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorContainerView withSubview:colorParametersView];
}

- (void) integrateShadowParametersChildViewController
{
  ShadowParametersViewController* shadowParametersViewController = [[ShadowParametersViewController alloc] initWithShadowParameters:self.strokeParameters.shadowParameters];
  [self addChildViewController:shadowParametersViewController];
  [shadowParametersViewController didMoveToParentViewController:self];

  UIView* shadowParametersView = shadowParametersViewController.view;
  [self.shadowContainerView addSubview:shadowParametersView];
  shadowParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.shadowContainerView withSubview:shadowParametersView];
}

#pragma mark - Switch input actions

- (IBAction) strokeEnabledValueChanged:(UISwitch*)sender
{
  BOOL strokeEnabled = sender.on;

  self.strokeParameters.strokeEnabled = strokeEnabled;
  [self.strokeParameters valuesDidChange];

  [self updateUiVisibility];
}

#pragma mark - Text field input actions

- (IBAction) lineWidthEditingDidEnd:(UITextField*)sender
{
  CGFloat lineWidth = [Converter floatFromStringValue:sender.text];

  self.strokeParameters.lineWidth = lineWidth;
  [self.strokeParameters valuesDidChange];

  self.lineWidthSlider.value = [Converter fractionFromPartValue:lineWidth
                                                     wholeValue:self.strokeParameters.maximumLineWidth];
}

#pragma mark - Slider input actions

- (IBAction) lineWidthValueChanged:(UISlider*)sender
{
  CGFloat lineWidth = [Converter partValueFromFractionValue:sender.value
                                                 wholeValue:self.strokeParameters.maximumLineWidth];

  self.strokeParameters.lineWidth = lineWidth;
  [self.strokeParameters valuesDidChange];

  self.lineWidthTextField.text = [NSString stringWithFormat:@"%f", lineWidth];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.strokeEnabledSwitch.on = self.strokeParameters.strokeEnabled;
  self.lineWidthTextField.text = [NSString stringWithFormat:@"%f", self.strokeParameters.lineWidth];
  self.lineWidthSlider.value = [Converter fractionFromPartValue:self.strokeParameters.lineWidth
                                                     wholeValue:self.strokeParameters.maximumLineWidth];

  [self updateUiVisibility];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.strokeParameters.strokeEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.strokeParametersStackView])
      [self.topLevelStackView insertArrangedSubview:self.strokeParametersStackView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.strokeParametersStackView])
    {
      [self.topLevelStackView removeArrangedSubview:self.strokeParametersStackView];
      [self.strokeParametersStackView removeFromSuperview];
    }
  }
}

@end
