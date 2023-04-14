//
//  ViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import "ViewController.h"
#import "AutoLayoutUtility.h"
#import "DrawingView.h"
#import "ParametersHelper.h"
#import "Controller/Drawing/DrawingParametersViewController.h"
#import "Model/Drawing/DrawingParameters.h"

@interface ViewController()
@property (strong, nonatomic) DrawingParameters* drawingParameters;
@property (weak, nonatomic) IBOutlet UIView* drawingParametersContainerView;
@property (weak, nonatomic) IBOutlet DrawingView* drawingView;
@end

@implementation ViewController

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  self.drawingParameters = [[DrawingParameters alloc] init];
  [self.drawingParameters readUserDefaults];

  [self integrateChildViewControllers];

  self.drawingView.drawingParameters = self.drawingParameters;
  [self.drawingView startObserving];
}

#pragma mark - Manage child view controllers

- (void) integrateChildViewControllers
{
  [self integrateDrawingParametersChildViewController];
}

- (void) integrateDrawingParametersChildViewController
{
  DrawingParametersViewController* drawingParametersViewController = [[DrawingParametersViewController alloc] initWithDrawingParameters:self.drawingParameters];
  [self addChildViewController:drawingParametersViewController];
  [drawingParametersViewController didMoveToParentViewController:self];

  UIView* drawingParametersView = drawingParametersViewController.view;
  [self.drawingParametersContainerView addSubview:drawingParametersView];
  drawingParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.drawingParametersContainerView withSubview:drawingParametersView];
}

#pragma mark - Button interactions

- (IBAction) saveButtonTapped:(UIButton*)sender
{
  [ParametersHelper saveParameters:self.drawingParameters];
}

- (IBAction) loadButtonTapped:(UIButton*)sender
{
  [ParametersHelper loadParameters:self.drawingParameters];
  [self updateUiWithModelValues];
}

- (IBAction) resetButtonTapped:(UIButton*)sender
{
  [ParametersHelper resetParameters:self.drawingParameters];
  [self updateUiWithModelValues];
}

- (IBAction) alignGradientToPathButtonTapped:(UIButton*)sender
{
  if (self.childViewControllers.count == 0)
    return;

  DrawingParametersViewController* drawingParametersViewController = self.childViewControllers.firstObject;
  [drawingParametersViewController alignGradientToPathParameters];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
