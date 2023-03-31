//
//  DrawingParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "DrawingParameters.h"
#import "AffineTransformParameters.h"
#import "ArcParameters.h"
#import "FillParameters.h"
#import "GradientParameters.h"
#import "StrokeParameters.h"

static NSString* drawingParametersKey = @"drawingParameters";
static NSString* affineTransformParametersKey = @"affineTransformParameters";
static NSString* arcParametersKey = @"arcParameters";
static NSString* fillParametersKey = @"fillParameters";
static NSString* gradientParametersKey = @"gradientParameters";
static NSString* strokeParametersKey = @"strokeParameters";

@implementation DrawingParameters

- (instancetype) init
{
  self = [super init];

  self.affineTransformParameters = [[AffineTransformParameters alloc] init];
  self.arcParameters = [[ArcParameters alloc] init];
  self.fillParameters = [[FillParameters alloc] init];
  self.gradientParameters = [[GradientParameters alloc] init];
  self.strokeParameters = [[StrokeParameters alloc] init];

  return self;
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    affineTransformParametersKey : [self.affineTransformParameters valuesAsDictionary],
    arcParametersKey : [self.arcParameters valuesAsDictionary],
    fillParametersKey : [self.fillParameters valuesAsDictionary],
    gradientParametersKey : [self.gradientParameters valuesAsDictionary],
    strokeParametersKey : [self.strokeParameters valuesAsDictionary],
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  [self.affineTransformParameters setValuesWithDictionary:dictionary[affineTransformParametersKey]];
  [self.arcParameters setValuesWithDictionary:dictionary[arcParametersKey]];
  [self.fillParameters setValuesWithDictionary:dictionary[fillParametersKey]];
  [self.gradientParameters setValuesWithDictionary:dictionary[gradientParametersKey]];
  [self.strokeParameters setValuesWithDictionary:dictionary[strokeParametersKey]];
}

- (void) readUserDefaults
{
  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary* dictionary = [userDefaults dictionaryForKey:drawingParametersKey];
  if (dictionary)
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
  [self.affineTransformParameters resetToDefaultValues];
  [self.arcParameters resetToDefaultValues];
  [self.fillParameters resetToDefaultValues];
  [self.gradientParameters resetToDefaultValues];
  [self.strokeParameters resetToDefaultValues];
}

@end
