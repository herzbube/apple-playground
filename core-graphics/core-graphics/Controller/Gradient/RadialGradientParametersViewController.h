//
//  RadialGradientParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class RadialGradientParameters;

NS_ASSUME_NONNULL_BEGIN

@interface RadialGradientParametersViewController : UIViewController

- (instancetype) initWithRadialGradientParameters:(RadialGradientParameters*)radialGradientParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) RadialGradientParameters* radialGradientParameters;

@end

NS_ASSUME_NONNULL_END
