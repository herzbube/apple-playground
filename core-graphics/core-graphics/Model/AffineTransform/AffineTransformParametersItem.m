//
//  AffineTransformParametersItem.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "AffineTransformParametersItem.h"
#import "MatrixAffineTransformParameters.h"
#import "RotateAffineTransformParameters.h"
#import "ScaleAffineTransformParameters.h"
#import "ShearAffineTransformParameters.h"
#import "TranslateAffineTransformParameters.h"

static NSString* affineTransformTypeKey = @"affineTransformType";
static NSString* matrixAffineTransformParametersKey = @"matrixAffineTransformParameters";
static NSString* rotateAffineTransformParametersKey = @"rotateAffineTransformParameters";
static NSString* scaleAffineTransformParametersKey = @"scaleAffineTransformParameters";
static NSString* shearAffineTransformParametersKey = @"shearAffineTransformParameters";
static NSString* translateAffineTransformParametersKey = @"translateAffineTransformParameters";

@implementation AffineTransformParametersItem

- (instancetype) init
{
  self = [super init];

  self.matrixAffineTransformParameters = [[MatrixAffineTransformParameters alloc] init];
  self.rotateAffineTransformParameters = [[RotateAffineTransformParameters alloc] init];
  self.scaleAffineTransformParameters = [[ScaleAffineTransformParameters alloc] init];
  self.shearAffineTransformParameters = [[ShearAffineTransformParameters alloc] init];
  self.translateAffineTransformParameters = [[TranslateAffineTransformParameters alloc] init];

  [self initializeWithDefaultValues];

  [self startObserving];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.affineTransformType = AffineTransformTypeTranslate;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    affineTransformTypeKey : @(self.affineTransformType),
    matrixAffineTransformParametersKey : [self.matrixAffineTransformParameters valuesAsDictionary],
    rotateAffineTransformParametersKey : [self.rotateAffineTransformParameters valuesAsDictionary],
    scaleAffineTransformParametersKey : [self.scaleAffineTransformParameters valuesAsDictionary],
    shearAffineTransformParametersKey : [self.shearAffineTransformParameters valuesAsDictionary],
    translateAffineTransformParametersKey : [self.translateAffineTransformParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  [self stopObserving];

  self.affineTransformType = [dictionary[affineTransformTypeKey] intValue];
  [self.matrixAffineTransformParameters setValuesWithDictionary:dictionary[matrixAffineTransformParametersKey]];
  [self.rotateAffineTransformParameters setValuesWithDictionary:dictionary[rotateAffineTransformParametersKey]];
  [self.scaleAffineTransformParameters setValuesWithDictionary:dictionary[scaleAffineTransformParametersKey]];
  [self.shearAffineTransformParameters setValuesWithDictionary:dictionary[shearAffineTransformParametersKey]];
  [self.translateAffineTransformParameters setValuesWithDictionary:dictionary[translateAffineTransformParametersKey]];

  [self startObserving];
}

- (void) resetToDefaultValues
{
  [self stopObserving];

  [self.matrixAffineTransformParameters resetToDefaultValues];
  [self.rotateAffineTransformParameters resetToDefaultValues];
  [self.scaleAffineTransformParameters resetToDefaultValues];
  [self.shearAffineTransformParameters resetToDefaultValues];
  [self.translateAffineTransformParameters resetToDefaultValues];

  [self initializeWithDefaultValues];

  [self startObserving];
}

#pragma mark - KVO

- (void) startObserving
{
  [self addObserver:self forKeyPath:@"affineTransformType" options:0 context:NULL];
  [self.matrixAffineTransformParameters addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];
  [self.rotateAffineTransformParameters addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];
  [self.scaleAffineTransformParameters addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];
  [self.shearAffineTransformParameters addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];
  [self.translateAffineTransformParameters addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];

  [self updateAffineTransformTypeAsString];
  [self updateAffineTransform];
  [self updateParametersAsString];
}

- (void) stopObserving
{
  [self removeObserver:self forKeyPath:@"affineTransformType"];
  [self.matrixAffineTransformParameters removeObserver:self forKeyPath:@"affineTransform"];
  [self.rotateAffineTransformParameters removeObserver:self forKeyPath:@"affineTransform"];
  [self.scaleAffineTransformParameters removeObserver:self forKeyPath:@"affineTransform"];
  [self.shearAffineTransformParameters removeObserver:self forKeyPath:@"affineTransform"];
  [self.translateAffineTransformParameters removeObserver:self forKeyPath:@"affineTransform"];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  if ([keyPath isEqualToString:@"affineTransformType"])
    [self updateAffineTransformTypeAsString];

  [self updateAffineTransform];
  [self updateParametersAsString];
}

- (void) updateAffineTransform
{
  switch (self.affineTransformType)
  {
    case AffineTransformTypeMatrix:
      self.affineTransform = self.matrixAffineTransformParameters.affineTransform;
      break;
    case AffineTransformTypeRotate:
      self.affineTransform = self.rotateAffineTransformParameters.affineTransform;
      break;
    case AffineTransformTypeScale:
      self.affineTransform = self.scaleAffineTransformParameters.affineTransform;
      break;
    case AffineTransformTypeShear:
      self.affineTransform = self.shearAffineTransformParameters.affineTransform;
      break;
    case AffineTransformTypeTranslate:
      self.affineTransform = self.translateAffineTransformParameters.affineTransform;
      break;
    default:
      self.affineTransform = CGAffineTransformIdentity;
      break;
  }
}

- (void) updateAffineTransformTypeAsString
{
  switch (self.affineTransformType)
  {
    case AffineTransformTypeMatrix:
      self.affineTransformTypeAsString = [self.matrixAffineTransformParameters affineTransformTypeAsString];
      break;
    case AffineTransformTypeRotate:
      self.affineTransformTypeAsString = [self.rotateAffineTransformParameters affineTransformTypeAsString];
      break;
    case AffineTransformTypeScale:
      self.affineTransformTypeAsString = [self.scaleAffineTransformParameters affineTransformTypeAsString];
      break;
    case AffineTransformTypeShear:
      self.affineTransformTypeAsString = [self.shearAffineTransformParameters affineTransformTypeAsString];
      break;
    case AffineTransformTypeTranslate:
      self.affineTransformTypeAsString = [self.translateAffineTransformParameters affineTransformTypeAsString];
      break;
    default:
      self.affineTransformTypeAsString = @"Unknown transform type";
      break;
  }
}

- (void) updateParametersAsString
{
  switch (self.affineTransformType)
  {
    case AffineTransformTypeMatrix:
      self.parametersAsString = [self.matrixAffineTransformParameters parametersAsString];
      break;
    case AffineTransformTypeRotate:
      self.parametersAsString = [self.rotateAffineTransformParameters parametersAsString];
      break;
    case AffineTransformTypeScale:
      self.parametersAsString = [self.scaleAffineTransformParameters parametersAsString];
      break;
    case AffineTransformTypeShear:
      self.parametersAsString = [self.shearAffineTransformParameters parametersAsString];
      break;
    case AffineTransformTypeTranslate:
      self.parametersAsString = [self.translateAffineTransformParameters parametersAsString];
      break;
    default:
      self.parametersAsString = @"Unknown transform type";
      break;
  }
}

@end
