//
//  PTGraphViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 22/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PTGraphViewController.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"

@interface PTGraphViewController ()

@end

@implementation PTGraphViewController
@synthesize Get_data,get_unit,get_graph_id;
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Getting Graph Data....%@",Get_data);
    
   
    [UIView transitionWithView:self.view duration:0.8 options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        
                         self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
                        
                    }
                    completion:nil];

    
    _Datepick.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
 /////////////////////////////////////////////////////////////////////////////
    
    
    if (Get_data.count==0)
    {
        
    }
    else
    {
        
        _deadline.text=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:0]objectForKey:@"x_axis_point"]];
        
    NSString *goalValue=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:0]objectForKey:@"y_axis_point"]];
        
    _user_weight.text=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:0]objectForKey:@"y_axis_point"]];
        
    NSString *new_str = [_user_weight.text stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
    _user_weight.text=new_str;
        
        NSString *dateString = [NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:0]objectForKey:@"x_axis_point"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *goal_date = [[NSDate alloc] init];
        
        goal_date = [dateFormatter dateFromString:dateString];
        
        [_Datepick setMinimumDate:goal_date];
        
        goalValue =[goalValue stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
        _goal_value.text=goalValue;
        
        _goal_unit.text=get_unit;
    
        NSString *point1=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:0]objectForKey:@"x_axis_point"]];
        if ([point1 isEqualToString:@"00"])
        {
            point1 =@"";

        }
        else
        {
              point1 = [point1 substringWithRange:NSMakeRange(5,5)];
        }
     
        
        NSString *point2=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:1]objectForKey:@"x_axis_point"]];
     
        if ([point2 isEqualToString:@"00"])
        {
            point2 =@"";
        }
        else
        {
            point2 = [point2 substringWithRange:NSMakeRange(5,5)];
        }

        
        NSString *point3=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:2]objectForKey:@"x_axis_point"]];
      
        if ([point3 isEqualToString:@"00"])
        {
            point3 =@"";
        }
        else
        {
            point3 = [point3 substringWithRange:NSMakeRange(5,5)];
        }

        
        NSString *point4=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:3]objectForKey:@"x_axis_point"]];
     
        if ([point4 isEqualToString:@"00"])
        {
            point4 =@"";

        }
        else
        {
            point4 = [point4 substringWithRange:NSMakeRange(5,5)];
        }

        
        NSString *point5=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:4]objectForKey:@"x_axis_point"]];
        if ([point5 isEqualToString:@"00"])
        {
            point5 =@"";
        }
        else
        {
            point5 = [point5 substringWithRange:NSMakeRange(5,5)];
        }

        
        NSString *point6=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:5]objectForKey:@"x_axis_point"]];
        if ([point6 isEqualToString:@"00"])
        {
            point6 =@"";
        }
        else
        {
            point6 = [point6 substringWithRange:NSMakeRange(5,5)];
        }

    
        NSString *point7=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:6]objectForKey:@"x_axis_point"]];
        
        if ([point7 isEqualToString:@"00"])
        {
            point7 =@"";
        }
        else
        {
            point7 = [point7 substringWithRange:NSMakeRange(5,5)];
        }

    
        NSString *point8=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:7]objectForKey:@"x_axis_point"]];
        if ([point8 isEqualToString:@"00"])
        {
            point8 =@"";
        }
        else
        {
            point8 = [point8 substringWithRange:NSMakeRange(5,5)];
        }

    
        NSString *point9=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:8]objectForKey:@"x_axis_point"]];
        if ([point9 isEqualToString:@"00"])
        {
            point9 =@"";
        }
        else
        {
            point9 = [point9 substringWithRange:NSMakeRange(5,5)];
        }

        
        NSString *point10=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:9]objectForKey:@"x_axis_point"]];
        if ([point10 isEqualToString:@"00"])
        {
            point10 =@"";
        }
        else
        {
            point10 = [point10 substringWithRange:NSMakeRange(5,5)];
        }
    
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber1 = [f numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:0]objectForKey:@"y_axis_point"]]];
        
           
        NSNumberFormatter * f1 = [[NSNumberFormatter alloc] init];
        [f1 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber2 = [f1 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:1]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
        [f2 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber3 = [f2 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:2]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f3 = [[NSNumberFormatter alloc] init];
        [f3 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber4 = [f3 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:3]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f4 = [[NSNumberFormatter alloc] init];
        [f4 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber5 = [f4 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:4]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f5 = [[NSNumberFormatter alloc] init];
        [f5 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber6 = [f5 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:5]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f6 = [[NSNumberFormatter alloc] init];
        [f6 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber7 = [f6 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:6]objectForKey:@"y_axis_point"]]];
    
        NSNumberFormatter * f7 = [[NSNumberFormatter alloc] init];
        [f7 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber8 = [f7 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:7]objectForKey:@"y_axis_point"]]];
    
        NSNumberFormatter * f8 = [[NSNumberFormatter alloc] init];
       [f8 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber9 = [f8 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:8]objectForKey:@"y_axis_point"]]];
    
        NSNumberFormatter * f9 = [[NSNumberFormatter alloc] init];
       [f9 setNumberStyle:NSNumberFormatterDecimalStyle];
       NSNumber * myNumber10 = [f9 numberFromString:[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:9]objectForKey:@"y_axis_point"]]];
        
        _GraphBase.frame=CGRectMake(_GraphBase.frame.origin.x,_GraphBase.frame.origin.y,[UIScreen mainScreen].bounds.size.height, _GraphBase.frame.size.height);
        
        
        OVGraphView *graphview=[[OVGraphView alloc]initWithFrame:CGRectMake(0,0, _GraphBase.frame.size.width, _GraphBase.frame.size.height) ContentSize:CGSizeMake(_GraphBase.frame.size.width, _GraphBase.frame.size.height)];
        
        [_GraphBase addSubview:graphview];
        
        [graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:point1 YValue:myNumber1],[[OVGraphViewPoint alloc]initWithXLabel:point2 YValue:myNumber2 ],[[OVGraphViewPoint alloc]initWithXLabel:point3 YValue:myNumber3 ],[[OVGraphViewPoint alloc]initWithXLabel:point4 YValue:myNumber4],[[OVGraphViewPoint alloc]initWithXLabel:point5 YValue:myNumber5 ],[[OVGraphViewPoint alloc]initWithXLabel:point6 YValue:myNumber5 ],[[OVGraphViewPoint alloc]initWithXLabel:point6 YValue:myNumber6],[[OVGraphViewPoint alloc]initWithXLabel:point7 YValue:myNumber7 ],[[OVGraphViewPoint alloc]initWithXLabel:point8 YValue:myNumber8 ],[[OVGraphViewPoint alloc]initWithXLabel:point9 YValue:myNumber9],[[OVGraphViewPoint alloc]initWithXLabel:point10 YValue:myNumber10]]];
        
    }
    
    [_Datepick addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    
   
}
- (void) dateUpdated:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    date_pick_date = [formatter stringFromDate:datePicker.date];
    
    [_set_value setTitle:@"Done" forState:UIControlStateNormal];

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

- (void)didReceiveMemoryWarning
{
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

- (IBAction)BackBTN:(id)sender
{
    [self POPViewController];
}
- (IBAction)ADD_measurement:(id)sender
{
    [UIView transitionWithView:_Add_Base duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        
                        [_Add_Base setHidden:NO];
                        [_Black_Layer setHidden:NO];
                    }
                    completion:nil];

   
}
- (IBAction)CancelADDPOP:(id)sender
{
    [UIView transitionWithView:_Add_Base duration:0.9 options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                        [_Add_Base setHidden:YES];
                        [_Black_Layer setHidden:YES];

                    }
                    completion:nil];
   }

- (IBAction)DoneADDpop:(id)sender
{
    
    if (date_pick_date.length==0)
    {
        [_set_value setTitle:@"Select a Date" forState:UIControlStateNormal];
    }
    else
    {
    
    [UIView transitionWithView:_Add_Base duration:0.9 options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                        [_Add_Base setHidden:YES];
                        [_Black_Layer setHidden:YES];
                        
                    }
                    completion:nil];
    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/add_measurement?graph_id=%@&date=%@&measurement=%@",App_Domain_Url,get_graph_id,date_pick_date,_user_weight.text] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         NSLog(@"Adding....%@",JsonResult);
         
         
         JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
         [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/graph_details?graph_id=%@",App_Domain_Url,get_graph_id] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
          
        {
         
              NSLog(@"Refresh Data....%@",[JsonResult objectForKey:@"points"]);
            
            
            Get_data=[[JsonResult objectForKey:@"points"]mutableCopy];
            
            [self viewDidLoad];
              
        }];
         
     }];
        
    }

}
- (IBAction)plus:(id)sender
{
    weight=[_user_weight.text intValue];
    
    weight=weight+1;
    
    _user_weight.text=[NSString stringWithFormat:@"%d",weight];
    
}

- (IBAction)minus:(id)sender
{
    weight=[_user_weight.text intValue];
    
    weight=weight-1;
    
     _user_weight.text=[NSString stringWithFormat:@"%d",weight];
}

@end
