//
//  AppoListViewController.m
//  Fitness
//
//  Created by ios on 11/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "AppoListViewController.h"
#import "AppoListTableViewCell.h"
#import "FooterClass.h"
#import "JsonViewController.h"
#import "PTappodetailsViewController.h"
@interface AppoListViewController ()<UITableViewDelegate,UITableViewDataSource,footerdelegate>
{
    NSMutableArray *jsonarr;
    //JsonViewController *obj;
    NSMutableDictionary *maindic;
    NSMutableArray *marr;
}

@end

@implementation AppoListViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabview.delegate=self;
    self.tabview.dataSource=self;
    
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:1];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_FooterBase.frame.size.width,_FooterBase.frame.size.height);
    [_FooterBase addSubview:foot];
    // Do any additional setup after loading the view.
    
    
  
   NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
   NSString *loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
   NSString *selectedDate = [standardUserDefaults stringForKey:@"Selected_Date"];
    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_all_booking?client_id=%@&date_val=%@",App_Domain_Url,loggedin_userID,selectedDate] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         appo_data=[[NSMutableArray alloc]init];
         
         appo_data=[[JsonResult objectForKey:@"bookings"]mutableCopy];
         
         
         NSLog(@"appo Data ...%@",appo_data);
         
         
         [_tabview reloadData];
         
     }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appo_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppoListTableViewCell *cell=(AppoListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"appolist"];
    
    cell.PT_name.text=[NSString stringWithFormat:@"%@",[[appo_data objectAtIndex:indexPath.row]objectForKey:@"trainer_name"]];
    
    

    NSString *str=[NSString stringWithFormat:@"%@",[[appo_data objectAtIndex:indexPath.row] objectForKey:@"booking_time_start"]];

    
    cell.Start_time.text = [str substringWithRange:NSMakeRange(0,5)];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[[appo_data objectAtIndex:indexPath.row] objectForKey:@"booking_time_end"]];

     cell.End_time.text=[str1 substringWithRange:NSMakeRange(0,5)];

    
    NSString *booking_date2=[NSString stringWithFormat:@"%@",[[appo_data objectAtIndex:indexPath.row]objectForKey:@"booked_date"]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *b_date = [dateFormat dateFromString:booking_date2];
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"EEEE MMMM d, YYYY"];
    NSString *convertedDateString5 = [dateFormatter3 stringFromDate:b_date];

    
   cell.date.text=convertedDateString5;

    
      return cell;
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

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        
        AppoListViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        AppoListViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
        [self.navigationController pushViewController:obj animated:NO];
        
    }
    else if (sender.tag==2)
    {
        AppoListViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    
    else
    {
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTappodetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AppoDetails"];
    obj.booking_id=[[appo_data objectAtIndex:indexPath.row]objectForKey:@"id"];
    [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];
}

- (IBAction)backtomainview:(id)sender
{
    [self.navigationController popViewControllerAnimated:kCAMediaTimingFunctionEaseOut];
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

@end
