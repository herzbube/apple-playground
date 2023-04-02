//
//  ScaleAffineTransformParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

@class ScaleAffineTransformParameters;

NS_ASSUME_NONNULL_BEGIN

@interface ScaleAffineTransformParametersViewController : UIViewController

- (instancetype) initWithScaleAffineTransformParameters:(ScaleAffineTransformParameters*)scaleAffineTransformParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) ScaleAffineTransformParameters* scaleAffineTransformParameters;

@end

NS_ASSUME_NONNULL_END
