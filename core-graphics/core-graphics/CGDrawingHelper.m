//
//  DrawingHelper.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import "CGDrawingHelper.h"
#import "DrawingHelper.h"
#import "UIColorAdditions.h"

@implementation CGDrawingHelper

#pragma mark - Drawing shapes

// -----------------------------------------------------------------------------
/// @brief Draws a circle with center point @a center and radius @a radius.
/// The circle is either filled, or stroked, or both, or none.
///
/// If @a fillColor is not @e nil the circle is filled with @a fillColor.
///
/// If @a strokeColor is not @e nil the circle is stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// If both @a fillColor and @a strokeColor are not @e nil then the circle
/// is both filled and stroked.
///
/// If both @a fillColor and @a strokeColor are @e nil then this function
/// only creates a path without adding any visuals. It is up to the caller to
/// do something with the path (e.g. clipping).
// -----------------------------------------------------------------------------
+ (void) drawCircleWithContext:(CGContextRef)context
                        center:(CGPoint)center
                        radius:(CGFloat)radius
                     fillColor:(UIColor*)fillColor
                   strokeColor:(UIColor*)strokeColor
               strokeLineWidth:(CGFloat)strokeLineWidth
{
  const CGFloat startRadius = [DrawingHelper radians:0];
  const CGFloat endRadius = [DrawingHelper radians:360];
  const int clockwise = 0;
  CGContextAddArc(context,
                  center.x,
                  center.y,
                  radius,
                  startRadius,
                  endRadius,
                  clockwise);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:fillColor
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws a circle with center point @a center and radius @a radius.
/// The circle represents a Go stone with color @a stoneColor.
///
/// If @a stoneColor is #GoColorBlack then the circle is filled with black
/// color. The circle is not stroked.
///
/// If @a stoneColor is #GoColorWhite then the circle is filled with white
/// color. The circle is stroked with black color, using the stroke line
/// width @a strokeLineWidth.
///
/// If @a stoneColor is #GoColorNone then the circle is not filled. The
/// circle is stroked with black color, using the stroke line width
/// @a strokeLineWidth.
// -----------------------------------------------------------------------------
+ (void) drawStoneCircleWithContext:(CGContextRef)context
                             center:(CGPoint)center
                             radius:(CGFloat)radius
                         stoneColor:(enum GoColor)stoneColor
                    strokeLineWidth:(CGFloat)strokeLineWidth
{
  UIColor* fillColor;
  UIColor* strokeColor;
  [CGDrawingHelper fillAndStrokeColorsForStoneColor:stoneColor fillColor:&fillColor strokeColor:&strokeColor];

  [CGDrawingHelper drawCircleWithContext:context
                                  center:center
                                  radius:radius
                               fillColor:fillColor
                             strokeColor:strokeColor
                         strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws a rectangle with origin and size specified by @a rectangle.
/// The rectangle is either filled, or stroked, or both, or none.
///
/// If @a fillColor is not @e nil the rectangle is filled with @a fillColor.
///
/// If @a strokeColor is not @e nil the rectangle is stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// If both @a fillColor and @a strokeColor are not @e nil then the rectangle
/// is both filled and stroked.
///
/// If both @a fillColor and @a strokeColor are @e nil then this function
/// only creates a path without adding any visuals. It is up to the caller to
/// do something with the path (e.g. clipping).
// -----------------------------------------------------------------------------
+ (void) drawRectangleWithContext:(CGContextRef)context
                        rectangle:(CGRect)rectangle
                        fillColor:(UIColor*)fillColor
                      strokeColor:(UIColor*)strokeColor
                  strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGContextAddRect(context, rectangle);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:fillColor
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws a rectangle with origin and size specified by @a rectangle.
/// The rectangle uses a fill/stroke color scheme that corresponds to a Go stone
/// with color @a stoneColor.
///
/// If @a stoneColor is #GoColorBlack then the rectangle is filled with black
/// color. The rectangle is not stroked.
///
/// If @a stoneColor is #GoColorWhite then the rectangle is filled with white
/// color. The rectangle is stroked with black color, using the stroke line
/// width @a strokeLineWidth.
///
/// If @a stoneColor is #GoColorNone then the rectangle is not filled. The
/// rectangle is stroked with black color, using the stroke line width
/// @a strokeLineWidth.
// -----------------------------------------------------------------------------
+ (void) drawStoneRectangleWithContext:(CGContextRef)context
                             rectangle:(CGRect)rectangle
                            stoneColor:(enum GoColor)stoneColor
                       strokeLineWidth:(CGFloat)strokeLineWidth
{
  UIColor* fillColor;
  UIColor* strokeColor;
  [CGDrawingHelper fillAndStrokeColorsForStoneColor:stoneColor fillColor:&fillColor strokeColor:&strokeColor];

  [CGDrawingHelper drawRectangleWithContext:context
                                  rectangle:rectangle
                                  fillColor:fillColor
                                strokeColor:strokeColor
                            strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws a rectangle with rounded corners with origin and size specified
/// by @a rectangle. @a cornerRadius specifies the width and height of the
/// rounded corner sections. The rectangle is either filled, or stroked, or
/// both, or none.
///
/// If @a fillColor is not @e nil the rectangle is filled with @a fillColor.
///
/// If @a strokeColor is not @e nil the rectangle is stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// If both @a fillColor and @a strokeColor are not @e nil then the rectangle
/// is both filled and stroked.
///
/// If both @a fillColor and @a strokeColor are @e nil then this function
/// only creates a path without adding any visuals. It is up to the caller to
/// do something with the path (e.g. clipping).
// -----------------------------------------------------------------------------
+ (void) drawRoundedRectangleWithContext:(CGContextRef)context
                               rectangle:(CGRect)rectangle
                            cornerRadius:(CGSize)cornerRadius
                               fillColor:(UIColor*)fillColor
                             strokeColor:(UIColor*)strokeColor
                         strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGPathRef roundedRectanglePath = CGPathCreateWithRoundedRect(rectangle,
                                                               cornerRadius.width,
                                                               cornerRadius.height,
                                                               NULL);
  CGContextAddPath(context, roundedRectanglePath);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:fillColor
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];

  CGPathRelease(roundedRectanglePath);
}

// -----------------------------------------------------------------------------
/// @brief Draws a triangle that fits within a rectangle with origin and size
/// specified by @a rectangle. The triangle is either filled, or stroked,
/// or both, or none.
///
/// The following diagram illustrates how the triangle is drawn. The path
/// consists of three lines, the first going from A to B, the second going from
/// B to C, the third going from C to A.
/// @verbatim
/// Draw path from A => B => C
///     C
///     /\ <-----+
///    /  \      | rectangle.size.height
/// A /____\ B <-+
///   ^    ^
///   +----+
///   rectangle.size.width
/// @endverbatim
///
/// If @a fillColor is not @e nil the triangle is filled with @a fillColor.
///
/// If @a strokeColor is not @e nil the triangle is stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// If both @a fillColor and @a strokeColor are not @e nil then the triangle
/// is both filled and stroked.
///
/// If both @a fillColor and @a strokeColor are @e nil then this function
/// only creates a path without adding any visuals. It is up to the caller to
/// do something with the path (e.g. clipping).
// -----------------------------------------------------------------------------
+ (void) drawTriangleWithContext:(CGContextRef)context
                 insideRectangle:(CGRect)rectangle
                       fillColor:(UIColor*)fillColor
                     strokeColor:(UIColor*)strokeColor
                 strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGContextBeginPath(context);

  CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y + rectangle.size.height);
  CGContextAddLineToPoint(context, rectangle.origin.x + rectangle.size.width, rectangle.origin.y + rectangle.size.height);
  CGContextAddLineToPoint(context, rectangle.origin.x + floorf(rectangle.size.width / 2.0f), rectangle.origin.y);
  CGContextAddLineToPoint(context, rectangle.origin.x, rectangle.origin.y + rectangle.size.height);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:fillColor
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws an "X" symbol that fits within a rectangle with origin and size
/// specified by @a rectangle. The lines of the symbol are stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// The following diagram illustrates how the "X" symbol is drawn. The path
/// consists of two lines, the first going from A to B, the second going from
/// C to D.
/// @verbatim
/// C o     o B  <-+
///    \   /       |
///     \ /        |
///      o         | rectangle.size.height
///     / \        |
///    /   \       |
/// A o     o D  <-+
///   ^     ^
///   +-----+
///   rectangle.size.width
/// @endverbatim
// -----------------------------------------------------------------------------
+ (void) drawSymbolXWithContext:(CGContextRef)context
                insideRectangle:(CGRect)rectangle
                    strokeColor:(UIColor*)strokeColor
                strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGContextBeginPath(context);

  CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y + rectangle.size.height);
  CGContextAddLineToPoint(context, rectangle.origin.x + rectangle.size.width, rectangle.origin.y);

  CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y);
  CGContextAddLineToPoint(context, rectangle.origin.x + rectangle.size.width, rectangle.origin.y + rectangle.size.height);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:nil
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws an "X" symbol that fits within a square with center point
/// @a center and side length that is 2 * @a symbolSize. The lines of the symbol
/// are stroked with @a strokeColor, using the stroke line width
/// @a strokeLineWidth.
///
/// The following diagram illustrates how the "X" symbol is drawn. The path
/// consists of two lines, the first going from A to B, the second going from
/// C to D.
/// @verbatim
/// C o     o B
///    \   /
///     \ /
///      o <-- center
///     / \
///    /   \
/// A o     o D
///   ^     ^
///   +-----+
///    symbolSize * 2
/// @endverbatim
// -----------------------------------------------------------------------------
+ (void) drawSymbolXWithContext:(CGContextRef)context
                         center:(CGPoint)center
                     symbolSize:(CGFloat)symbolSize
                    strokeColor:(UIColor*)strokeColor
                strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGContextBeginPath(context);

  CGContextMoveToPoint(context, center.x - symbolSize, center.y + symbolSize);
  CGContextAddLineToPoint(context, center.x + symbolSize, center.y - symbolSize);

  CGContextMoveToPoint(context, center.x - symbolSize, center.y - symbolSize);
  CGContextAddLineToPoint(context, center.x + symbolSize, center.y + symbolSize);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:nil
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws a checkmark symbol that fits within a rectangle with origin
/// and size specified by @a rectangle. The lines of the symbol are stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// The following diagram illustrates how the checkmark symbol is drawn. The
/// path consists of two lines, the first going from A to B, the second going
/// from B to C.
/// @verbatim
///         C
///        /   <-+
///  A    / ^    | rectangle.size.height
///   \  /  |    |
///    \/   |  <-+
///     B   |
///  ^      |
///  +------+
///  rectangle.size.width
/// @endverbatim
// -----------------------------------------------------------------------------
+ (void) drawCheckmarkWithContext:(CGContextRef)context
                  insideRectangle:(CGRect)rectangle
                      strokeColor:(UIColor*)strokeColor
                  strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGContextBeginPath(context);

  CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y + floorf(2.0f * rectangle.size.height / 3.0f));
  CGContextAddLineToPoint(context, rectangle.origin.x + floorf(rectangle.size.width / 3.0f), rectangle.origin.y + rectangle.size.height);
  CGContextAddLineToPoint(context, rectangle.origin.x + rectangle.size.width, rectangle.origin.y);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:nil
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

// -----------------------------------------------------------------------------
/// @brief Draws a line between the two points @a startPoint and @e endPoint.
/// The line is stroked with @a strokeColor, using the stroke line width
/// @a strokeLineWidth.
// -----------------------------------------------------------------------------
+ (void) drawLineWithContext:(CGContextRef)context
                   fromPoint:(CGPoint)startPoint
                     toPoint:(CGPoint)endPoint
                 strokeColor:(UIColor*)strokeColor
             strokeLineWidth:(CGFloat)strokeLineWidth
{
  CGContextBeginPath(context);

  CGContextMoveToPoint(context, startPoint.x, startPoint.y);
  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);

  [CGDrawingHelper fillOrStrokePathWithContext:context
                                     fillColor:nil
                                   strokeColor:strokeColor
                               strokeLineWidth:strokeLineWidth];
}

#pragma mark - Filling and stroking

// -----------------------------------------------------------------------------
/// @brief Fills and/or strokes an existing path.
///
/// If @a fillColor is not @e nil the path is filled with @a fillColor.
///
/// If @a strokeColor is not @e nil the path is stroked with
/// @a strokeColor, using the stroke line width @a strokeLineWidth.
///
/// If both @a fillColor and @a strokeColor are not @e nil then the path
/// is both filled and stroked.
///
/// If both @a fillColor and @a strokeColor are @e nil then this function
/// does nothing.
// -----------------------------------------------------------------------------
+ (void) fillOrStrokePathWithContext:(CGContextRef)context
                           fillColor:(UIColor*)fillColor
                         strokeColor:(UIColor*)strokeColor
                     strokeLineWidth:(CGFloat)strokeLineWidth
{
  if (fillColor)
  {
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    if (! strokeColor)
    {
      CGContextFillPath(context);
      return;
    }
  }

  if (strokeColor)
  {
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, strokeLineWidth);
    if (! fillColor)
    {
      CGContextStrokePath(context);
      return;
    }
  }

  if (fillColor && strokeColor)
    CGContextDrawPath(context, kCGPathFillStroke);
}

// -----------------------------------------------------------------------------
/// @brief Fills the out parameters @a fillColor and @a strokeColor with
/// fill/and or stroke colors that can be used to draw a Go stone with color
/// @a stoneColor.
///
/// If @a stoneColor is #GoColorBlack then both @a fillColor and @a strokeColor
/// are set to black. Note that the black stone must also be stroked to make it
/// the same size as the white stone.
///
/// If @a stoneColor is #GoColorWhite then @a fillColor is set to white and
/// @a strokeColor is set to black.
///
/// If @a stoneColor is #GoColorNone then @a fillColor is set to @e nil and
/// @a strokeColor is set to black.
// -----------------------------------------------------------------------------
+ (void) fillAndStrokeColorsForStoneColor:(enum GoColor)stoneColor
                                fillColor:(UIColor**)fillColor
                              strokeColor:(UIColor**)strokeColor
{
  if (stoneColor == GoColorBlack)
  {
    *fillColor = [UIColor blackColor];
    *strokeColor = [UIColor blackColor];
  }
  else if (stoneColor == GoColorWhite)
  {
    *fillColor = [UIColor whiteColor];
    *strokeColor = [UIColor blackColor];
  }
  else
  {
    *fillColor = nil;
    *strokeColor = [UIColor blackColor];
  }
}

#pragma mark - Drawing images

// -----------------------------------------------------------------------------
/// @brief Draws a bitmap image within the rectangle with origin and size
/// specified by @a rectangle. The bitmap image is resized so that it fits
/// within the rectangle. The image is a custom image located in a bundle
/// resource file or an asset catalog. The image name is @a imageName.
// -----------------------------------------------------------------------------
+ (void) drawImageWithContext:(CGContextRef)context
                       inRect:(CGRect)rectangle
                    imageName:(NSString*)imageName
{
  UIImage* image = [UIImage imageNamed:imageName];
  [CGDrawingHelper drawImageWithContext:context inRect:rectangle image:image];
}

// -----------------------------------------------------------------------------
/// @brief Draws a bitmap image within the rectangle with origin and size
/// specified by @a rectangle. The bitmap image is resized so that it fits
/// within the rectangle. The image is a system-defined symbol image. The image
/// name is @a imageName.
// -----------------------------------------------------------------------------
+ (void) drawSystemImageWithContext:(CGContextRef)context
                             inRect:(CGRect)rectangle
                          imageName:(NSString*)imageName
{
  UIImage* image = [UIImage systemImageNamed:imageName];
  [CGDrawingHelper drawImageWithContext:context inRect:rectangle image:image];
}

// -----------------------------------------------------------------------------
/// @brief Draws the bitmap image @a image within the rectangle with origin and
/// size specified by @a rectangle. The bitmap image is resized so that it fits
/// within the rectangle.
// -----------------------------------------------------------------------------
+ (void) drawImageWithContext:(CGContextRef)context
                       inRect:(CGRect)rectangle
                        image:(UIImage*)image
{
  // Let UIImage do all the drawing for us. This includes 1) compensating for
  // coordinate system differences (if we use CGContextDrawImage() the image
  // is drawn upside down); and 2) for scaling.
  UIGraphicsPushContext(context);
  [image drawInRect:rectangle];
  UIGraphicsPopContext();
}

#pragma mark - Drawing strings

// -----------------------------------------------------------------------------
/// @brief Draws the string @a string using the attributes @a textAttributes.
/// The string is drawn both horizontally and vertically centered within the
/// rectangle with origin and size specified by @a rectangle. The string is not
/// clipped to the bounds defined by @a rectangle.
// -----------------------------------------------------------------------------
+ (void) drawStringWithContext:(CGContextRef)context
                centeredInRect:(CGRect)rectangle
                        string:(NSString*)string
                textAttributes:(NSDictionary*)textAttributes
{
  return [CGDrawingHelper drawStringWithContext:context
                                 centeredInRect:rectangle
                            rotatedCcwByDegrees:0.0f
                                         string:string
                                 textAttributes:textAttributes];
}

// -----------------------------------------------------------------------------
/// @brief Draws the string @a string using the attributes @a textAttributes.
/// The string is drawn both horizontally and vertically centered within the
/// rectangle with origin and size specified by @a rectangle. The string is
/// rotated counter-clockwise by @a degrees, with the rotation center being the
/// center of @a rectangle, which is the same as the center of the rendered text
/// itself. The string is not clipped to the bounds defined by @a rectangle.
// -----------------------------------------------------------------------------
+ (void) drawStringWithContext:(CGContextRef)context
                centeredInRect:(CGRect)rectangle
           rotatedCcwByDegrees:(CGFloat)degrees
                        string:(NSString*)string
                textAttributes:(NSDictionary*)textAttributes
{
  CGRect boundingBox = CGRectZero;
  boundingBox.size = [string sizeWithAttributes:textAttributes];

  CGPoint centerOfRectangle = CGPointMake(CGRectGetMidX(rectangle), CGRectGetMidY(rectangle));
  CGPoint centerOfBoundingBox = CGPointMake(CGRectGetMidX(boundingBox), CGRectGetMidY(boundingBox));

  CGRect drawingRect = CGRectZero;
  // Use the bounding box size for drawing so that the string is not clipped
  drawingRect.size = boundingBox.size;
  // Set the drawing origin so that the text is centered both horizontally and
  // vertically. Horizontal centering could also be achieved via text attributes
  // (with a paragraph style that uses NSTextAlignmentCenter), but vertical
  // centering cannot.
  drawingRect.origin.x = centerOfRectangle.x - centerOfBoundingBox.x;
  drawingRect.origin.y = centerOfRectangle.y - centerOfBoundingBox.y;

  bool shouldRotate = degrees != 0.0f;
  if (shouldRotate)
  {
    CGFloat angle = [DrawingHelper radians:360 - degrees];
    CGPoint rotationCenter = centerOfRectangle;

    CGContextSaveGState(context);

    // Shift the CTM to make the rotation center the origin
    CGContextTranslateCTM(context, rotationCenter.x, rotationCenter.y);
    CGContextRotateCTM(context, angle);
    // Undo the shift
    CGContextTranslateCTM(context, -rotationCenter.x, -rotationCenter.y);
  }

  // NSString's drawInRect:withAttributes: is a UIKit drawing function. To make
  // it work we need to push the specified drawing context to the top of the
  // UIKit context stack (which is currently empty).
  UIGraphicsPushContext(context);
  [string drawInRect:drawingRect withAttributes:textAttributes];
  UIGraphicsPopContext();

  if (shouldRotate)
    CGContextRestoreGState(context);
}

#pragma mark - Drawing gradients

// -----------------------------------------------------------------------------
/// @brief Draws a radial gradient with only two colors, @a startColor and
/// @a endColor, which are set at the gradient stops 0.0 and 1.0, respectively.
/// The gradient start circle (aka focal circle) is defined by @a startCenter
/// and a radius of length zero. The gradient end circle, which effectively is
/// an ellipse, is defined by @a endCenter and a base radius @a endRadius,
/// which is then scaled in x- and y-direction by @a endRadiusScaleFactorX and
/// @a endRadiusScaleFactorY, respectively, to give the end circle its
/// elliptical form.
///
/// This method imitates the Inkscape user interface which allows the user to
/// give the end circle an elliptical form by defining different lengths for the
/// end circle radius in x- and y-direction. How is it possible to have two
/// radius values, given that in the underlying SVG source, the end circle can
/// have only one radius value (SVG attribute @e r)? Inkscape solves this by
/// setting the SVG attribute @e gradientTransform with an affine transform that
/// has scaling factors in x- and y-direction, resulting in the end circle
/// radius (SVG attribute @e r) to have different values in the two directions.
/// But Inkscape then also adds translation to the affine transform to reverse
/// the effect that the scaling has on the location of the start/end circle
/// centers. Because the radius of the start (= focal) circle is always zero, it
/// is unaffected by the scaling.
///
/// To achieve its task, this method duplicates Inkscape's behaviour: It
/// temporarily applies the affine transform describe above to the CTM of
/// @a context, draws the gradient, and then restores the original CTM of
/// @a context.
///
/// @see drawRadialGradientWithContext:startColor:endColor:startCenter:startRadius:endCenter:endRadius:()
/// for details how to match method parameters to the SVG model for drawing
/// radial gradients:
// -----------------------------------------------------------------------------
+ (void) drawRadialGradientWithContext:(CGContextRef)context
                            startColor:(UIColor*)startColor
                              endColor:(UIColor*)endColor
                           startCenter:(CGPoint)startCenter
                             endCenter:(CGPoint)endCenter
                             endRadius:(CGFloat)endRadius
                 endRadiusScaleFactorX:(CGFloat)endRadiusScaleFactorX
                 endRadiusScaleFactorY:(CGFloat)endRadiusScaleFactorY
{
  CGFloat a = endRadiusScaleFactorX;
  CGFloat b = 0.0;
  CGFloat c = 0.0;
  CGFloat d = endRadiusScaleFactorY;
  // Translation is used to move the start/end centers back to their original
  // position
  CGFloat tx = endRadius - endRadius * endRadiusScaleFactorX;
  CGFloat ty = endRadius - endRadius * endRadiusScaleFactorY;
  CGAffineTransform affineTransform = CGAffineTransformMake(a, b, c, d, tx, ty);

  CGPoint startCenterBeforeTransform = CGPointMake((startCenter.x - tx) / a,
                                                   (startCenter.y - ty) / d);
  CGPoint endCenterBeforeTransform = CGPointMake((endCenter.x - tx) / a,
                                                 (endCenter.y - ty) / d);

  CGContextSaveGState(context);

  CGContextConcatCTM(context, affineTransform);

  [CGDrawingHelper drawRadialGradientWithContext:context
                                      startColor:startColor
                                        endColor:endColor
                                     startCenter:startCenterBeforeTransform
                                     startRadius:0.0f
                                       endCenter:endCenterBeforeTransform
                                       endRadius:endRadius];
  // Remove transform
  CGContextRestoreGState(context);
}

// -----------------------------------------------------------------------------
/// @brief Draws a radial gradient with only two colors, @a startColor and
/// @a endColor, which are set at the gradient stops 0.0 and 1.0, respectively.
/// The gradient start circle (aka focal circle) is defined by @a startCenter
/// and @a startRadius, and the gradient end circle is defined by @a endCenter.
///
/// The parameters of this method can be matched as follows to the SVG model
/// for drawing radial gradients:
/// - @a startCenter corresponds to the SVG attributes @e fx and @e fy
///   (prefix "f" referring to the term "focal").
/// - @a startRadius corresponds to the SVG attribute @e fr.
/// - @a endCenter corresponds to the SVG attributes @e cx and @e cy.
/// - @a endRadius corresponds to the SVG attribute @e r.
///
/// The SVG attribute @e gradientTransform, is not a parameter of this method
/// by design. If an affine transform is desired, it must be applied to
/// @a context prior to invoking this method.
///
/// The following SVG attributes are not part of this API because they don't
/// make sense for the CoreGraphics drawing model:
/// - @e gradientUnits
/// - @e spreadMethod
///
/// @see https://svgwg.org/svg2-draft/pservers.html#RadialGradients
// -----------------------------------------------------------------------------
+ (void) drawRadialGradientWithContext:(CGContextRef)context
                            startColor:(UIColor*)startColor
                              endColor:(UIColor*)endColor
                           startCenter:(CGPoint)startCenter
                           startRadius:(CGFloat)startRadius
                             endCenter:(CGPoint)endCenter
                             endRadius:(CGFloat)endRadius
{
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  NSArray* colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
  CGFloat locations[] = { 0.0, 1.0 };

  // NSArray is toll-free bridged, so we can simply cast to CGArrayRef
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                      (CFArrayRef)colors,
                                                      locations);

  CGContextDrawRadialGradient(context,
                              gradient,
                              startCenter,
                              startRadius,
                              endCenter,
                              endRadius,
                              0);

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

#pragma mark - Setting and removing clipping paths

// -----------------------------------------------------------------------------
/// @brief Configures the drawing context @a context with a circular clipping
/// path with center point @a center and radius @a radius. Drawing takes place
/// only within the circular area defined by the clipping path. Invocation of
/// this method must be balanced by also invoking
/// removeClippingPathWithContext:().
// -----------------------------------------------------------------------------
+ (void) setCircularClippingPathWithContext:(CGContextRef)context
                                     center:(CGPoint)center
                                     radius:(CGFloat)radius
{
  CGContextSaveGState(context);

  [CGDrawingHelper drawCircleWithContext:context
                                  center:center
                                  radius:radius
                               fillColor:nil
                             strokeColor:nil
                         strokeLineWidth:0.0f];
  CGContextClip(context);
}

// -----------------------------------------------------------------------------
/// @brief Configures the drawing context @a context with two concentric
/// circles with the radii @a innerRadius and @a outerRadius, both of which
/// share the center point @a center. Drawing that takes place within the outer
/// circle's area is clipped so that nothing is drawn within the inner circle's
/// area. Invocation of this method must be balanced by also invoking
/// removeClippingPathWithContext:().
// -----------------------------------------------------------------------------
+ (void) setCircularClippingPathWithContext:(CGContextRef)context
                                     center:(CGPoint)center
                                innerRadius:(CGFloat)innerRadius
                                outerRadius:(CGFloat)outerRadius
{
  CGContextSaveGState(context);

  // To draw OUTSIDE of a given area, first set a path that defines the entire
  // drawing area, then set a second path that defines the area to exclude, then
  // set the clipping path using the even-odd (EO) rule. Solution found here:
  // https://www.kodeco.com/349664-core-graphics-tutorial-arcs-and-paths
  [CGDrawingHelper drawCircleWithContext:context
                                  center:center
                                  radius:outerRadius
                               fillColor:nil
                             strokeColor:nil
                         strokeLineWidth:0.0f];
  [CGDrawingHelper drawCircleWithContext:context
                                  center:center
                                  radius:innerRadius
                               fillColor:nil
                             strokeColor:nil
                         strokeLineWidth:0.0f];
  CGContextEOClip(context);
}

// -----------------------------------------------------------------------------
/// @brief Configures the drawing context @a context with an inner circular area
/// with center point @a center and radius @a radius, and an outer rectangular
/// area with origin and size specified by @a outerRectangle. The inner circular
/// area is fully surrounded by the outer rectangular area. Drawing that takes
/// place within the outer rectangular area is clipped so that nothing is drawn
/// within the inner circular area. Invocation of this method must be balanced
/// by also invoking removeClippingPathWithContext:().
// -----------------------------------------------------------------------------
+ (void) setCircularClippingPathWithContext:(CGContextRef)context
                                     center:(CGPoint)center
                                     radius:(CGFloat)radius
                             outerRectangle:(CGRect)outerRectangle
{
  CGContextSaveGState(context);

  // To draw OUTSIDE of a given area, first set a path that defines the entire
  // drawing area, then set a second path that defines the area to exclude, then
  // set the clipping path using the even-odd (EO) rule. Solution found here:
  // https://www.kodeco.com/349664-core-graphics-tutorial-arcs-and-paths
  [CGDrawingHelper drawRectangleWithContext:context
                                  rectangle:outerRectangle
                                  fillColor:nil
                                strokeColor:nil
                            strokeLineWidth:0.0f];
  [CGDrawingHelper drawCircleWithContext:context
                                  center:center
                                  radius:radius
                               fillColor:nil
                             strokeColor:nil
                         strokeLineWidth:0.0f];
  CGContextEOClip(context);
}

// -----------------------------------------------------------------------------
/// @brief Configures the drawing context @a context with a rectangular clipping
/// path with origin and size specified by @a rectangle. Drawing takes place
/// only within the rectangular area defined by the clipping path. Invocation
/// of this method must be balanced by also invoking
/// removeClippingPathWithContext:().
// -----------------------------------------------------------------------------
+ (void) setRectangularClippingPathWithContext:(CGContextRef)context
                                     rectangle:(CGRect)rectangle
{
  CGContextSaveGState(context);

  [CGDrawingHelper drawRectangleWithContext:context
                                  rectangle:rectangle
                                  fillColor:nil
                                strokeColor:nil
                            strokeLineWidth:0.0f];
  CGContextClip(context);
}

// -----------------------------------------------------------------------------
/// @brief Configures the drawing context @a context with an inner and an outer
/// rectangular area whose origins and sizes are specified by @a innerRectangle
/// and @a outerRectangle, respectively. The inner rectangular area is fully
/// surrounded by the outer rectangular area. Drawing that takes place within
/// the outer rectangular area is clipped so that nothing is drawn within the
/// area of the inner rectangular area. Invocation of this method must be
/// balanced by also invoking removeClippingPathWithContext:().
// -----------------------------------------------------------------------------
+ (void) setRectangularClippingPathWithContext:(CGContextRef)context
                                innerRectangle:(CGRect)innerRectangle
                                outerRectangle:(CGRect)outerRectangle
{
  CGContextSaveGState(context);

  // To draw OUTSIDE of a given area, first set a path that defines the entire
  // drawing area, then set a second path that defines the area to exclude, then
  // set the clipping path using the even-odd (EO) rule. Solution found here:
  // https://www.kodeco.com/349664-core-graphics-tutorial-arcs-and-paths
  [CGDrawingHelper drawRectangleWithContext:context
                                  rectangle:outerRectangle
                                  fillColor:nil
                                strokeColor:nil
                            strokeLineWidth:0.0f];
  [CGDrawingHelper drawRectangleWithContext:context
                                  rectangle:innerRectangle
                                  fillColor:nil
                                strokeColor:nil
                            strokeLineWidth:0.0f];
  CGContextEOClip(context);
}

// -----------------------------------------------------------------------------
/// @brief Configures the drawing context @a context with an inner rectangular
/// area with origin and size specified by @a innerRectangle, and an outer
/// circular area with center point @a center and radius @a radius. The inner
/// rectangular area is fully surrounded by the outer circular area. Drawing
/// that takes place within the outer circular area is clipped so that nothing
/// is drawn within the inner rectangular area. Invocation of this method must
/// be balanced by also invoking removeClippingPathWithContext:().
// -----------------------------------------------------------------------------
+ (void) setRectangularClippingPathWithContext:(CGContextRef)context
                                innerRectangle:(CGRect)innerRectangle
                                        center:(CGPoint)center
                                        radius:(CGFloat)radius
{
  CGContextSaveGState(context);

  // To draw OUTSIDE of a given area, first set a path that defines the entire
  // drawing area, then set a second path that defines the area to exclude, then
  // set the clipping path using the even-odd (EO) rule. Solution found here:
  // https://www.kodeco.com/349664-core-graphics-tutorial-arcs-and-paths
  [CGDrawingHelper drawCircleWithContext:context
                                  center:center
                                  radius:radius
                               fillColor:nil
                             strokeColor:nil
                         strokeLineWidth:0.0f];
  [CGDrawingHelper drawRectangleWithContext:context
                                  rectangle:innerRectangle
                                  fillColor:nil
                                strokeColor:nil
                            strokeLineWidth:0.0f];
  CGContextEOClip(context);
}

// -----------------------------------------------------------------------------
/// @brief Removes a previously configured clipping path from the drawing
/// context @a context. Invocation of this method balances a previous invocation
/// of any of the set...ClippingPathWithContext:() methods.
// -----------------------------------------------------------------------------
+ (void) removeClippingPathWithContext:(CGContextRef)context
{
  // Clipping can only be removed by restoring a previously saved graphics
  // state
  CGContextRestoreGState(context);
}

#pragma mark - Calculating points, sizes and rectangles

//// -----------------------------------------------------------------------------
///// @brief Returns the rectangle occupied by @a tile on the "canvas", i.e. the
///// entire drawing area covered by a tiled view. The origin is in the upper-left
///// corner. The tile with row/column = 0/0 is assumed to contain the origin.
//// -----------------------------------------------------------------------------
//+ (CGRect) canvasRectForTile:(id<Tile>)tile
//                    withSize:(CGSize)tileSize
//{
//  CGRect canvasRect = CGRectZero;
//  canvasRect.size = tileSize;
//  canvasRect.origin.x = tile.column * tileSize.width;
//  canvasRect.origin.y = tile.row * tileSize.height;
//  return canvasRect;
//}
//
//// -----------------------------------------------------------------------------
///// @brief Returns the rectangle that must be passed to CGContextDrawLayerInRect
///// for drawing the specified layer, which must have a size that is scaled up
///// using @a contentScale.
//// -----------------------------------------------------------------------------
//+ (CGRect) drawingRectForScaledLayer:(CGLayerRef)layer
//                   withContentsScale:(CGFloat)contentsScale
//{
//  CGSize drawingSize = CGLayerGetSize(layer);
//  drawingSize.width /= contentsScale;
//  drawingSize.height /= contentsScale;
//
//  CGRect drawingRect;
//  drawingRect.origin = CGPointZero;
//  drawingRect.size = drawingSize;
//
//  return drawingRect;
//}
//
//// -----------------------------------------------------------------------------
///// @brief Translates the origin of @a canvasRect (a rectangle on the "canvas",
///// i.e. the entire drawing area covered by a tiled view) into the coordinate
///// system of the tile described by @a tileRect (the rectangle on the "canvas"
///// occupied by the tile). The origin is in the upper-left corner.
//// -----------------------------------------------------------------------------
//+ (CGRect) drawingRectFromCanvasRect:(CGRect)canvasRect
//                      inTileWithRect:(CGRect)tileRect
//{
//  CGRect drawingRect = canvasRect;
//  drawingRect.origin.x -= tileRect.origin.x;
//  drawingRect.origin.y -= tileRect.origin.y;
//  return drawingRect;
//}


// -----------------------------------------------------------------------------
/// @brief Creates and returns a CGLayer object that is associated with graphics
/// context @a context and contains the drawing operations to draw a stone
/// played by @a playerColor. @a isCrossHairStone indicates whether the stone
/// has its natural color or uses a special cross-hair stone color. The
/// available size for drawing the stone is @a size - the CGLayer returned by
/// this function therefore has size @a size.
///
/// If @a size is not square, then the smaller dimension is used to limit the
/// stone circle size.
///
/// @note Whoever invokes this function is responsible for releasing the
/// returned CGLayer object using the function CGLayerRelease when the layer is
/// no longer needed.
///
/// @note The result of this method approximates the images in the resource
/// files stone-black.png, stone-white.png and stone-crosshair.png, which were
/// produced by exporting SVG graphics from Inkscape (see the MediaFiles text
/// file in the documentation for details on the process). Each of the images
/// originally consists of 3 SVG layers: A shadow layer at the bottom, the
/// actual stone layer above the shadow layer, and a highlight layer at the top.
/// The SVG source in stones.svg was analyzed manually to obtain the numbers
/// that are used in the implementation of this method and its sub-methods. The
/// implementation is written so that stones of variable size can be drawn while
/// all aspects of the stone image are scaled to the desired target size.
/// - All layers use a circle to represent a stone. The circle has a fixed
///   radius <r>.
/// - Shadow layer: In SVG this is done with a gaussian blur applied to the
///   stone circle. Core Graphics does not have a gaussian blur function, it
///   only allows to generate a shadow with an amount of blur for the fill
///   and/or stroke of a path. This method approximates the SVG gaussian blur
///   shadow by drawing a Core Graphics shadow for the filled stone, with
///   experimentally determined blur and offset numbers so that the result looks
///   approximately the same as in the SVG original.
/// - Stone layer: This uses a radial gradient with solid colors, to the effect
///   that the entire stone circle is filled. The focus of the radial gradient
///   is located a certain distance above the stone circle center which results
///   in a moderate lighting effect as if the light source is above the stone.
///   To allow for variable stone sizes, the distance of the gradient focus
///   above the stone circle center can be expressed as a percentage of the
///   stone circle radius. The percentage used in the implementation of this
///   method was determined with the measuring tool in Inkscape.
/// - Highlight layer: This uses another radial gradient, but this time the end
///   color is fully transparent. The end circle of the gradient uses a very
///   small radius so that the bright white'ish starting color quickly fades out
///   to nothing, thus creating the glare lighting effect. Both the start and
///   end circle centers of the radial gradient are located above the stone
///   circle center, at varying distances. As for the stone layer, the distances
///   above the stone circle center can be expressed as percentages of the stone
///   circle radius, and the percentages used in the implementation of this
///   method were determined with the measuring tool in Inkscape.
/// - General radial gradient notes: The Inkscape UI allows the user to set
///   the location of the start (= focal) circle center, the location of the
///   end circle center, and the x-radius and y-radius of the end circle.
///   However, in the underlying SVG source, the end circle can have only one
///   radius value. Inkscape solves this by applying an affine transform to the
///   gradient which includes scaling factors in x- and y-direction that result
///   in the end circle radius to have different values in the two directions.
///   Inkscape adds translation to the transform to reverse the effect that the
///   scaling has on the location of the start/end circle centers. The radius
///   of the start circle is always 0. The implementation of this method
///   follows Inkscape's approach with calculating an affine transform, because
///   the Core Graphics API for radial gradients also allows only one radius
///   size for the end circle.
// -----------------------------------------------------------------------------

// xxx
CGLayerRef CreateStoneLayer(CGContextRef context, CGSize size, enum GoColor playerColor, bool isCrossHairStone)
{
  CGRect layerRect = CGRectZero;
  layerRect.size = size;
  CGLayerRef layer = CGLayerCreateWithContext(context, layerRect.size, NULL);
  if (! layer)
    return NULL;

  // In case the specified size is rectangular and not square, we use the
  // lesser dimension as the base size for our calculations
  CGFloat lesserDimension = MIN(size.width, size.height);

  // Both the stone and its shadow must fit into the layer.
  // - The shadow is bigger than the stone, otherwise it would not be visible
  //   => The stone circle does not extend to the edge of the layer
  // - The shadow is offset in y-direction but not in x-direction
  //   => The stone circle center is not equal to the layer center
  CGPoint layerCenter = CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect));

  // Both the stone and its shadow must fit into the layer. The shadow must be
  // larger than the stone, otherwise it would not be visible because it would
  // be covered by the stone. The size that the caller specifies therefore
  // corresponds to the shadow size, and the stone circle must not use the
  // entire available size, i.e. the stone circle radius must be less than 50%.
  // Specifically, the shadow layer in stones.svg is 294.4px wide/high. This
  // corresponds to the size we have available for drawing. The stone circle
  // radius in stones.svg is 131.42857px, or 44.64% of the available size. Here
  // we round this to 45%.
  CGFloat stoneCircleRadius = lesserDimension * 0.45f;
  // The remaining area around the stone circle is used for drawing the shadow.
  // Specifically, the diameter of the stone layer in stones.svg is 262.85714,
  // which leaves 31.54286px for the shadow.
  CGFloat widthAndHeightAvailableForShadow = lesserDimension - stoneCircleRadius * 2.0f;
  // In Core Graphics, shadowing works by defining an amount of blur. This is
  // the number of points that are added ***ON ALL SIDES*** of a filled path
  // (or on all sides of the stroke of a path, but since we don't stroke this
  // is not relevant here). The width/height available for drawing the shadow
  // must therefore be divided by 2 to get the amount of blur.
  // Note: In the Inkscape UI the amount of blur is shown as 22.4%, in the
  // underlying SVG markup this results in an feGaussianBlur element with the
  // attribute stdDeviation="6.5714287". These values are of no use here,
  // though, because the Core Graphics shadow API does not correspond to the
  // Gaussian blur API of SVG/Inkscape.
  CGFloat shadowBlur = widthAndHeightAvailableForShadow / 2.0f;
  // We don't want the shadow to surround the stone on all sides, we want it to
  // be offset in y-direction. Specifically, in stones.svg the center of the
  // circle in the shadow layer is offset by about 8.5px below the center of the
  // circle in the stone layer. This is 26.95% of the height available for
  // drawing the shadow. Here we round this to 27%.
  CGFloat shadowOffsetY = widthAndHeightAvailableForShadow * 0.27f;
  // Initially we said that the size that the caller specifies corresponds to
  // the shadow size. The layer center therefore corresponds to the shadow
  // center, and the shadow offset in y-direction in relation to the stone
  // circle is achieved by placing the stone circle center above the layer
  // (= shadow) center.
  CGPoint stoneCircleCenter = CGPointMake(layerCenter.x,
                                          layerCenter.y - shadowOffsetY);

  CGContextRef layerContext = CGLayerGetContext(layer);

  [CGDrawingHelper drawStoneWithContext:layerContext
                                stoneCircleCenter:stoneCircleCenter
                                stoneCircleRadius:stoneCircleRadius
                                      playerColor:playerColor
                                 isCrossHairStone:isCrossHairStone
                                       shadowBlur:shadowBlur
                                    shadowOffsetY:shadowOffsetY];

  return layer;
}

+ (void) drawStoneWithContext:(CGContextRef)context
            stoneCircleCenter:(CGPoint)stoneCircleCenter
            stoneCircleRadius:(CGFloat)stoneCircleRadius
                  playerColor:(enum GoColor)playerColor
             isCrossHairStone:(bool)isCrossHairStone
                   shadowBlur:(CGFloat)shadowBlur
                shadowOffsetY:(CGFloat)shadowOffsetY
{
  // The order in which things are drawn is important: Later drawing covers
  // earlier drawing.
  [CGDrawingHelper drawStoneShadowLayerWithContext:context
                                           stoneCircleCenter:stoneCircleCenter
                                           stoneCircleRadius:stoneCircleRadius
                                                        blur:shadowBlur
                                                     offsetY:shadowOffsetY];
  [CGDrawingHelper drawStoneMainLayerWithContext:context
                                         stoneCircleCenter:stoneCircleCenter
                                         stoneCircleRadius:stoneCircleRadius
                                               playerColor:playerColor
                                          isCrossHairStone:isCrossHairStone];
  [CGDrawingHelper drawStoneHighlightLayerWithContext:context
                                              stoneCircleCenter:stoneCircleCenter
                                              stoneCircleRadius:stoneCircleRadius
                                                    playerColor:playerColor
                                               isCrossHairStone:isCrossHairStone];
}

+ (void) drawStoneShadowLayerWithContext:(CGContextRef)context
                       stoneCircleCenter:(CGPoint)stoneCircleCenter
                       stoneCircleRadius:(CGFloat)stoneCircleRadius
                                    blur:(CGFloat)blur
                                 offsetY:(CGFloat)offsetY
{
  CGContextSaveGState(context);

  // Same fill color as in stones.svg.
  UIColor* fillColor = [UIColor blackColor];

  CGSize offset = CGSizeMake(0.0f, offsetY);
  // The opacity of the shadow layer in stones.svg is 60.1%. This corresponds
  // to alpha 39.9%, or hex 0x65. However, because shadowing in SVG works
  // differently than in Core Graphics, the opacity from stones.svg cannot be
  // used directly here. Instead, an experimentally determined alpha value is
  // used here for the shadow color. Note that unlike SVG/Inkscape, which only
  // works with opacity/alpha, Core Graphics wants a full shadow color value,
  // so we use the same base color as the fill color (i.e. black), just with an
  // alpha.
  UIColor* shadowColor = [UIColor colorFromHexString:@"00000080"];

  CGContextSetShadowWithColor(context,
                              offset,
                              blur,
                              shadowColor.CGColor);

  [CGDrawingHelper drawCircleWithContext:context
                                  center:stoneCircleCenter
                                  radius:stoneCircleRadius
                               fillColor:fillColor
                             strokeColor:nil
                         strokeLineWidth:0.0f];
  // Remove shadow
  CGContextRestoreGState(context);
}

+ (void) drawStoneMainLayerWithContext:(CGContextRef)context
                     stoneCircleCenter:(CGPoint)stoneCircleCenter
                     stoneCircleRadius:(CGFloat)stoneCircleRadius
                           playerColor:(enum GoColor)playerColor
                      isCrossHairStone:(bool)isCrossHairStone
{
  // The gradient start/end colors can be taken from the Inkscape UI by
  // inspecting the radial gradient's two stop colors.
  UIColor* gradientStartColor;
  UIColor* gradientEndColor;
  // The gradient focal center (i.e. center of the gradient start circle) and
  // the center of the gradient end circle are located a certain distance above
  // the stone circle center. The distance in pixel must be measured manually in
  // the Inkscape UI. To remain flexible, the distance is then expressed as a
  // percentage, or factor, of the stone circle radius.
  CGFloat gradientFocalCenterYFactor;
  // For the stone layer the end circle center is the same as the stone circle
  // center, so we can assign factor 0.0f here for all stones.
  CGFloat gradientEndCenterYFactor = 0.0f;
  // The scale factors can be taken from the gradientTransform property of the
  // <radialGradient> element in the stones.svg source. The transform parameters
  // a and d correspond to the x/y factors.
  // The factors are the same for all stones, so we can ssign them here.
  CGFloat gradientEndRadiusScaleFactorX = 1.2021983f;
  CGFloat gradientEndRadiusScaleFactorY = 1.1837884f;

  if (isCrossHairStone)
  {
    // The radial gradient used to fill the cross-hair stone layer in stones.svg
    // has id="radialGradient3893"
    gradientStartColor = [UIColor colorFromHexString:@"3232ffff"];
    gradientEndColor = [UIColor colorFromHexString:@"1515c8ff"];
    // The focal center of the radial gradient used to fill the cross-hair stone
    // layer in stones.svg is about 90px above the stone circle center. This is
    // 68.48% of the stone circle radius 131.42857px.
    gradientFocalCenterYFactor = 0.6848f;
  }
  else if (playerColor == GoColorBlack)
  {
    // The radial gradient used to fill the black stone layer in stones.svg
    // has id="radialGradient3768"
    gradientStartColor = [UIColor colorFromHexString:@"323232ff"];
    gradientEndColor = [UIColor colorFromHexString:@"151515ff"];
    // The focal center of the radial gradient used to fill the black stone
    // layer in stones.svg is about 90px above the stone circle center. This is
    // 68.48% of the stone circle radius 131.42857px.
    gradientFocalCenterYFactor = 0.6848f;
  }
  else
  {
    // The radial gradient used to fill the white stone layer in stones.svg
    // has id="radialGradient3778"
    gradientStartColor = [UIColor whiteColor];
    gradientEndColor = [UIColor colorFromHexString:@"dadadaff"];
    // The focal center of the radial gradient used to fill the white stone
    // layer in stones.svg is about 69px above the stone circle center. This is
    // 52.57% of the stone circle radius 131.42857px.
    gradientFocalCenterYFactor = 0.5257f;
  }

  [CGDrawingHelper drawStoneLayerWithContext:context
                                     stoneCircleCenter:stoneCircleCenter
                                     stoneCircleRadius:stoneCircleRadius
                                    gradientStartColor:gradientStartColor
                                      gradientEndColor:gradientEndColor
                            gradientFocalCenterYFactor:gradientFocalCenterYFactor
                              gradientEndCenterYFactor:gradientEndCenterYFactor
                         gradientEndRadiusScaleFactorX:gradientEndRadiusScaleFactorX
                         gradientEndRadiusScaleFactorY:gradientEndRadiusScaleFactorY];
}

+ (void) drawStoneHighlightLayerWithContext:(CGContextRef)context
                          stoneCircleCenter:(CGPoint)stoneCircleCenter
                          stoneCircleRadius:(CGFloat)stoneCircleRadius
                                playerColor:(enum GoColor)playerColor
                           isCrossHairStone:(bool)isCrossHairStone
{
  // For a description of the parameters, see the method
  // drawStoneMainLayerWithContext...
  UIColor* gradientStartColor;
  UIColor* gradientEndColor;
  // The focal center of the radial gradient used to fill any of the stone
  // highlight layers in stones.svg is about 111px above the stone circle
  // center. This is 84.73% of the stone circle radius 131.42857px.
  CGFloat gradientFocalCenterYFactor = 0.8473f;
  // The end circle center of the radial gradient used to fill any of the
  // stone highlight layer in stones.svg is about 80px above the stone circle
  // center. This is 61.07% of the stone circle radius 131.42857px.
  CGFloat gradientEndCenterYFactor = 0.6107f;
  CGFloat gradientEndRadiusScaleFactorX = 0.81687026f;
  CGFloat gradientEndRadiusScaleFactorY = 0.39511169f;

  if (isCrossHairStone)
  {
    // The radial gradient used to fill the cross-hair stone highlight layer in
    // stones.svg has id="radialGradient3923"
    gradientStartColor = [UIColor colorFromHexString:@"8585ffff"];
    gradientEndColor = [UIColor colorFromHexString:@"1515c800"];

  }
  else if (playerColor == GoColorBlack)
  {
    // The radial gradient used to fill the black stone highlight layer in
    // stones.svg has id="radialGradient3810"
    gradientStartColor = [UIColor colorFromHexString:@"858585ff"];
    gradientEndColor = [UIColor colorFromHexString:@"15151500"];
  }
  else
  {
    // The radial gradient used to fill the white stone highlight layer in
    // stones.svg has id="radialGradient3759"
    gradientStartColor = [UIColor colorFromHexString:@"f9f9f9ff"];
    gradientEndColor = [UIColor colorFromHexString:@"dcdcdc00"];
  }

  [CGDrawingHelper drawStoneLayerWithContext:context
                                     stoneCircleCenter:stoneCircleCenter
                                     stoneCircleRadius:stoneCircleRadius
                                    gradientStartColor:gradientStartColor
                                      gradientEndColor:gradientEndColor
                            gradientFocalCenterYFactor:gradientFocalCenterYFactor
                              gradientEndCenterYFactor:gradientEndCenterYFactor
                         gradientEndRadiusScaleFactorX:gradientEndRadiusScaleFactorX
                         gradientEndRadiusScaleFactorY:gradientEndRadiusScaleFactorY];
}

+ (void) drawStoneLayerWithContext:(CGContextRef)context
                 stoneCircleCenter:(CGPoint)stoneCircleCenter
                 stoneCircleRadius:(CGFloat)stoneCircleRadius
                gradientStartColor:(UIColor*)gradientStartColor
                  gradientEndColor:(UIColor*)gradientEndColor
        gradientFocalCenterYFactor:(CGFloat)gradientFocalCenterYFactor
          gradientEndCenterYFactor:(CGFloat)gradientEndCenterYFactor
     gradientEndRadiusScaleFactorX:(CGFloat)gradientEndRadiusScaleFactorX
     gradientEndRadiusScaleFactorY:(CGFloat)gradientEndRadiusScaleFactorY
{
  CGPoint startCenter = CGPointMake(stoneCircleCenter.x,
                                    stoneCircleCenter.y - stoneCircleRadius * gradientFocalCenterYFactor);
  CGPoint endCenter = CGPointMake(stoneCircleCenter.x,
                                  stoneCircleCenter.y - stoneCircleRadius * gradientEndCenterYFactor);

  // The radial gradient end circle may be larger than the stone circle, so we
  // must clip radial gradient drawing to confine it to the stone circle
  // boundary
  [CGDrawingHelper setCircularClippingPathWithContext:context
                                               center:stoneCircleCenter
                                               radius:stoneCircleRadius];

  [CGDrawingHelper drawRadialGradientWithContext:context
                                      startColor:gradientStartColor
                                        endColor:gradientEndColor
                                     startCenter:startCenter
                                       endCenter:endCenter
                                       endRadius:stoneCircleRadius
                           endRadiusScaleFactorX:gradientEndRadiusScaleFactorX
                           endRadiusScaleFactorY:gradientEndRadiusScaleFactorY];

  [CGDrawingHelper removeClippingPathWithContext:context];

//  CGFloat a = gradientEndRadiusScaleFactorX;
//  CGFloat b = 0.0;
//  CGFloat c = 0.0;
//  CGFloat d = gradientEndRadiusScaleFactorY;
//  // Translation is used to move the start/end centers back to their original
//  // position
//  CGFloat tx = stoneCircleRadius - stoneCircleRadius * gradientEndRadiusScaleFactorX;
//  CGFloat ty = stoneCircleRadius - stoneCircleRadius * gradientEndRadiusScaleFactorY;
//  CGAffineTransform affineTransform = CGAffineTransformMake(a, b, c, d, tx, ty);
//
//  CGPoint startCenterAfterTransform = CGPointMake(stoneCircleCenter.x,
//                                                  stoneCircleCenter.y - stoneCircleRadius * gradientFocalCenterYFactor);
//  CGPoint endCenterAfterTransform = CGPointMake(stoneCircleCenter.x,
//                                                stoneCircleCenter.y - stoneCircleRadius * gradientEndCenterYFactor);
//
//  CGPoint startCenterBeforeTransform = CGPointMake((startCenterAfterTransform.x - tx) / a,
//                                                   (startCenterAfterTransform.y - ty) / d);
//  CGPoint endCenterBeforeTransform = CGPointMake((endCenterAfterTransform.x - tx) / a,
//                                                 (endCenterAfterTransform.y - ty) / d);
//
//  CGFloat startRadius = 0.0f;
//  CGFloat endRadius = stoneCircleRadius;
//
//  [CGDrawingHelper setCircularClippingPathWithContext:context
//                                               center:stoneCircleCenter
//                                               radius:stoneCircleRadius];
//  CGContextSaveGState(context);
//
//  CGContextConcatCTM(context, affineTransform);
//
//  [CGDrawingHelper drawRadialGradientWithContext:context
//                                                startColor:gradientStartColor
//                                                  endColor:gradientEndColor
//                                               startCenter:startCenterBeforeTransform
//                                               startRadius:startRadius
//                                                 endCenter:endCenterBeforeTransform
//                                                 endRadius:endRadius];
//
//  // Remove transform
//  CGContextRestoreGState(context);
//
//  [CGDrawingHelper removeClippingPathWithContext:context];
}

// -----------------------------------------------------------------------------
/// @brief Draws a simplified radial gradient with only two colors,
/// @a startColor and @a endColor, which are set at the gradient stops 0.0
/// and 1.0, respectively. The gradient start circle (aka focal circle) is
/// defined by @a startCenter and @a startRadius, and the gradient end circle is
/// defined by @a endCenter.
///
/// TODO xxx Find out whether The gradient fills
/// This method uses parameters that match the SVG model:
/// - @a startCenter corresponds to the SVG attributes @e fx and @e fy
///   (prefix "f" referring to the term "focal").
/// - @a startRadius corresponds to the SVG attribute @e fr.
/// - @a endCenter corresponds to the SVG attributes @e cx and @e cy.
/// - @a endRadius corresponds to the SVG attribute @e r.
/// - @a gradientTransform corresponds to the SVG attribute of the same name.
///
/// The following SVG attributes are not part of this API because they don't
/// make sense for the CoreGraphics drawing model:
/// - @e gradientUnits
/// - @e spreadMethod
///
/// @see https://svgwg.org/svg2-draft/pservers.html#RadialGradients
// -----------------------------------------------------------------------------
//+ (void) drawRadialGradientWithContext:(CGContextRef)context
//                            startColor:(UIColor*)startColor
//                              endColor:(UIColor*)endColor
//                           startCenter:(CGPoint)startCenter
//                           startRadius:(CGFloat)startRadius
//                             endCenter:(CGPoint)endCenter
//                             endRadius:(CGFloat)endRadius
//{
//  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//  NSArray* colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
//  CGFloat locations[] = { 0.0, 1.0 };
//
//  // NSArray is toll-free bridged, so we can simply cast to CGArrayRef
//  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
//                                                      (CFArrayRef)colors,
//                                                      locations);
//
//  CGContextDrawRadialGradient(context,
//                              gradient,
//                              startCenter,
//                              startRadius,
//                              endCenter,
//                              endRadius,
//                              0);
//
//  CGGradientRelease(gradient);
//  CGColorSpaceRelease(colorSpace);
//}

@end
