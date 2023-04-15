//
//  RectangleParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "RectangleParameters.h"
#import "../../GlobalConstants.h"

static NSString* originXKey = @"originX";
static NSString* originYKey = @"originY";
static NSString* widthKey = @"width";
static NSString* heightKey = @"height";

@implementation RectangleParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _rangeOriginX = drawingCanvasWidth * 1.5f;
  _rangeOriginY = drawingCanvasHeight * 1.5f;
  _rangeWidth = drawingCanvasWidth;
  _rangeHeight = drawingCanvasHeight;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.originX = 100.0f;
  self.originY = 100.0f;
  self.width = 200.0f;
  self.height = 200.0f;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    originXKey : @(self.originX),
    originYKey : @(self.originY),
    widthKey : @(self.width),
    heightKey : @(self.height),
  };
}
- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.originX = [dictionary[originXKey] floatValue];
  self.originY = [dictionary[originYKey] floatValue];
  self.width = [dictionary[widthKey] floatValue];
  self.height = [dictionary[heightKey] floatValue];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  self.parametersAsString = [NSString stringWithFormat:@"%f, %f, %f, %f", _originX, _originX, _width, _height];
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
