//
//  AppoTableViewCell.h
//  Fitness
//
//  Created by Rahul Singha Roy on 01/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timing;
@property (weak, nonatomic) IBOutlet UILabel *app_name;
@property (weak, nonatomic) IBOutlet UIButton *cell_button;

- (IBAction)booking_button:(id)sender;

@end
