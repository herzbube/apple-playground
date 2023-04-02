//
//  RotateAffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "RotateAffineTransformParametersViewController.h"
#import "../../Model/AffineTransform/RotateAffineTransformParameters.h"
#import "../../Converter.h"

@interface RotateAffineTransformParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* rotateAngleTextField;
@property (weak, nonatomic) IBOutlet UISlider* rotateAngleSlider;
@end

@implementation RotateAffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithRotateAffineTransformParameters:(RotateAffineTransformParameters*)rotateAffineTransformParameters
{
  self = [super initWithNibName:@"RotateAffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (rotateAffineTransformParameters)
    self.rotateAffineTransformParameters = rotateAffineTransformParameters;
  else
    self.rotateAffineTransformParameters = [[RotateAffineTransformParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) rotateAngleEditingDidEnd:(UITextField*)sender
{
  CGFloat rotateAngle = [Converter floatFromStringValue:sender.text];

  self.rotateAffineTransformParameters.rotateAngle = rotateAngle;
  [self.rotateAffineTransformParameters updateParametersDidChange];

  self.rotateAngleSlider.value = [Converter fractionFromPartValue:rotateAngle
                                                       rangeValue:self.rotateAffineTransformParameters.rangeRotateAngle];
}

#pragma mark - Slider input actions

- (IBAction) rotateAngleValueChanged:(UISlider*)sender
{
  CGFloat rotateAngle = [Converter partValueFromFractionValue:sender.value
                                                   rangeValue:self.rotateAffineTransformParameters.rangeRotateAngle];

  self.rotateAffineTransformParameters.rotateAngle = rotateAngle;
  [self.rotateAffineTransformParameters updateParametersDidChange];

  self.rotateAngleTextField.text = [NSString stringWithFormat:@"%f", rotateAngle];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.rotateAngleTextField.text = [NSString stringWithFormat:@"%f", self.rotateAffineTransformParameters.rotateAngle];

  self.rotateAngleSlider.value = [Converter fractionFromPartValue:self.rotateAffineTransformParameters.rotateAngle
                                                       rangeValue:self.rotateAffineTransformParameters.rangeRotateAngle];
}

@end
