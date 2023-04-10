//
//  DrawingHelper.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class ColorParameters;
@class FillParameters;
@class GradientParameters;
@class PathParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingHelper : NSObject

+ (CGFloat) radians:(CGFloat)degrees;
+ (CGPoint) centerOfRect:(CGRect)rect;
+ (CGFloat) lesserDimensionOfRect:(CGRect)rect;
+ (UIColor*) colorFromColorParameters:(ColorParameters*)colorParameters;
+ (void) concatTransformWithContext:(CGContextRef)context
          affineTransformParameters:(AffineTransformParameters*)affineTransformParameters;
+ (void) fillOrStrokePathWithContext:(CGContextRef)context
                    strokeParameters:(StrokeParameters*)strokeParameters
                      fillParameters:(FillParameters*)fillParameters
                      pathParameters:(PathParameters*)pathParameters;
+ (void) drawGradientWithContext:(CGContextRef)context
              gradientParameters:(GradientParameters*)gradientParameters;

@end

NS_ASSUME_NONNULL_END
