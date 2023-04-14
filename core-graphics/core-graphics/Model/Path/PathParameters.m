//
//  PathParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "PathParameters.h"
#import "ArcParameters.h"
#import "RectangleParameters.h"
#import "../../GlobalConstants.h"

static NSString* pathEnabledKey = @"pathEnabled";
static NSString* pathTypeKey = @"pathType";
static NSString* arcParametersKey = @"arcParameters";
static NSString* rectangleParametersKey = @"rectangleParameters";

@implementation PathParameters

- (instancetype) init
{
  self = [super init];

  self.arcParameters = [[ArcParameters alloc] init];
  self.rectangleParameters = [[RectangleParameters alloc] init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.pathEnabled = true;
  self.pathType = PathTypeArc;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    pathEnabledKey : @(self.pathEnabled),
    pathTypeKey : @(self.pathType),
    arcParametersKey : [self.arcParameters valuesAsDictionary],
    rectangleParametersKey : [self.rectangleParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.pathEnabled = [dictionary[pathEnabledKey] boolValue];
  self.pathType = [dictionary[pathTypeKey] intValue];
  [self.arcParameters setValuesWithDictionary:dictionary[arcParametersKey]];
  [self.rectangleParameters setValuesWithDictionary:dictionary[rectangleParametersKey]];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self.arcParameters resetToDefaultValues];
  [self.rectangleParameters resetToDefaultValues];

  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
