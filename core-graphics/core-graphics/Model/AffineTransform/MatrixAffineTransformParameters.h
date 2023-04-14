//
//  MatrixAffineTransformParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// The affine transform parameters are named according to the Apple
// documentation. See README.md for details.

@interface MatrixAffineTransformParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

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

@property (nonatomic) CGAffineTransform affineTransform;
@property (strong, nonatomic) NSString* affineTransformTypeAsString;
@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
