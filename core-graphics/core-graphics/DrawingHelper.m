//
//  DrawingHelper.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "DrawingHelper.h"

#import "Model/ColorParameters.h"
#import "Model/StrokeParameters.h"
#import "Model/AffineTransform/AffineTransformParameters.h"
#import "Model/Fill/FillParameters.h"
#import "Model/Fill/SolidColorFillParameters.h"
#import "Model/Fill/GradientFillParameters.h"
#import "Model/Gradient/GradientParameters.h"
#import "Model/Gradient/GradientStopParameters.h"
#import "Model/Gradient/LinearGradientParameters.h"
#import "Model/Gradient/RadialGradientParameters.h"
#import "Model/Path/ArcParameters.h"
#import "Model/Path/PathParameters.h"
#import "Model/Path/RectangleParameters.h"

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
                      pathParameters:(PathParameters*)pathParameters
{
  // Perform gradient fill before stroking so that stroke draws over the fill
  // => same behaviour as if both solid color fill & stroking is enabled, i.e.
  //    path is drawn with kCGPathFillStroke
  if (fillParameters.fillEnabled && fillParameters.fillType == FillTypeGradient)
  {
    [DrawingHelper gradientFillPathWithContext:context
                                fillParameters:fillParameters
                                pathParameters:pathParameters];
  }

  [DrawingHelper solidColorFillOrStrokePathWithContext:context
                                      strokeParameters:strokeParameters
                                        fillParameters:fillParameters
                                        pathParameters:pathParameters];
}

+ (void) gradientFillPathWithContext:(CGContextRef)context
                      fillParameters:(FillParameters*)fillParameters
                      pathParameters:(PathParameters*)pathParameters
{
  bool shouldGradientFill = fillParameters.fillEnabled && fillParameters.fillType == FillTypeGradient;
  if (! shouldGradientFill)
    return;

  if (fillParameters.gradientFillParameters.clipGradientToPath)
  {
    CGContextSaveGState(context);

    // Path will be cleared below by CGContextClip
    [DrawingHelper addPathToContext:context
                     pathParameters:pathParameters];

    CGContextClip(context);
  }

  [DrawingHelper drawGradientWithContext:context
                      gradientParameters:fillParameters.gradientFillParameters.gradientParameters];

  if (fillParameters.gradientFillParameters.clipGradientToPath)
  {
    // Remove clipping
    CGContextRestoreGState(context);
  }
}

+ (void) solidColorFillOrStrokePathWithContext:(CGContextRef)context
                              strokeParameters:(StrokeParameters*)strokeParameters
                                fillParameters:(FillParameters*)fillParameters
                                pathParameters:(PathParameters*)pathParameters
{
  bool shouldStroke = strokeParameters.strokeEnabled;
  bool shouldSolidColorFill = fillParameters.fillEnabled && fillParameters.fillType == FillTypeSolidColor;
  if (! shouldStroke && ! shouldSolidColorFill)
    return;

  // Path will be cleared below when it is stroked and/or filled
  [DrawingHelper addPathToContext:context
                   pathParameters:pathParameters];

  if (shouldSolidColorFill)
  {
    UIColor* fillColor = [DrawingHelper colorFromColorParameters:fillParameters.solidColorFillParameters.colorParameters];
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    if (! shouldStroke)
    {
      CGContextFillPath(context);
      return;
    }
  }

  if (shouldStroke)
  {
    UIColor* strokeColor = [DrawingHelper colorFromColorParameters:strokeParameters.colorParameters];
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, strokeParameters.lineWidth);
    if (! shouldSolidColorFill)
    {
      CGContextStrokePath(context);
      return;
    }
  }

  if (shouldSolidColorFill && shouldStroke)
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

+ (void) addPathToContext:(CGContextRef)context
           pathParameters:(PathParameters*)pathParameters
{
  if (! pathParameters.pathEnabled)
    return;

  if (pathParameters.pathType == PathTypeArc)
  {
    CGContextAddArc(context,
                    pathParameters.arcParameters.centerX,
                    pathParameters.arcParameters.centerY,
                    pathParameters.arcParameters.radius,
                    [DrawingHelper radians:pathParameters.arcParameters.startAngle],
                    [DrawingHelper radians:pathParameters.arcParameters.endAngle],
                    pathParameters.arcParameters.clockwise);
  }
  else
  {
    CGRect rectangle = CGRectMake(pathParameters.rectangleParameters.originX,
                                  pathParameters.rectangleParameters.originY,
                                  pathParameters.rectangleParameters.width,
                                  pathParameters.rectangleParameters.height);
    CGContextAddRect(context, rectangle);
  }
}

+ (void) drawGradientWithContext:(CGContextRef)context
              gradientParameters:(GradientParameters*)gradientParameters
{
  if (gradientParameters.gradientType == GradientTypeLinear)
  {
    [DrawingHelper drawGradientWithContext:context
                  linearGradientParameters:gradientParameters.linearGradientParameters];
  }
  else
  {
    [DrawingHelper drawGradientWithContext:context
                  radialGradientParameters:gradientParameters.radialGradientParameters];
  }
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
