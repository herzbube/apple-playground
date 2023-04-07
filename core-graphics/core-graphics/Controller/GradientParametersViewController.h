//
//  GradientParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class GradientParameters;

NS_ASSUME_NONNULL_BEGIN

@interface GradientParametersViewController : UIViewController

- (instancetype) initWithGradientParameters:(GradientParameters*)gradientParameters;

- (void) updateUiWithModelValues;
- (void) hideTitleLabelAndEnabledSwitch;

@property (strong, nonatomic) GradientParameters* gradientParameters;

@end

NS_ASSUME_NONNULL_END
