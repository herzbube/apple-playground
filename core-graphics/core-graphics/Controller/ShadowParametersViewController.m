//
//  ShadowParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "ShadowParametersViewController.h"
#import "ColorParametersViewController.h"
#import "../Model/ShadowParameters.h"
#import "../AutoLayoutUtility.h"
#import "../Converter.h"

@interface ShadowParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* shadowEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIStackView* shadowParametersStackView;
@property (weak, nonatomic) IBOutlet UITextField* offsetXTextField;
@property (weak, nonatomic) IBOutlet UISlider* offsetXSlider;
@property (weak, nonatomic) IBOutlet UITextField* offsetYTextField;
@property (weak, nonatomic) IBOutlet UISlider* offsetYSlider;
@property (weak, nonatomic) IBOutlet UITextField* blurTextField;
@property (weak, nonatomic) IBOutlet UISlider* blurSlider;
@property (weak, nonatomic) IBOutlet UIView* colorParametersContainerView;
@end

@implementation ShadowParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithShadowParameters:(ShadowParameters*)shadowParameters
{
  self = [super initWithNibName:@"ShadowParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (shadowParameters)
    self.shadowParameters = shadowParameters;
  else
    self.shadowParameters = [[ShadowParameters alloc] init];

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
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.shadowParameters.colorParameters];

  [self addChildViewController:colorParametersViewController];
  [colorParametersViewController didMoveToParentViewController:self];

  UIView* colorParametersView = colorParametersViewController.view;
  [self.colorParametersContainerView addSubview:colorParametersView];
  colorParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorParametersContainerView withSubview:colorParametersView];
}

#pragma mark - Switch input actions

- (IBAction) shadowEnabledValueChanged:(UISwitch*)sender
{
  BOOL shadowEnabled = sender.on;

  self.shadowParameters.shadowEnabled = shadowEnabled;
  [self.shadowParameters valuesDidChange];

  [self updateUiVisibility];
}

#pragma mark - Text field input actions

- (IBAction) offsetXEditingDidEnd:(UITextField*)sender
{
  CGFloat offsetX = [Converter floatFromStringValue:sender.text];

  self.shadowParameters.offsetX = offsetX;
  [self.shadowParameters valuesDidChange];

  self.offsetXSlider.value = [Converter fractionFromPartValue:offsetX
                                                   rangeValue:self.shadowParameters.rangeOffsetX];
}

- (IBAction) offsetYEditingDidEnd:(UITextField*)sender
{
  CGFloat offsetY = [Converter floatFromStringValue:sender.text];

  self.shadowParameters.offsetY = offsetY;
  [self.shadowParameters valuesDidChange];

  self.offsetYSlider.value = [Converter fractionFromPartValue:offsetY
                                                   rangeValue:self.shadowParameters.rangeOffsetY];
}

- (IBAction) blurEditingDidEnd:(UITextField*)sender
{
  CGFloat blur = [Converter floatFromStringValue:sender.text];

  self.shadowParameters.blur = blur;
  [self.shadowParameters valuesDidChange];

  self.blurSlider.value = [Converter fractionFromPartValue:blur
                                                wholeValue:self.shadowParameters.maximumBlur];
}

#pragma mark - Slider input actions

- (IBAction) offsetXValueChanged:(UISlider*)sender
{
  CGFloat offsetX = [Converter partValueFromFractionValue:sender.value
                                               rangeValue:self.shadowParameters.rangeOffsetX];

  self.shadowParameters.offsetX = offsetX;
  [self.shadowParameters valuesDidChange];

  self.offsetXTextField.text = [NSString stringWithFormat:@"%f", offsetX];
}

- (IBAction) offsetYValueChanged:(UISlider*)sender
{
  CGFloat offsetY = [Converter partValueFromFractionValue:sender.value
                                               rangeValue:self.shadowParameters.rangeOffsetY];

  self.shadowParameters.offsetY = offsetY;
  [self.shadowParameters valuesDidChange];

  self.offsetYTextField.text = [NSString stringWithFormat:@"%f", offsetY];
}

- (IBAction) blurValueChanged:(UISlider*)sender
{
  CGFloat blur = [Converter partValueFromFractionValue:sender.value
                                            wholeValue:self.shadowParameters.maximumBlur];

  self.shadowParameters.blur = blur;
  [self.shadowParameters valuesDidChange];

  self.blurTextField.text = [NSString stringWithFormat:@"%f", blur];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.shadowEnabledSwitch.on = self.shadowParameters.shadowEnabled;
  self.offsetXTextField.text = [NSString stringWithFormat:@"%f", self.shadowParameters.offsetX];
  self.offsetXSlider.value = [Converter fractionFromPartValue:self.shadowParameters.offsetX
                                                   rangeValue:self.shadowParameters.rangeOffsetX];
  self.offsetYTextField.text = [NSString stringWithFormat:@"%f", self.shadowParameters.offsetY];
  self.offsetYSlider.value = [Converter fractionFromPartValue:self.shadowParameters.offsetY
                                                   rangeValue:self.shadowParameters.rangeOffsetY];
  self.blurTextField.text = [NSString stringWithFormat:@"%f", self.shadowParameters.blur];
  self.blurSlider.value = [Converter fractionFromPartValue:self.shadowParameters.blur
                                                wholeValue:self.shadowParameters.maximumBlur];

  [self updateUiVisibility];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.shadowParameters.shadowEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.shadowParametersStackView])
      [self.topLevelStackView insertArrangedSubview:self.shadowParametersStackView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.shadowParametersStackView])
    {
      [self.topLevelStackView removeArrangedSubview:self.shadowParametersStackView];
      [self.shadowParametersStackView removeFromSuperview];
    }
  }
}

@end
