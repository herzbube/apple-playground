//
//  ArcParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "ArcParametersViewController.h"
#import "../../Model/Path/ArcParameters.h"
#import "../../Converter.h"

@interface ArcParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* centerXTextField;
@property (weak, nonatomic) IBOutlet UITextField* centerYTextField;
@property (weak, nonatomic) IBOutlet UITextField* radiusTextField;
@property (weak, nonatomic) IBOutlet UITextField* startAngleTextField;
@property (weak, nonatomic) IBOutlet UITextField* endAngleTextField;
@property (weak, nonatomic) IBOutlet UISlider* centerXSlider;
@property (weak, nonatomic) IBOutlet UISlider* centerYSlider;
@property (weak, nonatomic) IBOutlet UISlider* radiusSlider;
@property (weak, nonatomic) IBOutlet UISlider* startAngleSlider;
@property (weak, nonatomic) IBOutlet UISlider* endAngleSlider;
@property (weak, nonatomic) IBOutlet UISwitch* clockwiseSwitch;
@end

@implementation ArcParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithArcParameters:(ArcParameters*)arcParameters
{
  self = [super initWithNibName:@"ArcParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (arcParameters)
    self.arcParameters = arcParameters;
  else
    self.arcParameters = [[ArcParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) centerXEditingDidEnd:(UITextField*)sender
{
  CGFloat centerX = [Converter floatFromStringValue:sender.text];

  self.arcParameters.centerX = centerX;
  [self.arcParameters valuesDidChange];

  self.centerXSlider.value = [Converter fractionFromPartValue:centerX
                                                   wholeValue:self.arcParameters.maximumCenterX];
}

- (IBAction) centerYEditingDidEnd:(UITextField*)sender
{
  CGFloat centerY = [Converter floatFromStringValue:sender.text];

  self.arcParameters.centerY = centerY;
  [self.arcParameters valuesDidChange];

  self.centerYSlider.value = [Converter fractionFromPartValue:centerY
                                                   wholeValue:self.arcParameters.maximumCenterY];
}

- (IBAction) radiusEditingDidEnd:(UITextField*)sender
{
  CGFloat radius = [Converter floatFromStringValue:sender.text];

  self.arcParameters.radius = radius;
  [self.arcParameters valuesDidChange];

  self.radiusSlider.value = [Converter fractionFromPartValue:radius
                                                  wholeValue:self.arcParameters.maximumRadius];
}

- (IBAction) startAngleEditingDidEnd:(UITextField*)sender
{
  CGFloat startAngle = [Converter floatFromStringValue:sender.text];

  self.arcParameters.startAngle = startAngle;
  [self.arcParameters valuesDidChange];

  self.startAngleSlider.value = [Converter fractionFromPartValue:startAngle
                                                      wholeValue:self.arcParameters.maximumStartAngle];
}

- (IBAction) endAngleEditingDidEnd:(UITextField*)sender
{
  CGFloat endAngle = [Converter floatFromStringValue:sender.text];

  self.arcParameters.endAngle = endAngle;
  [self.arcParameters valuesDidChange];

  self.endAngleSlider.value = [Converter fractionFromPartValue:endAngle
                                                    wholeValue:self.arcParameters.maximumEndAngle];
}

#pragma mark - Slider input actions

- (IBAction) centerXValueChanged:(UISlider*)sender
{
  CGFloat centerX = [Converter partValueFromFractionValue:sender.value
                                               wholeValue:self.arcParameters.maximumCenterX];

  self.arcParameters.centerX = centerX;
  [self.arcParameters valuesDidChange];

  self.centerXTextField.text = [NSString stringWithFormat:@"%f", centerX];
}

- (IBAction) centerYValueChanged:(UISlider*)sender
{
  CGFloat centerY = [Converter partValueFromFractionValue:sender.value
                                               wholeValue:self.arcParameters.maximumCenterY];

  self.arcParameters.centerY = centerY;
  [self.arcParameters valuesDidChange];

  self.centerYTextField.text = [NSString stringWithFormat:@"%f", centerY];
}

- (IBAction) radiusValueChanged:(UISlider*)sender
{
  CGFloat radius = [Converter partValueFromFractionValue:sender.value
                                              wholeValue:self.arcParameters.maximumRadius];

  self.arcParameters.radius = radius;
  [self.arcParameters valuesDidChange];

  self.radiusTextField.text = [NSString stringWithFormat:@"%f", radius];
}

- (IBAction) startAngleValueChanged:(UISlider*)sender
{
  CGFloat startAngle = [Converter partValueFromFractionValue:sender.value
                                                  wholeValue:self.arcParameters.maximumStartAngle];

  self.arcParameters.startAngle = startAngle;
  [self.arcParameters valuesDidChange];

  self.startAngleTextField.text = [NSString stringWithFormat:@"%f", startAngle];
}

- (IBAction) endAngleValueChanged:(UISlider*)sender
{
  CGFloat endAngle = [Converter partValueFromFractionValue:sender.value
                                                wholeValue:self.arcParameters.maximumEndAngle];

  self.arcParameters.endAngle = endAngle;
  [self.arcParameters valuesDidChange];

  self.endAngleTextField.text = [NSString stringWithFormat:@"%f", endAngle];
}

#pragma mark - Switch input actions

- (IBAction) clockwiseValueChanged:(UISwitch*)sender
{
  BOOL clockwise = sender.on;
  [self.arcParameters valuesDidChange];

  self.arcParameters.clockwise = clockwise;
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.centerXTextField.text = [NSString stringWithFormat:@"%f", self.arcParameters.centerX];
  self.centerYTextField.text = [NSString stringWithFormat:@"%f", self.arcParameters.centerY];
  self.radiusTextField.text = [NSString stringWithFormat:@"%f", self.arcParameters.radius];
  self.startAngleTextField.text = [NSString stringWithFormat:@"%f", self.arcParameters.startAngle];
  self.endAngleTextField.text = [NSString stringWithFormat:@"%f", self.arcParameters.endAngle];

  self.centerXSlider.value = [Converter fractionFromPartValue:self.arcParameters.centerX
                                                   wholeValue:self.arcParameters.maximumCenterX];
  self.centerYSlider.value = [Converter fractionFromPartValue:self.arcParameters.centerY
                                                   wholeValue:self.arcParameters.maximumCenterY];
  self.radiusSlider.value = [Converter fractionFromPartValue:self.arcParameters.radius
                                                  wholeValue:self.arcParameters.maximumRadius];
  self.startAngleSlider.value = [Converter fractionFromPartValue:self.arcParameters.startAngle
                                                      wholeValue:self.arcParameters.maximumStartAngle];
  self.endAngleSlider.value = [Converter fractionFromPartValue:self.arcParameters.endAngle
                                                    wholeValue:self.arcParameters.maximumEndAngle];

  self.clockwiseSwitch.on = self.arcParameters.clockwise;
}

@end
