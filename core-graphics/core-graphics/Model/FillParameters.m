//
//  FillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "FillParameters.h"
#import "ColorParameters.h"
#import "GradientParameters.h"
#import "LinearGradientParameters.h"
#import "RadialGradientParameters.h"

static NSString* fillEnabledKey = @"fillEnabled";
static NSString* fillTypeKey = @"fillType";
static NSString* clipGradientToPathKey = @"clipGradientToPath";
static NSString* colorParametersKey = @"colorParameters";
static NSString* gradientParametersKey = @"gradientParameters";

@implementation FillParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];
  self.gradientParameters = [[GradientParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.fillEnabled = true;
  self.fillType = FillTypeSolidColor;
  self.clipGradientToPath = true;
  
  [self.colorParameters updateWithHexString:@"0000FFFF"];
  self.gradientParameters.linearGradientParameters.startPointX = 75.0f;
  self.gradientParameters.linearGradientParameters.startPointY = 200.0f;
  self.gradientParameters.linearGradientParameters.endPointX = 325.0f;
  self.gradientParameters.linearGradientParameters.endPointY = 200.0f;
  self.gradientParameters.radialGradientParameters.startCenterX = 200.0f;
  self.gradientParameters.radialGradientParameters.startCenterY = 200.0f;
  self.gradientParameters.radialGradientParameters.startRadius = 20.0f;
  self.gradientParameters.radialGradientParameters.endCenterX = 200.0f;
  self.gradientParameters.radialGradientParameters.endCenterY = 200.0f;
  self.gradientParameters.radialGradientParameters.endRadius = 120.0f;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    fillEnabledKey : @(self.fillEnabled),
    fillTypeKey : @(self.fillType),
    clipGradientToPathKey : @(self.clipGradientToPath),
    colorParametersKey : [self.colorParameters valuesAsDictionary],
    gradientParametersKey : [self.gradientParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.fillEnabled = [dictionary[fillEnabledKey] boolValue];
  self.fillType = [dictionary[fillTypeKey] intValue];
  self.clipGradientToPath = [dictionary[clipGradientToPathKey] boolValue];
  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];
  [self.gradientParameters setValuesWithDictionary:dictionary[gradientParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];
  [self.gradientParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
