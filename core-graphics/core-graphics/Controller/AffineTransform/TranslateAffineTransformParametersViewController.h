//
//  TranslateAffineTransformParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

@class TranslateAffineTransformParameters;

NS_ASSUME_NONNULL_BEGIN

@interface TranslateAffineTransformParametersViewController : UIViewController

- (instancetype) initWithTranslateAffineTransformParameters:(TranslateAffineTransformParameters*)translateAffineTransformParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) TranslateAffineTransformParameters* translateAffineTransformParameters;

@end

NS_ASSUME_NONNULL_END
