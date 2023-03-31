//
//  StrokeParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 22.03.23.
//

#import "StrokeParametersViewController.h"
#import "ColorParametersViewController.h"
#import "../Model/StrokeParameters.h"
#import "../AutoLayoutUtility.h"
#import "../Converter.h"

@interface StrokeParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* strokeEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* stackView;
@property (weak, nonatomic) IBOutlet UITextField* lineWidthTextField;
@property (weak, nonatomic) IBOutlet UISlider* lineWidthSlider;
@property (weak, nonatomic) IBOutlet UIView* colorParametersContainerView;
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
  ColorParametersViewController* colorParametersViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.strokeParameters.colorParameters];

  [self addChildViewController:colorParametersViewController];
  [colorParametersViewController didMoveToParentViewController:self];

  UIView* colorParametersView = colorParametersViewController.view;
  [self.colorParametersContainerView addSubview:colorParametersView];
  colorParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorParametersContainerView withSubview:colorParametersView];
}

#pragma mark - Switch input actions

- (IBAction) strokeEnabledValueChanged:(UISwitch*)sender
{
  BOOL strokeEnabled = sender.on;

  self.stackView.hidden = ! strokeEnabled;

  self.strokeParameters.strokeEnabled = strokeEnabled;
}

#pragma mark - Text field input actions

- (IBAction) lineWidthEditingDidEnd:(UITextField*)sender
{
  CGFloat lineWidth = [Converter floatFromStringValue:sender.text];

  self.strokeParameters.lineWidth = lineWidth;

  self.lineWidthSlider.value = [Converter fractionFromPartValue:lineWidth
                                                     wholeValue:self.strokeParameters.maximumLineWidth];
}

#pragma mark - Slider input actions

- (IBAction) lineWidthValueChanged:(UISlider*)sender
{
  CGFloat lineWidth = [Converter partValueFromFractionValue:sender.value
                                                 wholeValue:self.strokeParameters.maximumLineWidth];

  self.strokeParameters.lineWidth = lineWidth;

  self.lineWidthTextField.text = [NSString stringWithFormat:@"%f", lineWidth];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.strokeEnabledSwitch.on = self.strokeParameters.strokeEnabled;
  self.stackView.hidden = ! self.strokeParameters.strokeEnabled;
  self.lineWidthTextField.text = [NSString stringWithFormat:@"%f", self.strokeParameters.lineWidth];
  self.lineWidthSlider.value = [Converter fractionFromPartValue:self.strokeParameters.lineWidth
                                                     wholeValue:self.strokeParameters.maximumLineWidth];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
