//
//  RadialGradientParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "RadialGradientParameters.h"
#import "GradientStopParameters.h"
#import "../ColorParameters.h"
#import "../ShadowParameters.h"
#import "../AffineTransform/AffineTransformParameters.h"
#import "../../GlobalConstants.h"

static NSString* startCenterXKey = @"startCenterX";
static NSString* startCenterYKey = @"startCenterY";
static NSString* startRadiusKey = @"startRadius";
static NSString* endCenterXKey = @"endCenterX";
static NSString* endCenterYKey = @"endCenterY";
static NSString* endRadiusKey = @"endRadius";
static NSString* gradientStopParametersKey = @"gradientStopParameters";
static NSString* shadowParametersKey = @"shadowParameters";
static NSString* affineTransformParametersKey = @"affineTransformParameters";

@implementation RadialGradientParameters

- (instancetype) init
{
  self = [super init];

  self.gradientStopParameters = [[GradientStopParameters alloc] init];
  self.shadowParameters = [[ShadowParameters alloc] init];
  self.affineTransformParameters = [[AffineTransformParameters alloc] init];

  [self initializeWithDefaultValues];

  _rangeStartCenterX = drawingCanvasWidth * 1.5f;
  _rangeStartCenterY = drawingCanvasHeight * 1.5f;
  _rangeStartRadius = MAX(drawingCanvasWidth, drawingCanvasHeight) / 2.0f;
  _rangeEndCenterX = drawingCanvasWidth * 1.5f;
  _rangeEndCenterY = drawingCanvasHeight * 1.5f;
  _rangeEndRadius = MAX(drawingCanvasWidth, drawingCanvasHeight) / 2.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.startCenterX = 100.0f;
  self.startCenterY = 400.0f;
  self.startRadius = 50.0f;
  self.endCenterX = 250.0f;
  self.endCenterY = 600.0f;
  self.endRadius = 100.0f;

  [self.gradientStopParameters.colorParameters1 updateWithHexString:@"FFFF00FF"];
  [self.gradientStopParameters.colorParameters2 updateWithHexString:@"0000FF00"];
  self.shadowParameters.shadowEnabled = false;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    startCenterXKey : @(self.startCenterX),
    startCenterYKey : @(self.startCenterY),
    startRadiusKey : @(self.startRadius),
    endCenterXKey : @(self.endCenterX),
    endCenterYKey : @(self.endCenterY),
    endRadiusKey : @(self.endRadius),
    gradientStopParametersKey : [self.gradientStopParameters valuesAsDictionary],
    shadowParametersKey : [self.shadowParameters valuesAsDictionary],
    affineTransformParametersKey : [self.affineTransformParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.startCenterX = [dictionary[startCenterXKey] floatValue];
  self.startCenterY = [dictionary[startCenterYKey] floatValue];
  self.startRadius = [dictionary[startRadiusKey] floatValue];
  self.endCenterX = [dictionary[endCenterXKey] floatValue];
  self.endCenterY = [dictionary[endCenterYKey] floatValue];
  self.endRadius = [dictionary[endRadiusKey] floatValue];
  [self.gradientStopParameters setValuesWithDictionary:dictionary[gradientStopParametersKey]];
  [self.shadowParameters setValuesWithDictionary:dictionary[shadowParametersKey]];
  [self.affineTransformParameters setValuesWithDictionary:dictionary[affineTransformParametersKey]];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self.gradientStopParameters resetToDefaultValues];
  [self.shadowParameters resetToDefaultValues];
  [self.affineTransformParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
