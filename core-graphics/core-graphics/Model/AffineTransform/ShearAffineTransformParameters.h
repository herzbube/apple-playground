//
//  ShearAffineTransformParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShearAffineTransformParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

- (void) updateParametersDidChange;

@property CGFloat shearAngleX;
@property (readonly) CGFloat rangeShearAngleX;

@property CGFloat shearAngleY;
@property (readonly) CGFloat rangeShearAngleY;

@property (nonatomic) CGAffineTransform affineTransform;
@property (strong, nonatomic) NSString* affineTransformTypeAsString;
@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
