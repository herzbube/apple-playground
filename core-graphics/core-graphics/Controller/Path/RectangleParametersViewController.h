//
//  RectangleParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <UIKit/UIKit.h>

@class RectangleParameters;

NS_ASSUME_NONNULL_BEGIN

@interface RectangleParametersViewController : UIViewController

- (instancetype) initWithRectangleParameters:(RectangleParameters*)rectangleParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) RectangleParameters* rectangleParameters;

@end

NS_ASSUME_NONNULL_END
