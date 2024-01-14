//
//  BoardPositionCollectionViewCell.h
//  boardpositioncollectionviewcell-layout
//
//  Created by Patrick Näf Moser on 14.01.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoardPositionCellView : UIView

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* detailText;
@property (strong, nonatomic) NSString* capturedStones;
@property (nonatomic) bool useBackgroundColors;
@property (nonatomic) bool showDetailText;
@property (nonatomic) bool showCapturedStones;
@property (nonatomic) bool showHotspotIcon;
@property (nonatomic) bool showInfoIcon;
@property (nonatomic) bool showMarkupIcon;
@property (nonatomic) bool activateEqualHeightsConstraint;
@property (nonatomic) bool useHiddenProperty;
@property (nonatomic) bool activateContentSizeConstraints;
@property (nonatomic) CGSize contentSize;

@end

NS_ASSUME_NONNULL_END
