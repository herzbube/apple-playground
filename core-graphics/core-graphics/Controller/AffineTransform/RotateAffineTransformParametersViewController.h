//
//  RotateAffineTransformParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

@class RotateAffineTransformParameters;

NS_ASSUME_NONNULL_BEGIN

@interface RotateAffineTransformParametersViewController : UIViewController

- (instancetype) initWithRotateAffineTransformParameters:(RotateAffineTransformParameters*)rotateAffineTransformParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) RotateAffineTransformParameters* rotateAffineTransformParameters;

@end

NS_ASSUME_NONNULL_END
