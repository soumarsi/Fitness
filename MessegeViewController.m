//
//  MessegeViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 27/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "MessegeViewController.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"
@interface MessegeViewController ()<footerdelegate>

@end

@implementation MessegeViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _messegeTable.delegate=self;
    _messegeTable.dataSource=self;
    
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:4];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    // Getting Message Data //
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    
    NSLog(@"##### Test Mode ######...%@",loggedin_userID);
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@dashboard/get_sender_list_app?logged_in_user=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         
         NSMutableArray *data_array=[[NSMutableArray alloc]init];
         data_array=[JsonResult mutableCopy];

          if (!data_array.count==0)
          {
              Message_Details_array=[[NSMutableArray alloc]init];
              Message_Details_array =[JsonResult objectForKey:@"all_user"];
              
              NSLog(@"Server_Data...%@",Message_Details_array);
              
              
              
              [_messegeTable reloadData];
              [_messegeTable setHidden:NO];

          }
         else
         {
             
         }
         
         
         
     }];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Message_Details_array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cellid";
    MessegeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                 forIndexPath:indexPath];
    
    cell.userimage.layer.cornerRadius=(cell.userimage.frame.size.width)/2;
    cell.userimage.clipsToBounds=YES;
    cell.userimage.contentMode=UIViewContentModeScaleAspectFill;
    
    [cell.userimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[Message_Details_array objectAtIndex:indexPath.row]objectForKey:@"user_image"]]] placeholderImage:[UIImage imageNamed:@"demoimage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];

    
    cell.msg.text=[NSString stringWithFormat:@"%@",[[Message_Details_array objectAtIndex:indexPath.row]objectForKey:@"last_message"]];
    
      cell.username.text=[NSString stringWithFormat:@"%@",[[Message_Details_array objectAtIndex:indexPath.row]objectForKey:@"user_name"]];
    
//      cell.time.text=[NSString stringWithFormat:@"%@",[[Message_Details_array objectAtIndex:indexPath.row]objectForKey:@"last_send_time"]];
    
    
    NSString *datestring=[NSString stringWithFormat:@"%@",[[Message_Details_array objectAtIndex:indexPath.row]objectForKey:@"last_send_time"]];
    
    NSArray *Date_cut = [datestring componentsSeparatedByString: @" "];
    
    NSString *date_part1=[NSString stringWithFormat:@"%@",[Date_cut objectAtIndex:0]];
    NSString *date_part2=[NSString stringWithFormat:@"%@",[Date_cut objectAtIndex:1]];
    
    
    NSArray *Date_cut2= [date_part2 componentsSeparatedByString: @":"];

     NSDate *currentDate = [NSDate date];
    
    NSDate *now = [NSDate date];
    int daysToAdd = -1;
    NSDate *yesterday = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *cd_string = [dateFormatter stringFromDate:currentDate];
    
    NSString *yd_string = [formatter stringFromDate:yesterday];

   
    
    NSLog(@"#####.....Test Bot...%@",[Date_cut objectAtIndex:0]);

    if ([cd_string isEqualToString:date_part1])
    {
        cell.time.text=[NSString stringWithFormat:@"%@:%@",[Date_cut2 objectAtIndex:0],[Date_cut2 objectAtIndex:1]];
    }
    else if ([date_part1 isEqualToString:yd_string])
    {
        cell.time.text=@"Yesterday";
    }
    else
    {
         cell.time.text=[NSString stringWithFormat:@"%@",[Date_cut objectAtIndex:0]];
    }

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ChatViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"chatPage"];
    newView.trainerID=[[Message_Details_array objectAtIndex:indexPath.row]objectForKey:@"user_id"];
    [self PushViewController:newView WithAnimation:kCAMediaTimingFunctionEaseOut];
}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
       // [self performSegueWithIdentifier:@"msgpage" sender:sender];
    }
    else if (sender.tag==1)
    {
        MessegeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
         [self.navigationController pushViewController:obj animated:NO];

    }
    else if (sender.tag==3)
    {
        MessegeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
         [self.navigationController pushViewController:obj animated:NO];

    }
    else if (sender.tag==2)
    {
        MessegeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
