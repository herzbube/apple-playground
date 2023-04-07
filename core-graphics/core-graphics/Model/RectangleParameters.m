//
//  RectangleParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "RectangleParameters.h"

static NSString* originXKey = @"originX";
static NSString* originYKey = @"originY";
static NSString* widthKey = @"width";
static NSString* heightKey = @"height";

@implementation RectangleParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _maximumOriginX = 500.0f;
  _maximumOriginY = 500.0f;
  _maximumWidth = 500.0f;
  _maximumHeight = 360.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.originX = 100.0f;
  self.originY = 100.0f;
  self.width = 200.0f;
  self.height = 200.0f;
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
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

@end
