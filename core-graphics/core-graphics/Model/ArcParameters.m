//
//  ArcParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "ArcParameters.h"

@interface ArcParameters()
@end

@implementation ArcParameters

- (instancetype) init
{
  self = [super init];

  self.centerX = 200.0f;
  _maximumCenterX = 500.0f;

  self.centerY = 200.0f;
  _maximumCenterY = 500.0f;

  self.radius = 100.0f;
  _maximumRadius = 500.0f;

  self.startAngle = 0.0f;
  _maximumStartAngle = 360.0f;

  self.endAngle = 360.0f;
  _maximumEndAngle = 360.0f;

  self.clockwise = FALSE;

  return self;
}

@end
