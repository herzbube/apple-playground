//
//  DrawingView.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import "DrawingView.h"
#import "DrawingHelper.h"
#import "Model/AffineTransformParameters.h"
#import "Model/ArcParameters.h"
#import "Model/ColorParameters.h"
#import "Model/FillParameters.h"
#import "Model/StrokeParameters.h"

@implementation DrawingView

#pragma mark - KVO

- (void) startObserving
{
  [self.arcParameters addObserver:self forKeyPath:@"centerX" options:0 context:NULL];
  [self.arcParameters addObserver:self forKeyPath:@"centerY" options:0 context:NULL];
  [self.arcParameters addObserver:self forKeyPath:@"radius" options:0 context:NULL];
  [self.arcParameters addObserver:self forKeyPath:@"startAngle" options:0 context:NULL];
  [self.arcParameters addObserver:self forKeyPath:@"endAngle" options:0 context:NULL];
  [self.arcParameters addObserver:self forKeyPath:@"clockwise" options:0 context:NULL];

  [self.strokeParameters addObserver:self forKeyPath:@"strokeEnabled" options:0 context:NULL];
  [self.strokeParameters addObserver:self forKeyPath:@"lineWidth" options:0 context:NULL];
  [self.strokeParameters.colorParameters addObserver:self forKeyPath:@"hexString" options:0 context:NULL];

  [self.fillParameters addObserver:self forKeyPath:@"fillEnabled" options:0 context:NULL];
  [self.fillParameters.colorParameters addObserver:self forKeyPath:@"hexString" options:0 context:NULL];

  [self.affineTransformParameters addObserver:self forKeyPath:@"affineTransformEnabled" options:0 context:NULL];
  [self.affineTransformParameters addObserver:self forKeyPath:@"a" options:0 context:NULL];
  [self.affineTransformParameters addObserver:self forKeyPath:@"b" options:0 context:NULL];
  [self.affineTransformParameters addObserver:self forKeyPath:@"c" options:0 context:NULL];
  [self.affineTransformParameters addObserver:self forKeyPath:@"d" options:0 context:NULL];
  [self.affineTransformParameters addObserver:self forKeyPath:@"tx" options:0 context:NULL];
  [self.affineTransformParameters addObserver:self forKeyPath:@"ty" options:0 context:NULL];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void) drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  if (self.affineTransformParameters.affineTransformEnabled)
  {
    CGAffineTransform transform = CGAffineTransformMake(self.affineTransformParameters.a,
                                                        self.affineTransformParameters.b,
                                                        self.affineTransformParameters.c,
                                                        self.affineTransformParameters.d,
                                                        self.affineTransformParameters.tx,
                                                        self.affineTransformParameters.ty);
    if (! CGAffineTransformIsIdentity(transform))
    {
      CGContextConcatCTM(context, transform);
    }
  }

//  if (self.model.pathType == PathTypeArc)
  {
    CGContextAddArc(context,
                    self.arcParameters.centerX,
                    self.arcParameters.centerY,
                    self.arcParameters.radius,
                    [DrawingHelper radians:self.arcParameters.startAngle],
                    [DrawingHelper radians:self.arcParameters.endAngle],
                    self.arcParameters.clockwise);
  }
//  else
  {
    // TODO Draw rectangle
  }

//  [DrawingView fillOrStrokePathWithContext:context model:self.model];
//  if (self.strokeParameters.strokeEnabled)
//  {
//    UIColor* strokeColor = [UIColor colorWithRed:self.strokeParameters.colorParameters.red
//                                           green:self.strokeParameters.colorParameters.green
//                                            blue:self.strokeParameters.colorParameters.blue
//                                           alpha:self.strokeParameters.colorParameters.alpha];
//    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
//    CGContextSetLineWidth(context, self.strokeParameters.lineWidth);
//    CGContextStrokePath(context);
//  }
  [DrawingHelper fillOrStrokePathWithContext:context
                            strokeParameters:self.strokeParameters
                              fillParameters:self.fillParameters];
}

@end
