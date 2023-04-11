//
//  PathParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <UIKit/UIKit.h>

@class PathParameters;

NS_ASSUME_NONNULL_BEGIN

@interface PathParametersViewController : UIViewController

- (instancetype) initWithPathParameters:(PathParameters*)pathParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) PathParameters* pathParameters;

@end

NS_ASSUME_NONNULL_END
