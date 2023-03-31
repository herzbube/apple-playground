//
//  LinearGradientParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class LinearGradientParameters;

NS_ASSUME_NONNULL_BEGIN

@interface LinearGradientParametersViewController : UIViewController

- (instancetype) initWithLinearGradientParameters:(LinearGradientParameters*)linearGradientParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) LinearGradientParameters* linearGradientParameters;

@end

NS_ASSUME_NONNULL_END
