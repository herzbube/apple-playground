//
//  MatrixAffineTransformParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

@class MatrixAffineTransformParameters;

NS_ASSUME_NONNULL_BEGIN

@interface MatrixAffineTransformParametersViewController : UIViewController

- (instancetype) initWithMatrixAffineTransformParameters:(MatrixAffineTransformParameters*)matrixAffineTransformParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) MatrixAffineTransformParameters* matrixAffineTransformParameters;

@end

NS_ASSUME_NONNULL_END
