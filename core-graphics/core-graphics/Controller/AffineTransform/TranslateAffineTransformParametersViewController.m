//
//  TranslateAffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "TranslateAffineTransformParametersViewController.h"
#import "../../Model/AffineTransform/TranslateAffineTransformParameters.h"
#import "../../Converter.h"

@interface TranslateAffineTransformParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* translateXTextField;
@property (weak, nonatomic) IBOutlet UITextField* translateYTextField;
@property (weak, nonatomic) IBOutlet UISlider* translateXSlider;
@property (weak, nonatomic) IBOutlet UISlider* translateYSlider;
@end

@implementation TranslateAffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithTranslateAffineTransformParameters:(TranslateAffineTransformParameters*)translateAffineTransformParameters
{
  self = [super initWithNibName:@"TranslateAffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (translateAffineTransformParameters)
    self.translateAffineTransformParameters = translateAffineTransformParameters;
  else
    self.translateAffineTransformParameters = [[TranslateAffineTransformParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) translateXEditingDidEnd:(UITextField*)sender
{
  CGFloat translateX = [Converter floatFromStringValue:sender.text];

  self.translateAffineTransformParameters.translateX = translateX;
  [self.translateAffineTransformParameters updateParametersDidChange];

  self.translateXSlider.value = [Converter fractionFromPartValue:translateX
                                                      rangeValue:self.translateAffineTransformParameters.rangeTranslateX];
}

- (IBAction) translateYEditingDidEnd:(UITextField*)sender
{
  CGFloat translateY = [Converter floatFromStringValue:sender.text];

  self.translateAffineTransformParameters.translateY = translateY;
  [self.translateAffineTransformParameters updateParametersDidChange];

  self.translateYSlider.value = [Converter fractionFromPartValue:translateY
                                                      rangeValue:self.translateAffineTransformParameters.rangeTranslateY];
}

#pragma mark - Slider input actions

- (IBAction) translateXValueChanged:(UISlider*)sender
{
  CGFloat translateX = [Converter partValueFromFractionValue:sender.value
                                                  rangeValue:self.translateAffineTransformParameters.rangeTranslateX];

  self.translateAffineTransformParameters.translateX = translateX;
  [self.translateAffineTransformParameters updateParametersDidChange];

  self.translateXTextField.text = [NSString stringWithFormat:@"%f", translateX];
}

- (IBAction) translateYValueChanged:(UISlider*)sender
{
  CGFloat translateY = [Converter partValueFromFractionValue:sender.value
                                                  rangeValue:self.translateAffineTransformParameters.rangeTranslateY];

  self.translateAffineTransformParameters.translateY = translateY;
  [self.translateAffineTransformParameters updateParametersDidChange];

  self.translateYTextField.text = [NSString stringWithFormat:@"%f", translateY];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.translateXTextField.text = [NSString stringWithFormat:@"%f", self.translateAffineTransformParameters.translateX];
  self.translateYTextField.text = [NSString stringWithFormat:@"%f", self.translateAffineTransformParameters.translateY];

  self.translateXSlider.value = [Converter fractionFromPartValue:self.translateAffineTransformParameters.translateX
                                                      rangeValue:self.translateAffineTransformParameters.rangeTranslateX];
  self.translateYSlider.value = [Converter fractionFromPartValue:self.translateAffineTransformParameters.translateY
                                                      rangeValue:self.translateAffineTransformParameters.rangeTranslateY];
}

@end
