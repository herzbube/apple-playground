//
//  ScaleAffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "ScaleAffineTransformParametersViewController.h"
#import "../../Model/AffineTransform/ScaleAffineTransformParameters.h"
#import "../../Converter.h"

@interface ScaleAffineTransformParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* scaleXTextField;
@property (weak, nonatomic) IBOutlet UITextField* scaleYTextField;
@property (weak, nonatomic) IBOutlet UISlider* scaleXSlider;
@property (weak, nonatomic) IBOutlet UISlider* scaleYSlider;
@end

@implementation ScaleAffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithScaleAffineTransformParameters:(ScaleAffineTransformParameters*)scaleAffineTransformParameters
{
  self = [super initWithNibName:@"ScaleAffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (scaleAffineTransformParameters)
    self.scaleAffineTransformParameters = scaleAffineTransformParameters;
  else
    self.scaleAffineTransformParameters = [[ScaleAffineTransformParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) scaleXEditingDidEnd:(UITextField*)sender
{
  CGFloat scaleX = [Converter floatFromStringValue:sender.text];

  self.scaleAffineTransformParameters.scaleX = scaleX;
  [self.scaleAffineTransformParameters valuesDidChange];

  self.scaleXSlider.value = [Converter fractionFromPartValue:scaleX
                                                  wholeValue:self.scaleAffineTransformParameters.maximumScaleX];
}

- (IBAction) scaleYEditingDidEnd:(UITextField*)sender
{
  CGFloat scaleY = [Converter floatFromStringValue:sender.text];

  self.scaleAffineTransformParameters.scaleY = scaleY;
  [self.scaleAffineTransformParameters valuesDidChange];

  self.scaleYSlider.value = [Converter fractionFromPartValue:scaleY
                                                  wholeValue:self.scaleAffineTransformParameters.maximumScaleY];
}

#pragma mark - Slider input actions

- (IBAction) scaleXValueChanged:(UISlider*)sender
{
  CGFloat scaleX = [Converter partValueFromFractionValue:sender.value
                                              wholeValue:self.scaleAffineTransformParameters.maximumScaleX];

  self.scaleAffineTransformParameters.scaleX = scaleX;
  [self.scaleAffineTransformParameters valuesDidChange];

  self.scaleXTextField.text = [NSString stringWithFormat:@"%f", scaleX];
}

- (IBAction) scaleYValueChanged:(UISlider*)sender
{
  CGFloat scaleY = [Converter partValueFromFractionValue:sender.value
                                              wholeValue:self.scaleAffineTransformParameters.maximumScaleY];

  self.scaleAffineTransformParameters.scaleY = scaleY;
  [self.scaleAffineTransformParameters valuesDidChange];

  self.scaleYTextField.text = [NSString stringWithFormat:@"%f", scaleY];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.scaleXTextField.text = [NSString stringWithFormat:@"%f", self.scaleAffineTransformParameters.scaleX];
  self.scaleYTextField.text = [NSString stringWithFormat:@"%f", self.scaleAffineTransformParameters.scaleY];

  self.scaleXSlider.value = [Converter fractionFromPartValue:self.scaleAffineTransformParameters.scaleX
                                                  wholeValue:self.scaleAffineTransformParameters.maximumScaleX];
  self.scaleYSlider.value = [Converter fractionFromPartValue:self.scaleAffineTransformParameters.scaleY
                                                  wholeValue:self.scaleAffineTransformParameters.maximumScaleY];
}

@end
