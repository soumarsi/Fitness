//
//  appoViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "appoViewController.h"
#import "FooterClass.h"
#import "AppoTableViewCell.h"
#import "CKCalendarView.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
#import "PTappodetailsViewController.h"
#import "PTappodetailsViewController.h"
#import <EventKit/EventKit.h>

@interface appoViewController ()<footerdelegate,UITableViewDelegate,UITableViewDataSource,CKCalendarDelegate>
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@end

@implementation appoViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:2];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];

    
    
    /// Setting Date ////
    
    
    NSDate *todayDate2 = [NSDate date];
    appo_date=todayDate2;
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"EEEE MMMM d YYYY"];
    NSString *convertedDateString2 = [dateFormatter2 stringFromDate:todayDate2];
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
    convertedDateString3 = [dateFormatter3 stringFromDate:todayDate2];
    
    booking_date_value=convertedDateString3;
    
   // [[NSUserDefaults standardUserDefaults]setObject:convertedDateString3 forKey:@"Selected_Date"];
   // [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSArray *Date_chunks = [convertedDateString2 componentsSeparatedByString: @" "];
    
    
   // NSLog(@"#### Date Test...%@",Date_chunks);
    
    _date_digit.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:2]];
     _day_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:0]];
     _month_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:1]];
    
    
    ////
    
    
   NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
   loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];

    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/mark_calender?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         NSMutableArray *data_check=[[NSMutableArray alloc]init];
         data_check=[JsonResult mutableCopy];
         
         if (data_check.count==0)
         {
             
         }
         else
         {
             appo_array=[[NSMutableArray alloc]init];
             appo_array=[[JsonResult objectForKey:@"appointment_date"]mutableCopy];
             
            ////// Accessing ical integration ////
             
             
             for (int c=0; c<appo_array.count; c++)
             {
                 
                 NSString *dateStr =[NSString stringWithFormat:@"%@",[appo_array objectAtIndex:c]];
                 
                 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                 [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm aa"];
                 [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
                 NSDate *event_date = [dateFormat dateFromString:dateStr];
                 
                 NSLog(@"#####>>>>>######....%@",event_date);
                 
                 EKEventStore *store = [EKEventStore new];
                 [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                     if (!granted) { return; }
                     EKEvent *event = [EKEvent eventWithEventStore:store];
                     event.title = @"PT-Planner Appointment";
                     event.startDate = event_date;
                     event.endDate = [event_date dateByAddingTimeInterval:60*60];
                     event.calendar = [store defaultCalendarForNewReminders];
                     NSError *err = nil;
                     
                     [store saveEvent:event span:EKSpanThisEvent error:&err];
                     NSString* str = [[NSString alloc] initWithFormat:@"%@", event.eventIdentifier];
                     [arrayofCalIDs addObject:str];
                     
                     event = [store eventWithIdentifier:[arrayofCalIDs objectAtIndex:c]];
                     if (event != nil) {
                         NSError* error = nil;
                         [store removeEvent:event span:EKSpanThisEvent error:&error];
                     }
                     
                    [store saveEvent:event span:EKSpanThisEvent error:&err];
                     
                     [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                    
                     
                     savedEventId = event.eventIdentifier;
                     
                 }];

             }

            
             
             
             
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
             
             calendar.frame = CGRectMake(0,45, _calendar_base.frame.size.width,_calendar_base.frame.size.height);
             [_calendar_base addSubview:calendar];
             
             [_hidebtn bringSubviewToFront:calendar];
         }
         
         
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_by_date?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,convertedDateString3] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          {
              
              NSMutableArray *data_check=[[NSMutableArray alloc]init];
              data_check=[JsonResult mutableCopy];
              
              if (data_check.count==0)
              {
                  
              }
              else
              {
                   NSLog(@"#### PT Data....%@",[JsonResult objectForKey:@"trainer"]);
                  
                  trainner_array=[[NSMutableArray alloc]init];
                  trainner_array=[[JsonResult objectForKey:@"trainer"] mutableCopy];

                  
                  if (trainner_array.count>1)
                  {
                      [_PT_left setImage:[UIImage imageNamed:@"leftarrow2"] forState:UIControlStateNormal];
                      [_PT_right setImage:[UIImage imageNamed:@"rightarrow2"] forState:UIControlStateNormal];
                  }
                  else
                  {
                      [_PT_left setImage:[UIImage imageNamed:@"leftarrow3"] forState:UIControlStateNormal];
                      [_PT_right setImage:[UIImage imageNamed:@"rightarrow3"] forState:UIControlStateNormal];
                  }

                 
                  
    [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];

     _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
     _trainner_image.clipsToBounds=YES;
     _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
                  
    
    _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_name"]];
    
    _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"working_address"]];
                  
                  
              }
              
    booking_pt_id=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"]];
              
              
              JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
              [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
               
               {
                   
                   NSMutableArray *data_array=[[NSMutableArray alloc]init];
                   data_array=[JsonResult mutableCopy];
                   

                   if (data_array.count==0)
                   {
                       
                   }
                   else
                   {
                   
                       timing_array=[[NSMutableArray alloc]init];
                       timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                       
                        NSLog(@"# Timing Data....%@",timing_array);
                       
                       [_booking_table reloadData];
                  }
               }];

              
             
              
          }];

         
    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    
    /// starting loop value ////
    
    PT=1;

    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    ////// Accessing ical integration ////
    
    
//    for (int c=0; c<appo_array.count; c++)
//    {
//        
//        NSString *dateStr =[NSString stringWithFormat:@"%@",[appo_array objectAtIndex:c]];
//        
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm aa"];
//        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
//        NSDate *event_date = [dateFormat dateFromString:dateStr];
//        
//        NSLog(@"#####>>>>>######....%@",event_date);
//        
//        EKEventStore *store = [EKEventStore new];
//        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//            if (!granted) { return; }
//            EKEvent *event = [EKEvent eventWithEventStore:store];
//            event.title = @"PT-Planner Appointment";
//            event.startDate = event_date;
//            event.endDate = [event_date dateByAddingTimeInterval:60*60];
//            event.calendar = [store defaultCalendarForNewReminders];
//            NSError *err = nil;
//            
//            [store saveEvent:event span:EKSpanThisEvent error:&err];
////            NSString* str = [[NSString alloc] initWithFormat:@"%@", event.eventIdentifier];
////            [arrayofCalIDs addObject:str];
////            
////            event = [store eventWithIdentifier:[arrayofCalIDs objectAtIndex:c]];
////            if (event != nil) {
////                NSError* error = nil;
////                [store removeEvent:event span:EKSpanThisEvent error:&error];
////            }
//            
//            [store saveEvent:event span:EKSpanThisEvent error:&err];
//            
//            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
//            
//            
//            savedEventId = event.eventIdentifier;
//            
//        }];
//        
//    }

}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        appoViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        appoViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        appoViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
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




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [timing_array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
   
    
    cell.timing.text=[NSString stringWithFormat:@"%@ - %@",[[timing_array objectAtIndex:indexPath.row]objectForKey:@"slot_start"],[[timing_array objectAtIndex:indexPath.row]objectForKey:@"slot_end"]];
    
     cell.app_name.text=[NSString stringWithFormat:@"%@",[[timing_array objectAtIndex:indexPath.row]objectForKey:@"counter"]];
    
    
    check_booking=[NSString stringWithFormat:@"%@",[[timing_array objectAtIndex:indexPath.row]objectForKey:@"status"]];
    
    cell.cell_button.tag=indexPath.row;

    
    if ([check_booking isEqualToString:@"NB"])
    {
        [cell.cell_button setImage:[UIImage imageNamed:@"book"] forState:UIControlStateNormal];
        
        cell.cell_button.userInteractionEnabled=YES;
        
         [cell.cell_button addTarget:self action:@selector(booking_fuction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([check_booking isEqualToString:@"B"])
    {
       
        [cell.cell_button setImage:[UIImage imageNamed:@"booked_img"] forState:UIControlStateNormal];
        //cell.cell_button.userInteractionEnabled=NO;
        
        [cell.cell_button addTarget:self action:@selector(booking_details_page:) forControlEvents:UIControlEventTouchUpInside];

    }
     else if ([check_booking isEqualToString:@"Ex"])
    {
        [cell.cell_button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
      //  cell.cell_button.userInteractionEnabled=NO;
        
     [cell.cell_button addTarget:self action:@selector(Empty_booking) forControlEvents:UIControlEventTouchUpInside];
        
   
    }
    else
    {
          cell.cell_button.userInteractionEnabled=YES;
        
         [cell.cell_button addTarget:self action:@selector(Empty_booking) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.cell_button.tag=indexPath.row;
    
   
    
    cell.selectionStyle=NO;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)Empty_booking
{
     NSLog(@"No Booking Details");
}


-(void)booking_details_page:(UIButton *)sender
{
    booking_id=[NSString stringWithFormat:@"%@",[[timing_array objectAtIndex:sender.tag]objectForKey:@"booking_id"]];
    
    if (booking_id.length>0)
    {
        PTappodetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AppoDetails"];
        obj.booking_id=booking_id;
        [self.navigationController pushViewController:obj animated:NO];
    }
    else
    {
        
    }
    
  
}

-(void)booking_fuction:(UIButton *)sender
{
    
    NSLog(@"####.......%@",booking_date_value);
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
  
    

    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/add_booking?trainer_id=%@&client_id=%@&booking_date=%@&slot_start=%@&slot_end=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT_id_tracker]objectForKey:@"pt_id"],loggedin_userID,booking_date_value,[[timing_array objectAtIndex:sender.tag]objectForKey:@"slot_start"],[[timing_array objectAtIndex:sender.tag]objectForKey:@"slot_end"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         
             NSLog(@"Appo Data ...... %@",JsonResult);
         
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT_id_tracker]objectForKey:@"pt_id"],booking_date_value,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          
          {
              
              NSMutableArray *data_array=[[NSMutableArray alloc]init];
              data_array=[JsonResult mutableCopy];
              
              
              if (data_array.count==0)
              {
                  
              }
              else
              {
                  
                  timing_array=[[NSMutableArray alloc]init];
                  timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                  
                  //  NSLog(@"# Timing Data....%@",timing_array);
                  
                  [_booking_table reloadData];
              }
              
              
              
          }];
     }];

}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


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

- (IBAction)open_calendar:(id)sender
{
    [UIView transitionWithView:_calendar_base duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_calendar_base setHidden:NO];
                        
                        [_calendar_base setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                     [_Blackoverlay setHidden:NO];
                        
                        
                    }
                    completion:nil];
    

}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
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
    
    for (date_check=0; date_check<appo_array.count; date_check++)
    {
        
        NSString *mark_date=[NSString stringWithFormat:@"%@",[appo_array objectAtIndex:date_check]];
        NSArray *Date_cut = [mark_date componentsSeparatedByString: @" "];
        
        NSString *final_date=[NSString stringWithFormat:@"%@",[Date_cut objectAtIndex:0]];
        
        
        //  NSLog(@"current_date------ %@------- %@",Current_date,final_date);
        //
        if ([Current_date isEqualToString:final_date])
        {
            
            
            
            
            if ([UIScreen mainScreen].bounds.size.width>320)
            {
                
                dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"appo_marker2"]];
                
                
            }
            else if ([marking_Date isEqualToString:Current_date])
            {
                dateItem.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
                dateItem.textColor = [UIColor whiteColor];
                
            
            }

            else
            {
                 dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"appo_marker"]];
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
    
    appo_date=date;
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"EEEE MMMM d YYYY"];
    NSString *convertedDateString2 = [dateFormatter2 stringFromDate:appo_date];
    NSArray *Date_chunks = [convertedDateString2 componentsSeparatedByString: @" "];
    
    
//    NSLog(@"#### Date Test...%@",Date_chunks);
    
    _date_digit.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:2]];
    _day_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:0]];
    _month_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:1]];
    
    
    [UIView transitionWithView:_calendar_base duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_calendar_base setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_calendar_base setHidden:YES];
                        
                        [_Blackoverlay setHidden:YES];
                        
                    }
                    completion:^(BOOL finished)
     {
         
         NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
         [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
         convertedDateString3 = [dateFormatter3 stringFromDate:date];
         
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_by_date?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,convertedDateString3] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          {
              
              NSMutableArray *data_check=[[NSMutableArray alloc]init];
              data_check=[JsonResult mutableCopy];
              
              if (data_check.count==0)
              {
                  
              }
              else
              {
                 // NSLog(@"#### PT Data....%@",[JsonResult objectForKey:@"trainer"]);
                  
                  trainner_array=[[NSMutableArray alloc]init];
                  trainner_array=[[JsonResult objectForKey:@"trainer"] mutableCopy];
                  
                
                  if (trainner_array.count>1)
                  {
                      [_PT_left setImage:[UIImage imageNamed:@"leftarrow2"] forState:UIControlStateNormal];
                      [_PT_right setImage:[UIImage imageNamed:@"rightarrow2"] forState:UIControlStateNormal];
                  }
                  else
                  {
                      [_PT_left setImage:[UIImage imageNamed:@"leftarrow3"] forState:UIControlStateNormal];
                      [_PT_right setImage:[UIImage imageNamed:@"rightarrow3"] forState:UIControlStateNormal];
                  }

                  
                  [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                  
                  _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
                  _trainner_image.clipsToBounds=YES;
                  _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
                  
                  
                  _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_name"]];
                  
                  _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"working_address"]];
                  
                  
                  
              }
              
        booking_pt_id=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"]];
              
              JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
              [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
               
               {
                   
                   NSMutableArray *data_array=[[NSMutableArray alloc]init];
                   data_array=[JsonResult mutableCopy];
                   
                   
                   if (data_array.count==0)
                   {
                       
                   }
                   else
                   {
                       
                       timing_array=[[NSMutableArray alloc]init];
                       timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                       
                      // NSLog(@"# Timing Data....%@",timing_array);
                       
                       [_booking_table reloadData];
                   }
               }];
              

              
              
          }];

         
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

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}


- (IBAction)hide_calendar:(id)sender
{
    
    [UIView transitionWithView:_calendar_base duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_calendar_base setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_calendar_base setHidden:YES];
                        
                        [_Blackoverlay setHidden:YES];
                        
                    }
                    completion:^(BOOL finished)
     {
         
     }];
    
    

}
- (IBAction)next_button:(id)sender
{
    int daysToAdd = 1;
    appo_date = [appo_date dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"EEEE MMMM d YYYY"];
    NSString *convertedDateString2 = [dateFormatter2 stringFromDate:appo_date];
    NSArray *Date_chunks = [convertedDateString2 componentsSeparatedByString: @" "];
    
    
    _date_digit.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:2]];
    _day_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:0]];
    _month_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:1]];
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
    convertedDateString3 = [dateFormatter3 stringFromDate:appo_date];
    
     booking_date_value=convertedDateString3;
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_by_date?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,convertedDateString3] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         NSMutableArray *data_check=[[NSMutableArray alloc]init];
         data_check=[JsonResult mutableCopy];
         
         if (data_check.count==0)
         {
             
         }
         else
         {
             
             trainner_array=[[NSMutableArray alloc]init];
             trainner_array=[[JsonResult objectForKey:@"trainer"] mutableCopy];
             
             NSLog(@"#### PT Data....%@",trainner_array);

             if (trainner_array.count>1)
             {
                 [_PT_left setImage:[UIImage imageNamed:@"leftarrow2"] forState:UIControlStateNormal];
                 [_PT_right setImage:[UIImage imageNamed:@"rightarrow2"] forState:UIControlStateNormal];
             }
             else
             {
                 [_PT_left setImage:[UIImage imageNamed:@"leftarrow3"] forState:UIControlStateNormal];
                 [_PT_right setImage:[UIImage imageNamed:@"rightarrow3"] forState:UIControlStateNormal];
             }

             
             
             [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
             _trainner_image.clipsToBounds=YES;
             _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
             
             
             _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_name"]];
             
             _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"working_address"]];
             
             
             
         }
         
         
    booking_pt_id=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"]];
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          
          {
              
              NSMutableArray *data_array=[[NSMutableArray alloc]init];
              data_array=[JsonResult mutableCopy];
              
              
              if (data_array.count==0)
              {
                  
              }
              else
              {
                  
                  timing_array=[[NSMutableArray alloc]init];
                  timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                  
                 // NSLog(@"# Timing Data....%@",timing_array);
                  
                  [_booking_table reloadData];
              }
          }];
         
         
         
         
     }];
    
    


}

- (IBAction)previous_button:(id)sender
{
    int daysToAdd = -1;
    appo_date = [appo_date dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"EEEE MMMM d YYYY"];
    NSString *convertedDateString2 = [dateFormatter2 stringFromDate:appo_date];
    NSArray *Date_chunks = [convertedDateString2 componentsSeparatedByString: @" "];
    
    
    _date_digit.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:2]];
    _day_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:0]];
    _month_value.text=[NSString stringWithFormat:@"%@",[Date_chunks objectAtIndex:1]];
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
    convertedDateString3 = [dateFormatter3 stringFromDate:appo_date];
    
    booking_date_value=convertedDateString3;
    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_by_date?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,convertedDateString3] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         NSMutableArray *data_check=[[NSMutableArray alloc]init];
         data_check=[JsonResult mutableCopy];
         
         if (data_check.count==0)
         {
             
         }
         else
         {
            // NSLog(@"#### PT Data....%@",[JsonResult objectForKey:@"trainer"]);
             
             trainner_array=[[NSMutableArray alloc]init];
             trainner_array=[[JsonResult objectForKey:@"trainer"] mutableCopy];
             
             
             if (trainner_array.count>1)
             {
                 [_PT_left setImage:[UIImage imageNamed:@"leftarrow2"] forState:UIControlStateNormal];
                 [_PT_right setImage:[UIImage imageNamed:@"rightarrow2"] forState:UIControlStateNormal];
             }
             else
             {
                 [_PT_left setImage:[UIImage imageNamed:@"leftarrow3"] forState:UIControlStateNormal];
                 [_PT_right setImage:[UIImage imageNamed:@"rightarrow3"] forState:UIControlStateNormal];
             }
             
             [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
             _trainner_image.clipsToBounds=YES;
             _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
             
             
             _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_name"]];
             
             _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"working_address"]];
             
             
             
         }
        
          booking_pt_id=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"]];
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:0]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          
          {
              
              NSMutableArray *data_array=[[NSMutableArray alloc]init];
              data_array=[JsonResult mutableCopy];
              
              
              if (data_array.count==0)
              {
                  
              }
              else
              {
                  
                  timing_array=[[NSMutableArray alloc]init];
                  timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                  
                //  NSLog(@"# Timing Data....%@",timing_array);
                  
                  [_booking_table reloadData];
              }
          }];
         
         
         
         
     }];

}
- (IBAction)previous_PT:(id)sender
{
    NSLog(@"######...%d",PT);
    
    //NSString *count_str=[NSString stringWithFormat:@"%lu",(unsigned long)trainner_array.count];
    
    // int count_int = [count_str intValue];

    
    PT=PT-1;
    
    if (PT<0||PT==0)
    {
        PT=0;
        
        [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
        _trainner_image.clipsToBounds=YES;
        _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
        
        
        _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_name"]];
        
        _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"working_address"]];
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             data_array=[JsonResult mutableCopy];
             
             
             if (data_array.count==0)
             {
                 
             }
             else
             {
                 
                 timing_array=[[NSMutableArray alloc]init];
                 timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                 
                 // NSLog(@"# Timing Data....%@",timing_array);
                 
                 [_booking_table reloadData];
                 
                 PT_id_tracker=0;
             }
         }];

    }
    else if (trainner_array.count==1)
    {
        PT=0;
        
        [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
        _trainner_image.clipsToBounds=YES;
        _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
        
        
        _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_name"]];
        
        _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"working_address"]];
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             data_array=[JsonResult mutableCopy];
             
             
             if (data_array.count==0)
             {
                 
             }
             else
             {
                 
                 timing_array=[[NSMutableArray alloc]init];
                 timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                 
                 // NSLog(@"# Timing Data....%@",timing_array);
                 
                 [_booking_table reloadData];
                 
                 PT_id_tracker=0;
             }
         }];

    }
    else
    {
    
      PT=PT-1;
        
        
        [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
        _trainner_image.clipsToBounds=YES;
        _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
        
        
        _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_name"]];
        
        _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"working_address"]];
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             data_array=[JsonResult mutableCopy];
             
             
             if (data_array.count==0)
             {
                 
             }
             else
             {
                 
                 timing_array=[[NSMutableArray alloc]init];
                 timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                 
                // NSLog(@"# Timing Data....%@",timing_array);
                 
                 [_booking_table reloadData];
                 
                  PT_id_tracker=PT;
             }
         }];

       
    }
    

    
    
}

- (IBAction)next_PT:(id)sender
{
     NSLog(@"######...%d",PT);
   
   
    if (PT==trainner_array.count)
    {
        PT=0;
        [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
        _trainner_image.clipsToBounds=YES;
        _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
        
        
        _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_name"]];
        
        _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"working_address"]];
        
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             data_array=[JsonResult mutableCopy];
             
             
             if (data_array.count==0)
             {
                 
             }
             else
             {
                 
                 timing_array=[[NSMutableArray alloc]init];
                 timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                 
                 //  NSLog(@"# Timing Data....%@",timing_array);
                 
                 [_booking_table reloadData];
                 
                 PT_id_tracker=0;
             }
         }];
        

        
    }
    else if (trainner_array.count==1)
    {
        PT=0;
        
        [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
        _trainner_image.clipsToBounds=YES;
        _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
        
        
        _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_name"]];
        
        _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"working_address"]];
        
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             data_array=[JsonResult mutableCopy];
             
             
             if (data_array.count==0)
             {
                 
             }
             else
             {
                 
                 timing_array=[[NSMutableArray alloc]init];
                 timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                 
                 //  NSLog(@"# Timing Data....%@",timing_array);
                 
                 [_booking_table reloadData];
                 
                  PT_id_tracker=0;
             }
         }];
        
        
       // PT=PT+1;
        

    }
    else
    {
        PT=1;
        
        [_trainner_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        _trainner_image.layer.cornerRadius=(_trainner_image.frame.size.width)/2;
        _trainner_image.clipsToBounds=YES;
        _trainner_image.contentMode=UIViewContentModeScaleAspectFill;
        
        
        _trainner_name.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_name"]];
        
        _trainner_address.text=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"working_address"]];
        
        
        booking_pt_id=[NSString stringWithFormat:@"%@",[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"]];
        
       
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/trainer_booking_details?trainer_id=%@&date_val=%@&client_id=%@",App_Domain_Url,[[trainner_array objectAtIndex:PT]objectForKey:@"pt_id"],convertedDateString3,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             data_array=[JsonResult mutableCopy];
             
             
             if (data_array.count==0)
             {
                 
             }
             else
             {
                 
                 timing_array=[[NSMutableArray alloc]init];
                 timing_array=[[JsonResult objectForKey:@"time_slots"] mutableCopy];
                 
               //  NSLog(@"# Timing Data....%@",timing_array);
                 
                 [_booking_table reloadData];
             }
             
             PT_id_tracker=PT;
             
               PT=PT+1;
             
             
         }];
        
        
      

    }
    
   

}
@end
