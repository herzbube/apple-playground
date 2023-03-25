//
//  DrawingView.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import <UIKit/UIKit.h>

@class AffineTransformParameters;
@class ArcParameters;
@class FillParameters;
@class StrokeParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingView : UIView

- (void) startObserving;

@property (strong, nonatomic) ArcParameters* arcParameters;
@property (strong, nonatomic) FillParameters* fillParameters;
@property (strong, nonatomic) StrokeParameters* strokeParameters;
@property (strong, nonatomic) AffineTransformParameters* affineTransformParameters;

@end

NS_ASSUME_NONNULL_END
