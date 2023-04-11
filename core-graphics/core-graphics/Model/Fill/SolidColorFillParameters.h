//
//  SolidColorFillParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 11.04.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface SolidColorFillParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property (strong, nonatomic) ColorParameters* colorParameters;

@end

NS_ASSUME_NONNULL_END
