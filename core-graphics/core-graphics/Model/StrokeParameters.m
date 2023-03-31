//
//  StrokeParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "StrokeParameters.h"
#import "ColorParameters.h"

static NSString* strokeEnabledKey = @"strokeEnabled";
static NSString* lineWidthKey = @"lineWidth";
static NSString* colorParametersKey = @"colorParameters";

@implementation StrokeParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];

  [self initializeWithDefaultValues];

  _maximumLineWidth = 50.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.strokeEnabled = true;
  self.lineWidth = 10.0f;

  [self.colorParameters updateWithHexString:@"FF0000FF"];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    strokeEnabledKey : @(self.strokeEnabled),
    lineWidthKey : @(self.lineWidth),
    colorParametersKey : [self.colorParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  self.strokeEnabled = [dictionary[strokeEnabledKey] boolValue];
  self.lineWidth = [dictionary[lineWidthKey] floatValue];
  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
