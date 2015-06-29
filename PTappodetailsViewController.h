//
//  PTappodetailsViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 08/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTappodetailsViewController : UIViewController
- (IBAction)backtoCalPage:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *footerbase;

@property (weak, nonatomic) IBOutlet UILabel *PT_name;
@property (weak, nonatomic) IBOutlet UIImageView *PT_image;
@property (weak, nonatomic) IBOutlet UILabel *program_name;

@property (weak, nonatomic) IBOutlet UITextView *PT_details;

@property (weak, nonatomic) IBOutlet UILabel *Booked_date;

@property (weak, nonatomic) IBOutlet UILabel *booking_time;

@property (weak, nonatomic) IBOutlet UILabel *PT_address;

@property (strong,nonatomic)NSString *booking_id;
- (IBAction)cancel_appo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancel_button;

@end
