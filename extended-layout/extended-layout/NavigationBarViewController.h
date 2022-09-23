//
//  NavigationBarViewController.h
//  extended-layout
//
//  Created by Patrick Näf Moser on 05.03.22.
//

#import <UIKit/UIKit.h>

@interface NavigationBarViewController : UIViewController <UINavigationBarDelegate>

- (instancetype) initWithNumberOfNavigationBars:(int)numberOfNavigationBars;

@end

