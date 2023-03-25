//
//  Converter.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "Converter.h"

@interface Converter()
@end

@implementation Converter

#pragma mark - Public API

+ (unsigned int) unsignedIntFromStringValue:(NSString*)stringValue
{
  unsigned int unsignedIntValue;
  [[NSScanner scannerWithString:stringValue] scanHexInt:&unsignedIntValue];
  return unsignedIntValue;
}

+ (CGFloat) floatFromStringValue:(NSString*)stringValue
{
  return [stringValue floatValue];
}

+ (CGFloat) fractionFromPartValue:(CGFloat)partValue
                       wholeValue:(CGFloat)wholeValue
{
  return partValue / wholeValue;
}

+ (CGFloat) fractionFromPartValue:(CGFloat)partValue
                       rangeValue:(CGFloat)rangeValue
{
  if (partValue >= 0.0f)
    partValue += rangeValue;
  CGFloat wholeValue = 2 * rangeValue;
  return [Converter fractionFromPartValue:partValue wholeValue:wholeValue];
}

+ (CGFloat) fractionFromPartStringValue:(NSString*)partStringValue
                             wholeValue:(CGFloat)wholeValue
{
  CGFloat partValue = [Converter floatFromStringValue:partStringValue];
  return [Converter fractionFromPartValue:partValue wholeValue:wholeValue];
}

+ (CGFloat) partValueFromFractionValue:(CGFloat)fractionValue
                            wholeValue:(CGFloat)wholeValue
{
  return fractionValue * wholeValue;
}

+ (CGFloat) partValueFromFractionValue:(CGFloat)fractionValue
                            rangeValue:(CGFloat)rangeValue
{
  CGFloat wholeValue = 2 * rangeValue;
  CGFloat partValue = [Converter partValueFromFractionValue:fractionValue
                                                 wholeValue:wholeValue];
  return partValue - rangeValue;
}

+ (CGFloat) colorComponentValueFromFractionValue:(CGFloat)fractionValue
{
  return [Converter partValueFromFractionValue:fractionValue
                                    wholeValue:255.0f];
}

+ (unsigned int) colorComponentByteValueFromFractionValue:(CGFloat)fractionValue
{
  CGFloat colorComponentValue = [Converter colorComponentValueFromFractionValue:fractionValue];

  if (colorComponentValue < 0)
    return 0;
  else if (colorComponentValue > 255)
    return 255;
  else
    return floorf(colorComponentValue);
}

+ (CGFloat) colorFractionFromColorComponentStringValue:(NSString*)stringValue
{
  CGFloat partValue = [Converter unsignedIntFromStringValue:stringValue];
  return [Converter fractionFromPartValue:partValue wholeValue:255.0f];
}

@end
