//
//  DrawingView.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import "DrawingView.h"
#import "DrawingHelper.h"
#import "Model/AffineTransform/AffineTransformParameters.h"
#import "Model/ArcParameters.h"
#import "Model/ColorParameters.h"
#import "Model/FillParameters.h"
#import "Model/GradientParameters.h"
#import "Model/GradientStopParameters.h"
#import "Model/LinearGradientParameters.h"
#import "Model/PathParameters.h"
#import "Model/RadialGradientParameters.h"
#import "Model/RectangleParameters.h"
#import "Model/StrokeParameters.h"

@implementation DrawingView

#pragma mark - KVO

- (void) startObserving
{
  [self.pathParameters addObserver:self forKeyPath:@"pathEnabled" options:0 context:NULL];
  [self.pathParameters addObserver:self forKeyPath:@"pathType" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"centerX" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"centerY" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"radius" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"startAngle" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"endAngle" options:0 context:NULL];
  [self.pathParameters.arcParameters addObserver:self forKeyPath:@"clockwise" options:0 context:NULL];
  [self.pathParameters.rectangleParameters addObserver:self forKeyPath:@"originX" options:0 context:NULL];
  [self.pathParameters.rectangleParameters addObserver:self forKeyPath:@"originY" options:0 context:NULL];
  [self.pathParameters.rectangleParameters addObserver:self forKeyPath:@"width" options:0 context:NULL];
  [self.pathParameters.rectangleParameters addObserver:self forKeyPath:@"height" options:0 context:NULL];

  [self.strokeParameters addObserver:self forKeyPath:@"strokeEnabled" options:0 context:NULL];
  [self.strokeParameters addObserver:self forKeyPath:@"lineWidth" options:0 context:NULL];
  [self.strokeParameters.colorParameters addObserver:self forKeyPath:@"hexString" options:0 context:NULL];

  [self.fillParameters addObserver:self forKeyPath:@"fillEnabled" options:0 context:NULL];
  [self.fillParameters addObserver:self forKeyPath:@"fillType" options:0 context:NULL];
  [self.fillParameters addObserver:self forKeyPath:@"clipGradientToPath" options:0 context:NULL];
  [self startObservingColorParameters:self.fillParameters.colorParameters];
  [self startObservingGradientParameters:self.fillParameters.gradientParameters];

  [self startObservingAffineTransformParameters:self.affineTransformParameters];
  [self startObservingGradientParameters:self.gradientParameters];
}

- (void) startObservingColorParameters:(ColorParameters*)colorParameters
{
  [colorParameters addObserver:self forKeyPath:@"hexString" options:0 context:NULL];
}

- (void) startObservingAffineTransformParameters:(AffineTransformParameters*)affineTransformParameters
{
  [affineTransformParameters addObserver:self forKeyPath:@"affineTransformEnabled" options:0 context:NULL];
  [affineTransformParameters addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];
}

- (void) startObservingGradientParameters:(GradientParameters*)gradientParameters
{
  [gradientParameters addObserver:self forKeyPath:@"gradientEnabled" options:0 context:NULL];
  [gradientParameters addObserver:self forKeyPath:@"gradientType" options:0 context:NULL];
  [gradientParameters.linearGradientParameters addObserver:self forKeyPath:@"startPointX" options:0 context:NULL];
  [gradientParameters.linearGradientParameters addObserver:self forKeyPath:@"startPointY" options:0 context:NULL];
  [gradientParameters.linearGradientParameters addObserver:self forKeyPath:@"endPointX" options:0 context:NULL];
  [gradientParameters.linearGradientParameters addObserver:self forKeyPath:@"endPointY" options:0 context:NULL];
  [self startObservingGradientStopParameters:gradientParameters.linearGradientParameters.gradientStopParameters];
  [self startObservingAffineTransformParameters:gradientParameters.linearGradientParameters.affineTransformParameters];
  [gradientParameters.radialGradientParameters addObserver:self forKeyPath:@"startCenterX" options:0 context:NULL];
  [gradientParameters.radialGradientParameters addObserver:self forKeyPath:@"startCenterY" options:0 context:NULL];
  [gradientParameters.radialGradientParameters addObserver:self forKeyPath:@"startRadius" options:0 context:NULL];
  [gradientParameters.radialGradientParameters addObserver:self forKeyPath:@"endCenterX" options:0 context:NULL];
  [gradientParameters.radialGradientParameters addObserver:self forKeyPath:@"endCenterY" options:0 context:NULL];
  [gradientParameters.radialGradientParameters addObserver:self forKeyPath:@"endRadius" options:0 context:NULL];
  [self startObservingGradientStopParameters:gradientParameters.radialGradientParameters.gradientStopParameters];
  [self startObservingAffineTransformParameters:gradientParameters.radialGradientParameters.affineTransformParameters];
}

- (void) startObservingGradientStopParameters:(GradientStopParameters*)gradientStopParameters
{
  [gradientStopParameters addObserver:self forKeyPath:@"position1" options:0 context:NULL];
  [self startObservingColorParameters:gradientStopParameters.colorParameters1];
  [gradientStopParameters addObserver:self forKeyPath:@"position2" options:0 context:NULL];
  [self startObservingColorParameters:gradientStopParameters.colorParameters2];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void) drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSaveGState(context);

  [DrawingHelper concatTransformWithContext:context
                  affineTransformParameters:self.affineTransformParameters];

  if (self.pathParameters.pathEnabled)
  {
    if (self.pathParameters.pathType == PathTypeArc)
    {
      CGContextAddArc(context,
                      self.pathParameters.arcParameters.centerX,
                      self.pathParameters.arcParameters.centerY,
                      self.pathParameters.arcParameters.radius,
                      [DrawingHelper radians:self.pathParameters.arcParameters.startAngle],
                      [DrawingHelper radians:self.pathParameters.arcParameters.endAngle],
                      self.pathParameters.arcParameters.clockwise);
    }
    else
    {
      CGRect rectangle = CGRectMake(self.pathParameters.rectangleParameters.originX,
                                    self.pathParameters.rectangleParameters.originY,
                                    self.pathParameters.rectangleParameters.width,
                                    self.pathParameters.rectangleParameters.height);
      CGContextAddRect(context, rectangle);
    }
  }

  [DrawingHelper fillOrStrokePathWithContext:context
                            strokeParameters:self.strokeParameters
                              fillParameters:self.fillParameters];

  // Remove transform
  CGContextRestoreGState(context);

  if (self.gradientParameters.gradientEnabled)
  {
    [DrawingHelper drawGradientWithContext:context
                        gradientParameters:self.gradientParameters];
  }
}

@end
