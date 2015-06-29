//
//  PTDiaryViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 10/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTDiaryViewController : UIViewController<UITextViewDelegate>
{
    BOOL Calendar_status,Diary_Status;
    
    NSMutableArray *diary_date_array,*diary_date_array2;
    
    NSString *diaryID;
    
    NSString *loggedin_userID;
    NSString *selectedDate;
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UIView *mainswipeView;
- (IBAction)swipup:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *topbar;
- (IBAction)BackToCalPage:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *calenderBase;
@property (strong, nonatomic) IBOutlet UIScrollView *Diary_Scroll;
- (IBAction)Calender:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Calendar_button;
@property (strong, nonatomic) IBOutlet UIView *footerbase;
@property (strong, nonatomic) IBOutlet UIImageView *user_profile_image;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *diary_text;
- (IBAction)diary_edit:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *edit_icon;

@end
