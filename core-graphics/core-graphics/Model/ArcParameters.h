//
//  ArcParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArcParameters : NSObject

- (instancetype) init;

@property CGFloat centerX;
@property (readonly) CGFloat maximumCenterX;

@property CGFloat centerY;
@property (readonly) CGFloat maximumCenterY;

@property CGFloat radius;
@property (readonly) CGFloat maximumRadius;

@property CGFloat startAngle;
@property (readonly) CGFloat maximumStartAngle;

@property CGFloat endAngle;
@property (readonly) CGFloat maximumEndAngle;

@property BOOL clockwise;

@end

NS_ASSUME_NONNULL_END
