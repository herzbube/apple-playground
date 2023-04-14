//
//  FillParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;
@class GradientFillParameters;
@class SolidColorFillParameters;

typedef NS_ENUM(NSInteger, FillType)
{
  FillTypeSolidColor,
  FillTypeGradient,
};

NS_ASSUME_NONNULL_BEGIN

@interface FillParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

@property bool fillEnabled;
@property FillType fillType;

@property (strong, nonatomic) SolidColorFillParameters* solidColorFillParameters;
@property (strong, nonatomic) GradientFillParameters* gradientFillParameters;

@end

NS_ASSUME_NONNULL_END
