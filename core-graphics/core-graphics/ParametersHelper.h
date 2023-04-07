//
//  ParametersHelper.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 07.04.23.
//

#import <UIKit/UIKit.h>

@class DrawingParameters;

NS_ASSUME_NONNULL_BEGIN

@interface ParametersHelper : NSObject

+ (void) saveParameters:(DrawingParameters*)drawingParameters;
+ (void) loadParameters:(DrawingParameters*)drawingParameters;
+ (void) resetParameters:(DrawingParameters*)drawingParameters;
+ (void) alignGradientToPathParameters:(DrawingParameters*)drawingParameters;

@end

NS_ASSUME_NONNULL_END
