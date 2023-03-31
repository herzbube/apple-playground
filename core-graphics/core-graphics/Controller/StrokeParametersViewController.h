//
//  StrokeParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 22.03.23.
//

#import <UIKit/UIKit.h>

@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface StrokeParametersViewController : UIViewController

- (instancetype) initWithStrokeParameters:(StrokeParameters*)strokeParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) StrokeParameters* strokeParameters;

@end

NS_ASSUME_NONNULL_END
