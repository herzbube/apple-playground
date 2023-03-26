//
//  AffineTransformParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// The affine transform parameters are named according to the Apple
// documentation. See README.md for details.

@interface AffineTransformParameters : NSObject

- (instancetype) init;

@property bool affineTransformEnabled;

@property CGFloat a;
@property (readonly) CGFloat rangeA;

@property CGFloat b;
@property (readonly) CGFloat rangeB;

@property CGFloat c;
@property (readonly) CGFloat rangeC;

@property CGFloat d;
@property (readonly) CGFloat rangeD;

@property CGFloat tx;
@property (readonly) CGFloat rangeTx;

@property CGFloat ty;
@property (readonly) CGFloat rangeTy;


@end

NS_ASSUME_NONNULL_END
