//
//  DrawingView.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import "DrawingView.h"
#import "DrawingHelper.h"
#import "GlobalConstants.h"
#import "Model/Drawing/DrawingParameters.h"
#import "Model/Drawing/DrawingParametersItem.h"

@implementation DrawingView

#pragma mark - KVO

- (void) startObserving
{
  NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(drawingParametersDidChange:) name:drawingParametersDidChange object:nil];
}

- (void) drawingParametersDidChange:(NSNotification*)notification
{
  [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void) drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  for (DrawingParametersItem* item in self.drawingParameters.drawingParametersItems)
  {
    CGContextSaveGState(context);

    [DrawingHelper concatTransformWithContext:context
                    affineTransformParameters:item.affineTransformParameters];

    [DrawingHelper fillOrStrokePathWithContext:context
                              strokeParameters:item.strokeParameters
                                fillParameters:item.fillParameters
                                pathParameters:item.pathParameters];

    // Remove transform
    CGContextRestoreGState(context);

    [DrawingHelper drawGradientWithContext:context
                        gradientParameters:item.gradientParameters];

    // TODO: Enable this to draw Go stones. Obviously this should be
    // integrated properly into the project
//    bool didDraw = [DrawingHelper drawStones:context pathParameters:item.pathParameters];
//    if (didDraw)
//      break;
  }
}

@end
