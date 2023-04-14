//
//  DrawingParametersViewController.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 13.04.23.
//

#import <UIKit/UIKit.h>

@class DrawingParameters;
@class DrawingParametersItem;

NS_ASSUME_NONNULL_BEGIN

@interface DrawingParametersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

- (instancetype) initWithDrawingParameters:(DrawingParameters*)drawingParameters;

- (void) updateUiWithModelValues;

@property (strong, nonatomic) DrawingParameters* drawingParameters;

@end

NS_ASSUME_NONNULL_END
