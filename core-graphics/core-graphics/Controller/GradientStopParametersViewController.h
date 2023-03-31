//
//  GradientStopParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class GradientStopParameters;

NS_ASSUME_NONNULL_BEGIN

@interface GradientStopParametersViewController : UIViewController

- (instancetype) initWithGradientStopParameters:(GradientStopParameters*)gradientStopParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) GradientStopParameters* gradientStopParameters;

@end

NS_ASSUME_NONNULL_END
