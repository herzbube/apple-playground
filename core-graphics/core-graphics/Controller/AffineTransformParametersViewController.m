//
//  AffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "AffineTransformParametersViewController.h"
#import "../Model/AffineTransformParameters.h"
#import "../Converter.h"

@interface AffineTransformParametersViewController()
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

@implementation AffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) init
{
  self = [super initWithNibName:@"AffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  self.affineTransformParameters = [[AffineTransformParameters alloc] init];

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

  self.affineTransformParameters.a = a;

  self.aSlider.value = [Converter fractionFromPartValue:a
                                             rangeValue:self.affineTransformParameters.rangeA];
}

- (IBAction) bEditingDidEnd:(UITextField*)sender
{
  CGFloat b = [Converter floatFromStringValue:sender.text];

  self.affineTransformParameters.b = b;

  self.bSlider.value = [Converter fractionFromPartValue:b
                                             rangeValue:self.affineTransformParameters.rangeB];
}

- (IBAction) cEditingDidEnd:(UITextField*)sender
{
  CGFloat c = [Converter floatFromStringValue:sender.text];

  self.affineTransformParameters.c = c;

  self.cSlider.value = [Converter fractionFromPartValue:c
                                             rangeValue:self.affineTransformParameters.rangeC];
}

- (IBAction) dEditingDidEnd:(UITextField*)sender
{
  CGFloat d = [Converter floatFromStringValue:sender.text];

  self.affineTransformParameters.d = d;

  self.dSlider.value = [Converter fractionFromPartValue:d
                                             rangeValue:self.affineTransformParameters.rangeD];
}

- (IBAction) txEditingDidEnd:(UITextField*)sender
{
  CGFloat tx = [Converter floatFromStringValue:sender.text];

  self.affineTransformParameters.tx = tx;

  self.txSlider.value = [Converter fractionFromPartValue:tx
                                              rangeValue:self.affineTransformParameters.rangeTx];
}

- (IBAction) tyEditingDidEnd:(UITextField*)sender
{
  CGFloat ty = [Converter floatFromStringValue:sender.text];

  self.affineTransformParameters.ty = ty;

  self.tySlider.value = [Converter fractionFromPartValue:ty
                                              rangeValue:self.affineTransformParameters.rangeTy];
}

#pragma mark - Slider input actions

- (IBAction) aValueChanged:(UISlider*)sender
{
  CGFloat a = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.affineTransformParameters.rangeA];

  self.affineTransformParameters.a = a;

  self.aTextField.text = [NSString stringWithFormat:@"%f", a];
}

- (IBAction) bValueChanged:(UISlider*)sender
{
  CGFloat b = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.affineTransformParameters.rangeB];

  self.affineTransformParameters.b = b;

  self.bTextField.text = [NSString stringWithFormat:@"%f", b];
}

- (IBAction) cValueChanged:(UISlider*)sender
{
  CGFloat c = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.affineTransformParameters.rangeC];

  self.affineTransformParameters.c = c;

  self.cTextField.text = [NSString stringWithFormat:@"%f", c];
}

- (IBAction) dValueChanged:(UISlider*)sender
{
  CGFloat d = [Converter partValueFromFractionValue:sender.value
                                         rangeValue:self.affineTransformParameters.rangeD];

  self.affineTransformParameters.d = d;

  self.dTextField.text = [NSString stringWithFormat:@"%f", d];
}

- (IBAction) txValueChanged:(UISlider*)sender
{
  CGFloat tx = [Converter partValueFromFractionValue:sender.value
                                          rangeValue:self.affineTransformParameters.rangeTx];

  self.affineTransformParameters.tx = tx;

  self.txTextField.text = [NSString stringWithFormat:@"%f", tx];
}

- (IBAction) tyValueChanged:(UISlider*)sender
{
  CGFloat ty = [Converter partValueFromFractionValue:sender.value
                                          rangeValue:self.affineTransformParameters.rangeTy];

  self.affineTransformParameters.ty = ty;

  self.tyTextField.text = [NSString stringWithFormat:@"%f", ty];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.aTextField.text = [NSString stringWithFormat:@"%f", self.affineTransformParameters.a];
  self.bTextField.text = [NSString stringWithFormat:@"%f", self.affineTransformParameters.b];
  self.cTextField.text = [NSString stringWithFormat:@"%f", self.affineTransformParameters.c];
  self.dTextField.text = [NSString stringWithFormat:@"%f", self.affineTransformParameters.d];
  self.txTextField.text = [NSString stringWithFormat:@"%f", self.affineTransformParameters.tx];
  self.tyTextField.text = [NSString stringWithFormat:@"%f", self.affineTransformParameters.ty];

  self.aSlider.value = [Converter fractionFromPartValue:self.affineTransformParameters.a
                                             rangeValue:self.affineTransformParameters.rangeA];
  self.bSlider.value = [Converter fractionFromPartValue:self.affineTransformParameters.b
                                             rangeValue:self.affineTransformParameters.rangeB];
  self.cSlider.value = [Converter fractionFromPartValue:self.affineTransformParameters.c
                                             rangeValue:self.affineTransformParameters.rangeC];
  self.dSlider.value = [Converter fractionFromPartValue:self.affineTransformParameters.d
                                             rangeValue:self.affineTransformParameters.rangeD];
  self.txSlider.value = [Converter fractionFromPartValue:self.affineTransformParameters.tx
                                              rangeValue:self.affineTransformParameters.rangeTx];
  self.tySlider.value = [Converter fractionFromPartValue:self.affineTransformParameters.ty
                                              rangeValue:self.affineTransformParameters.rangeTy];
}

@end
