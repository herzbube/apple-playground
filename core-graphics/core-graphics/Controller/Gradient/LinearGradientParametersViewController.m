//
//  LinearGradientParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "LinearGradientParametersViewController.h"
#import "GradientStopParametersViewController.h"
#import "../AffineTransform/AffineTransformParametersViewController.h"
#import "../ShadowParametersViewController.h"
#import "../../Model/Gradient/LinearGradientParameters.h"
#import "../../AutoLayoutUtility.h"
#import "../../Converter.h"

@interface LinearGradientParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* startPointXTextField;
@property (weak, nonatomic) IBOutlet UITextField* startPointYTextField;
@property (weak, nonatomic) IBOutlet UITextField* endPointXTextField;
@property (weak, nonatomic) IBOutlet UITextField* endPointYTextField;
@property (weak, nonatomic) IBOutlet UISlider* startPointXSlider;
@property (weak, nonatomic) IBOutlet UISlider* startPointYSlider;
@property (weak, nonatomic) IBOutlet UISlider* endPointXSlider;
@property (weak, nonatomic) IBOutlet UISlider* endPointYSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl* gradientStopShadowSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView* gradientStopShadowContainerView;
@property (strong, nonatomic) NSArray* gradientStopShadowAutoLayoutConstraints;
@property (weak, nonatomic) IBOutlet UIView* affineTransformContainerView;
@end

@implementation LinearGradientParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithLinearGradientParameters:(LinearGradientParameters*)linearGradientParameters
{
  self = [super initWithNibName:@"LinearGradientParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (linearGradientParameters)
    self.linearGradientParameters = linearGradientParameters;
  else
    self.linearGradientParameters = [[LinearGradientParameters alloc] init];
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
  GradientStopParametersViewController* gradientStopParametersViewController = [[GradientStopParametersViewController alloc] initWithGradientStopParameters:self.linearGradientParameters.gradientStopParameters];

  [self addChildViewController:gradientStopParametersViewController];
  [gradientStopParametersViewController didMoveToParentViewController:self];

  UIView* gradientStopParametersView = gradientStopParametersViewController.view;
  [self.gradientStopShadowContainerView addSubview:gradientStopParametersView];
  gradientStopParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.gradientStopShadowAutoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.gradientStopShadowContainerView withSubview:gradientStopParametersView];
}

- (void) integrateShadowParametersChildViewController
{
  ShadowParametersViewController* shadowParametersViewController = [[ShadowParametersViewController alloc] initWithShadowParameters:self.linearGradientParameters.shadowParameters];
  [self addChildViewController:shadowParametersViewController];
  [shadowParametersViewController didMoveToParentViewController:self];

  UIView* shadowParametersView = shadowParametersViewController.view;
  [self.gradientStopShadowContainerView addSubview:shadowParametersView];
  shadowParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.gradientStopShadowAutoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.gradientStopShadowContainerView withSubview:shadowParametersView];
}

- (void) integrateAffineTransformParametersChildViewController
{
  AffineTransformParametersViewController* affineTransformParametersViewController = [[AffineTransformParametersViewController alloc] initWithAffineTransformParameters:self.linearGradientParameters.affineTransformParameters];

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

- (IBAction) startPointXEditingDidEnd:(UITextField*)sender
{
  CGFloat startPointX = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.startPointX = startPointX;
  [self.linearGradientParameters valuesDidChange];

  self.startPointXSlider.value = [Converter fractionFromPartValue:startPointX
                                                       rangeValue:self.linearGradientParameters.rangeStartPointX];
}

- (IBAction) startPointYEditingDidEnd:(UITextField*)sender
{
  CGFloat startPointY = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.startPointY = startPointY;
  [self.linearGradientParameters valuesDidChange];

  self.startPointYSlider.value = [Converter fractionFromPartValue:startPointY
                                                       rangeValue:self.linearGradientParameters.rangeStartPointY];
}

- (IBAction) endPointXEditingDidEnd:(UITextField*)sender
{
  CGFloat endPointX = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.endPointX = endPointX;
  [self.linearGradientParameters valuesDidChange];

  self.endPointXSlider.value = [Converter fractionFromPartValue:endPointX
                                                     rangeValue:self.linearGradientParameters.rangeEndPointX];
}

- (IBAction) endPointYEditingDidEnd:(UITextField*)sender
{
  CGFloat endPointY = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.endPointY = endPointY;
  [self.linearGradientParameters valuesDidChange];

  self.endPointYSlider.value = [Converter fractionFromPartValue:endPointY
                                                     rangeValue:self.linearGradientParameters.rangeEndPointY];
}

#pragma mark - Slider input actions

- (IBAction) startPointXValueChanged:(UISlider*)sender
{
  CGFloat startPointX = [Converter partValueFromFractionValue:sender.value
                                                   rangeValue:self.linearGradientParameters.rangeStartPointX];

  self.linearGradientParameters.startPointX = startPointX;
  [self.linearGradientParameters valuesDidChange];

  self.startPointXTextField.text = [NSString stringWithFormat:@"%f", startPointX];
}

- (IBAction) startPointYValueChanged:(UISlider*)sender
{
  CGFloat startPointY = [Converter partValueFromFractionValue:sender.value
                                                   rangeValue:self.linearGradientParameters.rangeStartPointY];

  self.linearGradientParameters.startPointY = startPointY;
  [self.linearGradientParameters valuesDidChange];

  self.startPointYTextField.text = [NSString stringWithFormat:@"%f", startPointY];
}

- (IBAction) endPointXValueChanged:(UISlider*)sender
{
  CGFloat endPointX = [Converter partValueFromFractionValue:sender.value
                                                 rangeValue:self.linearGradientParameters.rangeEndPointX];

  self.linearGradientParameters.endPointX = endPointX;
  [self.linearGradientParameters valuesDidChange];

  self.endPointXTextField.text = [NSString stringWithFormat:@"%f", endPointX];
}

- (IBAction) endPointYValueChanged:(UISlider*)sender
{
  CGFloat endPointY = [Converter partValueFromFractionValue:sender.value
                                                 rangeValue:self.linearGradientParameters.rangeEndPointY];

  self.linearGradientParameters.endPointY = endPointY;
  [self.linearGradientParameters valuesDidChange];

  self.endPointYTextField.text = [NSString stringWithFormat:@"%f", endPointY];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.startPointXTextField.text = [NSString stringWithFormat:@"%f", self.linearGradientParameters.startPointX];
  self.startPointYTextField.text = [NSString stringWithFormat:@"%f", self.linearGradientParameters.startPointY];
  self.endPointXTextField.text = [NSString stringWithFormat:@"%f", self.linearGradientParameters.endPointX];
  self.endPointYTextField.text = [NSString stringWithFormat:@"%f", self.linearGradientParameters.endPointY];

  self.startPointXSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.startPointX
                                                       rangeValue:self.linearGradientParameters.rangeStartPointX];
  self.startPointYSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.startPointY
                                                       rangeValue:self.linearGradientParameters.rangeStartPointY];
  self.endPointXSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.endPointX
                                                     rangeValue:self.linearGradientParameters.rangeEndPointX];
  self.endPointYSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.endPointY
                                                     rangeValue:self.linearGradientParameters.rangeEndPointY];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
