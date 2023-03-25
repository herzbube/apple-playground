//
//  FillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "FillParameters.h"
#import "ColorParameters.h"

@implementation FillParameters

- (instancetype) init
{
  self = [super init];

  self.fillEnabled = true;
  
  self.colorParameters = [[ColorParameters alloc] init];
  
  return self;
}

@end
