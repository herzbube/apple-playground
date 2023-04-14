//
//  StrokeParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;
@class ShadowParameters;

NS_ASSUME_NONNULL_BEGIN

@interface StrokeParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property bool strokeEnabled;

@property CGFloat lineWidth;
@property (readonly) CGFloat maximumLineWidth;

@property (strong, nonatomic) ColorParameters* colorParameters;
@property (strong, nonatomic) ShadowParameters* shadowParameters;

@end

NS_ASSUME_NONNULL_END
