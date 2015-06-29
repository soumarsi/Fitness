//
//  ProgressTableViewCell.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *type_name;
@property (weak, nonatomic) IBOutlet UILabel *goal_value;
@property (weak, nonatomic) IBOutlet UILabel *deadline;

@property (weak, nonatomic) IBOutlet UILabel *unit;

@end
