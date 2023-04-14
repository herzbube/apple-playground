//
//  ScaleAffineTransformParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScaleAffineTransformParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property CGFloat scaleX;
@property (readonly) CGFloat maximumScaleX;

@property CGFloat scaleY;
@property (readonly) CGFloat maximumScaleY;

@property (nonatomic) CGAffineTransform affineTransform;
@property (strong, nonatomic) NSString* affineTransformTypeAsString;
@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
