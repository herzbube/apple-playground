//
//  GradientFillParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import <UIKit/UIKit.h>

@class GradientFillParameters;

NS_ASSUME_NONNULL_BEGIN

@interface GradientFillParametersViewController : UIViewController

- (instancetype) initWithGradientFillParameters:(GradientFillParameters*)gradientFillParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) GradientFillParameters* gradientFillParameters;

@end

NS_ASSUME_NONNULL_END
