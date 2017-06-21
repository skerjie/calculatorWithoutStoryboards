//
//  CustomButton.m
//  EpamCalculator
//
//  Created by Andrei Palonski on 20.06.17.
//  Copyright © 2017 Andrei Palonski. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithFrameMyCustomBtnWIth:(CGRect)rect andText:(NSString*)text {
  
  CustomButton* button = [[CustomButton alloc] initWithFrame:rect];

  [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor colorWithRed:180.0/255.0 green:40.0/255.0 blue:108.0/255.0 alpha:0.7] forState:UIControlStateHighlighted];
  button.layer.cornerRadius = 5.0;
  button.layer.masksToBounds = YES;
  button.layer.borderWidth = 1.0;
  button.layer.borderColor = [UIColor redColor].CGColor;
  [button setTitle:text forState:UIControlStateNormal];
  button.titleLabel.font = [UIFont fontWithName: @"HelveticaNeue-Light" size: 40];
  button.titleLabel.shadowColor = [UIColor darkGrayColor];
  button.titleLabel.shadowOffset = CGSizeMake(-1.0, 2.0);
  button.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:88.0/255.0 blue:85.0/255.0 alpha:0.7];
  
  return button;
  
}

@end
