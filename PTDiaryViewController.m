//
//  PTDiaryViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 10/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PTDiaryViewController.h"
#import "CKCalendarView.h"
#import "FooterClass.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"

@interface PTDiaryViewController ()<CKCalendarDelegate,footerdelegate>
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation PTDiaryViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FooterClass *foot=[[FooterClass alloc]init];
    foot.Delegate=self;
    [foot TapCheck:1];
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];

    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    selectedDate = [standardUserDefaults stringForKey:@"Selected_Date"];

    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/mark_calender?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         NSMutableArray *data_array=[[NSMutableArray alloc]init];
         data_array=[JsonResult mutableCopy];

         if (data_array.count==0)
         {
             
         }
         else
             
         {
         
         diary_date_array=[[NSMutableArray alloc]init];
         diary_date_array2=[[NSMutableArray alloc]init];
         diary_date_array=[[JsonResult objectForKey:@"diary_date"]mutableCopy];
         
         }
    

    
         for (int i=0; i<diary_date_array.count; i++)
         {
             
             NSString *getString=[NSString stringWithFormat:@"%@",[diary_date_array objectAtIndex:i]];
             NSArray *foo = [getString componentsSeparatedByString: @" "];
             NSString *day =[foo objectAtIndex: 0];
             
             NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
             [dateFormat setDateFormat:@"yyyy-MM-dd"];
            [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
             NSDate *Progdate = [dateFormat dateFromString:day];
             [diary_date_array2 addObject:Progdate];
             
         }
         
        //NSLog(@">>>>>>>>>>>>>>>>> %@",diary_date_array2);
         
         Calendar_status=0;
         
         
         CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
         calendar = calendar;
         calendar.delegate = self;
         
         self.dateFormatter = [[NSDateFormatter alloc] init];
         [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
         self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
         
         self.disabledDates = @[
                                //                [self.dateFormatter dateFromString:@"05/01/2013"],
                                //                [self.dateFormatter dateFromString:@"06/01/2013"],
                                //                [self.dateFormatter dateFromString:@"07/01/2013"]
                                ];
         
         calendar.onlyShowCurrentMonth = NO;
         calendar.adaptHeightToNumberOfWeeksInMonth = YES;
         
         calendar.frame = CGRectMake(0,0, _calenderBase.frame.size.width,_calenderBase.frame.size.height);
         [_calenderBase addSubview:calendar];
         
         
         
       
         
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
         

         _date.text=selectedDate;
         
     }];

    
    
  
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
   
    
    // According to current date
    
//    NSDate *todayDate = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];
    
    
    
    jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_date_respective_diary?logged_in_user=%@&date_val=%@",App_Domain_Url,loggedin_userID,selectedDate] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
    
         NSLog(@"Server_Data...%@",JsonResult);
         
         NSString *diary_check=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"dairy_text"]];
         
         if (![diary_check isEqualToString:@""])
         {
             
             Diary_Status=1;
             
             _user_profile_image.layer.cornerRadius=(_user_profile_image.frame.size.width)/2;
             _user_profile_image.clipsToBounds=YES;
             _user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
             
             [_user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"client_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             
             
             _username.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"client_name"]];
             
             _date.text=selectedDate;
             
             _diary_text.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"dairy_text"]];
             _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16.0f];
             
             diaryID=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"diary_id"]];
             
             
               _edit_icon.hidden=NO;
             
             //--//
             
//             NSLog(@">>>>>>>>>>%lu",(unsigned long)_diary_text.text.length);
             
             if (_diary_text.text.length<100)
             {
                 
             }
             else
             {
                [_Diary_Scroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,_diary_text.frame.size.height+_diary_text.contentSize.height+365+150)];
             }
             
           
             
             //--//
         }
         else
         {
             
             _user_profile_image.layer.cornerRadius=(_user_profile_image.frame.size.width)/2;
             _user_profile_image.clipsToBounds=YES;
             _user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
             
             [_user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"client_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             
             
             _username.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"client_name"]];

             
             Diary_Status=0;
             
            _diary_text.text=@"If everything is going perfect, you should write that!";
             
            _diary_text.textAlignment=NSTextAlignmentCenter;
             
             _diary_text.textColor=[UIColor grayColor];
             
            _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:20.0f];
             
             
               _edit_icon.hidden=NO;
             
             [_edit_icon setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
             
//             UIAlertView *no_data=[[UIAlertView alloc]initWithTitle:@"" message:@"No Diary Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//             
//             [no_data show];
         }
         
         
       
         
     }];
    

    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,[UIScreen mainScreen].bounds.size.width, 35.0f)];
    toolbar.barStyle=UIBarStyleDefault;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Hide_keyboard)];

    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    _diary_text.inputAccessoryView = toolbar;

    
}
-(void)Hide_keyboard
{
    [_diary_text resignFirstResponder];
    

    if (Diary_Status==1)
    {
        NSString *Header=@"PT-Planner";
        NSString *Diary=[_diary_text.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/update_a_diary?diary_id=%@&diary_heading=%@&diary_text=%@",App_Domain_Url,diaryID,Header,Diary] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             
             NSLog(@"Server_Data 2...%@",JsonResult);
             
             
             
             
         }];

    }
    else
        {
        
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];

        NSString *Header=@"PT-Planner";
        NSString *Diary=[_diary_text.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/add_date_respective_diary?logged_in_user=%@&date_val=%@&diary_heading=%@&diary_text=%@",App_Domain_Url,loggedin_userID,_date.text,Header,Diary] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             
             NSLog(@"Server_Data 3...%@",JsonResult);
             
             
             
             
         }];
            
        }

  
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    
    
    NSDate *todayDate2 = [NSDate date];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *marking_Date = [dateFormatter2 stringFromDate:todayDate2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *Current_date = [formatter stringFromDate:date];

    
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
    
    
    
    int date_check;
    
    
    for (date_check=0; date_check<diary_date_array2.count; date_check++)
    {
        
        NSString *mark_date=[NSString stringWithFormat:@"%@",[diary_date_array2 objectAtIndex:date_check]];
        NSArray *Date_cut = [mark_date componentsSeparatedByString: @" "];
        
        NSString *final_date=[NSString stringWithFormat:@"%@",[Date_cut objectAtIndex:0]];
        
       
        
    
        if ([Current_date isEqualToString:final_date])
        {
            
            if ([UIScreen mainScreen].bounds.size.width>320)
            {
                   dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"D_mark2"]];
            }
            else if ([marking_Date isEqualToString:Current_date])
            {
                dateItem.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
                dateItem.textColor = [UIColor whiteColor];            }

            else
            {
                    dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"D_mark"]];
            }
            

            
            
       
            
        }
        else
        {
            
        }
    }

}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *D_string = [formatter stringFromDate:date];

    _date.text = D_string;
    
  JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_date_respective_diary?logged_in_user=%@&date_val=%@",App_Domain_Url,loggedin_userID,D_string] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         
         NSLog(@"Diary_Server_Data...%@",JsonResult);
         
         if (![JsonResult count]==0)
         {
             
             Diary_Status=1;
             
             _user_profile_image.layer.cornerRadius=(_user_profile_image.frame.size.width)/2;
             _user_profile_image.clipsToBounds=YES;
             _user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
             
             [_user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"client_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             
             
             _username.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"client_name"]];
             
            // _date.text=selectedDate;
             
             _diary_text.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"dairy_text"]];
             _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16.0f];
             
             diaryID=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"diary_id"]];
             
             
             _edit_icon.hidden=NO;
             
             
             if (_diary_text.text.length==0)
             {
                 _diary_text.text=@"If everything is going perfect, you should write that!";
                 
                 _diary_text.textAlignment=NSTextAlignmentCenter;
                 
                 _diary_text.textColor=[UIColor grayColor];
                 
                 _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:20.0f];
                 
                 
                 _edit_icon.hidden=NO;
                 
                 [_edit_icon setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
             }
         }
         else
         {
             
             Diary_Status=0;
             
             _diary_text.text=@"If everything is going perfect, you should write that!";
             
             _diary_text.textAlignment=NSTextAlignmentCenter;
             
             _diary_text.textColor=[UIColor grayColor];
             
             _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:20.0f];
             
             
             _edit_icon.hidden=NO;
             
             [_edit_icon setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
             
             //             UIAlertView *no_data=[[UIAlertView alloc]initWithTitle:@"" message:@"No Diary Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
             //
             //             [no_data show];
         }
         
         
         
         
     }];
    

}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date)
    {
        self.calendar.backgroundColor = [UIColor whiteColor];
        return YES;
    } else
    {
        self.calendar.backgroundColor = [UIColor whiteColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    // NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
           
    
}
- (IBAction)swipup:(UISwipeGestureRecognizer *)sender
{

   
}
- (IBAction)BackToCalPage:(id)sender
{
    [self POPViewController];
}
- (IBAction)Calender:(id)sender
{
    if (Calendar_status==0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [_mainswipeView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-190,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-_topbar.frame.size.height+25)];
            
            
            [_Calendar_button setTitle:@"Hide" forState:UIControlStateNormal];
            
          _Calendar_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
        }];
        
        
        _Diary_Scroll.scrollEnabled=YES;
        
        Calendar_status=1;
        
        
    }
    else
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [_mainswipeView setFrame:CGRectMake(0,_topbar.frame.origin.y+_topbar.frame.size.height-1,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-_topbar.frame.size.height+25)];
            
            [_Diary_Scroll setContentOffset:CGPointMake(0,0)];
            
             [_Calendar_button setTitle:@"Calendar" forState:UIControlStateNormal];
            
            
               _Calendar_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            
            
        }];
        
        
        
        _Diary_Scroll.scrollEnabled=NO;
        
        Calendar_status=0;
        
       
    }
    
   

}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        
        PTDiaryViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        PTDiaryViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==2)
    {
        PTDiaryViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        PTDiaryViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }

    else
    {
        
    }
    
}

-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.01f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}

-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.01f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}



- (IBAction)diary_edit:(id)sender
{
    
if ([_diary_text.text isEqualToString:@"If everything is going perfect, you should write that!"])
  
   {
       _diary_text.textAlignment=NSTextAlignmentLeft;
       
       _diary_text.textColor=[UIColor darkGrayColor];
       
       _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16.0f];
       
     _diary_text.text=@"";
     _diary_text.editable=YES;
     [_diary_text becomeFirstResponder];
     
    }

else
{
    _diary_text.textAlignment=NSTextAlignmentLeft;
    
    _diary_text.textColor=[UIColor darkGrayColor];
    
    _diary_text.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16.0f];
    
    _diary_text.editable=YES;
    [_diary_text becomeFirstResponder];
}
    
    
}
@end
