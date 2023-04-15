//
//  RectangleParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RectangleParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property CGFloat originX;
@property (readonly) CGFloat rangeOriginX;

@property CGFloat originY;
@property (readonly) CGFloat rangeOriginY;

@property CGFloat width;
@property (readonly) CGFloat rangeWidth;

@property CGFloat height;
@property (readonly) CGFloat rangeHeight;

@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
