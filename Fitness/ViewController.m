//
//  ViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 25/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ViewController.h"
#import "FooterClass.h"
#import "CKCalendarView.h"
#import "JsonViewController.h"
#import "StartProgressViewController.h"

@interface ViewController ()<footerdelegate,CKCalendarDelegate>
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@end

@implementation ViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSDate *todayDate2 = [NSDate date];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MMMM-d"];
    NSString *convertedDateString2 = [dateFormatter2 stringFromDate:todayDate2];
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
    NSString *convertedDateString3 = [dateFormatter3 stringFromDate:todayDate2];
    
    [[NSUserDefaults standardUserDefaults]setObject:convertedDateString3 forKey:@"Selected_Date"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    // Setting Main Date //
    
    
   NSArray *Date_chunks = [convertedDateString2 componentsSeparatedByString: @"-"];
    
    
    _Date_Digit.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:2]];
    _Date_Text.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:1]];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    /// Getting user details
    
    
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:1];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_FooterBase.frame.size.width,_FooterBase.frame.size.height);
    [_FooterBase addSubview:foot];
    

    
//    NSDate *todayDate = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];
    
    
    standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    NSString *selectedDate = [standardUserDefaults stringForKey:@"Selected_Date"];
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_all_events_for_date/?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,selectedDate] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         
         NSMutableArray *data_array=[[NSMutableArray alloc]init];
         data_array=[JsonResult mutableCopy];
         
         if (!data_array.count==0)
         {
             training_details=[[NSMutableArray alloc]init];
             training_details=[[JsonResult objectForKey:@"all_exercises"]mutableCopy];
             
             NSLog(@"User Data ...%@",JsonResult);
             
             User_Data=[JsonResult mutableCopy];
             
         //    _Appointement_details.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
             
     /*        [UIView animateWithDuration:0.3/1.5 animations:^{
                 _Appointement_details.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                 
             } completion:^(BOOL finished) {
                 [UIView animateWithDuration:0.3/2 animations:^{
                     _Appointement_details.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
                 } completion:^(BOOL finished) {
                     [UIView animateWithDuration:0.3/2 animations:^{
                         _Appointement_details.transform = CGAffineTransformIdentity;
                         
                         NSString *check_string=[NSString stringWithFormat:@"%@",[User_Data objectForKey:@"total_appointment"]];
                         
                         int check=[check_string intValue];
                         
                         NSLog(@"#######....%d",check);
                         
                         if (check==0)
                         {
                             [_right_small_arrow setHidden:YES];
                         }
                         else
                         {
                             [_right_small_arrow setHidden:NO];
                         }

                     }];
                 }];
             }];        */
             
             
             

             
             NSString *training_complete=[NSString stringWithFormat:@"%@  APPOINTMENTS",[User_Data objectForKey:@"total_appointment"]];
             
             [_Appointement_details setTitle:training_complete forState:UIControlStateNormal];
             
             [_UserTable reloadData];
             [_UserTable setHidden:NO];
             
         }
         else
         {
             
         }
         
         
         
         
     }];
    
    jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/mark_calender?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         prog_dateArray=[[NSMutableArray alloc]init];
         prog_dateArray2=[[NSMutableArray alloc]init];
         prog_dateArray=[[JsonResult objectForKey:@"program_date"]mutableCopy];
         
         NSLog(@"Calendar_Data....%@",JsonResult);
         
         
         for (int i=0; i<prog_dateArray.count; i++)
         {
             
             NSString *getString=[NSString stringWithFormat:@"%@",[prog_dateArray objectAtIndex:i]];
             NSArray *foo = [getString componentsSeparatedByString: @" "];
             NSString *day =[foo objectAtIndex: 0];
             
             NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
             [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
             [dateFormat setDateFormat:@"YYYY-MM-dd"];
             NSDate *Progdate = [dateFormat dateFromString:day];
             [prog_dateArray2 addObject:Progdate];

         }
         
         
        NSLog(@"###### TEST Mode _D %@",prog_dateArray2);
         
         
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
         
         calendar.frame = CGRectMake(0,45, _CalenderBaseView.frame.size.width,_CalenderBaseView.frame.size.height);
         [_CalenderBaseView addSubview:calendar];
         
         [_hidebtn bringSubviewToFront:calendar];

         
     }];

    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    
    standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *RemindTime = [standardUserDefaults stringForKey:@"Remind_Time"];
    
    
    NSDate *todayDate22 = [NSDate date];
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@" MM/d, hh:mm aa"];
    modified_format5 = [dateFormat2 stringFromDate:todayDate22];


    NSLog(@"##########........%@",modified_format5);
    
    if (RemindTime.length>0)
    {
        [_Remind_btn setTitle:RemindTime forState:UIControlStateNormal];
        
          [_remind_cancel setTitle:@"REMOVE" forState:UIControlStateNormal];
        
    }
    else
    {
         [_remind_cancel setTitle:@"CANCEL" forState:UIControlStateNormal];
        
        [timer invalidate];
    }
    
    
   timer = [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(toggleLabelAlpha) userInfo:nil repeats:YES];
    
     [_Remind_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
}

- (void)toggleLabelAlpha
{
    
    standardUserDefaults = [NSUserDefaults standardUserDefaults];
   remidtimer = [standardUserDefaults stringForKey:@"Remind_Time"];
    
    
    NSDate *todayDate22 = [NSDate date];
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@" MM/d, hh:mm aa"];
    modified_format5 = [dateFormat2 stringFromDate:todayDate22];
    
    if([modified_format5 isEqualToString:remidtimer])
    {
    
 [_Remind_btn setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(196.0f/255.0f) blue:(0.0f/255.0f) alpha:1 ] forState:UIControlStateNormal];
        
        
    }
    else
    {
        [_Remind_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                   forIndexPath:indexPath];
    
    
    
    NSString *training_complete=[NSString stringWithFormat:@"%@/%@ exercises done",[User_Data objectForKey:@"total_training_exercise_finished"],[User_Data objectForKey:@"total_training_exercises"]];
    
    NSString *check_training=[NSString stringWithFormat:@"%@",[User_Data objectForKey:@"total_training_exercises"]];
    
    if ([check_training isEqualToString:@"0"])
    {
         training_complete=@"-";
        
        
       cell.cell_title2.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:17.0f];
    }
    else
    {
         cell.cell_title2.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:17.0f];
    }
        
    
    NSString *countcheck=[NSString stringWithFormat:@"%@",[User_Data objectForKey:@"total_meal"]];
    
    if ([countcheck isEqualToString:@"0"])
    {
        meal_count=[NSString stringWithFormat:@"-"];
    }
    else if ([countcheck isEqualToString:@"1"])
    {
         meal_count=[NSString stringWithFormat:@"%@ meal",[User_Data objectForKey:@"total_meal"]];
    }
    else
    {
        meal_count=[NSString stringWithFormat:@"%@ meals",[User_Data objectForKey:@"total_meal"]];
    }
    
    
    
    NSString *Diary_Details=[NSString stringWithFormat:@"\"%@\"",[User_Data objectForKey:@"diary_text"]];
    
    if ([Diary_Details isEqualToString:@"\"\""])
    {
        Diary_Details=@"";
    }
    
    
    democellArray=[[NSMutableArray alloc]init];
    [democellArray addObject:@"Training"];
    [democellArray addObject:@"Diet"];
    [democellArray addObject:@"Diary"];
    
    democellArray2=[[NSMutableArray alloc]init];
    [democellArray2 addObject:training_complete];
    [democellArray2 addObject:meal_count];
    [democellArray2 addObject:Diary_Details];
    
    
    cell.cell_title1.text=[NSString stringWithFormat:@"%@",[democellArray objectAtIndex:indexPath.row]];
    
    cell.cell_title2.text=[NSString stringWithFormat:@"%@",[democellArray2 objectAtIndex:indexPath.row]];
    
    cell.selectionStyle=NO;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        StartProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressdetailsPage"];
        obj.Get_Training_Details=training_details;
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
        
        
    }
    else if (indexPath.row==1)
    {
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"dietPage"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
        
    }
    else if (indexPath.row==2)
    {
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DiaryPage"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
        
        
    }
    else
    {
        
    }
}
-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
       [self.navigationController pushViewController:obj animated:NO];

    }
    else if (sender.tag==2)
    {
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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

    
    if ([self dateIsDisabled:date])
    {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
    
    
   
    int date_check;
    
   // NSLog(@"Testing Date...%lu",(unsigned long)prog_dateArray2.count);
    
   for (date_check=0; date_check<prog_dateArray2.count; date_check++)
   {
       
 NSString *mark_date=[NSString stringWithFormat:@"%@",[prog_dateArray2 objectAtIndex:date_check]];
       NSArray *Date_cut = [mark_date componentsSeparatedByString: @" "];
       
       NSString *final_date=[NSString stringWithFormat:@"%@",[Date_cut objectAtIndex:0]];
       
       
     //  NSLog(@"current_date------ %@------- %@",Current_date,final_date);
     //
       if ([Current_date isEqualToString:final_date])
       {
        
           if ([UIScreen mainScreen].bounds.size.width>320)
           {
               dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot_image2"]];
           }
           else if ([marking_Date isEqualToString:Current_date])
           {
               dateItem.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
               dateItem.textColor = [UIColor whiteColor];
               
           }
           else
           {
               dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot_image"]];
               
               
           }
           
    
           
       }
       else
       {
           
       }
    }

    
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date
{
    return ![self dateIsDisabled:date];
}



- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    
    check_date_info=date;
    
    NSDateFormatter *dateFormatter6 = [[NSDateFormatter alloc] init];
    [dateFormatter6 setDateFormat:@"yyyy-MMMM-d"];
    NSString *convertedDateString7 = [dateFormatter6 stringFromDate:date];
    
    NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
    [dateFormatter4 setDateFormat:@"yyyy-MM-dd"];
    NSString *convertedDateString4 = [dateFormatter4 stringFromDate:date];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:convertedDateString4 forKey:@"Selected_Date"];
    [[NSUserDefaults standardUserDefaults]synchronize];


    
    NSArray *Date_chunks = [convertedDateString7 componentsSeparatedByString: @"-"];
    
    _Date_Digit.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:2]];
    _Date_Text.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:1]];
    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_all_events_for_date/?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,convertedDateString4] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         NSMutableArray *data_array=[[NSMutableArray alloc]init];
         data_array=[JsonResult mutableCopy];
         
         if (!data_array.count==0)
         {
             training_details=[[NSMutableArray alloc]init];
             training_details=[[JsonResult objectForKey:@"all_exercises"]mutableCopy];
             
             NSLog(@"User Data ...%@",JsonResult);
             
             User_Data=[JsonResult mutableCopy];
             
             _Appointement_details.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
             
             [UIView animateWithDuration:0.3/1.5 animations:^{
                 _Appointement_details.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                 
             } completion:^(BOOL finished) {
                 [UIView animateWithDuration:0.3/2 animations:^{
                     _Appointement_details.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
                 } completion:^(BOOL finished) {
                     [UIView animateWithDuration:0.3/2 animations:^{
                         _Appointement_details.transform = CGAffineTransformIdentity;
                         
                         NSString *check_string=[NSString stringWithFormat:@"%@",[User_Data objectForKey:@"total_appointment"]];
                         
                         int check=[check_string intValue];
                         
                         NSLog(@"#######....%d",check);
                         
                         if (check==0)
                         {
                             [_right_small_arrow setHidden:YES];
                         }
                         else
                         {
                              [_right_small_arrow setHidden:NO];
                         }

                     }];
                 }];
             }];
             

             
             NSString *training_complete=[NSString stringWithFormat:@"%@  APPOINTMENTS",[User_Data objectForKey:@"total_appointment"]];
             
             
             [_Appointement_details setTitle:training_complete forState:UIControlStateNormal];
             
             
             
             [_UserTable reloadData];
             [_UserTable setHidden:NO];
             
         }
         else
         {
             
         }
         
         
         
     }];

    [UIView transitionWithView:_CalenderBaseView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_CalenderBaseView setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_CalenderBaseView setHidden:YES];
                        
                        [_Blackoverlay setHidden:YES];
                        
                    }
                    completion:^(BOOL finished)
     {
         
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



-(void)ButtonTap
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ShowCalender:(id)sender
{
    [UIView transitionWithView:_CalenderBaseView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_CalenderBaseView setHidden:NO];
                        
                        [_CalenderBaseView setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_Blackoverlay setHidden:NO];
                      
                        
                            }
                    completion:nil];
    
    
}
- (IBAction)hideCalender:(id)sender
{
    
    
    [UIView transitionWithView:_CalenderBaseView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_CalenderBaseView setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_CalenderBaseView setHidden:YES];
                        
                        [_Blackoverlay setHidden:YES];
                        
                    }
                    completion:^(BOOL finished)
     {
         
     }];

    
    
}
- (IBAction)appoBtn:(id)sender
{
    
    NSString *check_appo=[NSString stringWithFormat:@"%@",[User_Data objectForKey:@"total_appointment"]];
    
    int check_appo2=[check_appo intValue];
    
    if (check_appo2>1)
    {
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AppointmentsList"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
    }
    else if (check_appo2==0)
    {
        
    }
    else
    {
    ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AppoDetails"];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
    }
    
    
}

- (IBAction)RemindME:(id)sender
{
    [UIView transitionWithView:_remindview duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        
                        [_Blackoverlay setHidden:NO];
                        [_remindview setHidden:NO];
                        
                    }
                    completion:^(BOOL finished)
         {
        
        
        
        
                    }];

}
- (IBAction)RemindPopupCancel:(id)sender
{
    [UIView transitionWithView:_remindview duration:0.9 options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                        if ([_remind_cancel.titleLabel.text isEqualToString:@"REMOVE"])
                        {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Remind_Time"];
                            
                            [_Remind_btn setTitle:@"Remind me" forState:UIControlStateNormal];
                            
                             [_remind_cancel setTitle:@"CANCEL" forState:UIControlStateNormal];
                            
                            [_Remind_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                            
                            [_Blackoverlay setHidden:YES];
                            [_remindview setHidden:YES];
                        }
                        else
                        {
                            [_Blackoverlay setHidden:YES];
                            [_remindview setHidden:YES];
                        }
                    
                    }
                    completion:^(BOOL finished)
    {
         
    
         
         
     }];

    
}

- (IBAction)Set_reminder:(id)sender
{
    [UIView transitionWithView:_remindview duration:0.9 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        [_Blackoverlay setHidden:YES];
                        [_remindview setHidden:YES];
                        
                    
                    }
                    completion:^(BOOL finished)
     {
         NSDate *myDate = _Remind_picker.date;
         
         Remind_alert_date=_Remind_picker.date;
         
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
         [dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
         
         NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
         [dateFormat2 setDateFormat:@" MM/d, hh:mm aa"];
         
         NSString *modified_format = [dateFormat stringFromDate:myDate];
         
         NSString *modified_format2 = [dateFormat2 stringFromDate:myDate];
         
         UIAlertView *remind_alert=[[UIAlertView alloc]initWithTitle:@"Reminder Set" message:modified_format delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [remind_alert show];
         
         
         [_Remind_btn setTitle:modified_format2 forState:UIControlStateNormal];
         //[_Remind_btn setUserInteractionEnabled:NO];
         
         
         [[NSUserDefaults standardUserDefaults]setObject:modified_format2 forKey:@"Remind_Time"];
         [[NSUserDefaults standardUserDefaults]synchronize];

        
         [_remind_cancel setTitle:@"REMOVE" forState:UIControlStateNormal];
         
         
          [_Remind_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         
         
     }];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
@end
