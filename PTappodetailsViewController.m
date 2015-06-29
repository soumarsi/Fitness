//
//  PTappodetailsViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 08/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PTappodetailsViewController.h"
#import "FooterClass.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
@interface PTappodetailsViewController ()<footerdelegate>

@end

@implementation PTappodetailsViewController
@synthesize booking_id;

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:1];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    NSString *selectedDate = [standardUserDefaults stringForKey:@"Selected_Date"];

    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_all_booking?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,selectedDate] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         NSMutableArray *data_check=[[NSMutableArray alloc]init];
         data_check=[JsonResult mutableCopy];
         
         if (data_check.count==0)
         {
             
         }
         else
         {
         
        NSMutableArray *appo_data=[[NSMutableArray alloc]init];
         
         appo_data=[[JsonResult objectForKey:@"bookings"]mutableCopy];
         
             
             if (appo_data.count==1)
             {
                 booking_id=[NSString stringWithFormat:@"%@",[[appo_data objectAtIndex:0] objectForKey:@"id"]];
             }
            else
            {
                                 
            }
             
         
         NSLog(@"appo Data ...%@",appo_data);
         
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_each_booking_details?booking_id=%@",App_Domain_Url,booking_id] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          {
              
             // NSLog(@"###### Test Data....%@",JsonResult);
              
              if (JsonResult)
              {
                  
                  _PT_name.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"trainer_name"]];
                  
                  [_PT_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"trainer_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                  
                  _PT_image.clipsToBounds=YES;
                  _PT_image.contentMode=UIViewContentModeScaleAspectFill;
                  _PT_image.layer.cornerRadius=(_PT_image.frame.size.width)/2;
                  
                  _program_name.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"program_name"]];
                  
                  _PT_details.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"trainer_about"]];
                  _PT_details.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16];
                  
                  
                  
                  NSString *booking_date3=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"booked_date"]];
                  
                  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                  [dateFormat setDateFormat:@"yyyy-MM-dd"];
                  NSDate *b_date = [dateFormat dateFromString:booking_date3];
                  
                  NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
                  [dateFormatter3 setDateFormat:@"EEEE MMMM d, YYYY"];
                  NSString *convertedDateString6 = [dateFormatter3 stringFromDate:b_date];

                  _Booked_date.text=convertedDateString6;
                  
                  _booking_time.text=[NSString stringWithFormat:@"%@  to  %@",[JsonResult objectForKey:@"booking_time_start"],[JsonResult objectForKey:@"booking_time_end"]];
                  
                  
                  _PT_address.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"trainer_address"]];
                  
                 NSString *cancel_ckeck=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"cancel_status"]];
                  
                  if ([cancel_ckeck isEqualToString:@"CAN"])
                  {
                      _cancel_button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                    
                      [UIView animateWithDuration:0.3/1.5 animations:^{
                          _cancel_button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                      } completion:^(BOOL finished) {
                          [UIView animateWithDuration:0.3/2 animations:^{
                              _cancel_button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
                          } completion:^(BOOL finished) {
                              [UIView animateWithDuration:0.3/2 animations:^{
                                  _cancel_button.transform = CGAffineTransformIdentity;
                                   [_cancel_button setHidden:NO];
                              }];
                          }];
                      }];
                      
                     
                  }
                  else
                  {
                      [_cancel_button setHidden:YES];
                  }
                  
              }
              else
              {
                  
              }
              
              
          }];

         }
     }];

    
    
    
    
}
-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        PTappodetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        PTappodetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        PTappodetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==2)
    {
        PTappodetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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

- (IBAction)backtoCalPage:(id)sender
{
    [self POPViewController];
     
}
- (IBAction)cancel_appo:(id)sender
{
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/cancel_booking?booking_id=%@",App_Domain_Url,booking_id] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         NSLog(@"Cancel Data....%@",booking_id);
         
             if ([[JsonResult objectForKey:@"response"]isEqualToString:@"success"])
             {
                 [_cancel_button setTitle:@"APPOINTMENT CANCELED" forState:UIControlStateNormal];
                 [_cancel_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                 _cancel_button.userInteractionEnabled=NO;
            }
             else
            {
                [_cancel_button setTitle:@"Booking Expired" forState:UIControlStateNormal];
                [_cancel_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                _cancel_button.userInteractionEnabled=NO;

                
            }
         
     }];

}
@end
