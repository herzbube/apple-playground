//
//  SolidColorFillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "SolidColorFillParameters.h"
#import "../ColorParameters.h"

static NSString* colorParametersKey = @"colorParameters";

@implementation SolidColorFillParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  [self.colorParameters updateWithHexString:@"0000FFFF"];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    colorParametersKey : [self.colorParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
