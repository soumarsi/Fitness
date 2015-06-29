//
//  MessegeTableViewCell.h
//  Fitness
//
//  Created by Rahul Singha Roy on 27/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessegeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userimage;
@property (strong, nonatomic) IBOutlet UILabel *username;

@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UILabel *msg;

@end
