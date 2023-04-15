//
//  RadialGradientParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "RadialGradientParametersViewController.h"
#import "GradientStopParametersViewController.h"
#import "../AffineTransform/AffineTransformParametersViewController.h"
#import "../ShadowParametersViewController.h"
#import "../../Model/Gradient/RadialGradientParameters.h"
#import "../../AutoLayoutUtility.h"
#import "../../Converter.h"

@interface RadialGradientParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* startCenterXTextField;
@property (weak, nonatomic) IBOutlet UITextField* startCenterYTextField;
@property (weak, nonatomic) IBOutlet UITextField* startRadiusTextField;
@property (weak, nonatomic) IBOutlet UITextField* endCenterXTextField;
@property (weak, nonatomic) IBOutlet UITextField* endCenterYTextField;
@property (weak, nonatomic) IBOutlet UITextField* endRadiusTextField;
@property (weak, nonatomic) IBOutlet UISlider* startCenterXSlider;
@property (weak, nonatomic) IBOutlet UISlider* startCenterYSlider;
@property (weak, nonatomic) IBOutlet UISlider* startRadiusSlider;
@property (weak, nonatomic) IBOutlet UISlider* endCenterXSlider;
@property (weak, nonatomic) IBOutlet UISlider* endCenterYSlider;
@property (weak, nonatomic) IBOutlet UISlider* endRadiusSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl* gradientStopShadowSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView* gradientStopShadowContainerView;
@property (strong, nonatomic) NSArray* gradientStopShadowAutoLayoutConstraints;
@property (weak, nonatomic) IBOutlet UIView* affineTransformContainerView;
@end

@implementation RadialGradientParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithRadialGradientParameters:(RadialGradientParameters*)radialGradientParameters
{
  self = [super initWithNibName:@"RadialGradientParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (radialGradientParameters)
    self.radialGradientParameters = radialGradientParameters;
  else
    self.radialGradientParameters = [[RadialGradientParameters alloc] init];
  self.gradientStopShadowAutoLayoutConstraints = nil;

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
  if (self.gradientStopShadowSegmentedControl.selectedSegmentIndex == 0)
    [self integrateGradientStopParametersChildViewController];
  else
    [self integrateShadowParametersChildViewController];
  [self integrateAffineTransformParametersChildViewController];
}

- (void) integrateGradientStopParametersChildViewController
{
  GradientStopParametersViewController* gradientStopParametersViewController = [[GradientStopParametersViewController alloc] initWithGradientStopParameters:self.radialGradientParameters.gradientStopParameters];

  [self addChildViewController:gradientStopParametersViewController];
  [gradientStopParametersViewController didMoveToParentViewController:self];

  UIView* gradientStopParametersView = gradientStopParametersViewController.view;
  [self.gradientStopShadowContainerView addSubview:gradientStopParametersView];
  gradientStopParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.gradientStopShadowContainerView withSubview:gradientStopParametersView];
}

- (void) integrateShadowParametersChildViewController
{
  ShadowParametersViewController* shadowParametersViewController = [[ShadowParametersViewController alloc] initWithShadowParameters:self.radialGradientParameters.shadowParameters];
  [self addChildViewController:shadowParametersViewController];
  [shadowParametersViewController didMoveToParentViewController:self];

  UIView* shadowParametersView = shadowParametersViewController.view;
  [self.gradientStopShadowContainerView addSubview:shadowParametersView];
  shadowParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.gradientStopShadowAutoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.gradientStopShadowContainerView withSubview:shadowParametersView];
}

- (void) integrateAffineTransformParametersChildViewController
{
  AffineTransformParametersViewController* affineTransformParametersViewController = [[AffineTransformParametersViewController alloc] initWithAffineTransformParameters:self.radialGradientParameters.affineTransformParameters];

  [self addChildViewController:affineTransformParametersViewController];
  [affineTransformParametersViewController didMoveToParentViewController:self];

  UIView* affineTransformParametersView = affineTransformParametersViewController.view;
  [self.affineTransformContainerView addSubview:affineTransformParametersView];
  affineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.affineTransformContainerView withSubview:affineTransformParametersView];
}

- (void) removeChildViewController
{
  if (self.childViewControllers.count == 0)
    return;

  UIViewController* childViewController = self.childViewControllers.firstObject;

  [childViewController.view removeFromSuperview];
  for (NSLayoutConstraint* autoLayoutConstraint in self.gradientStopShadowAutoLayoutConstraints)
    autoLayoutConstraint.active = NO;
  self.gradientStopShadowAutoLayoutConstraints = nil;

  [childViewController willMoveToParentViewController:nil];
  // Automatically calls didMoveToParentViewController:
  [childViewController removeFromParentViewController];
}

#pragma mark - Segmented control input actions

- (IBAction) gradientStopShadowValueChanged:(UISegmentedControl*)sender
{
  [self removeChildViewController];
  [self integrateChildViewControllers];
}

#pragma mark - Text field input actions

- (IBAction) startCenterXEditingDidEnd:(UITextField*)sender
{
  CGFloat startCenterX = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.startCenterX = startCenterX;
  [self.radialGradientParameters valuesDidChange];

  self.startCenterXSlider.value = [Converter fractionFromPartValue:startCenterX
                                                        rangeValue:self.radialGradientParameters.rangeStartCenterX];
}

- (IBAction) startCenterYEditingDidEnd:(UITextField*)sender
{
  CGFloat startCenterY = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.startCenterY = startCenterY;
  [self.radialGradientParameters valuesDidChange];

  self.startCenterYSlider.value = [Converter fractionFromPartValue:startCenterY
                                                        rangeValue:self.radialGradientParameters.rangeStartCenterY];
}

- (IBAction) startRadiusEditingDidEnd:(UITextField*)sender
{
  CGFloat startRadius = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.startRadius = startRadius;
  [self.radialGradientParameters valuesDidChange];

  self.startRadiusSlider.value = [Converter fractionFromPartValue:startRadius
                                                       rangeValue:self.radialGradientParameters.rangeStartRadius];
}

- (IBAction) endCenterXEditingDidEnd:(UITextField*)sender
{
  CGFloat endCenterX = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.endCenterX = endCenterX;
  [self.radialGradientParameters valuesDidChange];

  self.endCenterXSlider.value = [Converter fractionFromPartValue:endCenterX
                                                      rangeValue:self.radialGradientParameters.rangeEndCenterX];
}

- (IBAction) endCenterYEditingDidEnd:(UITextField*)sender
{
  CGFloat endCenterY = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.endCenterY = endCenterY;
  [self.radialGradientParameters valuesDidChange];

  self.endCenterYSlider.value = [Converter fractionFromPartValue:endCenterY
                                                      rangeValue:self.radialGradientParameters.rangeEndCenterY];
}

- (IBAction) endRadiusEditingDidEnd:(UITextField*)sender
{
  CGFloat endRadius = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.endRadius = endRadius;
  [self.radialGradientParameters valuesDidChange];

  self.endRadiusSlider.value = [Converter fractionFromPartValue:endRadius
                                                     rangeValue:self.radialGradientParameters.rangeEndRadius];
}

#pragma mark - Slider input actions

- (IBAction) startCenterXValueChanged:(UISlider*)sender
{
  CGFloat startCenterX = [Converter partValueFromFractionValue:sender.value
                                                    rangeValue:self.radialGradientParameters.rangeStartCenterX];

  self.radialGradientParameters.startCenterX = startCenterX;
  [self.radialGradientParameters valuesDidChange];

  self.startCenterXTextField.text = [NSString stringWithFormat:@"%f", startCenterX];
}

- (IBAction) startCenterYValueChanged:(UISlider*)sender
{
  CGFloat startCenterY = [Converter partValueFromFractionValue:sender.value
                                                    rangeValue:self.radialGradientParameters.rangeStartCenterY];

  self.radialGradientParameters.startCenterY = startCenterY;
  [self.radialGradientParameters valuesDidChange];

  self.startCenterYTextField.text = [NSString stringWithFormat:@"%f", startCenterY];
}

- (IBAction) startRadiusValueChanged:(UISlider*)sender
{
  CGFloat startRadius = [Converter partValueFromFractionValue:sender.value
                                                   rangeValue:self.radialGradientParameters.rangeStartRadius];

  self.radialGradientParameters.startRadius = startRadius;
  [self.radialGradientParameters valuesDidChange];

  self.startRadiusTextField.text = [NSString stringWithFormat:@"%f", startRadius];
}

- (IBAction) endCenterXValueChanged:(UISlider*)sender
{
  CGFloat endCenterX = [Converter partValueFromFractionValue:sender.value
                                                  rangeValue:self.radialGradientParameters.rangeEndCenterX];

  self.radialGradientParameters.endCenterX = endCenterX;
  [self.radialGradientParameters valuesDidChange];

  self.endCenterXTextField.text = [NSString stringWithFormat:@"%f", endCenterX];
}

- (IBAction) endCenterYValueChanged:(UISlider*)sender
{
  CGFloat endCenterY = [Converter partValueFromFractionValue:sender.value
                                                  rangeValue:self.radialGradientParameters.rangeEndCenterY];

  self.radialGradientParameters.endCenterY = endCenterY;
  [self.radialGradientParameters valuesDidChange];

  self.endCenterYTextField.text = [NSString stringWithFormat:@"%f", endCenterY];
}

- (IBAction) endRadiusValueChanged:(UISlider*)sender
{
  CGFloat endRadius = [Converter partValueFromFractionValue:sender.value
                                                 rangeValue:self.radialGradientParameters.rangeEndRadius];

  self.radialGradientParameters.endRadius = endRadius;
  [self.radialGradientParameters valuesDidChange];

  self.endRadiusTextField.text = [NSString stringWithFormat:@"%f", endRadius];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.startCenterXTextField.text = [NSString stringWithFormat:@"%f", self.radialGradientParameters.startCenterX];
  self.startCenterYTextField.text = [NSString stringWithFormat:@"%f", self.radialGradientParameters.startCenterY];
  self.startRadiusTextField.text = [NSString stringWithFormat:@"%f", self.radialGradientParameters.startRadius];
  self.endCenterXTextField.text = [NSString stringWithFormat:@"%f", self.radialGradientParameters.endCenterX];
  self.endCenterYTextField.text = [NSString stringWithFormat:@"%f", self.radialGradientParameters.endCenterY];
  self.endRadiusTextField.text = [NSString stringWithFormat:@"%f", self.radialGradientParameters.endRadius];

  self.startCenterXSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.startCenterX
                                                        rangeValue:self.radialGradientParameters.rangeStartCenterX];
  self.startCenterYSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.startCenterY
                                                        rangeValue:self.radialGradientParameters.rangeStartCenterY];
  self.startRadiusSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.startRadius
                                                       rangeValue:self.radialGradientParameters.rangeStartRadius];
  self.endCenterXSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.endCenterX
                                                      rangeValue:self.radialGradientParameters.rangeEndCenterX];
  self.endCenterYSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.endCenterY
                                                      rangeValue:self.radialGradientParameters.rangeEndCenterY];
  self.endRadiusSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.endRadius
                                                     rangeValue:self.radialGradientParameters.rangeEndRadius];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
