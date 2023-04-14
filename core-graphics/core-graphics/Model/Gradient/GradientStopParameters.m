//
//  GradientStopParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import "GradientStopParameters.h"
#import "../ColorParameters.h"
#import "../../GlobalConstants.h"

static NSString* position1Key = @"position1";
static NSString* colorParameters1Key = @"colorParameters1";
static NSString* position2Key = @"position2";
static NSString* colorParameters2Key = @"colorParameters2";

@implementation GradientStopParameters

- (instancetype) init
{
  self = [super init];

  self.colorParameters1 = [[ColorParameters alloc] init];
  self.colorParameters2 = [[ColorParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.position1 = 0.0f;
  self.position2 = 1.0f;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    position1Key : @(self.position1),
    colorParameters1Key : [self.colorParameters1 valuesAsDictionary],
    position2Key : @(self.position2),
    colorParameters2Key : [self.colorParameters2 valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.position1 = [dictionary[position1Key] floatValue];
  [self.colorParameters1 setValuesWithDictionary:dictionary[colorParameters1Key]];
  self.position2 = [dictionary[position2Key] floatValue];
  [self.colorParameters2 setValuesWithDictionary:dictionary[colorParameters2Key]];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self.colorParameters1 resetToDefaultValues];
  [self.colorParameters2 resetToDefaultValues];

  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
