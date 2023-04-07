//
//  RotateAffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "RotateAffineTransformParameters.h"
#import "../../DrawingHelper.h"

static NSString* rotateAngleKey = @"rotateAngle";

@implementation RotateAffineTransformParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _rangeRotateAngle = 360.0f;
  
  self.affineTransformTypeAsString = @"Rotate";

  return self;
}

- (void) initializeWithDefaultValues
{
  self.rotateAngle = 0.0f;

  [self updateParametersDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    rotateAngleKey : @(self.rotateAngle),
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.rotateAngle = [dictionary[rotateAngleKey] floatValue];

  [self updateParametersDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) updateParametersDidChange
{
  self.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                 [DrawingHelper radians:_rotateAngle]);
  self.parametersAsString = [NSString stringWithFormat:@"%f", _rotateAngle];
}

@end
