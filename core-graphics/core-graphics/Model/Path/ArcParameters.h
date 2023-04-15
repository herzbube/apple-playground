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

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property CGFloat centerX;
@property (readonly) CGFloat rangeCenterX;

@property CGFloat centerY;
@property (readonly) CGFloat rangeCenterY;

@property CGFloat radius;
@property (readonly) CGFloat rangeRadius;

@property CGFloat startAngle;
@property (readonly) CGFloat maximumStartAngle;

@property CGFloat endAngle;
@property (readonly) CGFloat maximumEndAngle;

@property BOOL clockwise;

@property (strong, nonatomic) NSString* parametersAsString;

@end

NS_ASSUME_NONNULL_END
