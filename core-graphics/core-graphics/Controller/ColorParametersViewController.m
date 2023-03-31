//
//  ColorParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
//

#import "ColorParametersViewController.h"
#import "../Model/ColorParameters.h"
#import "../Converter.h"

@interface ColorParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* redTextField;
@property (weak, nonatomic) IBOutlet UITextField* greenTextField;
@property (weak, nonatomic) IBOutlet UITextField* blueTextField;
@property (weak, nonatomic) IBOutlet UITextField* alphaTextField;
@property (weak, nonatomic) IBOutlet UITextField* hexTextField;
@property (weak, nonatomic) IBOutlet UISlider* redSlider;
@property (weak, nonatomic) IBOutlet UISlider* greenSlider;
@property (weak, nonatomic) IBOutlet UISlider* blueSlider;
@property (weak, nonatomic) IBOutlet UISlider* alphaSlider;
@end

@implementation ColorParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithColorParameters:(ColorParameters*)colorParameters
{
  self = [super initWithNibName:@"ColorParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (colorParameters)
    self.colorParameters = colorParameters;
  else
    self.colorParameters = [[ColorParameters alloc] init];

  return self;
}

#pragma mark - Public API

- (void) updateWithHexString:(NSString*)hexString
{
  [self updateModelWithHexString:hexString];
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) redEditingDidEnd:(UITextField*)sender
{
  CGFloat red = [Converter colorFractionFromColorComponentStringValue:sender.text];

  self.colorParameters.red = red;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.redSlider.value = red;
  self.hexTextField.text = hexString;
}

- (IBAction) greenEditingDidEnd:(UITextField*)sender
{
  CGFloat green = [Converter colorFractionFromColorComponentStringValue:sender.text];

  self.colorParameters.green = green;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.greenSlider.value = green;
  self.hexTextField.text = hexString;
}

- (IBAction) blueEditingDidEnd:(UITextField*)sender
{
  CGFloat blue = [Converter colorFractionFromColorComponentStringValue:sender.text];

  self.colorParameters.blue = blue;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.blueSlider.value = blue;
  self.hexTextField.text = hexString;
}

- (IBAction) alphaEditingDidEnd:(UITextField*)sender
{
  CGFloat alpha = [Converter colorFractionFromColorComponentStringValue:sender.text];

  self.colorParameters.alpha = alpha;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.alphaSlider.value = alpha;
  self.hexTextField.text = hexString;
}

- (IBAction) hexEditingDidEnd:(UITextField*)sender
{
  [self updateModelWithHexString:sender.text];

  // This updates the other UI controls, but it also updates the sender.
  //
  //                             Update sender                             Update other UI controls
  // -------------------------------------------------------------------------------------------------------------
  // User enters valid value     Not necessary, but does not hurt either   Necessary
  // User enters invalid value   Necessary (reset sender to model value)   Not necessary, but does not hurt either
  [self updateUiWithModelValues];
}

#pragma mark - Slider input actions

- (IBAction) redValueChanged:(UISlider*)sender
{
  CGFloat red = sender.value;

  self.colorParameters.red = red;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.redTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:red]];
  self.hexTextField.text = hexString;
}

- (IBAction) greenValueChanged:(UISlider*)sender
{
  CGFloat green = sender.value;

  self.colorParameters.green = green;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.greenTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:green]];
  self.hexTextField.text = hexString;
}

- (IBAction) blueValueChanged:(UISlider*)sender
{
  CGFloat blue = sender.value;

  self.colorParameters.blue = blue;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.blueTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:blue]];
  self.hexTextField.text = hexString;
}

- (IBAction) alphaValueChanged:(UISlider*)sender
{
  CGFloat alpha = sender.value;

  self.colorParameters.alpha = alpha;
  NSString* hexString = [self hexStringFromModelValues];
  self.colorParameters.hexString = hexString;

  self.alphaTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:alpha]];
  self.hexTextField.text = hexString;
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.redTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:self.colorParameters.red]];
  self.greenTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:self.colorParameters.green]];
  self.blueTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:self.colorParameters.blue]];
  self.alphaTextField.text = [NSString stringWithFormat:@"%f", [Converter colorComponentValueFromFractionValue:self.colorParameters.alpha]];
  self.hexTextField.text = self.colorParameters.hexString;

  self.redSlider.value = self.colorParameters.red;
  self.greenSlider.value = self.colorParameters.green;
  self.blueSlider.value = self.colorParameters.blue;
  self.alphaSlider.value = self.colorParameters.alpha;
}

- (void) updateModelWithHexString:(NSString*)hexString
{
  [self.colorParameters updateWithHexString:hexString];
}

#pragma mark - Conversion methods

- (NSString*) hexStringFromModelValues
{
  return [self.colorParameters hexStringFromColorComponentValues];
}

@end
