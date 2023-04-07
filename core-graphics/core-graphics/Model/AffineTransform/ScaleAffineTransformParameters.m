//
//  ScaleAffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "ScaleAffineTransformParameters.h"

static NSString* scaleXKey = @"scaleX";
static NSString* scaleYKey = @"scaleY";

@implementation ScaleAffineTransformParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _maximumScaleX = 10.0f;
  _maximumScaleY = 10.0f;
  
  self.affineTransformTypeAsString = @"Scale";

  return self;
}

- (void) initializeWithDefaultValues
{
  self.scaleX = 1.0f;
  self.scaleY = 1.0f;
  
  [self updateParametersDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    scaleXKey : @(self.scaleX),
    scaleYKey : @(self.scaleY),
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.scaleX = [dictionary[scaleXKey] floatValue];
  self.scaleY = [dictionary[scaleYKey] floatValue];

  [self updateParametersDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) updateParametersDidChange
{
  self.affineTransform = CGAffineTransformScale(CGAffineTransformIdentity, _scaleX, _scaleY);
  self.parametersAsString = [NSString stringWithFormat:@"%f, %f", _scaleX, _scaleY];
}

@end
