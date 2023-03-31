//
//  FillParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

@class FillParameters;

NS_ASSUME_NONNULL_BEGIN

@interface FillParametersViewController : UIViewController

- (instancetype) initWithFillParameters:(FillParameters*)fillParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) FillParameters* fillParameters;

@end

NS_ASSUME_NONNULL_END
