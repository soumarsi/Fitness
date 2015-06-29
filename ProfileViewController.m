//
//  ProfileViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 04/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ProfileViewController.h"
#import "FooterClass.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
@interface ProfileViewController ()<footerdelegate>
@end
@implementation ProfileViewController
@synthesize Chat_userId;

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:4];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];
    
    
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    selectedDate = [standardUserDefaults stringForKey:@"Selected_Date"];
    
    
    
    NSLog(@"### Test Bot ... %@",Chat_userId);
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/user_details?pt_id=%@",App_Domain_Url,Chat_userId] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     {
         
         PT_Data=[[NSMutableDictionary alloc]init];
         
         PT_Data=[JsonResult mutableCopy];
       
         NSLog(@"PT data ....%@",PT_Data);
         
      
         _profile_image.layer.cornerRadius=(_profile_image.frame.size.width)/2;
         _profile_image.clipsToBounds=YES;
         _profile_image.contentMode=UIViewContentModeScaleAspectFill;
         
   [_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[PT_Data objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
         
         
         _user_name.text=[NSString stringWithFormat:@"%@",[PT_Data objectForKey:@"name"]];
         
         _company.text=[NSString stringWithFormat:@"%@",[PT_Data objectForKey:@"company"]];
         
         _details.text=[NSString stringWithFormat:@"%@\n%@",[PT_Data objectForKey:@"about"],[PT_Data objectForKey:@"email"]];
         _details.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16];
         
         _location.text=[NSString stringWithFormat:@"%@\n%@",[PT_Data objectForKey:@"address"],[PT_Data objectForKey:@"billing_address"]];
         
     }];
    

}
-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        ProfileViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        ProfileViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        ProfileViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==2)
    {
        ProfileViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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

- (IBAction)Back_Button:(id)sender
{
    [self POPViewController];
}
@end
