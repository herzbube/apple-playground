//
//  TranslateAffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "TranslateAffineTransformParameters.h"
#import "../../GlobalConstants.h"

static NSString* translateXKey = @"translateX";
static NSString* translateYKey = @"translateY";

@implementation TranslateAffineTransformParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _rangeTranslateX = drawingCanvasWidth * 1.5f;
  _rangeTranslateY = drawingCanvasHeight * 1.5f;

  self.affineTransformTypeAsString = @"Translate";

  return self;
}

- (void) initializeWithDefaultValues
{
  self.translateX = 0.0f;
  self.translateY = 0.0f;

  [self valuesDidChange];
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
  if (! dictionary)
    return;

  self.translateX = [dictionary[translateXKey] floatValue];
  self.translateY = [dictionary[translateYKey] floatValue];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  self.affineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, _translateX, _translateY);
  self.parametersAsString = [NSString stringWithFormat:@"%f, %f", _translateX, _translateY];
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
