//
//  ViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import "ViewController.h"
#import "DrawingView.h"
#import "Controller/AffineTransformParametersViewController.h"
#import "Controller/ArcParametersViewController.h"
#import "Controller/FillParametersViewController.h"
#import "Controller/StrokeParametersViewController.h"
#import "AutoLayoutUtility.h"

@interface ViewController()
@property (weak, nonatomic) IBOutlet UIView* arcParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* strokeParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* fillParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* affineTransformParametersContainerView;
@property (weak, nonatomic) IBOutlet DrawingView* drawingView;
@end

@implementation ViewController

- (void) viewDidLoad
{
  [super viewDidLoad];
  [self integrateChildViewControllers];
  [self.drawingView startObserving];
}

- (void) integrateChildViewControllers
{
  [self integrateArcParametersChildViewController];
  [self integrateStrokeParametersChildViewController];
  [self integrateFillParametersChildViewController];
  [self integrateAffineTransformParametersChildViewController];
}

- (void) integrateArcParametersChildViewController
{
  ArcParametersViewController* arcParametersViewController = [[ArcParametersViewController alloc] init];
  [self addChildViewController:arcParametersViewController];
  [arcParametersViewController didMoveToParentViewController:self];

  UIView* arcParametersView = arcParametersViewController.view;
  [self.arcParametersContainerView addSubview:arcParametersView];
  arcParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.arcParametersContainerView withSubview:arcParametersView];

  self.drawingView.arcParameters = arcParametersViewController.arcParameters;
}

- (void) integrateStrokeParametersChildViewController
{
  StrokeParametersViewController* strokeParametersViewController = [[StrokeParametersViewController alloc] init];
  [self addChildViewController:strokeParametersViewController];
  [strokeParametersViewController didMoveToParentViewController:self];

  UIView* strokeParametersView = strokeParametersViewController.view;
  [self.strokeParametersContainerView addSubview:strokeParametersView];
  strokeParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.strokeParametersContainerView withSubview:strokeParametersView];

  self.drawingView.strokeParameters = strokeParametersViewController.strokeParameters;
}

- (void) integrateFillParametersChildViewController
{
  FillParametersViewController* fillParametersViewController = [[FillParametersViewController alloc] init];
  [self addChildViewController:fillParametersViewController];
  [fillParametersViewController didMoveToParentViewController:self];

  UIView* fillParametersView = fillParametersViewController.view;
  [self.fillParametersContainerView addSubview:fillParametersView];
  fillParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.fillParametersContainerView withSubview:fillParametersView];

  self.drawingView.fillParameters = fillParametersViewController.fillParameters;
}

- (void) integrateAffineTransformParametersChildViewController
{
  AffineTransformParametersViewController* affineTransformParametersViewController = [[AffineTransformParametersViewController alloc] init];
  [self addChildViewController:affineTransformParametersViewController];
  [affineTransformParametersViewController didMoveToParentViewController:self];

  UIView* affineTransformParametersView = affineTransformParametersViewController.view;
  [self.affineTransformParametersContainerView addSubview:affineTransformParametersView];
  affineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.affineTransformParametersContainerView withSubview:affineTransformParametersView];

  self.drawingView.affineTransformParameters = affineTransformParametersViewController.affineTransformParameters;
}

@end
