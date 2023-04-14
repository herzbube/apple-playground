//
//  GradientStopParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "GradientStopParametersViewController.h"
#import "../ColorParametersViewController.h"
#import "../../Model/Gradient/GradientStopParameters.h"
#import "../../AutoLayoutUtility.h"
#import "../../Converter.h"

@interface GradientStopParametersViewController()
@property (weak, nonatomic) IBOutlet UITextField* position1TextField;
@property (weak, nonatomic) IBOutlet UITextField* position2TextField;
@property (weak, nonatomic) IBOutlet UISlider* position1Slider;
@property (weak, nonatomic) IBOutlet UISlider* position2Slider;
@property (weak, nonatomic) IBOutlet UIView* colorParameters1ContainerView;
@property (weak, nonatomic) IBOutlet UIView* colorParameters2ContainerView;
@end

@implementation GradientStopParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithGradientStopParameters:(GradientStopParameters*)gradientStopParameters
{
  self = [super initWithNibName:@"GradientStopParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (gradientStopParameters)
    self.gradientStopParameters = gradientStopParameters;
  else
    self.gradientStopParameters = [[GradientStopParameters alloc] init];

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
  [self integrateColorParameters1ChildViewController];
  [self integrateColorParameters2ChildViewController];
}

- (void) integrateColorParameters1ChildViewController
{
  ColorParametersViewController* colorParameters1ViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.gradientStopParameters.colorParameters1];

  [self addChildViewController:colorParameters1ViewController];
  [colorParameters1ViewController didMoveToParentViewController:self];

  UIView* colorParameters1View = colorParameters1ViewController.view;
  [self.colorParameters1ContainerView addSubview:colorParameters1View];
  colorParameters1View.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorParameters1ContainerView withSubview:colorParameters1View];
}

- (void) integrateColorParameters2ChildViewController
{
  ColorParametersViewController* colorParameters2ViewController = [[ColorParametersViewController alloc] initWithColorParameters:self.gradientStopParameters.colorParameters2];

  [self addChildViewController:colorParameters2ViewController];
  [colorParameters2ViewController didMoveToParentViewController:self];

  UIView* colorParameters2View = colorParameters2ViewController.view;
  [self.colorParameters2ContainerView addSubview:colorParameters2View];
  colorParameters2View.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.colorParameters2ContainerView withSubview:colorParameters2View];
}

#pragma mark - Text field input actions

- (IBAction) position1EditingDidEnd:(UITextField*)sender
{
  CGFloat position1 = [Converter floatFromStringValue:sender.text];

  self.gradientStopParameters.position1 = position1;
  [self.gradientStopParameters valuesDidChange];

  self.position1Slider.value = position1;
}

- (IBAction) position2EditingDidEnd:(UITextField*)sender
{
  CGFloat position2 = [Converter floatFromStringValue:sender.text];

  self.gradientStopParameters.position2 = position2;
  [self.gradientStopParameters valuesDidChange];

  self.position2Slider.value = position2;
}

#pragma mark - Slider input actions

- (IBAction) position1ValueChanged:(UISlider*)sender
{
  CGFloat position1 = sender.value;

  self.gradientStopParameters.position1 = position1;
  [self.gradientStopParameters valuesDidChange];

  self.position1TextField.text = [NSString stringWithFormat:@"%f", position1];
}

- (IBAction) position2ValueChanged:(UISlider*)sender
{
  CGFloat position2 = sender.value;

  self.gradientStopParameters.position2 = position2;
  [self.gradientStopParameters valuesDidChange];

  self.position2TextField.text = [NSString stringWithFormat:@"%f", position2];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  self.position1TextField.text = [NSString stringWithFormat:@"%f", self.gradientStopParameters.position1];
  self.position1Slider.value = self.gradientStopParameters.position1;
  self.position2TextField.text = [NSString stringWithFormat:@"%f", self.gradientStopParameters.position2];
  self.position2Slider.value = self.gradientStopParameters.position2;

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
