//
//  ShearAffineTransformParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

@class ShearAffineTransformParameters;

NS_ASSUME_NONNULL_BEGIN

@interface ShearAffineTransformParametersViewController : UIViewController

- (instancetype) initWithShearAffineTransformParameters:(ShearAffineTransformParameters*)shearAffineTransformParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) ShearAffineTransformParameters* shearAffineTransformParameters;

@end

NS_ASSUME_NONNULL_END
