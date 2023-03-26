//
//  StrokeParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "StrokeParameters.h"
#import "ColorParameters.h"

@implementation StrokeParameters

- (instancetype) init
{
  self = [super init];

  self.strokeEnabled = true;

  self.lineWidth = 10.0f;
  _maximumLineWidth = 50.0f;
  
  self.colorParameters = [[ColorParameters alloc] init];

  [self.colorParameters updateWithHexString:@"FF0000FF"];

  return self;
}

@end
