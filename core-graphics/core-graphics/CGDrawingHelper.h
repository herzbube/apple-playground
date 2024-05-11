//
//  DrawingHelper.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

enum GoColor
{
  GoColorNone,   ///< @brief Used, among other things, to say that a GoPoint is empty and has no stone placed on it.
  GoColorBlack,
  GoColorWhite
};

//NS_ASSUME_NONNULL_BEGIN

// -----------------------------------------------------------------------------
/// @brief The CGDrawingHelper class provides generic helper functions for
/// drawing UI elements with Core Graphics.
///
/// There is no need to create an instance of CGDrawingHelper because
/// the class contains only functions and class methods.
// -----------------------------------------------------------------------------
@interface CGDrawingHelper : NSObject
{
}

/// @name Drawing shapes
//@{
+ (void) drawCircleWithContext:(CGContextRef _Nullable)context
                        center:(CGPoint)center
                        radius:(CGFloat)radius
                     fillColor:(UIColor* _Nullable)fillColor
                   strokeColor:(UIColor* _Nullable)strokeColor
               strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawStoneCircleWithContext:(CGContextRef _Nullable)context
                             center:(CGPoint)center
                             radius:(CGFloat)radius
                         stoneColor:(enum GoColor)stoneColor
                    strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawRectangleWithContext:(CGContextRef _Nullable)context
                        rectangle:(CGRect)rectangle
                        fillColor:(UIColor* _Nullable)fillColor
                      strokeColor:(UIColor* _Nullable)strokeColor
                  strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawStoneRectangleWithContext:(CGContextRef _Nullable)context
                             rectangle:(CGRect)rectangle
                            stoneColor:(enum GoColor)stoneColor
                       strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawRoundedRectangleWithContext:(CGContextRef _Nullable)context
                               rectangle:(CGRect)rectangle
                            cornerRadius:(CGSize)cornerRadius
                               fillColor:(UIColor* _Nullable)fillColor
                             strokeColor:(UIColor* _Nullable)strokeColor
                         strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawTriangleWithContext:(CGContextRef _Nullable)context
                 insideRectangle:(CGRect)rectangle
                       fillColor:(UIColor* _Nullable)fillColor
                     strokeColor:(UIColor* _Nullable)strokeColor
                 strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawSymbolXWithContext:(CGContextRef _Nullable)context
                insideRectangle:(CGRect)rectangle
                    strokeColor:(UIColor* _Nullable)strokeColor
                strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawSymbolXWithContext:(CGContextRef _Nullable)context
                         center:(CGPoint)center
                     symbolSize:(CGFloat)symbolSize
                    strokeColor:(UIColor* _Nullable)strokeColor
                strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawCheckmarkWithContext:(CGContextRef _Nullable)context
                  insideRectangle:(CGRect)rectangle
                      strokeColor:(UIColor* _Nullable)strokeColor
                  strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) drawLineWithContext:(CGContextRef _Nullable)context
                   fromPoint:(CGPoint)startPoint
                     toPoint:(CGPoint)endPoint
                 strokeColor:(UIColor* _Nullable)strokeColor
             strokeLineWidth:(CGFloat)strokeLineWidth;
//@}

/// @name Filling and stroking
//@{
+ (void) fillOrStrokePathWithContext:(CGContextRef _Nullable)context
                           fillColor:(UIColor* _Nullable)fillColor
                         strokeColor:(UIColor* _Nullable)strokeColor
                     strokeLineWidth:(CGFloat)strokeLineWidth;

+ (void) fillAndStrokeColorsForStoneColor:(enum GoColor)stoneColor
                                fillColor:(UIColor* _Nullable * _Nullable)fillColor
                              strokeColor:(UIColor* _Nullable * _Nullable)strokeColor;
//@}

/// @name Drawing images
//@{
+ (void) drawImageWithContext:(CGContextRef _Nullable)context
                       inRect:(CGRect)rectangle
                    imageName:(NSString* _Nullable)imageName;

+ (void) drawSystemImageWithContext:(CGContextRef _Nullable)context
                             inRect:(CGRect)rectangle
                          imageName:(NSString* _Nullable)imageName API_AVAILABLE(ios(13.0));

+ (void) drawImageWithContext:(CGContextRef _Nullable)context
                       inRect:(CGRect)rectangle
                        image:(UIImage* _Nullable)image;
//@}

/// @name Drawing strings
//@{
+ (void) drawStringWithContext:(CGContextRef _Nullable)context
                centeredInRect:(CGRect)rectangle
                        string:(NSString* _Nullable)string
                textAttributes:(NSDictionary* _Nullable)textAttributes;

+ (void) drawStringWithContext:(CGContextRef _Nullable)context
                centeredInRect:(CGRect)rectangle
           rotatedCcwByDegrees:(CGFloat)degrees
                        string:(NSString* _Nullable)string
                textAttributes:(NSDictionary* _Nullable)textAttributes;
//@}

/// @name Drawing gradients
//@{
+ (void) drawRadialGradientWithContext:(CGContextRef _Nullable)context
                            startColor:(UIColor* _Nullable)startColor
                              endColor:(UIColor* _Nullable)endColor
                           startCenter:(CGPoint)startCenter
                             endCenter:(CGPoint)endCenter
                             endRadius:(CGFloat)endRadius
                 endRadiusScaleFactorX:(CGFloat)endRadiusScaleFactorX
                 endRadiusScaleFactorY:(CGFloat)endRadiusScaleFactorY;

+ (void) drawRadialGradientWithContext:(CGContextRef _Nullable)context
                            startColor:(UIColor* _Nullable)startColor
                              endColor:(UIColor* _Nullable)endColor
                           startCenter:(CGPoint)startCenter
                           startRadius:(CGFloat)startRadius
                             endCenter:(CGPoint)endCenter
                             endRadius:(CGFloat)endRadius;
//@}

/// @name Setting and removing clipping paths
//@{
+ (void) setCircularClippingPathWithContext:(CGContextRef _Nullable)context
                                     center:(CGPoint)center
                                     radius:(CGFloat)radius;

+ (void) setCircularClippingPathWithContext:(CGContextRef _Nullable)context
                                     center:(CGPoint)center
                                innerRadius:(CGFloat)innerRadius
                                outerRadius:(CGFloat)outerRadius;

+ (void) setCircularClippingPathWithContext:(CGContextRef _Nullable)context
                                     center:(CGPoint)center
                                     radius:(CGFloat)innerRadius
                             outerRectangle:(CGRect)outerRectangle;

+ (void) setRectangularClippingPathWithContext:(CGContextRef _Nullable)context
                                     rectangle:(CGRect)rectangle;

+ (void) setRectangularClippingPathWithContext:(CGContextRef _Nullable)context
                                innerRectangle:(CGRect)innerRectangle
                                outerRectangle:(CGRect)outerRectangle;

+ (void) setRectangularClippingPathWithContext:(CGContextRef _Nullable)context
                                innerRectangle:(CGRect)innerRectangle
                                        center:(CGPoint)center
                                        radius:(CGFloat)radius;

+ (void) removeClippingPathWithContext:(CGContextRef _Nullable)context;
//@}

/// @name Calculating points, sizes and rectangles
//@{
//+ (CGRect) canvasRectForTile:(id<Tile>)tile
//                    withSize:(CGSize)tileSize;
//
//+ (CGRect) drawingRectForScaledLayer:(CGLayerRef)layer
//                   withContentsScale:(CGFloat)contentsScale;
//
//+ (CGRect) drawingRectFromCanvasRect:(CGRect)canvasRect
//                      inTileWithRect:(CGRect)tileRect;
//@}

CGLayerRef _Nullable CreateStoneLayer(CGContextRef _Nullable context, CGSize size, enum GoColor playerColor, bool isCrossHairStone);

@end

//NS_ASSUME_NONNULL_END
