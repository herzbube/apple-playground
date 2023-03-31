//
//  AffineTransformParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;

NS_ASSUME_NONNULL_BEGIN

@interface AffineTransformParametersViewController : UIViewController

- (instancetype) initWithAffineTransformParameters:(AffineTransformParameters*)affineTransformParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;

@end

NS_ASSUME_NONNULL_END
