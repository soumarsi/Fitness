//
//  DietViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietViewController : UIViewController
{
    NSMutableArray *diet_details;

    NSMutableArray *diet_data;
    
    NSString *loggedin_userID;
    
    NSString *selectedDate;
    
}
@property (strong, nonatomic) IBOutlet UIView *footerbase;
- (IBAction)BackTOcalender:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *diettable;
- (IBAction)calendar:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *calendar_base;

@property (weak, nonatomic) IBOutlet UIButton *hidebtn;
@property (weak, nonatomic) IBOutlet UIView *blackoverlay;
- (IBAction)calendar_hide:(id)sender;


@end
