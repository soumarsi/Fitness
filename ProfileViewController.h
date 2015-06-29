//
//  ProfileViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 04/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
{
    NSString *loggedin_userID;
    NSString *selectedDate;

    
    NSMutableDictionary *PT_Data;
}
- (IBAction)Back_Button:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *footerbase;

@property(nonatomic,assign)NSString *Chat_userId;


@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UITextView *details;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end
