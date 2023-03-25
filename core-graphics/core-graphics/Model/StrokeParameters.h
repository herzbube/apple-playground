//
//  StrokeParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface StrokeParameters : NSObject

- (instancetype) init;

@property bool strokeEnabled;

@property CGFloat lineWidth;
@property (readonly) CGFloat maximumLineWidth;

@property (strong, nonatomic) ColorParameters* colorParameters;

@end

NS_ASSUME_NONNULL_END
