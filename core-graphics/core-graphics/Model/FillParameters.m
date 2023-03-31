//
//  FillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "FillParameters.h"
#import "ColorParameters.h"

static NSString* fillEnabledKey = @"fillEnabled";
static NSString* colorParametersKey = @"colorParameters";

@implementation FillParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.fillEnabled = true;
  
  [self.colorParameters updateWithHexString:@"0000FFFF"];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    fillEnabledKey : @(self.fillEnabled),
    colorParametersKey : [self.colorParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  self.fillEnabled = [dictionary[fillEnabledKey] boolValue];
  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
