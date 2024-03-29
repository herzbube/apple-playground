//
//  ArcParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "ArcParameters.h"
#import "../../GlobalConstants.h"

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

  _rangeCenterX = drawingCanvasWidth * 1.5f;
  _rangeCenterY = drawingCanvasHeight * 1.5f;
  _rangeRadius = MAX(drawingCanvasWidth, drawingCanvasHeight) / 2.0f;
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

  [self valuesDidChange];
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

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  self.parametersAsString = [NSString stringWithFormat:@"%f, %f, %f, %f, %f, %d", _centerX, _centerY, _radius, _startAngle, _endAngle, _clockwise];
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
