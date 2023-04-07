//
//  FillParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;
@class GradientParameters;

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

@property bool fillEnabled;
@property FillType fillType;
@property bool clipGradientToPath;

@property (strong, nonatomic) ColorParameters* colorParameters;
@property (strong, nonatomic) GradientParameters* gradientParameters;

@end

NS_ASSUME_NONNULL_END
