//
//  AutoLayoutUtility.m
//  boardpositioncollectionviewcell-layout
//
//  Created by Patrick Näf Moser on 14.01.2024.
//

#import "AutoLayoutUtility.h"

@implementation AutoLayoutUtility

+ (NSArray*) fillSuperview:(UIView*)superview
               withSubview:(UIView*)subview
{
  return [AutoLayoutUtility fillSuperview:superview
                              withSubview:subview
                                  margins:UIEdgeInsetsMake(0, 0, 0, 0)];
}

+ (NSArray*) fillSuperview:(UIView*)superview
               withSubview:(UIView*)subview
                   margins:(UIEdgeInsets)margins
{
  NSDictionary* viewsDictionary = [NSDictionary dictionaryWithObject:subview
                                                              forKey:@"subview"];
  NSArray* visualFormats = [NSArray arrayWithObjects:
                            [NSString stringWithFormat:@"H:|-%f-[subview]-%f-|", margins.left, margins.right],
                            [NSString stringWithFormat:@"V:|-%f-[subview]-%f-|", margins.top, margins.bottom],
                            nil];
  return [AutoLayoutUtility installVisualFormats:visualFormats
                                       withViews:viewsDictionary
                                          inView:superview];
}

+ (NSLayoutConstraint*) alignFirstView:(UIView*)firstView
                        withSecondView:(UIView*)secondView
                           onAttribute:(NSLayoutAttribute)attribute
                      constraintHolder:(UIView*)constraintHolder
{
  return [AutoLayoutUtility alignFirstView:firstView
                            withSecondView:secondView
                               onAttribute:attribute
                            withMultiplier:1.0f
                              withConstant:0.0f
                          constraintHolder:constraintHolder];
}

+ (NSLayoutConstraint*) alignFirstView:(UIView*)firstView
                        withSecondView:(UIView*)secondView
                           onAttribute:(NSLayoutAttribute)attribute
                        withMultiplier:(CGFloat)multiplier
                          withConstant:(CGFloat)constant
                      constraintHolder:(UIView*)constraintHolder
{
  return [AutoLayoutUtility alignFirstView:firstView
                            withSecondView:secondView
                               onAttribute:attribute
                            withMultiplier:multiplier
                              withConstant:0.0f
                              withPriority:UILayoutPriorityRequired
                          constraintHolder:constraintHolder];
}

+ (NSLayoutConstraint*) alignFirstView:(UIView*)firstView
                        withSecondView:(UIView*)secondView
                           onAttribute:(NSLayoutAttribute)attribute
                        withMultiplier:(CGFloat)multiplier
                          withConstant:(CGFloat)constant
                          withPriority:(UILayoutPriority)priority
                      constraintHolder:(UIView*)constraintHolder
{
  NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:firstView
                                                                attribute:attribute
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:secondView
                                                                attribute:attribute
                                                               multiplier:multiplier
                                                                 constant:constant];
  constraint.priority = priority;
  [constraintHolder addConstraint:constraint];
  return constraint;
}

+ (NSArray*) installVisualFormats:(NSArray*)visualFormats
                        withViews:(NSDictionary*)viewsDictionary
                           inView:(UIView*)view
{
  NSArray* constraints = [AutoLayoutUtility createConstraintsWithVisualFormats:visualFormats
                                                                         views:viewsDictionary];
  [view addConstraints:constraints];
  return constraints;
}

+ (NSArray*) createConstraintsWithVisualFormats:(NSArray*)visualFormats
                                          views:(NSDictionary*)viewsDictionary
{
  NSMutableArray* generatedConstraints = [NSMutableArray array];
  for (NSString* visualFormat in visualFormats)
  {
    NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [generatedConstraints addObjectsFromArray:constraints];
  }
  return generatedConstraints;
}

@end
