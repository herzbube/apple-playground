//
//  AutoLayoutUtility.h
//  boardpositioncollectionviewcell-layout
//
//  Created by Patrick Näf Moser on 14.01.2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoLayoutUtility : NSObject

+ (NSArray*) fillSuperview:(UIView*)superview
               withSubview:(UIView*)subview;
+ (NSArray*) fillSuperview:(UIView*)superview
               withSubview:(UIView*)subview
                   margins:(UIEdgeInsets)margins;
+ (NSLayoutConstraint*) alignFirstView:(UIView*)firstView
                        withSecondView:(UIView*)secondView
                           onAttribute:(NSLayoutAttribute)attribute
                      constraintHolder:(UIView*)constraintHolder;
+ (NSLayoutConstraint*) alignFirstView:(UIView*)firstView
                        withSecondView:(UIView*)secondView
                           onAttribute:(NSLayoutAttribute)attribute
                        withMultiplier:(CGFloat)multiplier
                          withConstant:(CGFloat)constant
                      constraintHolder:(UIView*)constraintHolder;
+ (NSLayoutConstraint*) alignFirstView:(UIView*)firstView
                        withSecondView:(UIView*)secondView
                           onAttribute:(NSLayoutAttribute)attribute
                        withMultiplier:(CGFloat)multiplier
                          withConstant:(CGFloat)constant
                          withPriority:(UILayoutPriority)priority
                      constraintHolder:(UIView*)constraintHolder;
+ (NSArray*) installVisualFormats:(NSArray*)visualFormats
                        withViews:(NSDictionary*)viewsDictionary
                           inView:(UIView*)view;
+ (NSArray*) createConstraintsWithVisualFormats:(NSArray*)visualFormats
                                          views:(NSDictionary*)viewsDictionary;

@end

NS_ASSUME_NONNULL_END
