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

  // a and d
  // - a and d are used for scaling and are set with the scaling factor in
  //   x/y-direction. The two parameters can therefore theoretically become
  //   +/-INF.
  // - a and d are also used for rotation, in which case the two parameters are
  //   set with cos(θ) - θ being the rotation angle - and cos() oscillates
  //   between +/-1.
  // - Setting the range for a and d to +/-10 is a compromise with usability
  //   as it allows the user to drag a slider to the maximum/minimum position
  //   with reasonable accuracy and still see the scaling effect. If more
  //   scaling is needed the user can manually enter a value.
  //
  // b and c
  // - b and c can become +/-INF because for shearing these two parameters are
  //   set with tan(ψ) and tan(ϕ), respectively - ψ and ϕ being the shearing
  //   angles in x/y-direction - and tan() becomes +/-INF at 90° angles.
  // - b and c are also used for rotation, in which case the two parameters are
  //   set with +/-sin(θ) - θ being the rotation angle - and sin() oscillates
  //   between +/-1.
  // - Setting the range for b and c to +/-10 is a compromise with usability
  //   as it allows the user to drag a slider to the maximum/minimum position
  //   with reasonable accuracy and still see the shearing effect. The maximum
  //   shearing angle to be achieved is +/-84.3°, which should be sufficient for
  //   most cases. If more shearing is needed the user can manually enter a
  //   value, or use the transformation dedicated to shearing, which lets the
  //   user enter a degree value.
  _rangeA = 10.0f;
  _rangeB = 10.0f;
  _rangeC = 10.0f;
  _rangeD = 10.0f;
  _rangeTx = drawingCanvasWidth * 1.5f;
  _rangeTy = drawingCanvasHeight * 1.5f;
  
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
