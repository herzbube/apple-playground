//
//  TranslateAffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "TranslateAffineTransformParameters.h"

static NSString* translateXKey = @"translateX";
static NSString* translateYKey = @"translateY";

@implementation TranslateAffineTransformParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _rangeTranslateX = 1000.0f;
  _rangeTranslateY = 1000.0f;

  self.affineTransformTypeAsString = @"Translate";

  return self;
}

- (void) initializeWithDefaultValues
{
  self.translateX = 0.0f;
  self.translateY = 0.0f;

  [self updateParametersDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    translateXKey : @(self.translateX),
    translateYKey : @(self.translateY),
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  self.translateX = [dictionary[translateXKey] floatValue];
  self.translateY = [dictionary[translateYKey] floatValue];

  [self updateParametersDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) updateParametersDidChange
{
  self.affineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, _translateX, _translateY);
  self.parametersAsString = [NSString stringWithFormat:@"%f, %f", _translateX, _translateY];
}

@end
