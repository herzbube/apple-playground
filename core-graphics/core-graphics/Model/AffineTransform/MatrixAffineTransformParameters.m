//
//  MatrixAffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import "MatrixAffineTransformParameters.h"
#import "../../GlobalConstants.h"

static NSString* aKey = @"a";
static NSString* bKey = @"b";
static NSString* cKey = @"c";
static NSString* dKey = @"d";
static NSString* txKey = @"tx";
static NSString* tyKey = @"ty";

@implementation MatrixAffineTransformParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  _rangeA = 1000.0f;
  _rangeB = 1000.0f;
  _rangeC = 1000.0f;
  _rangeD = 1000.0f;
  _rangeTx = 1000.0f;
  _rangeTy = 1000.0f;
  
  self.affineTransformTypeAsString = @"Matrix";

  return self;
}

- (void) initializeWithDefaultValues
{
  self.a = 1.0f;
  self.b = 0.0f;
  self.c = 0.0f;
  self.d = 1.0f;
  self.tx = 0.0f;
  self.ty = 0.0f;

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    aKey : @(self.a),
    bKey : @(self.b),
    cKey : @(self.c),
    dKey : @(self.d),
    txKey : @(self.tx),
    tyKey : @(self.ty),
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  self.a = [dictionary[aKey] floatValue];
  self.b = [dictionary[bKey] floatValue];
  self.c = [dictionary[cKey] floatValue];
  self.d = [dictionary[dKey] floatValue];
  self.tx = [dictionary[txKey] floatValue];
  self.ty = [dictionary[tyKey] floatValue];

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  self.affineTransform = CGAffineTransformMake(_a, _b, _c, _d, _tx, _ty);
  self.parametersAsString = [NSString stringWithFormat:@"%f, %f, %f, %f, %f, %f", _a, _b, _c, _d, _tx, _ty];
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

@end
