//
//  AutoLayoutUtility.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
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
