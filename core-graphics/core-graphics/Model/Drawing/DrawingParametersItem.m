//
//  DrawingParametersItem.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 13.04.23.
//

#import "DrawingParametersItem.h"
#import "../StrokeParameters.h"
#import "../AffineTransform/AffineTransformParameters.h"
#import "../Fill/FillParameters.h"
#import "../Gradient/GradientParameters.h"
#import "../Path/ArcParameters.h"
#import "../Path/PathParameters.h"
#import "../Path/RectangleParameters.h"

static NSString* drawingParametersKey = @"drawingParameters";
static NSString* pathParametersKey = @"pathParameters";
static NSString* strokeParametersKey = @"strokeParameters";
static NSString* fillParametersKey = @"fillParameters";
static NSString* affineTransformParametersKey = @"affineTransformParameters";
static NSString* gradientParametersKey = @"gradientParameters";

@implementation DrawingParametersItem

- (instancetype) init
{
  self = [super init];

  self.pathParameters = [[PathParameters alloc] init];
  self.strokeParameters = [[StrokeParameters alloc] init];
  self.fillParameters = [[FillParameters alloc] init];
  self.affineTransformParameters = [[AffineTransformParameters alloc] init];
  self.gradientParameters = [[GradientParameters alloc] init];

  [self initializeWithDefaultValues];

  [self startObserving];

  return self;
}

- (void) initializeWithDefaultValues
{
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    pathParametersKey : [self.pathParameters valuesAsDictionary],
    strokeParametersKey : [self.strokeParameters valuesAsDictionary],
    fillParametersKey : [self.fillParameters valuesAsDictionary],
    affineTransformParametersKey : [self.affineTransformParameters valuesAsDictionary],
    gradientParametersKey : [self.gradientParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  [self stopObserving];

  [self.pathParameters setValuesWithDictionary:dictionary[pathParametersKey]];
  [self.strokeParameters setValuesWithDictionary:dictionary[strokeParametersKey]];
  [self.fillParameters setValuesWithDictionary:dictionary[fillParametersKey]];
  [self.affineTransformParameters setValuesWithDictionary:dictionary[affineTransformParametersKey]];
  [self.gradientParameters setValuesWithDictionary:dictionary[gradientParametersKey]];

  [self startObserving];
}

- (void) resetToDefaultValues
{
  [self stopObserving];

  [self.pathParameters resetToDefaultValues];
  [self.strokeParameters resetToDefaultValues];
  [self.fillParameters resetToDefaultValues];
  [self.affineTransformParameters resetToDefaultValues];
  [self.gradientParameters resetToDefaultValues];

  [self initializeWithDefaultValues];

  [self startObserving];
}

#pragma mark - KVO

- (void) startObserving
{
  [self.pathParameters addObserver:self forKeyPath:@"pathType" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"parametersAsString" options:0 context:NULL];
  [self.pathParameters.rectangleParameters addObserver:self forKeyPath:@"parametersAsString" options:0 context:NULL];

  [self updateItemAsString];
  [self updateItemDetailsAsString];
}

- (void) stopObserving
{
  [self.pathParameters removeObserver:self forKeyPath:@"pathType"];
  [self.pathParameters.arcParameters removeObserver:self forKeyPath:@"parametersAsString"];
  [self.pathParameters.rectangleParameters removeObserver:self forKeyPath:@"parametersAsString"];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  if ([keyPath isEqualToString:@"pathType"])
    [self updateItemAsString];

  [self updateItemDetailsAsString];
}

- (void) updateItemAsString
{
  switch (self.pathParameters.pathType)
  {
    case PathTypeArc:
      self.itemAsString = @"Arc";
      break;
    case PathTypeRectangle:
      self.itemAsString = @"Rectangle";
      break;
    default:
      self.itemAsString = @"Unknown path type";
      break;
  }
}

- (void) updateItemDetailsAsString
{
  switch (self.pathParameters.pathType)
  {
    case PathTypeArc:
      self.itemDetailsAsString = [self.pathParameters.arcParameters parametersAsString];
      break;
    case PathTypeRectangle:
      self.itemDetailsAsString = [self.pathParameters.rectangleParameters parametersAsString];
      break;
    default:
      self.itemDetailsAsString = @"Unknown path type";
      break;
  }
}

@end
