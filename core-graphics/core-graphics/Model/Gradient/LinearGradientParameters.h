//
//  LinearGradientParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class GradientStopParameters;
@class ShadowParameters;

NS_ASSUME_NONNULL_BEGIN

@interface LinearGradientParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property CGFloat startPointX;
@property (readonly) CGFloat rangeStartPointX;

@property CGFloat startPointY;
@property (readonly) CGFloat rangeStartPointY;

@property CGFloat endPointX;
@property (readonly) CGFloat rangeEndPointX;

@property CGFloat endPointY;
@property (readonly) CGFloat rangeEndPointY;

@property (strong, nonatomic) GradientStopParameters* gradientStopParameters;
@property (strong, nonatomic) ShadowParameters* shadowParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;

@end

NS_ASSUME_NONNULL_END
