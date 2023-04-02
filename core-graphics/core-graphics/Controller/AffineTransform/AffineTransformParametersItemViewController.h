//
//  AffineTransformParametersItemViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParametersItem;

NS_ASSUME_NONNULL_BEGIN

@interface AffineTransformParametersItemViewController : UIViewController

- (instancetype) init;

- (void) updateAffineTransformParametersItem:(AffineTransformParametersItem*)affineTransformParametersItem;

@property (strong, nonatomic, nullable) AffineTransformParametersItem* affineTransformParametersItem;

@end

NS_ASSUME_NONNULL_END
