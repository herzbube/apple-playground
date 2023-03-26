//
//  LinearGradientParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "LinearGradientParameters.h"
#import "AffineTransformParameters.h"
#import "ColorParameters.h"
#import "GradientStopParameters.h"

@interface LinearGradientParameters()
@end

@implementation LinearGradientParameters

- (instancetype) init
{
  self = [super init];

  self.startPointX = 150.0f;
  _maximumStartPointX = 500.0f;

  self.startPointY = 400.0f;
  _maximumStartPointY = 500.0f;

  self.endPointX = 0.0f;
  _maximumEndPointX = 500.0f;

  self.endPointY = 600.0f;
  _maximumEndPointY = 500.0f;

  self.gradientStopParameters = [[GradientStopParameters alloc] init];
  self.affineTransformParameters = [[AffineTransformParameters alloc] init];

  [self.gradientStopParameters.colorParameters1 updateWithHexString:@"00FF00FF"];
  [self.gradientStopParameters.colorParameters2 updateWithHexString:@"FF00FF00"];

  return self;
}

@end
