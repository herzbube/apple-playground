//
//  AutoLayoutUtility.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoLayoutUtility : NSObject

+ (NSArray*) fillSuperview:(UIView*)superview
               withSubview:(UIView*)subview;
+ (NSArray*) fillSuperview:(UIView*)superview
               withSubview:(UIView*)subview
                   margins:(UIEdgeInsets)margins;
+ (NSArray*) installVisualFormats:(NSArray*)visualFormats
                        withViews:(NSDictionary*)viewsDictionary
                           inView:(UIView*)view;
+ (NSArray*) createConstraintsWithVisualFormats:(NSArray*)visualFormats
                                          views:(NSDictionary*)viewsDictionary;

@end

NS_ASSUME_NONNULL_END
