//
//  DrawingParametersItem.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 13.04.23.
//

#import <Foundation/Foundation.h>

@class AffineTransformParameters;
@class FillParameters;
@class GradientParameters;
@class PathParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingParametersItem : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property (strong, nonatomic) PathParameters* pathParameters;
@property (strong, nonatomic) StrokeParameters* strokeParameters;
@property (strong, nonatomic) FillParameters* fillParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;
@property (strong, nonatomic) GradientParameters* gradientParameters;

@property (strong, nonatomic) NSString* itemAsString;
@property (strong, nonatomic) NSString* itemDetailsAsString;

@end

NS_ASSUME_NONNULL_END
