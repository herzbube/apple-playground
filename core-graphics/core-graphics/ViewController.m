//
//  ViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import "ViewController.h"
#import "Model/DrawingParameters.h"
#import "DrawingView.h"
#import "Controller/AffineTransformParametersViewController.h"
#import "Controller/FillParametersViewController.h"
#import "Controller/GradientParametersViewController.h"
#import "Controller/PathParametersViewController.h"
#import "Controller/StrokeParametersViewController.h"
#import "AutoLayoutUtility.h"

@interface ViewController()
@property (strong, nonatomic) DrawingParameters* drawingParameters;
@property (weak, nonatomic) IBOutlet UIView* pathParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* strokeParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* fillParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* affineTransformParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* gradientParametersContainerView;
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
  [self.drawingView startObserving];
}

#pragma mark - Manage child view controllers

- (void) integrateChildViewControllers
{
  [self integratePathParametersChildViewController];
  [self integrateStrokeParametersChildViewController];
  [self integrateFillParametersChildViewController];
  [self integrateAffineTransformParametersChildViewController];
  [self integrateGradientParametersChildViewController];
}

- (void) integratePathParametersChildViewController
{
  PathParametersViewController* pathParametersViewController = [[PathParametersViewController alloc] initWithPathParameters:self.drawingParameters.pathParameters];
  [self addChildViewController:pathParametersViewController];
  [pathParametersViewController didMoveToParentViewController:self];

  UIView* pathParametersView = pathParametersViewController.view;
  [self.pathParametersContainerView addSubview:pathParametersView];
  pathParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.pathParametersContainerView withSubview:pathParametersView];

  self.drawingView.pathParameters = self.drawingParameters.pathParameters;
}

- (void) integrateStrokeParametersChildViewController
{
  StrokeParametersViewController* strokeParametersViewController = [[StrokeParametersViewController alloc] initWithStrokeParameters:self.drawingParameters.strokeParameters];
  [self addChildViewController:strokeParametersViewController];
  [strokeParametersViewController didMoveToParentViewController:self];

  UIView* strokeParametersView = strokeParametersViewController.view;
  [self.strokeParametersContainerView addSubview:strokeParametersView];
  strokeParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.strokeParametersContainerView withSubview:strokeParametersView];

  self.drawingView.strokeParameters = self.drawingParameters.strokeParameters;
}

- (void) integrateFillParametersChildViewController
{
  FillParametersViewController* fillParametersViewController = [[FillParametersViewController alloc] initWithFillParameters:self.drawingParameters.fillParameters];
  [self addChildViewController:fillParametersViewController];
  [fillParametersViewController didMoveToParentViewController:self];

  UIView* fillParametersView = fillParametersViewController.view;
  [self.fillParametersContainerView addSubview:fillParametersView];
  fillParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.fillParametersContainerView withSubview:fillParametersView];

  self.drawingView.fillParameters = self.drawingParameters.fillParameters;
}

- (void) integrateAffineTransformParametersChildViewController
{
  AffineTransformParametersViewController* affineTransformParametersViewController = [[AffineTransformParametersViewController alloc] initWithAffineTransformParameters:self.drawingParameters.affineTransformParameters];
  [self addChildViewController:affineTransformParametersViewController];
  [affineTransformParametersViewController didMoveToParentViewController:self];

  UIView* affineTransformParametersView = affineTransformParametersViewController.view;
  [self.affineTransformParametersContainerView addSubview:affineTransformParametersView];
  affineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.affineTransformParametersContainerView withSubview:affineTransformParametersView];

  self.drawingView.affineTransformParameters = self.drawingParameters.affineTransformParameters;
}

- (void) integrateGradientParametersChildViewController
{
  GradientParametersViewController* gradientParametersViewController = [[GradientParametersViewController alloc] initWithGradientParameters:self.drawingParameters.gradientParameters];
  [self addChildViewController:gradientParametersViewController];
  [gradientParametersViewController didMoveToParentViewController:self];

  UIView* gradientParametersView = gradientParametersViewController.view;
  [self.gradientParametersContainerView addSubview:gradientParametersView];
  gradientParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.gradientParametersContainerView withSubview:gradientParametersView];

  self.drawingView.gradientParameters = self.drawingParameters.gradientParameters;
}

#pragma mark - Button interactions

- (IBAction) saveButtonTapped:(UIButton*)sender
{
  [self.drawingParameters writeUserDefaults];
}

- (IBAction) loadButtonTapped:(UIButton*)sender
{
  [self.drawingParameters readUserDefaults];

  [self updateUiWithModelValues];
}

- (IBAction) resetButtonTapped:(UIButton*)sender
{
  [self.drawingParameters resetToDefaultValues];

  [self updateUiWithModelValues];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

@end
