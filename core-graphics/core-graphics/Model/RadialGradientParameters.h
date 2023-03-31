//
//  RadialGradientParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class GradientStopParameters;

NS_ASSUME_NONNULL_BEGIN

@interface RadialGradientParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property CGFloat startCenterX;
@property (readonly) CGFloat maximumStartCenterX;

@property CGFloat startCenterY;
@property (readonly) CGFloat maximumStartCenterY;

@property CGFloat startRadius;
@property (readonly) CGFloat maximumStartRadius;

@property CGFloat endCenterX;
@property (readonly) CGFloat maximumEndCenterX;

@property CGFloat endCenterY;
@property (readonly) CGFloat maximumEndCenterY;

@property CGFloat endRadius;
@property (readonly) CGFloat maximumEndRadius;

@property (strong, nonatomic) GradientStopParameters* gradientStopParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;

@end

NS_ASSUME_NONNULL_END
