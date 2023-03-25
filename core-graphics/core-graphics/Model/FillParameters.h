//
//  FillParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface FillParameters : NSObject

- (instancetype) init;

@property bool fillEnabled;

@property (strong, nonatomic) ColorParameters* colorParameters;

@end

NS_ASSUME_NONNULL_END
