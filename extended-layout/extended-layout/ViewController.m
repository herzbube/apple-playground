//
//  ViewController.m
//  extended-layout
//
//  Created by Patrick Näf Moser on 05.03.22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void) viewDidLoad
{
  [super viewDidLoad];

  self.title = @"Navigation bar - View controller";

  CGRect labelFrame = CGRectMake(100, 100, 200, 100);
  UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
  label.text = @"Hello world";

  [self.view addSubview:label];

  self.view.backgroundColor = [UIColor greenColor];
}


@end
