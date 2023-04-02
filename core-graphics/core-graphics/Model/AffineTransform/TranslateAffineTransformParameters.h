//
//  TranslateAffineTransformParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 01.04.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TranslateAffineTransformParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

- (void) updateParametersDidChange;

@property CGFloat translateX;
@property (readonly) CGFloat rangeTranslateX;

@property CGFloat translateY;
@property (readonly) CGFloat rangeTranslateY;

@property (nonatomic) CGAffineTransform affineTransform;
@property (strong, nonatomic) NSString* affineTransformTypeAsString;
@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
