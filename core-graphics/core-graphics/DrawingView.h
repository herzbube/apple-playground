//
//  DrawingView.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class FillParameters;
@class GradientParameters;
@class PathParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingView : UIView

- (void) startObserving;

@property (strong, nonatomic) PathParameters* pathParameters;
@property (strong, nonatomic) StrokeParameters* strokeParameters;
@property (strong, nonatomic) FillParameters* fillParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;
@property (strong, nonatomic) GradientParameters* gradientParameters;

@end

NS_ASSUME_NONNULL_END
