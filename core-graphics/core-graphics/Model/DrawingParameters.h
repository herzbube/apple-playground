//
//  DrawingParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <Foundation/Foundation.h>

@class AffineTransformParameters;
@class ArcParameters;
@class FillParameters;
@class GradientParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

- (void) readUserDefaults;
- (void) writeUserDefaults;

@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;
@property (strong, nonatomic) ArcParameters* arcParameters;
@property (strong, nonatomic) FillParameters* fillParameters;
@property (strong, nonatomic) GradientParameters* gradientParameters;
@property (strong, nonatomic) StrokeParameters* strokeParameters;

@end

NS_ASSUME_NONNULL_END
