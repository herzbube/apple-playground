//
//  ShearAffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "ShearAffineTransformParameters.h"
#import "../../DrawingHelper.h"
#import "../../GlobalConstants.h"

static NSString* shearAngleXKey = @"shearAngleX";
static NSString* shearAngleYKey = @"shearAngleY";

@implementation ShearAffineTransformParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _rangeShearAngleX = 360.0f;
  _rangeShearAngleY = 360.0f;

  self.affineTransformTypeAsString = @"Shear";

  return self;
}

- (void) initializeWithDefaultValues
{
  self.shearAngleX = 0.0f;
  self.shearAngleY = 0.0f;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    shearAngleXKey : @(self.shearAngleX),
    shearAngleYKey : @(self.shearAngleY),
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.shearAngleX = [dictionary[shearAngleXKey] floatValue];
  self.shearAngleY = [dictionary[shearAngleYKey] floatValue];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  CGAffineTransform shearAffineTransform = CGAffineTransformIdentity;
  shearAffineTransform.c = tan([DrawingHelper radians:_shearAngleX]);
  shearAffineTransform.b = tan([DrawingHelper radians:_shearAngleY]);
  self.affineTransform = shearAffineTransform;

  self.parametersAsString = [NSString stringWithFormat:@"%f, %f", _shearAngleX, _shearAngleY];
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
