//
//  ArcParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "ArcParameters.h"

static NSString* centerXKey = @"centerX";
static NSString* centerYKey = @"centerY";
static NSString* radiusKey = @"radius";
static NSString* startAngleKey = @"startAngle";
static NSString* endAngleKey = @"endAngle";
static NSString* clockwiseKey = @"clockwise";

@implementation ArcParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _maximumCenterX = 500.0f;
  _maximumCenterY = 500.0f;
  _maximumRadius = 500.0f;
  _maximumStartAngle = 360.0f;
  _maximumEndAngle = 360.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.centerX = 200.0f;
  self.centerY = 200.0f;
  self.radius = 100.0f;
  self.startAngle = 0.0f;
  self.endAngle = 360.0f;
  self.clockwise = FALSE;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    centerXKey : @(self.centerX),
    centerYKey : @(self.centerY),
    radiusKey : @(self.radius),
    startAngleKey : @(self.startAngle),
    endAngleKey : @(self.endAngle),
    clockwiseKey : @(self.clockwise),
  };
}
- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.centerX = [dictionary[centerXKey] floatValue];
  self.centerY = [dictionary[centerYKey] floatValue];
  self.radius = [dictionary[radiusKey] floatValue];
  self.startAngle = [dictionary[startAngleKey] floatValue];
  self.endAngle = [dictionary[endAngleKey] floatValue];
  self.clockwise = [dictionary[clockwiseKey] boolValue];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

@end
