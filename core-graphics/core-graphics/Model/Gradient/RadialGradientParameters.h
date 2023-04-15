//
//  RadialGradientParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class GradientStopParameters;
@class ShadowParameters;

NS_ASSUME_NONNULL_BEGIN

@interface RadialGradientParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property CGFloat startCenterX;
@property (readonly) CGFloat rangeStartCenterX;

@property CGFloat startCenterY;
@property (readonly) CGFloat rangeStartCenterY;

@property CGFloat startRadius;
@property (readonly) CGFloat rangeStartRadius;

@property CGFloat endCenterX;
@property (readonly) CGFloat rangeEndCenterX;

@property CGFloat endCenterY;
@property (readonly) CGFloat rangeEndCenterY;

@property CGFloat endRadius;
@property (readonly) CGFloat rangeEndRadius;

@property (strong, nonatomic) GradientStopParameters* gradientStopParameters;
@property (strong, nonatomic) ShadowParameters* shadowParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;

@end

NS_ASSUME_NONNULL_END
