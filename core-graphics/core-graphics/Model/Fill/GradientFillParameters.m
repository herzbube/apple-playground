//
//  GradientFillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "GradientFillParameters.h"
#import "../Gradient/GradientParameters.h"
#import "../Gradient/LinearGradientParameters.h"
#import "../Gradient/RadialGradientParameters.h"

static NSString* clipGradientToPathKey = @"clipGradientToPath";
static NSString* gradientParametersKey = @"gradientParameters";

@implementation GradientFillParameters

- (instancetype) init
{
  self = [super init];

  self.gradientParameters = [[GradientParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.clipGradientToPath = true;
  
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
    clipGradientToPathKey : @(self.clipGradientToPath),
    gradientParametersKey : [self.gradientParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.clipGradientToPath = [dictionary[clipGradientToPathKey] boolValue];
  [self.gradientParameters setValuesWithDictionary:dictionary[gradientParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.gradientParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
