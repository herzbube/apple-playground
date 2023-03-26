//
//  RadialGradientParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "RadialGradientParameters.h"
#import "AffineTransformParameters.h"
#import "ColorParameters.h"
#import "GradientStopParameters.h"

@interface RadialGradientParameters()
@end

@implementation RadialGradientParameters

- (instancetype) init
{
  self = [super init];

  self.startCenterX = 100.0f;
  _maximumStartCenterX = 500.0f;

  self.startCenterY = 400.0f;
  _maximumStartCenterY = 500.0f;

  self.startRadius = 50.0f;
  _maximumStartRadius = 500.0f;

  self.endCenterX = 250.0f;
  _maximumEndCenterX = 500.0f;

  self.endCenterY = 600.0f;
  _maximumEndCenterY = 500.0f;

  self.endRadius = 100.0f;
  _maximumEndRadius = 500.0f;

  self.gradientStopParameters = [[GradientStopParameters alloc] init];
  self.affineTransformParameters = [[AffineTransformParameters alloc] init];

  [self.gradientStopParameters.colorParameters1 updateWithHexString:@"FFFF00FF"];
  [self.gradientStopParameters.colorParameters2 updateWithHexString:@"0000FF00"];

  return self;
}

@end
