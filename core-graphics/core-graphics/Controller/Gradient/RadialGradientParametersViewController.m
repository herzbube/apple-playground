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

  self.startCenterXSlider.value = [Converter fractionFromPartValue:startCenterX
                                                        wholeValue:self.radialGradientParameters.maximumStartCenterX];
}

- (IBAction) startCenterYEditingDidEnd:(UITextField*)sender
{
  CGFloat startCenterY = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.startCenterY = startCenterY;

  self.startCenterYSlider.value = [Converter fractionFromPartValue:startCenterY
                                                        wholeValue:self.radialGradientParameters.maximumStartCenterY];
}

- (IBAction) startRadiusEditingDidEnd:(UITextField*)sender
{
  CGFloat startRadius = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.startRadius = startRadius;

  self.startRadiusSlider.value = [Converter fractionFromPartValue:startRadius
                                                       wholeValue:self.radialGradientParameters.maximumStartRadius];
}

- (IBAction) endCenterXEditingDidEnd:(UITextField*)sender
{
  CGFloat endCenterX = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.endCenterX = endCenterX;

  self.endCenterXSlider.value = [Converter fractionFromPartValue:endCenterX
                                                     wholeValue:self.radialGradientParameters.maximumEndCenterX];
}

- (IBAction) endCenterYEditingDidEnd:(UITextField*)sender
{
  CGFloat endCenterY = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.endCenterY = endCenterY;

  self.endCenterYSlider.value = [Converter fractionFromPartValue:endCenterY
                                                     wholeValue:self.radialGradientParameters.maximumEndCenterY];
}

- (IBAction) endRadiusEditingDidEnd:(UITextField*)sender
{
  CGFloat endRadius = [Converter floatFromStringValue:sender.text];

  self.radialGradientParameters.endRadius = endRadius;

  self.endRadiusSlider.value = [Converter fractionFromPartValue:endRadius
                                                     wholeValue:self.radialGradientParameters.maximumEndRadius];
}

#pragma mark - Slider input actions

- (IBAction) startCenterXValueChanged:(UISlider*)sender
{
  CGFloat startCenterX = [Converter partValueFromFractionValue:sender.value
                                                    wholeValue:self.radialGradientParameters.maximumStartCenterX];

  self.radialGradientParameters.startCenterX = startCenterX;

  self.startCenterXTextField.text = [NSString stringWithFormat:@"%f", startCenterX];
}

- (IBAction) startCenterYValueChanged:(UISlider*)sender
{
  CGFloat startCenterY = [Converter partValueFromFractionValue:sender.value
                                                    wholeValue:self.radialGradientParameters.maximumStartCenterY];

  self.radialGradientParameters.startCenterY = startCenterY;

  self.startCenterYTextField.text = [NSString stringWithFormat:@"%f", startCenterY];
}

- (IBAction) startRadiusValueChanged:(UISlider*)sender
{
  CGFloat startRadius = [Converter partValueFromFractionValue:sender.value
                                                   wholeValue:self.radialGradientParameters.maximumStartRadius];

  self.radialGradientParameters.startRadius = startRadius;

  self.startRadiusTextField.text = [NSString stringWithFormat:@"%f", startRadius];
}

- (IBAction) endCenterXValueChanged:(UISlider*)sender
{
  CGFloat endCenterX = [Converter partValueFromFractionValue:sender.value
                                                  wholeValue:self.radialGradientParameters.maximumEndCenterX];

  self.radialGradientParameters.endCenterX = endCenterX;

  self.endCenterXTextField.text = [NSString stringWithFormat:@"%f", endCenterX];
}

- (IBAction) endCenterYValueChanged:(UISlider*)sender
{
  CGFloat endCenterY = [Converter partValueFromFractionValue:sender.value
                                                  wholeValue:self.radialGradientParameters.maximumEndCenterY];

  self.radialGradientParameters.endCenterY = endCenterY;

  self.endCenterYTextField.text = [NSString stringWithFormat:@"%f", endCenterY];
}

- (IBAction) endRadiusValueChanged:(UISlider*)sender
{
  CGFloat endRadius = [Converter partValueFromFractionValue:sender.value
                                                 wholeValue:self.radialGradientParameters.maximumEndRadius];

  self.radialGradientParameters.endRadius = endRadius;

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
                                                        wholeValue:self.radialGradientParameters.maximumStartCenterX];
  self.startCenterYSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.startCenterY
                                                        wholeValue:self.radialGradientParameters.maximumStartCenterY];
  self.startRadiusSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.startRadius
                                                       wholeValue:self.radialGradientParameters.maximumStartRadius];
  self.endCenterXSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.endCenterX
                                                      wholeValue:self.radialGradientParameters.maximumEndCenterX];
  self.endCenterYSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.endCenterY
                                                      wholeValue:self.radialGradientParameters.maximumEndCenterY];
  self.endRadiusSlider.value = [Converter fractionFromPartValue:self.radialGradientParameters.endRadius
                                                     wholeValue:self.radialGradientParameters.maximumEndRadius];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
