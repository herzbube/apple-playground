//
//  GradientStopParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "GradientStopParameters.h"
#import "ColorParameters.h"

@implementation GradientStopParameters

- (instancetype) init
{
  self = [super init];

  self.position1 = 0.0f;
  self.colorParameters1 = [[ColorParameters alloc] init];

  self.position2 = 1.0f;
  self.colorParameters2 = [[ColorParameters alloc] init];

  return self;
}

@end
