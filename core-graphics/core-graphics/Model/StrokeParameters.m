//
//  StrokeParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "StrokeParameters.h"
#import "ColorParameters.h"
#import "ShadowParameters.h"
#import "../GlobalConstants.h"

static NSString* strokeEnabledKey = @"strokeEnabled";
static NSString* lineWidthKey = @"lineWidth";
static NSString* colorParametersKey = @"colorParameters";
static NSString* shadowParametersKey = @"shadowParameters";

@implementation StrokeParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];
  self.shadowParameters = [[ShadowParameters alloc] init];

  [self initializeWithDefaultValues];

  _maximumLineWidth = 50.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.strokeEnabled = true;
  self.lineWidth = 10.0f;

  [self.colorParameters updateWithHexString:@"FF0000FF"];

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    strokeEnabledKey : @(self.strokeEnabled),
    lineWidthKey : @(self.lineWidth),
    colorParametersKey : [self.colorParameters valuesAsDictionary],
    shadowParametersKey : [self.shadowParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.strokeEnabled = [dictionary[strokeEnabledKey] boolValue];
  self.lineWidth = [dictionary[lineWidthKey] floatValue];
  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];
  [self.shadowParameters setValuesWithDictionary:dictionary[shadowParametersKey]];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];
  [self.shadowParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
