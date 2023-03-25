//
//  AffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "AffineTransformParameters.h"

@implementation AffineTransformParameters

- (instancetype) init
{
  self = [super init];

  self.a = 1.0f;
  _rangeA = 1000.0f;

  self.b = 0.0f;
  _rangeB = 1000.0f;

  self.c = 0.0f;
  _rangeC = 1000.0f;

  self.d = 1.0f;
  _rangeD = 1000.0f;

  self.tx = 0.0f;
  _rangeTx = 1000.0f;

  self.ty = 0.0f;
  _rangeTy = 1000.0f;

  return self;
}

@end
