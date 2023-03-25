//
//  DrawingHelper.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "DrawingHelper.h"
#import "Model/ColorParameters.h"
#import "Model/FillParameters.h"
#import "Model/StrokeParameters.h"

@implementation DrawingHelper

+ (CGFloat) radians:(CGFloat)degrees
{
  return degrees * M_PI / 180;
}

+ (CGPoint) centerOfRect:(CGRect)rect
{
  return CGPointMake(CGRectGetMidX(rect),
                     CGRectGetMidY(rect));
}

+ (CGFloat) lesserDimensionOfRect:(CGRect)rect
{
  return MIN(rect.size.width, rect.size.height);
}

//+ (UIColor*) colorFromHexString:(NSString*)hexString
//{
//  if ([hexString length] != 6)
//    return [UIColor blackColor];
//
//  NSRange range = NSMakeRange(0, 2);
//  NSString* redString = [hexString substringWithRange:range];
//  range = NSMakeRange(2, 2);
//  NSString* greenString = [hexString substringWithRange:range];
//  range = NSMakeRange(4, 2);
//  NSString* blueString = [hexString substringWithRange:range];
//
//  unsigned int red;
//  [[NSScanner scannerWithString:redString] scanHexInt:&red];
//  unsigned int green;
//  [[NSScanner scannerWithString:greenString] scanHexInt:&green];
//  unsigned int blue;
//  [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
//
//  return [UIColor colorWithRed:red / 255.0
//                         green:green / 255.0
//                          blue:blue / 255.0
//                         alpha:1.0];
//}

//+ (UIColor*) randomColor
//{
//  CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
//  CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
//  CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
//  return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//}

+ (void) fillOrStrokePathWithContext:(CGContextRef)context
                    strokeParameters:(StrokeParameters*)strokeParameters
                      fillParameters:(FillParameters*)fillParameters
{
  if (fillParameters.fillEnabled)
  {
    UIColor* fillColor = [UIColor colorWithRed:fillParameters.colorParameters.red
                                         green:fillParameters.colorParameters.green
                                          blue:fillParameters.colorParameters.blue
                                         alpha:fillParameters.colorParameters.alpha];
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    if (! strokeParameters.strokeEnabled)
    {
      CGContextFillPath(context);
      return;
    }
  }

  if (strokeParameters.strokeEnabled)
  {
    UIColor* strokeColor = [UIColor colorWithRed:strokeParameters.colorParameters.red
                                           green:strokeParameters.colorParameters.green
                                            blue:strokeParameters.colorParameters.blue
                                           alpha:strokeParameters.colorParameters.alpha];
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, strokeParameters.lineWidth);
    if (! fillParameters.fillEnabled)
    {
      CGContextStrokePath(context);
      return;
    }
  }

  if (fillParameters.fillEnabled && strokeParameters.strokeEnabled)
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
