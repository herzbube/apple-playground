//
//  GradientParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "GradientParameters.h"
#import "LinearGradientParameters.h"
#import "RadialGradientParameters.h"

@implementation GradientParameters

- (instancetype) init
{
  self = [super init];

  self.gradientEnabled = true;
  self.gradientType = GradientTypeLinear;
  self.linearGradientParameters = [[LinearGradientParameters alloc] init];
  self.radialGradientParameters = [[RadialGradientParameters alloc] init];

  return self;
}

@end
