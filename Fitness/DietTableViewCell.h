//
//  DietTableViewCell.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *diet_image;
@property (strong, nonatomic) IBOutlet UILabel *diet_title;

@property (strong, nonatomic) IBOutlet UILabel *diet_details;




@end

