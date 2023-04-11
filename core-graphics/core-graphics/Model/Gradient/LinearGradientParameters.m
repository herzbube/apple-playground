//
//  LinearGradientParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "LinearGradientParameters.h"
#import "GradientStopParameters.h"
#import "../ColorParameters.h"
#import "../AffineTransform/AffineTransformParameters.h"

static NSString* startPointXKey = @"startPointX";
static NSString* startPointYKey = @"startPointY";
static NSString* endPointXKey = @"endPointX";
static NSString* endPointYKey = @"endPointY";
static NSString* gradientStopParametersKey = @"gradientStopParameters";
static NSString* affineTransformParametersKey = @"affineTransformParameters";

@implementation LinearGradientParameters

- (instancetype) init
{
  self = [super init];

  self.gradientStopParameters = [[GradientStopParameters alloc] init];
  self.affineTransformParameters = [[AffineTransformParameters alloc] init];

  [self initializeWithDefaultValues];

  _maximumStartPointX = 500.0f;
  _maximumStartPointY = 500.0f;
  _maximumEndPointX = 500.0f;
  _maximumEndPointY = 500.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.startPointX = 150.0f;
  self.startPointY = 400.0f;
  self.endPointX = 0.0f;
  self.endPointY = 600.0f;

  [self.gradientStopParameters.colorParameters1 updateWithHexString:@"00FF00FF"];
  [self.gradientStopParameters.colorParameters2 updateWithHexString:@"FF00FF00"];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    startPointXKey : @(self.startPointX),
    startPointYKey : @(self.startPointY),
    endPointXKey : @(self.endPointX),
    endPointYKey : @(self.endPointY),
    gradientStopParametersKey : [self.gradientStopParameters valuesAsDictionary],
    affineTransformParametersKey : [self.affineTransformParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.startPointX = [dictionary[startPointXKey] floatValue];
  self.startPointY = [dictionary[startPointYKey] floatValue];
  self.endPointX = [dictionary[endPointXKey] floatValue];
  self.endPointY = [dictionary[endPointYKey] floatValue];
  [self.gradientStopParameters setValuesWithDictionary:dictionary[gradientStopParametersKey]];
  [self.affineTransformParameters setValuesWithDictionary:dictionary[affineTransformParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.gradientStopParameters resetToDefaultValues];
  [self.affineTransformParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
