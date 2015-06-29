//
//  AppoListTableViewCell.h
//  Fitness
//
//  Created by ios on 11/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppoListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *PT_name;
@property (weak, nonatomic) IBOutlet UILabel *Start_time;
@property (weak, nonatomic) IBOutlet UILabel *End_time;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
