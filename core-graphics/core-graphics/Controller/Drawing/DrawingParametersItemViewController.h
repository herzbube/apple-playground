//
//  DrawingParametersItemViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 13.04.23.
//

#import <UIKit/UIKit.h>

@class DrawingParametersItem;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingParametersItemViewController : UIViewController

- (instancetype) init;

- (void) updateUiWithModelValues;
- (void) updateDrawingParametersItem:(DrawingParametersItem*)drawingParametersItem;

@property (strong, nonatomic, nullable) DrawingParametersItem* drawingParametersItem;

@end

NS_ASSUME_NONNULL_END
