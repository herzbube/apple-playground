//
//  LinearGradientParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "LinearGradientParametersViewController.h"
#import "GradientStopParametersViewController.h"
#import "../AffineTransform/AffineTransformParametersViewController.h"
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
@property (weak, nonatomic) IBOutlet UIView* gradientStopParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* affineTransformParametersContainerView;
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
  [self integrateGradientStopParametersChildViewController];
  [self integrateAffineTransformParametersChildViewController];
}

- (void) integrateGradientStopParametersChildViewController
{
  GradientStopParametersViewController* gradientStopParametersViewController = [[GradientStopParametersViewController alloc] initWithGradientStopParameters:self.linearGradientParameters.gradientStopParameters];

  [self addChildViewController:gradientStopParametersViewController];
  [gradientStopParametersViewController didMoveToParentViewController:self];

  UIView* gradientStopParametersView = gradientStopParametersViewController.view;
  [self.gradientStopParametersContainerView addSubview:gradientStopParametersView];
  gradientStopParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.gradientStopParametersContainerView withSubview:gradientStopParametersView];
}

- (void) integrateAffineTransformParametersChildViewController
{
  AffineTransformParametersViewController* affineTransformParametersViewController = [[AffineTransformParametersViewController alloc] initWithAffineTransformParameters:self.linearGradientParameters.affineTransformParameters];

  [self addChildViewController:affineTransformParametersViewController];
  [affineTransformParametersViewController didMoveToParentViewController:self];

  UIView* affineTransformParametersView = affineTransformParametersViewController.view;
  [self.affineTransformParametersContainerView addSubview:affineTransformParametersView];
  affineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.affineTransformParametersContainerView withSubview:affineTransformParametersView];
}

#pragma mark - Text field input actions

- (IBAction) startPointXEditingDidEnd:(UITextField*)sender
{
  CGFloat startPointX = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.startPointX = startPointX;

  self.startPointXSlider.value = [Converter fractionFromPartValue:startPointX
                                                       wholeValue:self.linearGradientParameters.maximumStartPointX];
}

- (IBAction) startPointYEditingDidEnd:(UITextField*)sender
{
  CGFloat startPointY = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.startPointY = startPointY;

  self.startPointYSlider.value = [Converter fractionFromPartValue:startPointY
                                                       wholeValue:self.linearGradientParameters.maximumStartPointY];
}

- (IBAction) endPointXEditingDidEnd:(UITextField*)sender
{
  CGFloat endPointX = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.endPointX = endPointX;

  self.endPointXSlider.value = [Converter fractionFromPartValue:endPointX
                                                     wholeValue:self.linearGradientParameters.maximumEndPointX];
}

- (IBAction) endPointYEditingDidEnd:(UITextField*)sender
{
  CGFloat endPointY = [Converter floatFromStringValue:sender.text];

  self.linearGradientParameters.endPointY = endPointY;

  self.endPointYSlider.value = [Converter fractionFromPartValue:endPointY
                                                     wholeValue:self.linearGradientParameters.maximumEndPointY];
}

#pragma mark - Slider input actions

- (IBAction) startPointXValueChanged:(UISlider*)sender
{
  CGFloat startPointX = [Converter partValueFromFractionValue:sender.value
                                                   wholeValue:self.linearGradientParameters.maximumStartPointX];

  self.linearGradientParameters.startPointX = startPointX;

  self.startPointXTextField.text = [NSString stringWithFormat:@"%f", startPointX];
}

- (IBAction) startPointYValueChanged:(UISlider*)sender
{
  CGFloat startPointY = [Converter partValueFromFractionValue:sender.value
                                                   wholeValue:self.linearGradientParameters.maximumStartPointY];

  self.linearGradientParameters.startPointY = startPointY;

  self.startPointYTextField.text = [NSString stringWithFormat:@"%f", startPointY];
}

- (IBAction) endPointXValueChanged:(UISlider*)sender
{
  CGFloat endPointX = [Converter partValueFromFractionValue:sender.value
                                                 wholeValue:self.linearGradientParameters.maximumEndPointX];

  self.linearGradientParameters.endPointX = endPointX;

  self.endPointXTextField.text = [NSString stringWithFormat:@"%f", endPointX];
}

- (IBAction) endPointYValueChanged:(UISlider*)sender
{
  CGFloat endPointY = [Converter partValueFromFractionValue:sender.value
                                                 wholeValue:self.linearGradientParameters.maximumEndPointY];

  self.linearGradientParameters.endPointY = endPointY;

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
                                                       wholeValue:self.linearGradientParameters.maximumStartPointX];
  self.startPointYSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.startPointY
                                                       wholeValue:self.linearGradientParameters.maximumStartPointY];
  self.endPointXSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.endPointX
                                                     wholeValue:self.linearGradientParameters.maximumEndPointX];
  self.endPointYSlider.value = [Converter fractionFromPartValue:self.linearGradientParameters.endPointY
                                                     wholeValue:self.linearGradientParameters.maximumEndPointY];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
