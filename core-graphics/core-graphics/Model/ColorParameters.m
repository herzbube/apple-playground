//
//  ColorParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
//

#import "ColorParameters.h"

@implementation ColorParameters

- (instancetype) init
{
  self = [super init];

  self.red = 1.0f;
  self.green = 0.0f;
  self.blue = 0.0f;
  self.alpha = 1.0f;
  self.hexString = @"FF0000FF";

  return self;
}

@end
