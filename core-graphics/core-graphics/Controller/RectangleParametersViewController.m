//
//  RectangleParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "RectangleParametersViewController.h"
#import "../Model/RectangleParameters.h"
#import "../Converter.h"

@interface RectangleParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* originXTextField;
@property (weak, nonatomic) IBOutlet UITextField* originYTextField;
@property (weak, nonatomic) IBOutlet UITextField* widthTextField;
@property (weak, nonatomic) IBOutlet UITextField* heightTextField;
@property (weak, nonatomic) IBOutlet UISlider* originXSlider;
@property (weak, nonatomic) IBOutlet UISlider* originYSlider;
@property (weak, nonatomic) IBOutlet UISlider* widthSlider;
@property (weak, nonatomic) IBOutlet UISlider* heightSlider;
@end

@implementation RectangleParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithRectangleParameters:(RectangleParameters*)rectangleParameters
{
  self = [super initWithNibName:@"RectangleParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (rectangleParameters)
    self.rectangleParameters = rectangleParameters;
  else
    self.rectangleParameters = [[RectangleParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUiWithModelValues];
}

#pragma mark - Text field input actions

- (IBAction) originXEditingDidEnd:(UITextField*)sender
{
  CGFloat originX = [Converter floatFromStringValue:sender.text];

  self.rectangleParameters.originX = originX;

  self.originXSlider.value = [Converter fractionFromPartValue:originX
                                                   wholeValue:self.rectangleParameters.maximumOriginX];
}

- (IBAction) originYEditingDidEnd:(UITextField*)sender
{
  CGFloat originY = [Converter floatFromStringValue:sender.text];

  self.rectangleParameters.originY = originY;

  self.originYSlider.value = [Converter fractionFromPartValue:originY
                                                   wholeValue:self.rectangleParameters.maximumOriginY];
}

- (IBAction) widthEditingDidEnd:(UITextField*)sender
{
  CGFloat width = [Converter floatFromStringValue:sender.text];

  self.rectangleParameters.width = width;

  self.widthSlider.value = [Converter fractionFromPartValue:width
                                                 wholeValue:self.rectangleParameters.maximumWidth];
}

- (IBAction) heightEditingDidEnd:(UITextField*)sender
{
  CGFloat height = [Converter floatFromStringValue:sender.text];

  self.rectangleParameters.height = height;

  self.heightSlider.value = [Converter fractionFromPartValue:height
                                                  wholeValue:self.rectangleParameters.maximumHeight];
}

#pragma mark - Slider input actions

- (IBAction) originXValueChanged:(UISlider*)sender
{
  CGFloat originX = [Converter partValueFromFractionValue:sender.value
                                               wholeValue:self.rectangleParameters.maximumOriginX];

  self.rectangleParameters.originX = originX;

  self.originXTextField.text = [NSString stringWithFormat:@"%f", originX];
}

- (IBAction) originYValueChanged:(UISlider*)sender
{
  CGFloat originY = [Converter partValueFromFractionValue:sender.value
                                               wholeValue:self.rectangleParameters.maximumOriginY];

  self.rectangleParameters.originY = originY;

  self.originYTextField.text = [NSString stringWithFormat:@"%f", originY];
}

- (IBAction) widthValueChanged:(UISlider*)sender
{
  CGFloat width = [Converter partValueFromFractionValue:sender.value
                                             wholeValue:self.rectangleParameters.maximumWidth];

  self.rectangleParameters.width = width;

  self.widthTextField.text = [NSString stringWithFormat:@"%f", width];
}

- (IBAction) heightValueChanged:(UISlider*)sender
{
  CGFloat height = [Converter partValueFromFractionValue:sender.value
                                              wholeValue:self.rectangleParameters.maximumHeight];

  self.rectangleParameters.height = height;

  self.heightTextField.text = [NSString stringWithFormat:@"%f", height];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.originXTextField.text = [NSString stringWithFormat:@"%f", self.rectangleParameters.originX];
  self.originYTextField.text = [NSString stringWithFormat:@"%f", self.rectangleParameters.originY];
  self.widthTextField.text = [NSString stringWithFormat:@"%f", self.rectangleParameters.width];
  self.heightTextField.text = [NSString stringWithFormat:@"%f", self.rectangleParameters.height];

  self.originXSlider.value = [Converter fractionFromPartValue:self.rectangleParameters.originX
                                                   wholeValue:self.rectangleParameters.maximumOriginX];
  self.originYSlider.value = [Converter fractionFromPartValue:self.rectangleParameters.originY
                                                   wholeValue:self.rectangleParameters.maximumOriginY];
  self.widthSlider.value = [Converter fractionFromPartValue:self.rectangleParameters.width
                                                 wholeValue:self.rectangleParameters.maximumWidth];
  self.heightSlider.value = [Converter fractionFromPartValue:self.rectangleParameters.height
                                                  wholeValue:self.rectangleParameters.maximumHeight];
}

@end
