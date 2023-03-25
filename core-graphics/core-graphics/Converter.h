//
//  Converter.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

@class ColorParameters;

NS_ASSUME_NONNULL_BEGIN

@interface Converter : NSObject

+ (unsigned int) unsignedIntFromStringValue:(NSString*)stringValue;
+ (CGFloat) floatFromStringValue:(NSString*)stringValue;
+ (CGFloat) fractionFromPartValue:(CGFloat)partValue
                       wholeValue:(CGFloat)wholeValue;
+ (CGFloat) fractionFromPartValue:(CGFloat)partValue
                       rangeValue:(CGFloat)rangeValue;
+ (CGFloat) fractionFromPartStringValue:(NSString*)stringValue
                             wholeValue:(CGFloat)wholeValue;
+ (CGFloat) partValueFromFractionValue:(CGFloat)fractionValue
                            wholeValue:(CGFloat)wholeValue;
+ (CGFloat) partValueFromFractionValue:(CGFloat)fractionValue
                            rangeValue:(CGFloat)rangeValue;
+ (CGFloat) colorComponentValueFromFractionValue:(CGFloat)fractionValue;
+ (unsigned int) colorComponentByteValueFromFractionValue:(CGFloat)fractionValue;
+ (CGFloat) colorFractionFromColorComponentStringValue:(NSString*)stringValue;

@end

NS_ASSUME_NONNULL_END
