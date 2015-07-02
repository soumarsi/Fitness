//
//  ViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 25/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "profilecell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    profilecell *cell;
    
    NSMutableDictionary *User_Data;
    NSUserDefaults * standardUserDefaults;
    NSMutableArray *training_details;
    NSOperationQueue *downloadQueue;
    
    NSString *meal_count;
    
    NSMutableArray *democellArray,*democellArray2,*prog_dateArray,*prog_dateArray2;
    
    NSString *loggedin_userID;
    
    NSDate *check_date_info;
    
    NSDate *Remind_alert_date;
    
    NSTimer *timer;
    
    NSString *modified_format5,*remidtimer;
    
}
@property (strong, nonatomic) IBOutlet UITableView *UserTable;
@property (strong, nonatomic) IBOutlet UIView *FooterBase;
- (IBAction)ShowCalender:(id)sender;
@property (strong, nonatomic) IBOutlet UIVisualEffectView *CalenderBaseView;
- (IBAction)hideCalender:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *hidebtn;
@property (strong, nonatomic) IBOutlet UIView *Blackoverlay;
- (IBAction)appoBtn:(id)sender;
- (IBAction)RemindME:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *remindview;
- (IBAction)RemindPopupCancel:(id)sender;

- (IBAction)Set_reminder:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *Remind_picker;
@property (strong, nonatomic) IBOutlet UIButton *Remind_btn;
-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType;


@property (strong, nonatomic) IBOutlet UILabel *Date_Digit;

@property (strong, nonatomic) IBOutlet UILabel *Date_Text;

@property (strong, nonatomic) IBOutlet UIButton *Appointement_details;


@property (weak, nonatomic) IBOutlet UIButton *remind_cancel;


@property (weak, nonatomic) IBOutlet UIImageView *right_small_arrow;

@end

