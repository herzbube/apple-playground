//
//  Model.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "Model.h"
#import "ArcParameters.h"
#import "StrokeParameters.h"

@implementation Model

- (instancetype) init
{
  self = [super init];

  self.arcParameters = [[ArcParameters alloc] init];
  self.shouldStrokePath = true;
  self.strokeParameters = [[StrokeParameters alloc] init];

  return self;
}

@end
