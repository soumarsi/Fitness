//
//  GymTableViewCell.h
//  Fitness
//
//  Created by Rahul Singha Roy on 30/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GymTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *reps_count;

@property (strong, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UIButton *Edit_button;
@property (weak, nonatomic) IBOutlet UILabel *item1;
@property (weak, nonatomic) IBOutlet UILabel *item2;
@property (weak, nonatomic) IBOutlet UILabel *item3;
@property (weak, nonatomic) IBOutlet UILabel *item4;
@property (weak, nonatomic) IBOutlet UILabel *item5;
@property (weak, nonatomic) IBOutlet UIImageView *item6;
@property (weak, nonatomic) IBOutlet UIView *line_view;

@end
