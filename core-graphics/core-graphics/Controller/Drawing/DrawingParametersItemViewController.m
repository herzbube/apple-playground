//
//  DrawingParametersItemViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "DrawingParametersItemViewController.h"
#import "../AffineTransform/AffineTransformParametersViewController.h"
#import "../Fill/FillParametersViewController.h"
#import "../Gradient/GradientParametersViewController.h"
#import "../Path/PathParametersViewController.h"
#import "../StrokeParametersViewController.h"
#import "../../Model/Drawing/DrawingParametersItem.h"
#import "../../AutoLayoutUtility.h"

@interface DrawingParametersItemViewController()
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIScrollView* drawingParametersItemScrollView;
@property (weak, nonatomic) IBOutlet UIView* pathParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* strokeParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* fillParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* affineTransformParametersContainerView;
@property (weak, nonatomic) IBOutlet UIView* gradientParametersContainerView;
@property (strong, nonatomic) NSMutableArray* autoLayoutConstraints;
@end

@implementation DrawingParametersItemViewController

#pragma mark - Initialization, deallocation

- (instancetype) init
{
  self = [super initWithNibName:@"DrawingParametersItemViewController" bundle:nil];
  if (! self)
    return nil;

  self.drawingParametersItem = nil;
  self.autoLayoutConstraints = [NSMutableArray array];

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
  if (! self.drawingParametersItem)
    return;

  [self integratePathParametersChildViewController];
  [self integrateStrokeParametersChildViewController];
  [self integrateFillParametersChildViewController];
  [self integrateAffineTransformParametersChildViewController];
  [self integrateGradientParametersChildViewController];
}

- (void) integratePathParametersChildViewController
{
  PathParametersViewController* pathParametersViewController = [[PathParametersViewController alloc] initWithPathParameters:self.drawingParametersItem.pathParameters];
  [self addChildViewController:pathParametersViewController];
  [pathParametersViewController didMoveToParentViewController:self];

  UIView* pathParametersView = pathParametersViewController.view;
  [self.pathParametersContainerView addSubview:pathParametersView];
  pathParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  NSArray* autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.pathParametersContainerView withSubview:pathParametersView];
  [self.autoLayoutConstraints addObjectsFromArray:autoLayoutConstraints];
}

- (void) integrateStrokeParametersChildViewController
{
  StrokeParametersViewController* strokeParametersViewController = [[StrokeParametersViewController alloc] initWithStrokeParameters:self.drawingParametersItem.strokeParameters];
  [self addChildViewController:strokeParametersViewController];
  [strokeParametersViewController didMoveToParentViewController:self];

  UIView* strokeParametersView = strokeParametersViewController.view;
  [self.strokeParametersContainerView addSubview:strokeParametersView];
  strokeParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  NSArray* autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.strokeParametersContainerView withSubview:strokeParametersView];
  [self.autoLayoutConstraints addObjectsFromArray:autoLayoutConstraints];
}

- (void) integrateFillParametersChildViewController
{
  FillParametersViewController* fillParametersViewController = [[FillParametersViewController alloc] initWithFillParameters:self.drawingParametersItem.fillParameters];
  [self addChildViewController:fillParametersViewController];
  [fillParametersViewController didMoveToParentViewController:self];

  UIView* fillParametersView = fillParametersViewController.view;
  [self.fillParametersContainerView addSubview:fillParametersView];
  fillParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  NSArray* autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.fillParametersContainerView withSubview:fillParametersView];
  [self.autoLayoutConstraints addObjectsFromArray:autoLayoutConstraints];
}

- (void) integrateAffineTransformParametersChildViewController
{
  AffineTransformParametersViewController* affineTransformParametersViewController = [[AffineTransformParametersViewController alloc] initWithAffineTransformParameters:self.drawingParametersItem.affineTransformParameters];
  [self addChildViewController:affineTransformParametersViewController];
  [affineTransformParametersViewController didMoveToParentViewController:self];

  UIView* affineTransformParametersView = affineTransformParametersViewController.view;
  [self.affineTransformParametersContainerView addSubview:affineTransformParametersView];
  affineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  NSArray* autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.affineTransformParametersContainerView withSubview:affineTransformParametersView];
  [self.autoLayoutConstraints addObjectsFromArray:autoLayoutConstraints];
}

- (void) integrateGradientParametersChildViewController
{
  GradientParametersViewController* gradientParametersViewController = [[GradientParametersViewController alloc] initWithGradientParameters:self.drawingParametersItem.gradientParameters];
  [self addChildViewController:gradientParametersViewController];
  [gradientParametersViewController didMoveToParentViewController:self];

  UIView* gradientParametersView = gradientParametersViewController.view;
  [self.gradientParametersContainerView addSubview:gradientParametersView];
  gradientParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  NSArray* autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.gradientParametersContainerView withSubview:gradientParametersView];
  [self.autoLayoutConstraints addObjectsFromArray:autoLayoutConstraints];
}

- (void) removeChildViewControllers
{
  if (self.childViewControllers.count == 0)
    return;

  for (NSLayoutConstraint* autoLayoutConstraint in self.autoLayoutConstraints)
    autoLayoutConstraint.active = NO;
  [self.autoLayoutConstraints removeAllObjects];

  for (UIViewController* childViewController in self.childViewControllers)
  {
    [childViewController.view removeFromSuperview];

    [childViewController willMoveToParentViewController:nil];
    // Automatically calls didMoveToParentViewController:
    [childViewController removeFromParentViewController];
  }
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  [self updateUiVisibility];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateDrawingParametersItem:(DrawingParametersItem*)drawingParametersItem
{
  self.drawingParametersItem = drawingParametersItem;

  [self removeChildViewControllers];
  [self integrateChildViewControllers];

  [self updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.drawingParametersItem)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.drawingParametersItemScrollView])
      [self.topLevelStackView insertArrangedSubview:self.drawingParametersItemScrollView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.drawingParametersItemScrollView])
    {
      [self.topLevelStackView removeArrangedSubview:self.drawingParametersItemScrollView];
      [self.drawingParametersItemScrollView removeFromSuperview];
    }
  }
}

@end
