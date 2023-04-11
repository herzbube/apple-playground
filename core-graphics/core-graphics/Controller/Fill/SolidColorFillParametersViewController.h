//
//  SolidColorFillParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import <UIKit/UIKit.h>

@class SolidColorFillParameters;

NS_ASSUME_NONNULL_BEGIN

@interface SolidColorFillParametersViewController : UIViewController

- (instancetype) initWithSolidColorFillParameters:(SolidColorFillParameters*)solidColorFillParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) SolidColorFillParameters* solidColorFillParameters;

@end

NS_ASSUME_NONNULL_END
