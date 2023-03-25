//
//  Model.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

@class ArcParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

- (instancetype) init;

//@property (nonatomic) PathType pathType;
@property (strong, nonatomic) IBOutlet ArcParameters* arcParameters;
//@property (nonatomic) RectangleParameters rectangleParameters;
//@property (nonatomic) bool shouldApplyAffineTransform;
//@property (nonatomic) AffineTransformParameters affineTransformParameters;
//@property (nonatomic) AffineTransformRawParameters affineTransformRawParameters;
@property (nonatomic) bool shouldStrokePath;
@property (strong, nonatomic) IBOutlet StrokeParameters* strokeParameters;
//@property (nonatomic) bool shouldFillPath;
//@property (nonatomic) FillParameters fillParameters;
//@property (nonatomic) bool shouldDrawGradient;
//@property (nonatomic) GradientType gradientType;
//@property (nonatomic) GradientParameters gradientParameters;
//@property (nonatomic) LinearGradientParameters linearGradientParameters;
//@property (nonatomic) RadialGradientParameters radialGradientParameters;

@end

NS_ASSUME_NONNULL_END
