//
//  DrawingHelper.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 20.03.23.
//

#import <UIKit/UIKit.h>

// Forward declarations
@class NSString;
@class UIColor;


NS_ASSUME_NONNULL_BEGIN

// -----------------------------------------------------------------------------
/// @brief The UIColorAdditions category enhances UIColor by adding string
/// conversion methods and a number of new predefined colors.
///
/// @ingroup utility
///
/// Inspiration for this category comes from
/// - String conversion: https://arstechnica.com/gadgets/2009/02/iphone-development-accessing-uicolor-components/
/// - Slate blue color: https://stackoverflow.com/questions/3943607/iphone-need-the-dark-blue-color-as-a-uicolor-used-on-tables-details-text-3366
// -----------------------------------------------------------------------------
@interface UIColor(UIColorAdditions)
+ (NSString*) stringFromUIColor:(UIColor*)color;
+ (NSString*) hexStringFromUIColor:(UIColor*)color;
+ (UIColor*) colorFromString:(NSString*)string;
+ (UIColor*) colorFromHexString:(NSString*)hexString;
- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;
- (CGFloat) alpha;
+ (UIColor*) slateBlueColor;
+ (UIColor*) lightBlueColor;
+ (UIColor*) lightBlueGrayColor;
+ (UIColor*) bleuDeFranceColor;
+ (UIColor*) darkTangerineColor;
+ (UIColor*) whiteSmokeColor;
+ (UIColor*) mayaBlueColor;
+ (UIColor*) nonPhotoBlueColor;
+ (UIColor*) malachiteColor;
+ (UIColor*) ncsYellowColor;
+ (UIColor*) pantoneRedColor;
+ (UIColor*) constructionOrangeColor;
+ (UIColor*) randomColor;
+ (UIColor*) iPadGroupTableViewBackgroundGradientStartColor;
+ (UIColor*) iPadGroupTableViewBackgroundGradientEndColor;
+ (NSArray*) redButtonTableViewCellBackgroundGradientColors;
+ (NSArray*) redButtonTableViewCellSelectedBackgroundGradientColors;
//+ (UIColor*) tableViewCellDetailTextLabelColor;
+ (UIColor*) navigationbarBackgroundColor;
//+ (UIColor*) woodenBackgroundColor;
//+ (UIColor*) hotspotColor:(enum GoBoardPositionHotspotDesignation)goBoardPositionHotspotDesignation;
+ (UIColor*) labelTextColorRegularText;
+ (UIColor*) labelTextColorPlaceholderText;

@end

NS_ASSUME_NONNULL_END
