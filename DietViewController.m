//
//  DietViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "DietViewController.h"
#import "FooterClass.h"
#import "DietTableViewCell.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
#import "DietDetailsViewController.h"
#import "CKCalendarView.h"
@interface DietViewController ()<footerdelegate,UITableViewDataSource,UITableViewDelegate,CKCalendarDelegate>
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@end

@implementation DietViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _diettable.delegate=self;
    _diettable.dataSource=self;
    
    FooterClass *foot=[[FooterClass alloc]init];
    foot.Delegate=self;
    [foot TapCheck:1];
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];
    
    
    /// Getting Diet Details
    
    
//    NSDate *todayDate = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];
    
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    selectedDate = [standardUserDefaults stringForKey:@"Selected_Date"];
    

    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/date_respective_client_meal?logged_in_user=%@&date_val=%@",App_Domain_Url,loggedin_userID,selectedDate] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
        
         NSMutableArray *data_array=[[NSMutableArray alloc]init];
         data_array=[JsonResult mutableCopy];
         
        
         
         
         if (!data_array.count==0)
         {
             diet_details=[[NSMutableArray alloc]init];
             diet_details=[[JsonResult objectForKey:@"meal"]mutableCopy];
             
             NSLog(@"Diet Data ...%@",diet_details);
             
             [_diettable reloadData];
         }
         else
         {
        UIAlertView *no_data=[[UIAlertView alloc]initWithTitle:@"" message:@"Zero Calorie Diet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [no_data show];
         }
         
         
               
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/mark_calender?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          {
              
              NSMutableArray *data_check=[[NSMutableArray alloc]init];
              data_check=[JsonResult mutableCopy];
              
              NSLog(@"#########....%@",data_check);
              
              if (data_check.count==0)
              {
                 

              }
              else
              {
                  
                  diet_data=[[NSMutableArray alloc]init];
                  diet_data=[[JsonResult objectForKey:@"meal_date"]mutableCopy];
                  
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
              
              
              
          }];

     }];

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [diet_details count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cellid";
    DietTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                 forIndexPath:indexPath];
    
    
 [cell.diet_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[diet_details objectAtIndex:indexPath.row]objectForKey:@"meal_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    cell.diet_image.clipsToBounds=YES;
    cell.diet_image.contentMode=UIViewContentModeScaleAspectFill;
    
    
    cell.diet_title.text=[NSString stringWithFormat:@"%@",[[diet_details objectAtIndex:indexPath.row]objectForKey:@"meal_title"]];
    
    cell.diet_details.text=[NSString stringWithFormat:@"%@",[[diet_details objectAtIndex:indexPath.row]objectForKey:@"meal_description"]];

    
    cell.selectionStyle=NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DietDetailsViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"dietdetailsPage"];
    newView.diet_id=[NSString stringWithFormat:@"%@",[[diet_details objectAtIndex:indexPath.row]objectForKey:@"meal_id"]];
    
    newView.Custom_diet_id=[NSString stringWithFormat:@"%@",[[diet_details objectAtIndex:indexPath.row]objectForKey:@"custom_meal_id"]];
    
    [self.navigationController pushViewController:newView animated:NO];
}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        DietViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        DietViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        DietViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==2)
    {
        DietViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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
- (IBAction)BackTOcalender:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)calendar:(id)sender
{
    [UIView transitionWithView:_calendar_base duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_calendar_base setHidden:NO];
                        
                        [_calendar_base setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_blackoverlay setHidden:NO];
                        
                        
                    }
                    completion:nil];

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
    
    for (date_check=0; date_check<diet_data.count; date_check++)
    {
        
        NSString *mark_date=[NSString stringWithFormat:@"%@",[diet_data objectAtIndex:date_check]];
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
                dateItem.textColor = [UIColor whiteColor];            }

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
    
    
    [UIView transitionWithView:_calendar_base duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_calendar_base setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                        [_calendar_base setHidden:YES];
                        
                        [_blackoverlay setHidden:YES];
                        
                    }
                    completion:^(BOOL finished)
     {
         
         NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
         [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
        NSString *convertedDateString3 = [dateFormatter3 stringFromDate:date];
         
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/date_respective_client_meal?logged_in_user=%@&date_val=%@",App_Domain_Url,loggedin_userID,convertedDateString3] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          
          {
              
              NSMutableArray *data_array=[[NSMutableArray alloc]init];
              data_array=[JsonResult mutableCopy];
              
              
              if (!data_array.count==0)
              {
                  diet_details=[[NSMutableArray alloc]init];
                  diet_details=[[JsonResult objectForKey:@"meal"]mutableCopy];
                  
                  NSLog(@"Diet Data ...%@",diet_details);
                  
                  [_diettable reloadData];
              }
              else
              {
                  UIAlertView *no_data=[[UIAlertView alloc]initWithTitle:@"" message:@"Zero Calorie Diet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                  
                  [no_data show];
              }
              
              
              
              
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

- (IBAction)calendar_hide:(id)sender
{
    [UIView transitionWithView:_calendar_base duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        [_calendar_base setFrame:CGRectMake(0,18,[UIScreen mainScreen].bounds.size.width,380)];
                        
                     
                        [_calendar_base setHidden:YES];

                        [_blackoverlay setHidden:YES];
                        
                    }
                    completion:^(BOOL finished)
     {
         
         
         
     }];
    

}
@end
