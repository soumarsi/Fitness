//
//  DietDetailsViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "DietDetailsViewController.h"
#import "FooterClass.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
@interface DietDetailsViewController ()<footerdelegate>

@end

@implementation DietDetailsViewController
@synthesize diet_id,Custom_diet_id;
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_Diet_Scroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width+200)];
    _Diet_Scroll.delegate=self;

    
    FooterClass *foot=[[FooterClass alloc]init];
    foot.Delegate=self;
    [foot TapCheck:1];
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];

    
    
   //--//
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        [_diet_details setFrame:CGRectMake(16, 340, 318,_footerbase.frame.origin.y-12)];
    }
    else
    {
        [_diet_details setFrame:CGRectMake(16, 233, 288,_footerbase.frame.origin.y-12)];
    }
    
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    

    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_custom_meal_details?custom_meal_id=%@&client_id=%@&meal_id=%@",App_Domain_Url,Custom_diet_id,loggedin_userID,diet_id] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         
         
    [_diet_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"meal_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
         
         
    _diet_title.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"meal_title"]];
         
    _Page_title.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"meal_title"]];
         
    _diet_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"meal_description"]];
    _diet_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16.0f];
         
         
         NSLog(@"Diet Data ...%lu",(unsigned long)_diet_description.text.length);
    
         if(_diet_description.text.length>1000)
         {
             
             [_Diet_Scroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width+850)];

         }
         else if (_diet_description.text.length>700)
         {
             [_Diet_Scroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width+660)];
         }

         else if (_diet_description.text.length>400)
         {
              [_Diet_Scroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width+400)];
         }
         
     }];
 
    
    
   
}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        DietDetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];

    }
    else if (sender.tag==1)
    {
        DietDetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        DietDetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
         [self.navigationController pushViewController:obj animated:NO];

    }
    else if (sender.tag==2)
    {
        DietDetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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

- (IBAction)BackTOdiet:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
