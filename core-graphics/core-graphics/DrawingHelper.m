//
//  DrawingHelper.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "DrawingHelper.h"
#import "Model/AffineTransform/AffineTransformParameters.h"
#import "Model/ColorParameters.h"
#import "Model/FillParameters.h"
#import "Model/GradientStopParameters.h"
#import "Model/LinearGradientParameters.h"
#import "Model/RadialGradientParameters.h"
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

+ (UIColor*) colorFromColorParameters:(ColorParameters*)colorParameters
{
  return [UIColor colorWithRed:colorParameters.red
                         green:colorParameters.green
                          blue:colorParameters.blue
                         alpha:colorParameters.alpha];
}

+ (void) concatTransformWithContext:(CGContextRef)context
          affineTransformParameters:(AffineTransformParameters*)affineTransformParameters
{
  if (! affineTransformParameters.affineTransformEnabled)
    return;

  if (CGAffineTransformIsIdentity(affineTransformParameters.affineTransform))
    return;

  CGContextConcatCTM(context, affineTransformParameters.affineTransform);
}

+ (void) fillOrStrokePathWithContext:(CGContextRef)context
                    strokeParameters:(StrokeParameters*)strokeParameters
                      fillParameters:(FillParameters*)fillParameters
{
  if (fillParameters.fillEnabled)
  {
    UIColor* fillColor = [DrawingHelper colorFromColorParameters:fillParameters.colorParameters];
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    if (! strokeParameters.strokeEnabled)
    {
      CGContextFillPath(context);
      return;
    }
  }

  if (strokeParameters.strokeEnabled)
  {
    UIColor* strokeColor = [DrawingHelper colorFromColorParameters:strokeParameters.colorParameters];
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

CGGradientRef CreateGradient(CGColorSpaceRef colorSpace,
                             GradientStopParameters* gradientStopParameters)
{
  CGFloat locations[] = { gradientStopParameters.position1, gradientStopParameters.position2 };

  UIColor* color1 = [DrawingHelper colorFromColorParameters:gradientStopParameters.colorParameters1];
  UIColor* color2 = [DrawingHelper colorFromColorParameters:gradientStopParameters.colorParameters2];
  NSArray* colors = [NSArray arrayWithObjects:(id)color1.CGColor, (id)color2.CGColor, nil];

  // NSArray is toll-free bridged, so we can simply cast to CGArrayRef
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                      (CFArrayRef)colors,
                                                      locations);
  return gradient;
}

+ (void) drawGradientWithContext:(CGContextRef)context
        linearGradientParameters:(LinearGradientParameters*)linearGradientParameters
{
  CGContextSaveGState(context);
  
  [DrawingHelper concatTransformWithContext:context
                  affineTransformParameters:linearGradientParameters.affineTransformParameters];

  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  CGGradientRef gradient = CreateGradient(colorSpace, linearGradientParameters.gradientStopParameters);

  CGPoint startPoint = CGPointMake(linearGradientParameters.startPointX, linearGradientParameters.startPointY);
  CGPoint endPoint = CGPointMake(linearGradientParameters.endPointX, linearGradientParameters.endPointY);

  CGGradientDrawingOptions gradientDrawingOptions = 0;

  CGContextDrawLinearGradient(context,
                              gradient,
                              startPoint,
                              endPoint,
                              gradientDrawingOptions);

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);

  // Remove transform
  CGContextRestoreGState(context);
}

+ (void) drawGradientWithContext:(CGContextRef)context
        radialGradientParameters:(RadialGradientParameters*)radialGradientParameters
{
  CGContextSaveGState(context);

  [DrawingHelper concatTransformWithContext:context
                  affineTransformParameters:radialGradientParameters.affineTransformParameters];

  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  CGGradientRef gradient = CreateGradient(colorSpace, radialGradientParameters.gradientStopParameters);

  CGPoint startCenter = CGPointMake(radialGradientParameters.startCenterX, radialGradientParameters.startCenterY);
  CGPoint endCenter = CGPointMake(radialGradientParameters.endCenterX, radialGradientParameters.endCenterY);

  CGGradientDrawingOptions gradientDrawingOptions = 0;

  CGContextDrawRadialGradient(context,
                              gradient,
                              startCenter,
                              radialGradientParameters.startRadius,
                              endCenter,
                              radialGradientParameters.endRadius,
                              gradientDrawingOptions);

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);

  // Remove transform
  CGContextRestoreGState(context);
}

@end
