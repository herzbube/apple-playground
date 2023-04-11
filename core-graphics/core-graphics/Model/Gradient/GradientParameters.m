//
//  GradientParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "GradientParameters.h"
#import "LinearGradientParameters.h"
#import "RadialGradientParameters.h"

static NSString* gradientEnabledKey = @"gradientEnabled";
static NSString* gradientTypeKey = @"gradientType";
static NSString* linearGradientParametersKey = @"linearGradientParameters";
static NSString* radialGradientParametersKey = @"radialGradientParameters";

@implementation GradientParameters

- (instancetype) init
{
  self = [super init];

  self.linearGradientParameters = [[LinearGradientParameters alloc] init];
  self.radialGradientParameters = [[RadialGradientParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.gradientEnabled = true;
  self.gradientType = GradientTypeLinear;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    gradientEnabledKey : @(self.gradientEnabled),
    gradientTypeKey : @(self.gradientType),
    linearGradientParametersKey : [self.linearGradientParameters valuesAsDictionary],
    radialGradientParametersKey : [self.radialGradientParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.gradientEnabled = [dictionary[gradientEnabledKey] boolValue];
  self.gradientType = [dictionary[gradientTypeKey] intValue];
  [self.linearGradientParameters setValuesWithDictionary:dictionary[linearGradientParametersKey]];
  [self.radialGradientParameters setValuesWithDictionary:dictionary[radialGradientParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.linearGradientParameters resetToDefaultValues];
  [self.radialGradientParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
