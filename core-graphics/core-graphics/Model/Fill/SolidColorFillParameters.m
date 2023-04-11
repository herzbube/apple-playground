//
//  SolidColorFillParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import "SolidColorFillParameters.h"
#import "../ColorParameters.h"
#import "../ShadowParameters.h"

static NSString* colorParametersKey = @"colorParameters";
static NSString* shadowParametersKey = @"shadowParameters";

@implementation SolidColorFillParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters = [[ColorParameters alloc] init];
  self.shadowParameters = [[ShadowParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  [self.colorParameters updateWithHexString:@"8080FFFF"];
  self.shadowParameters.shadowEnabled = false;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    colorParametersKey : [self.colorParameters valuesAsDictionary],
    shadowParametersKey : [self.shadowParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  [self.colorParameters setValuesWithDictionary:dictionary[colorParametersKey]];
  [self.shadowParameters setValuesWithDictionary:dictionary[shadowParametersKey]];
}

- (void) resetToDefaultValues
{
  [self.colorParameters resetToDefaultValues];
  [self.shadowParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

@end
