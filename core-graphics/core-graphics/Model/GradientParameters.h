//
//  GradientParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 26.03.23.
//

#import <UIKit/UIKit.h>

@class LinearGradientParameters;
@class RadialGradientParameters;

typedef NS_ENUM(NSInteger, GradientType)
{
  GradientTypeLinear,
  GradientTypeRadial,
};

NS_ASSUME_NONNULL_BEGIN

@interface GradientParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property bool gradientEnabled;
@property GradientType gradientType;
@property (strong, nonatomic) LinearGradientParameters* linearGradientParameters;
@property (strong, nonatomic) RadialGradientParameters* radialGradientParameters;

@end

NS_ASSUME_NONNULL_END
