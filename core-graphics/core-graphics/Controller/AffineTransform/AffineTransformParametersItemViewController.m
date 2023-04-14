//
//  AffineTransformParametersItemViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "AffineTransformParametersItemViewController.h"
#import "MatrixAffineTransformParametersViewController.h"
#import "RotateAffineTransformParametersViewController.h"
#import "ScaleAffineTransformParametersViewController.h"
#import "ShearAffineTransformParametersViewController.h"
#import "TranslateAffineTransformParametersViewController.h"
#import "../../Model/AffineTransform/AffineTransformParametersItem.h"
#import "../../AutoLayoutUtility.h"

@interface AffineTransformParametersItemViewController()
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIScrollView* affineTransformParametersItemScrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* affineTransformTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView* containerView;
@property (strong, nonatomic) NSArray* autoLayoutConstraints;
@end

@implementation AffineTransformParametersItemViewController

#pragma mark - Initialization, deallocation

- (instancetype) init
{
  self = [super initWithNibName:@"AffineTransformParametersItemViewController" bundle:nil];
  if (! self)
    return nil;

  self.affineTransformParametersItem = nil;
  self.autoLayoutConstraints = nil;

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
  if (! self.affineTransformParametersItem)
    return;

  switch (self.affineTransformParametersItem.affineTransformType)
  {
    case AffineTransformTypeMatrix:
      [self integrateMatrixAffineTransformParametersChildViewController];
      break;
    case AffineTransformTypeRotate:
      [self integrateRotateAffineTransformParametersChildViewController];
      break;
    case AffineTransformTypeScale:
      [self integrateScaleAffineTransformParametersChildViewController];
      break;
    case AffineTransformTypeShear:
      [self integrateShearAffineTransformParametersChildViewController];
      break;
    case AffineTransformTypeTranslate:
      [self integrateTranslateAffineTransformParametersChildViewController];
      break;
    default:
      break;
  }
}

- (void) integrateMatrixAffineTransformParametersChildViewController
{
  MatrixAffineTransformParametersViewController* matrixAffineTransformParametersViewController = [[MatrixAffineTransformParametersViewController alloc] initWithMatrixAffineTransformParameters:self.affineTransformParametersItem.matrixAffineTransformParameters];

  [self addChildViewController:matrixAffineTransformParametersViewController];
  [matrixAffineTransformParametersViewController didMoveToParentViewController:self];

  UIView* matrixAffineTransformParametersView = matrixAffineTransformParametersViewController.view;
  [self.containerView addSubview:matrixAffineTransformParametersView];
  matrixAffineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:matrixAffineTransformParametersView];
}

- (void) integrateRotateAffineTransformParametersChildViewController
{
  RotateAffineTransformParametersViewController* rotateAffineTransformParametersViewController = [[RotateAffineTransformParametersViewController alloc] initWithRotateAffineTransformParameters:self.affineTransformParametersItem.rotateAffineTransformParameters];

  [self addChildViewController:rotateAffineTransformParametersViewController];
  [rotateAffineTransformParametersViewController didMoveToParentViewController:self];

  UIView* rotateAffineTransformParametersView = rotateAffineTransformParametersViewController.view;
  [self.containerView addSubview:rotateAffineTransformParametersView];
  rotateAffineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:rotateAffineTransformParametersView];
}

- (void) integrateScaleAffineTransformParametersChildViewController
{
  ScaleAffineTransformParametersViewController* scaleAffineTransformParametersViewController = [[ScaleAffineTransformParametersViewController alloc] initWithScaleAffineTransformParameters:self.affineTransformParametersItem.scaleAffineTransformParameters];

  [self addChildViewController:scaleAffineTransformParametersViewController];
  [scaleAffineTransformParametersViewController didMoveToParentViewController:self];

  UIView* scaleAffineTransformParametersView = scaleAffineTransformParametersViewController.view;
  [self.containerView addSubview:scaleAffineTransformParametersView];
  scaleAffineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:scaleAffineTransformParametersView];
}

- (void) integrateShearAffineTransformParametersChildViewController
{
  ShearAffineTransformParametersViewController* shearAffineTransformParametersViewController = [[ShearAffineTransformParametersViewController alloc] initWithShearAffineTransformParameters:self.affineTransformParametersItem.shearAffineTransformParameters];

  [self addChildViewController:shearAffineTransformParametersViewController];
  [shearAffineTransformParametersViewController didMoveToParentViewController:self];

  UIView* shearAffineTransformParametersView = shearAffineTransformParametersViewController.view;
  [self.containerView addSubview:shearAffineTransformParametersView];
  shearAffineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:shearAffineTransformParametersView];
}

- (void) integrateTranslateAffineTransformParametersChildViewController
{
  TranslateAffineTransformParametersViewController* translateAffineTransformParametersViewController = [[TranslateAffineTransformParametersViewController alloc] initWithTranslateAffineTransformParameters:self.affineTransformParametersItem.translateAffineTransformParameters];

  [self addChildViewController:translateAffineTransformParametersViewController];
  [translateAffineTransformParametersViewController didMoveToParentViewController:self];

  UIView* translateAffineTransformParametersView = translateAffineTransformParametersViewController.view;
  [self.containerView addSubview:translateAffineTransformParametersView];
  translateAffineTransformParametersView.translatesAutoresizingMaskIntoConstraints = NO;
  self.autoLayoutConstraints = [AutoLayoutUtility fillSuperview:self.containerView withSubview:translateAffineTransformParametersView];
}

- (void) removeChildViewController
{
  if (self.childViewControllers.count == 0)
    return;

  UIViewController* childViewController = self.childViewControllers.firstObject;

  [childViewController.view removeFromSuperview];
  for (NSLayoutConstraint* autoLayoutConstraint in self.autoLayoutConstraints)
    autoLayoutConstraint.active = NO;
  self.autoLayoutConstraints = nil;

  [childViewController willMoveToParentViewController:nil];
  // Automatically calls didMoveToParentViewController:
  [childViewController removeFromParentViewController];
}

#pragma mark - Segmented control input actions

- (IBAction) affineTransformTypeValueChanged:(UISegmentedControl*)sender
{
  AffineTransformType affineTransformType = [self affineTransformTypeForSegmentIndex:sender.selectedSegmentIndex];

  self.affineTransformParametersItem.affineTransformType = affineTransformType;
  [self.affineTransformParametersItem valuesDidChange];

  [self removeChildViewController];
  [self integrateChildViewControllers];
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  if (self.affineTransformParametersItem)
    self.affineTransformTypeSegmentedControl.selectedSegmentIndex = [self segmentIndexForAffineTransformType:self.affineTransformParametersItem.affineTransformType];

  [self updateUiVisibility];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

- (void) updateAffineTransformParametersItem:(AffineTransformParametersItem*)affineTransformParametersItem
{
  self.affineTransformParametersItem = affineTransformParametersItem;

  [self removeChildViewController];
  [self integrateChildViewControllers];

  [self updateUiWithModelValues];
}

- (void) updateUiVisibility
{
  if (self.affineTransformParametersItem)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.affineTransformParametersItemScrollView])
      [self.topLevelStackView insertArrangedSubview:self.affineTransformParametersItemScrollView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.affineTransformParametersItemScrollView])
    {
      [self.topLevelStackView removeArrangedSubview:self.affineTransformParametersItemScrollView];
      [self.affineTransformParametersItemScrollView removeFromSuperview];
    }
  }
}

#pragma mark - Helpers

- (NSUInteger) segmentIndexForAffineTransformType:(AffineTransformType)affineTransformType
{
  switch (affineTransformType)
  {
    case AffineTransformTypeScale:
      return 0;
    case AffineTransformTypeShear:
      return 1;
    case AffineTransformTypeRotate:
      return 2;
    case AffineTransformTypeTranslate:
      return 3;
    case AffineTransformTypeMatrix:
      return 4;
    default:
      return -1;
  }
}

- (AffineTransformType) affineTransformTypeForSegmentIndex:(NSUInteger)segmentIndex
{
  switch (segmentIndex)
  {
    case 0:
      return AffineTransformTypeScale;
    case 1:
      return AffineTransformTypeShear;
    case 2:
      return AffineTransformTypeRotate;
    case 3:
      return AffineTransformTypeTranslate;
    case 4:
      return AffineTransformTypeMatrix;
    default:
      return -1;
  }
}

@end
