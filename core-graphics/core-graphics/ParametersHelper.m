//
//  ParametersHelper.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 07.04.23.
//

#import "ParametersHelper.h"
#import "Model/ArcParameters.h"
#import "Model/DrawingParameters.h"
#import "Model/GradientParameters.h"
#import "Model/GradientStopParameters.h"
#import "Model/LinearGradientParameters.h"
#import "Model/PathParameters.h"
#import "Model/RadialGradientParameters.h"
#import "Model/RectangleParameters.h"

@implementation ParametersHelper

+ (void) saveParameters:(DrawingParameters*)drawingParameters
{
  [drawingParameters writeUserDefaults];
}

+ (void) loadParameters:(DrawingParameters*)drawingParameters
{
  [drawingParameters readUserDefaults];
}

+ (void) resetParameters:(DrawingParameters*)drawingParameters
{
  [drawingParameters resetToDefaultValues];
}

+ (void) alignGradientToPathParameters:(DrawingParameters*)drawingParameters
{
  if (drawingParameters.gradientParameters.gradientType == GradientTypeLinear)
  {
    LinearGradientParameters* linearGradientParameters = drawingParameters.gradientParameters.linearGradientParameters;

    if (drawingParameters.pathParameters.pathType == PathTypeArc)
    {
      ArcParameters* arcParameters = drawingParameters.pathParameters.arcParameters;

      linearGradientParameters.startPointX = arcParameters.centerX - arcParameters.radius;
      linearGradientParameters.startPointY = arcParameters.centerY;

      linearGradientParameters.endPointX = arcParameters.centerX + arcParameters.radius;
      linearGradientParameters.endPointY = arcParameters.centerY;
    }
    else
    {
      RectangleParameters* rectangleParameters = drawingParameters.pathParameters.rectangleParameters;

      CGRect rect = CGRectMake(rectangleParameters.originX,
                               rectangleParameters.originY,
                               rectangleParameters.width,
                               rectangleParameters.height);

      linearGradientParameters.startPointX = CGRectGetMinX(rect);
      linearGradientParameters.startPointY = CGRectGetMidY(rect);

      linearGradientParameters.endPointX = CGRectGetMaxX(rect);
      linearGradientParameters.endPointY = CGRectGetMidY(rect);
    }
  }
  else
  {
    RadialGradientParameters* radialGradientParameters = drawingParameters.gradientParameters.radialGradientParameters;

    if (drawingParameters.pathParameters.pathType == PathTypeArc)
    {
      ArcParameters* arcParameters = drawingParameters.pathParameters.arcParameters;

      radialGradientParameters.startCenterX = arcParameters.centerX;
      radialGradientParameters.startCenterY = arcParameters.centerY;
      radialGradientParameters.startRadius = 0.0f;

      radialGradientParameters.endCenterX = arcParameters.centerX;
      radialGradientParameters.endCenterY = arcParameters.centerY;
      radialGradientParameters.endRadius = arcParameters.radius;
    }
    else
    {
      RectangleParameters* rectangleParameters = drawingParameters.pathParameters.rectangleParameters;

      CGRect rect = CGRectMake(rectangleParameters.originX,
                               rectangleParameters.originY,
                               rectangleParameters.width,
                               rectangleParameters.height);

      radialGradientParameters.startCenterX = CGRectGetMidX(rect);
      radialGradientParameters.startCenterY = CGRectGetMidY(rect);
      radialGradientParameters.startRadius = 0.0f;

      radialGradientParameters.endCenterX = CGRectGetMidX(rect);
      radialGradientParameters.endCenterY = CGRectGetMidY(rect);
      radialGradientParameters.endRadius = MIN(rect.size.width, rect.size.height);
    }
  }
}

@end
