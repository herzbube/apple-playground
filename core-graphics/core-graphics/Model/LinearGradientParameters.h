//
//  LinearGradientParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class GradientStopParameters;

NS_ASSUME_NONNULL_BEGIN

@interface LinearGradientParameters : NSObject

- (instancetype) init;

@property CGFloat startPointX;
@property (readonly) CGFloat maximumStartPointX;

@property CGFloat startPointY;
@property (readonly) CGFloat maximumStartPointY;

@property CGFloat endPointX;
@property (readonly) CGFloat maximumEndPointX;

@property CGFloat endPointY;
@property (readonly) CGFloat maximumEndPointY;

@property (strong, nonatomic) GradientStopParameters* gradientStopParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;

@end

NS_ASSUME_NONNULL_END
