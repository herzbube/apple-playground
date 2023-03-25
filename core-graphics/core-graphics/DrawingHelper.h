//
//  DrawingHelper.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

@class FillParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingHelper : NSObject

+ (CGFloat) radians:(CGFloat)degrees;
+ (CGPoint) centerOfRect:(CGRect)rect;
+ (CGFloat) lesserDimensionOfRect:(CGRect)rect;
+ (void) fillOrStrokePathWithContext:(CGContextRef)context
                    strokeParameters:(StrokeParameters*)strokeParameters
                      fillParameters:(FillParameters*)fillParameters;

@end

NS_ASSUME_NONNULL_END
