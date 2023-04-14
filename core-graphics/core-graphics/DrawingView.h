//
//  DrawingView.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 19.03.23.
//

#import <UIKit/UIKit.h>

@class DrawingParameters;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingView : UIView

- (void) startObserving;

@property (strong, nonatomic) DrawingParameters* drawingParameters;

@end

NS_ASSUME_NONNULL_END
