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

@end
