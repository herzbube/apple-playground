//
//  DrawingParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "DrawingParameters.h"
#import "AffineTransformParameters.h"
#import "FillParameters.h"
#import "GradientParameters.h"
#import "PathParameters.h"
#import "StrokeParameters.h"

static NSString* drawingParametersKey = @"drawingParameters";
static NSString* pathParametersKey = @"pathParameters";
static NSString* strokeParametersKey = @"strokeParameters";
static NSString* fillParametersKey = @"fillParameters";
static NSString* affineTransformParametersKey = @"affineTransformParameters";
static NSString* gradientParametersKey = @"gradientParameters";

@implementation DrawingParameters

- (instancetype) init
{
  self = [super init];

  self.pathParameters = [[PathParameters alloc] init];
  self.strokeParameters = [[StrokeParameters alloc] init];
  self.fillParameters = [[FillParameters alloc] init];
  self.affineTransformParameters = [[AffineTransformParameters alloc] init];
  self.gradientParameters = [[GradientParameters alloc] init];

  return self;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    pathParametersKey : [self.pathParameters valuesAsDictionary],
    strokeParametersKey : [self.strokeParameters valuesAsDictionary],
    fillParametersKey : [self.fillParameters valuesAsDictionary],
    affineTransformParametersKey : [self.affineTransformParameters valuesAsDictionary],
    gradientParametersKey : [self.gradientParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  [self.pathParameters setValuesWithDictionary:dictionary[pathParametersKey]];
  [self.strokeParameters setValuesWithDictionary:dictionary[strokeParametersKey]];
  [self.fillParameters setValuesWithDictionary:dictionary[fillParametersKey]];
  [self.affineTransformParameters setValuesWithDictionary:dictionary[affineTransformParametersKey]];
  [self.gradientParameters setValuesWithDictionary:dictionary[gradientParametersKey]];
}

- (void) readUserDefaults
{
  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary* dictionary = [userDefaults dictionaryForKey:drawingParametersKey];
  [self setValuesWithDictionary:dictionary];
}

- (void) writeUserDefaults
{
  NSDictionary* dictionary = [self valuesAsDictionary];
  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:dictionary forKey:drawingParametersKey];
}

- (void) resetToDefaultValues
{
  [self.pathParameters resetToDefaultValues];
  [self.strokeParameters resetToDefaultValues];
  [self.fillParameters resetToDefaultValues];
  [self.affineTransformParameters resetToDefaultValues];
  [self.gradientParameters resetToDefaultValues];
}

@end
