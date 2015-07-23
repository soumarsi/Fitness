//
//  appoViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppoTableViewCell.h"
@interface appoViewController : UIViewController
{
    NSMutableArray *appo_array;
    
    NSDate *appo_date;
    
    NSString *loggedin_userID;
    
    NSString *convertedDateString3;
    
    NSMutableArray *trainner_array;
    
    int PT,PT_id_tracker;
    
    NSMutableArray *timing_array;
    
    AppoTableViewCell *cell;
    
    NSString *check_booking,*booking_pt_id,*booking_date_value;
    
    NSString *booking_id;
    
    NSString *savedEventId;
    
    NSMutableArray *arrayofCalIDs;
    
}
@property (strong, nonatomic) IBOutlet UIView *footerbase;

- (IBAction)open_calendar:(id)sender;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *calendar_base;
@property (weak, nonatomic) IBOutlet UIView *Blackoverlay;

- (IBAction)hide_calendar:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *hidebtn;

@property (weak, nonatomic) IBOutlet UILabel *date_digit;

@property (weak, nonatomic) IBOutlet UILabel *day_value;

@property (weak, nonatomic) IBOutlet UILabel *month_value;

- (IBAction)next_button:(id)sender;
- (IBAction)previous_button:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *trainner_image;

@property (weak, nonatomic) IBOutlet UILabel *trainner_name;

@property (weak, nonatomic) IBOutlet UILabel *trainner_address;

- (IBAction)previous_PT:(id)sender;

- (IBAction)next_PT:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *booking_table;

@property (weak, nonatomic) IBOutlet UIImageView *button_image;

@property (weak, nonatomic) IBOutlet UIButton *PT_right;

@property (weak, nonatomic) IBOutlet UIButton *PT_left;

@end
