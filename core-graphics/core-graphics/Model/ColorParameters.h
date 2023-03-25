//
//  ColorParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorParameters : NSObject

- (instancetype) init;

@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat alpha;
@property (strong, nonatomic) NSString* hexString;

@end

NS_ASSUME_NONNULL_END
