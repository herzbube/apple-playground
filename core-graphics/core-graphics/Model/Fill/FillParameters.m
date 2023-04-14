//
//  FillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "FillParameters.h"
#import "GradientFillParameters.h"
#import "SolidColorFillParameters.h"
#import "../../GlobalConstants.h"

static NSString* fillEnabledKey = @"fillEnabled";
static NSString* fillTypeKey = @"fillType";
static NSString* solidColorFillParametersKey = @"solidColorFillParameters";
static NSString* gradientFillParametersKey = @"gradientFillParameters";

@implementation FillParameters

- (instancetype) init
{
  self = [super init];

  self.solidColorFillParameters = [[SolidColorFillParameters alloc] init];
  self.gradientFillParameters = [[GradientFillParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.fillEnabled = true;
  self.fillType = FillTypeSolidColor;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    fillEnabledKey : @(self.fillEnabled),
    fillTypeKey : @(self.fillType),
    solidColorFillParametersKey : [self.solidColorFillParameters valuesAsDictionary],
    gradientFillParametersKey : [self.gradientFillParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.fillEnabled = [dictionary[fillEnabledKey] boolValue];
  self.fillType = [dictionary[fillTypeKey] intValue];
  [self.solidColorFillParameters setValuesWithDictionary:dictionary[solidColorFillParametersKey]];
  [self.gradientFillParameters setValuesWithDictionary:dictionary[gradientFillParametersKey]];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self.solidColorFillParameters resetToDefaultValues];
  [self.gradientFillParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
