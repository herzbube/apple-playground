//
//  GradientStopParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface GradientStopParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property CGFloat position1;
@property (strong, nonatomic) ColorParameters* colorParameters1;

@property CGFloat position2;
@property (strong, nonatomic) ColorParameters* colorParameters2;

@end

NS_ASSUME_NONNULL_END
