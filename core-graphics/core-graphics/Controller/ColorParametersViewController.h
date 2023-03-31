//
//  ColorParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface ColorParametersViewController : UIViewController

- (instancetype) initWithColorParameters:(ColorParameters*)colorParameters;

- (void) updateUiWithModelValues;

- (void) updateWithHexString:(NSString*)hexString;

@property (strong, nonatomic) ColorParameters* colorParameters;

@end

NS_ASSUME_NONNULL_END
