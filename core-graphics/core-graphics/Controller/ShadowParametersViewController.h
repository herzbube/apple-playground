//
//  ShadowParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import <UIKit/UIKit.h>

@class ShadowParameters;

NS_ASSUME_NONNULL_BEGIN

@interface ShadowParametersViewController : UIViewController

- (instancetype) initWithShadowParameters:(ShadowParameters*)shadowParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) ShadowParameters* shadowParameters;

@end

NS_ASSUME_NONNULL_END
