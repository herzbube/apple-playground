//
//  AffineTransformParametersItem.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

@class MatrixAffineTransformParameters;
@class RotateAffineTransformParameters;
@class ScaleAffineTransformParameters;
@class ShearAffineTransformParameters;
@class TranslateAffineTransformParameters;

typedef NS_ENUM(NSInteger, AffineTransformType) {
  AffineTransformTypeScale,
  AffineTransformTypeShear,
  AffineTransformTypeRotate,
  AffineTransformTypeTranslate,
  AffineTransformTypeMatrix,
};

NS_ASSUME_NONNULL_BEGIN

@interface AffineTransformParametersItem : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property AffineTransformType affineTransformType;

@property (strong, nonatomic) MatrixAffineTransformParameters* matrixAffineTransformParameters;
@property (strong, nonatomic) RotateAffineTransformParameters* rotateAffineTransformParameters;
@property (strong, nonatomic) ScaleAffineTransformParameters* scaleAffineTransformParameters;
@property (strong, nonatomic) ShearAffineTransformParameters* shearAffineTransformParameters;
@property (strong, nonatomic) TranslateAffineTransformParameters* translateAffineTransformParameters;

@property (nonatomic) CGAffineTransform affineTransform;
@property (strong, nonatomic) NSString* affineTransformTypeAsString;
@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
