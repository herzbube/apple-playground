//
//  ShadowParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface ShadowParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property bool shadowEnabled;

@property CGFloat offsetX;
@property (readonly) CGFloat rangeOffsetX;

@property CGFloat offsetY;
@property (readonly) CGFloat rangeOffsetY;

@property CGFloat blur;
@property (readonly) CGFloat maximumBlur;

@property (strong, nonatomic) ColorParameters* colorParameters;

@end

NS_ASSUME_NONNULL_END
