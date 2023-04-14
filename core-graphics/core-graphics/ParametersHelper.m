//
//  ParametersHelper.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 07.04.23.
//

#import "ParametersHelper.h"
#import "Model/Drawing/DrawingParameters.h"
#import "Model/Drawing/DrawingParametersItem.h"
#import "Model/Gradient/GradientParameters.h"
#import "Model/Gradient/GradientStopParameters.h"
#import "Model/Gradient/LinearGradientParameters.h"
#import "Model/Gradient/RadialGradientParameters.h"
#import "Model/Path/ArcParameters.h"
#import "Model/Path/PathParameters.h"
#import "Model/Path/RectangleParameters.h"

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

+ (void) alignGradientToPathParameters:(DrawingParametersItem*)drawingParametersItem
{
  if (drawingParametersItem.gradientParameters.gradientType == GradientTypeLinear)
  {
    LinearGradientParameters* linearGradientParameters = drawingParametersItem.gradientParameters.linearGradientParameters;

    if (drawingParametersItem.pathParameters.pathType == PathTypeArc)
    {
      ArcParameters* arcParameters = drawingParametersItem.pathParameters.arcParameters;

      linearGradientParameters.startPointX = arcParameters.centerX - arcParameters.radius;
      linearGradientParameters.startPointY = arcParameters.centerY;

      linearGradientParameters.endPointX = arcParameters.centerX + arcParameters.radius;
      linearGradientParameters.endPointY = arcParameters.centerY;
    }
    else
    {
      RectangleParameters* rectangleParameters = drawingParametersItem.pathParameters.rectangleParameters;

      CGRect rect = CGRectMake(rectangleParameters.originX,
                               rectangleParameters.originY,
                               rectangleParameters.width,
                               rectangleParameters.height);

      linearGradientParameters.startPointX = CGRectGetMinX(rect);
      linearGradientParameters.startPointY = CGRectGetMidY(rect);

      linearGradientParameters.endPointX = CGRectGetMaxX(rect);
      linearGradientParameters.endPointY = CGRectGetMidY(rect);
    }

    [linearGradientParameters valuesDidChange];
  }
  else
  {
    RadialGradientParameters* radialGradientParameters = drawingParametersItem.gradientParameters.radialGradientParameters;

    if (drawingParametersItem.pathParameters.pathType == PathTypeArc)
    {
      ArcParameters* arcParameters = drawingParametersItem.pathParameters.arcParameters;

      radialGradientParameters.startCenterX = arcParameters.centerX;
      radialGradientParameters.startCenterY = arcParameters.centerY;
      radialGradientParameters.startRadius = 0.0f;

      radialGradientParameters.endCenterX = arcParameters.centerX;
      radialGradientParameters.endCenterY = arcParameters.centerY;
      radialGradientParameters.endRadius = arcParameters.radius;
    }
    else
    {
      RectangleParameters* rectangleParameters = drawingParametersItem.pathParameters.rectangleParameters;

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

    [radialGradientParameters valuesDidChange];
  }
}

@end
