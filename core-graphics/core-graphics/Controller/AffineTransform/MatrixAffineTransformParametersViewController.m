//
//  MatrixAffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "MatrixAffineTransformParametersViewController.h"
#import "../../Model/AffineTransform/MatrixAffineTransformParameters.h"
#import "../../Converter.h"

@interface MatrixAffineTransformParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* aTextField;
@property (weak, nonatomic) IBOutlet UITextField* bTextField;
@property (weak, nonatomic) IBOutlet UITextField* cTextField;
@property (weak, nonatomic) IBOutlet UITextField* dTextField;
@property (weak, nonatomic) IBOutlet UITextField* txTextField;
@property (weak, nonatomic) IBOutlet UITextField* tyTextField;
@property (weak, nonatomic) IBOutlet UISlider* aSlider;
@property (weak, nonatomic) IBOutlet UISlider* bSlider;
@property (weak, nonatomic) IBOutlet UISlider* cSlider;
@property (weak, nonatomic) IBOutlet UISlider* dSlider;
@property (weak, nonatomic) IBOutlet UISlider* txSlider;
@property (weak, nonatomic) IBOutlet UISlider* tySlider;
@end

@implementation MatrixAffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithMatrixAffineTransformParameters:(MatrixAffineTransformParameters*)matrixAffineTransformParameters
{
  self = [super initWithNibName:@"MatrixAffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (matrixAffineTransformParameters)
    self.matrixAffineTransformParameters = matrixAffineTransformParameters;
  else
    self.matrixAffineTransformParameters = [[MatrixAffineTransformParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) aEditingDidEnd:(UITextField*)sender
{
  CGFloat a = [Converter floatFromStringValue:sender.text];

  self.matrixAffineTransformParameters.a = a;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.aSlider.value = [Converter fractionFromPartValue:a
                                             rangeValue:self.matrixAffineTransformParameters.rangeA];
}

- (IBAction) bEditingDidEnd:(UITextField*)sender
{
  CGFloat b = [Converter floatFromStringValue:sender.text];

  self.matrixAffineTransformParameters.b = b;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.bSlider.value = [Converter fractionFromPartValue:b
                                             rangeValue:self.matrixAffineTransformParameters.rangeB];
}

- (IBAction) cEditingDidEnd:(UITextField*)sender
{
  CGFloat c = [Converter floatFromStringValue:sender.text];

  self.matrixAffineTransformParameters.c = c;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.cSlider.value = [Converter fractionFromPartValue:c
                                             rangeValue:self.matrixAffineTransformParameters.rangeC];
}

- (IBAction) dEditingDidEnd:(UITextField*)sender
{
  CGFloat d = [Converter floatFromStringValue:sender.text];

  self.matrixAffineTransformParameters.d = d;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.dSlider.value = [Converter fractionFromPartValue:d
                                             rangeValue:self.matrixAffineTransformParameters.rangeD];
}

- (IBAction) txEditingDidEnd:(UITextField*)sender
{
  CGFloat tx = [Converter floatFromStringValue:sender.text];

  self.matrixAffineTransformParameters.tx = tx;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.txSlider.value = [Converter fractionFromPartValue:tx
                                              rangeValue:self.matrixAffineTransformParameters.rangeTx];
}

- (IBAction) tyEditingDidEnd:(UITextField*)sender
{
  CGFloat ty = [Converter floatFromStringValue:sender.text];

  self.matrixAffineTransformParameters.ty = ty;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.tySlider.value = [Converter fractionFromPartValue:ty
                                              rangeValue:self.matrixAffineTransformParameters.rangeTy];
}

#pragma mark - Slider input actions

- (IBAction) aValueChanged:(UISlider*)sender
{
  CGFloat a = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.matrixAffineTransformParameters.rangeA];

  self.matrixAffineTransformParameters.a = a;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.aTextField.text = [NSString stringWithFormat:@"%f", a];
}

- (IBAction) bValueChanged:(UISlider*)sender
{
  CGFloat b = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.matrixAffineTransformParameters.rangeB];

  self.matrixAffineTransformParameters.b = b;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.bTextField.text = [NSString stringWithFormat:@"%f", b];
}

- (IBAction) cValueChanged:(UISlider*)sender
{
  CGFloat c = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.matrixAffineTransformParameters.rangeC];

  self.matrixAffineTransformParameters.c = c;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.cTextField.text = [NSString stringWithFormat:@"%f", c];
}

- (IBAction) dValueChanged:(UISlider*)sender
{
  CGFloat d = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.matrixAffineTransformParameters.rangeD];

  self.matrixAffineTransformParameters.d = d;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.dTextField.text = [NSString stringWithFormat:@"%f", d];
}

- (IBAction) txValueChanged:(UISlider*)sender
{
  CGFloat tx = [Converter partValueFromFractionValue:sender.value
                                          rangeValue:self.matrixAffineTransformParameters.rangeTx];

  self.matrixAffineTransformParameters.tx = tx;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.txTextField.text = [NSString stringWithFormat:@"%f", tx];
}

- (IBAction) tyValueChanged:(UISlider*)sender
{
  CGFloat ty = [Converter partValueFromFractionValue:sender.value
                                          rangeValue:self.matrixAffineTransformParameters.rangeTy];

  self.matrixAffineTransformParameters.ty = ty;
  [self.matrixAffineTransformParameters valuesDidChange];

  self.tyTextField.text = [NSString stringWithFormat:@"%f", ty];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.aTextField.text = [NSString stringWithFormat:@"%f", self.matrixAffineTransformParameters.a];
  self.bTextField.text = [NSString stringWithFormat:@"%f", self.matrixAffineTransformParameters.b];
  self.cTextField.text = [NSString stringWithFormat:@"%f", self.matrixAffineTransformParameters.c];
  self.dTextField.text = [NSString stringWithFormat:@"%f", self.matrixAffineTransformParameters.d];
  self.txTextField.text = [NSString stringWithFormat:@"%f", self.matrixAffineTransformParameters.tx];
  self.tyTextField.text = [NSString stringWithFormat:@"%f", self.matrixAffineTransformParameters.ty];

  self.aSlider.value = [Converter fractionFromPartValue:self.matrixAffineTransformParameters.a
                                             rangeValue:self.matrixAffineTransformParameters.rangeA];
  self.bSlider.value = [Converter fractionFromPartValue:self.matrixAffineTransformParameters.b
                                             rangeValue:self.matrixAffineTransformParameters.rangeB];
  self.cSlider.value = [Converter fractionFromPartValue:self.matrixAffineTransformParameters.c
                                             rangeValue:self.matrixAffineTransformParameters.rangeC];
  self.dSlider.value = [Converter fractionFromPartValue:self.matrixAffineTransformParameters.d
                                             rangeValue:self.matrixAffineTransformParameters.rangeD];
  self.txSlider.value = [Converter fractionFromPartValue:self.matrixAffineTransformParameters.tx
                                              rangeValue:self.matrixAffineTransformParameters.rangeTx];
  self.tySlider.value = [Converter fractionFromPartValue:self.matrixAffineTransformParameters.ty
                                              rangeValue:self.matrixAffineTransformParameters.rangeTy];
}

@end
