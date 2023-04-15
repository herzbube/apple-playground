//
//  ShadowParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "ShadowParameters.h"
#import "ColorParameters.h"
#import "../GlobalConstants.h"

static NSString* shadowEnabledKey = @"shadowEnabled";
static NSString* offsetXKey = @"offsetX";
static NSString* offsetYKey = @"offsetY";
static NSString* blurKey = @"blur";
static NSString* colorParametersKey = @"colorParameters";

@implementation ShadowParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];

  [self initializeWithDefaultValues];

  _rangeOffsetX = drawingCanvasWidth * 1.5f;
  _rangeOffsetY = drawingCanvasHeight * 1.5f;
  _maximumBlur = 200.0f;

  return self;
}

- (void) initializeWithDefaultValues
{
  self.shadowEnabled = true;
  self.offsetX = 10.0f;
  self.offsetY = 10.0f;
  self.blur = 10.0f;

  [self.colorParameters updateWithHexString:@"00000080"];

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    shadowEnabledKey : @(self.shadowEnabled),
    offsetXKey : @(self.offsetX),
    offsetYKey : @(self.offsetY),
    blurKey : @(self.blur),
    colorParametersKey : [self.colorParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.shadowEnabled = [dictionary[shadowEnabledKey] boolValue];
  self.offsetX = [dictionary[offsetXKey] floatValue];
  self.offsetY = [dictionary[offsetYKey] floatValue];
  self.blur = [dictionary[blurKey] floatValue];
  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
