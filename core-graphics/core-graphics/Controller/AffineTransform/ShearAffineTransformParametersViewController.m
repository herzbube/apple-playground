//
//  ShearAffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "ShearAffineTransformParametersViewController.h"
#import "../../Model/AffineTransform/ShearAffineTransformParameters.h"
#import "../../Converter.h"

@interface ShearAffineTransformParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* shearAngleXTextField;
@property (weak, nonatomic) IBOutlet UITextField* shearAngleYTextField;
@property (weak, nonatomic) IBOutlet UISlider* shearAngleXSlider;
@property (weak, nonatomic) IBOutlet UISlider* shearAngleYSlider;
@end

@implementation ShearAffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithShearAffineTransformParameters:(ShearAffineTransformParameters*)shearAffineTransformParameters
{
  self = [super initWithNibName:@"ShearAffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (shearAffineTransformParameters)
    self.shearAffineTransformParameters = shearAffineTransformParameters;
  else
    self.shearAffineTransformParameters = [[ShearAffineTransformParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) shearAngleXEditingDidEnd:(UITextField*)sender
{
  CGFloat shearAngleX = [Converter floatFromStringValue:sender.text];

  self.shearAffineTransformParameters.shearAngleX = shearAngleX;
  [self.shearAffineTransformParameters updateParametersDidChange];

  self.shearAngleXSlider.value = [Converter fractionFromPartValue:shearAngleX
                                                       rangeValue:self.shearAffineTransformParameters.rangeShearAngleX];
}

- (IBAction) shearAngleYEditingDidEnd:(UITextField*)sender
{
  CGFloat shearAngleY = [Converter floatFromStringValue:sender.text];

  self.shearAffineTransformParameters.shearAngleY = shearAngleY;
  [self.shearAffineTransformParameters updateParametersDidChange];

  self.shearAngleYSlider.value = [Converter fractionFromPartValue:shearAngleY
                                                       rangeValue:self.shearAffineTransformParameters.rangeShearAngleY];
}

#pragma mark - Slider input actions

- (IBAction) shearAngleXValueChanged:(UISlider*)sender
{
  CGFloat shearAngleX = [Converter partValueFromFractionValue:sender.value
                                                   rangeValue:self.shearAffineTransformParameters.rangeShearAngleX];

  self.shearAffineTransformParameters.shearAngleX = shearAngleX;
  [self.shearAffineTransformParameters updateParametersDidChange];

  self.shearAngleXTextField.text = [NSString stringWithFormat:@"%f", shearAngleX];
}

- (IBAction) shearAngleYValueChanged:(UISlider*)sender
{
  CGFloat shearAngleY = [Converter partValueFromFractionValue:sender.value
                                                   rangeValue:self.shearAffineTransformParameters.rangeShearAngleY];

  self.shearAffineTransformParameters.shearAngleY = shearAngleY;
  [self.shearAffineTransformParameters updateParametersDidChange];

  self.shearAngleYTextField.text = [NSString stringWithFormat:@"%f", shearAngleY];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.shearAngleXTextField.text = [NSString stringWithFormat:@"%f", self.shearAffineTransformParameters.shearAngleX];
  self.shearAngleYTextField.text = [NSString stringWithFormat:@"%f", self.shearAffineTransformParameters.shearAngleY];

  self.shearAngleXSlider.value = [Converter fractionFromPartValue:self.shearAffineTransformParameters.shearAngleX
                                                       rangeValue:self.shearAffineTransformParameters.rangeShearAngleX];
  self.shearAngleYSlider.value = [Converter fractionFromPartValue:self.shearAffineTransformParameters.shearAngleY
                                                       rangeValue:self.shearAffineTransformParameters.rangeShearAngleY];
}

@end
