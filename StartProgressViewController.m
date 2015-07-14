//
//  StartProgressViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//



#import <MediaPlayer/MediaPlayer.h>


#import "StartProgressViewController.h"
#import "FooterClass.h"
#import "GymTableViewCell.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
@interface StartProgressViewController ()<footerdelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    NSInteger flag;
    NSInteger i;
    NSInteger j;
    
}

@end

@implementation StartProgressViewController
@synthesize Get_Training_Details;
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _Gymtable.delegate=self;
    _Gymtable.dataSource=self;
    
    
    _Gymtable.separatorStyle=NO;
    
    
    [_left_arrow setHidden:YES];
    index_number=0;
    i=0;
    j=0;
    
    _left_arrow_button.userInteractionEnabled=NO;
    
    NSInteger val1=([UIScreen mainScreen].bounds.size.width)*2;
    [self.mainscroll setContentSize:CGSizeMake(val1,177.0f)];
    flag=0;
    
    if(!myWebView.loading)
    {
        [_spinner startAnimating];
        
    }
    else
    {
        _spinner.hidden = TRUE;
        [_spinner stopAnimating];
        
        
    }
    //[_spinner startAnimating];
    
    NSInteger val=[UIScreen mainScreen].bounds.size.width;
    myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,val,177)];
    _border_view.frame=CGRectMake(0,0,val,24);
    [myWebView addSubview:_border_view];
   // websiteUrl = [NSURL URLWithString:@"https://exorlive.com/video/?ex=825"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [myWebView loadRequest:urlRequest];
    _thumbnailimg.userInteractionEnabled=YES;
    [_thumbnailimg addSubview:myWebView];
    myWebView.delegate=self;
    //[_spinner stopAnimating];
    
    
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:1];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];
    
    
    Over_layer=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x,_details_view.frame.origin.y+_details_view.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    Over_layer.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.4];
    [self.view addSubview:Over_layer];
    [Over_layer setHidden:YES];
    
    
    [_more_detailsview setHidden:NO];
    
    
    if (Get_Training_Details.count>0)
    {
        val=1;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
        
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        
        
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:0]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:0]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
             {
                 [_finish_btn setImage:nil forState:UIControlStateNormal];
                 
                 [_finish_btn setBackgroundColor:[UIColor grayColor]];
                 [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                 [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 _finish_btn.layer.cornerRadius=3;
                 
                 [_finish_btn setUserInteractionEnabled:NO];

             }
             else
             {
                  [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                 
                 [_finish_btn setUserInteractionEnabled:YES];
                 
                 
             }
             
             rips_array=[[NSMutableArray alloc]init];
             rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
             
             training_data=[[NSMutableArray alloc]init];
             training_data=[JsonResult mutableCopy];
             
             _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
             _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
             
             _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
             _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
             
             
             [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
             NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
             [myWebView loadRequest:urlRequest];
             
             
             //[_spinner stopAnimating];
             //_spinner.hidden=YES;
             
             
             
             _training_image.clipsToBounds=YES;
             _training_image.contentMode=UIViewContentModeScaleAspectFit;
             
             NSString *Reps_check=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:0]objectForKey:@"kg"]] ;
             
             if ([Reps_check isEqualToString:@"0"])
             {
                 _Gymtable.hidden=YES;
             }
             else
             {
                   [_Gymtable reloadData];
             }
             
             
             weight_array=[[NSMutableArray alloc]init];
             
             for (int w=0; w<rips_array.count; w++)
             {
                 if (Rips.length==0)
                 {
                     Rips=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:w]objectForKey:@"reps"]];
                     
                 }
                 else
                 {
                     Rips=[NSString stringWithFormat:@"%@,%@",Rips,[[rips_array objectAtIndex:w]objectForKey:@"reps"]];
                     
                 }
                 
                 [weight_array addObject:[[rips_array objectAtIndex:w]objectForKey:@"kg"]];
                 
             }

             
         }];
        
        
        
        /// Updating UI
        
        //_Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:0]objectForKey:@"exercise_title"]];
        
        _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:0]objectForKey:@"exercise_title"]];
        
        _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:1]objectForKey:@"exercise_title"]];
        
        
        
    }
    else
    {
        [_right_arrow setHidden:YES];
        [_finish_btn setHidden:YES];
        
        _Right_arrow_button.userInteractionEnabled=NO;
        _left_arrow_button.userInteractionEnabled=NO;
        
        UIAlertView *No_Data=[[UIAlertView alloc]initWithTitle:@"" message:@"You gotta ask your personal trainer for some workouts! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [No_Data show];
    }
    
    
    Windex=-1;
    keyboard_status=0;
    
    [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,_custom_keyboard.frame.origin.y+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_spinner stopAnimating];
//    _border_view.hidden=NO;
    _spinner.hidden = TRUE;
}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        StartProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        StartProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==3)
    {
        StartProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"progressPage"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==2)
    {
        StartProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rips_array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GymTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                             forIndexPath:indexPath];
    
    
  //  NSLog(@"--====-=-===--=-= %ld",Windex);
    
    if (indexPath.row== Windex)
    {
        cell.backgroundColor = [UIColor colorWithRed:(30.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
        
        [cell.Edit_button setTitle:@"Change" forState:UIControlStateNormal];
        cell.Edit_button.titleLabel.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:18];
        [cell.Edit_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
        cell.reps_count.text=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"reps"]];
        
        cell.weight.text=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"kg"]];
        
        cell.Edit_button.tag=indexPath.row;
        
        cell.item1.textColor=[UIColor whiteColor];
        cell.item2.textColor=[UIColor whiteColor];
        cell.item3.textColor=[UIColor whiteColor];
        cell.item4.textColor=[UIColor whiteColor];
        cell.item5.textColor=[UIColor whiteColor];
        
        cell.item4.backgroundColor=[UIColor colorWithRed:(32.0f/255.0f) green:(147.0f/255.0f) blue:(209.0f/255.0f) alpha:1];
        cell.item5.backgroundColor=[UIColor colorWithRed:(32.0f/255.0f) green:(147.0f/255.0f) blue:(209.0f/255.0f) alpha:1];
        
        [cell.line_view setHidden:YES];
        
        cell.selectionStyle=NO;
        
        cell.item4.text=@"";
        
        reflectlbl=[[UILabel alloc]initWithFrame:CGRectMake(cell.item4.frame.origin.x,cell.item4.frame.origin.y,cell.item4.frame.size.width, cell.item4.frame.size.height)];
        
        reflectlbl.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:18];
        reflectlbl.textColor=[UIColor whiteColor];
        reflectlbl.textAlignment=NSTextAlignmentCenter;
        
        [cell addSubview:reflectlbl];
        
    }
    else
    {
        [cell.line_view setHidden:NO];
        
       reflectlbl.text=@"";
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.item4.backgroundColor=[UIColor clearColor];
        cell.item5.backgroundColor=[UIColor clearColor];
        
        [cell.Edit_button setTitle:@"" forState:UIControlStateNormal];
        
        cell.item1.textColor=[UIColor darkGrayColor];
        cell.item2.textColor=[UIColor colorWithRed:(30.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
        cell.item3.textColor=[UIColor darkGrayColor];
        cell.item4.textColor=[UIColor colorWithRed:(30.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
        cell.item5.textColor=[UIColor darkGrayColor];

        
        cell.reps_count.text=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"reps"]];
        
        cell.weight.text=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"kg"]];
        
        cell.Edit_button.tag=indexPath.row;
        
        
        cell.selectionStyle=NO;
    }

    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
 //   NSLog(@"########>>>>>>>>>> %@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"reps"]);
    
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

- (IBAction)backTOprogress:(id)sender
{
    [self POPViewController];
}

- (IBAction)MoreDetails:(id)sender
{
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        
        [_more_detailsview setFrame:CGRectMake(0,0,_more_detailsview.frame.size.width, _more_detailsview.frame.size.height)];
        
        
        
        [Over_layer setFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x,_details_view.frame.origin.y+_details_view.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [Over_layer setHidden:NO];
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (IBAction)Hide_Details:(id)sender
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        
        [_more_detailsview setFrame:CGRectMake(0,-400,_more_detailsview.frame.size.width, _more_detailsview.frame.size.height)];
        
        [Over_layer setFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x,_details_view.frame.origin.y+_details_view.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        
        [Over_layer setHidden:YES];
        
        
    } completion:^(BOOL finished) {
        
        //[_more_detailsview setHidden:YES];
        
        
    }];
    
    
}
- (IBAction)Finished_button:(id)sender
{
    
    [_finish_btn setImage:nil forState:UIControlStateNormal];
    
    [_finish_btn setBackgroundColor:[UIColor grayColor]];
    [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
    [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _finish_btn.layer.cornerRadius=3;
    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    
    
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/update_finish_status?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         Windex = -1;
         
         [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
             
             [_custom_keyboard setHidden:NO];
             
             [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
             
         }
                          completion:^(BOOL finished)
          {
              keyboard_status=0;
              
          }];
         
         
         NSLog(@"...........%d",index_number);
         
         index_number=index_number+1;
         i=i+1;
         
         [_left_arrow setHidden:NO];
         
         _left_arrow_button.userInteractionEnabled=YES;
         
         if (Get_Training_Details.count==index_number)
         {
             
             
             [_right_arrow setHidden:YES];
             
             _Right_arrow_button.userInteractionEnabled=NO;
             
             _left_arrow_button.userInteractionEnabled=YES;
             
             index_number=index_number-1;
             
         }
         else
         {
             
             
             JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
             
             
             [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
              
              {
                  
                  if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
                  {
                      [_finish_btn setImage:nil forState:UIControlStateNormal];
                      
                      [_finish_btn setBackgroundColor:[UIColor grayColor]];
                      [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                      [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                      _finish_btn.layer.cornerRadius=3;
                      
                      [_finish_btn setUserInteractionEnabled:NO];
                      
                  }
                  else
                  {
                      [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                      
                       [_finish_btn setUserInteractionEnabled:YES];
                      
                  }
                  
                  
                  
                  NSLog(@"###### Test Mode ###### ... %@",JsonResult);
                  
                  rips_array=[[NSMutableArray alloc]init];
                  rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
                  
                  training_data=[[NSMutableArray alloc]init];
                  training_data=[JsonResult mutableCopy];
                  
                  _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
                  _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                  
                  _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
                  _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                  
                  
                  [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                  
                  websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
                  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
                  [myWebView loadRequest:urlRequest];
                  
                  _training_image.clipsToBounds=YES;
                  _training_image.contentMode=UIViewContentModeScaleAspectFit;
                  
                  [_Gymtable reloadData];
                  
              }];
             
             
             
             
             
             if(index_number-i>=0)
             {
                 _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-i]objectForKey:@"exercise_title"]];
                 
             }
             
             
             _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
             
             if(i<Get_Training_Details.count-index_number)
             {
                 _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+i]objectForKey:@"exercise_title"]];
             }
             if(index_number==Get_Training_Details.count-1)
             {
                 _Training_Name2.text=Nil;
                 [_right_arrow setHidden:YES];
                 _Right_arrow_button.userInteractionEnabled=NO;
             }
             
             if ([_Training_Name2.text isEqualToString:@""])
             {
                 
                 
                 [_right_arrow setHidden:YES];
                 
                 _Right_arrow_button.userInteractionEnabled=NO;
                 
                 _left_arrow_button.userInteractionEnabled=YES;
                 
                 index_number=index_number-1;
                 
             }
             
             
         }
         i=i-1;

     }];

    
    
    
    
}
- (IBAction)Next_Button:(id)sender
{
    
    Windex = -1;
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
        
        [_custom_keyboard setHidden:NO];
        
            [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
        
        [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
        
    }
                     completion:^(BOOL finished)
     {
         keyboard_status=0;
         
     }];

    
    NSLog(@"...........%d",index_number);
    
    index_number=index_number+1;
    i=i+1;
    
    [_left_arrow setHidden:NO];
    
     _left_arrow_button.userInteractionEnabled=YES;
    
    
    if (Get_Training_Details.count==index_number)
    {
        
        
        [_right_arrow setHidden:YES];
        
        _Right_arrow_button.userInteractionEnabled=NO;
        
        _left_arrow_button.userInteractionEnabled=YES;
        
        index_number=index_number-1;
        
    }
    else
    {
        
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        
        
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
             {
                 [_finish_btn setImage:nil forState:UIControlStateNormal];
                 
                 [_finish_btn setBackgroundColor:[UIColor grayColor]];
                 [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                 [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 _finish_btn.layer.cornerRadius=3;
                 
                 [_finish_btn setUserInteractionEnabled:NO];
                 
             }
             else
             {
                 [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                 
                  [_finish_btn setUserInteractionEnabled:YES];
                 
             }


             
             NSLog(@"###### Test Mode ###### ... %@",JsonResult);
             
             rips_array=[[NSMutableArray alloc]init];
             rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
             
             training_data=[[NSMutableArray alloc]init];
             training_data=[JsonResult mutableCopy];
             
             _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
             _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
             
             _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
             _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
             
             
             [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
             NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
             [myWebView loadRequest:urlRequest];
             
             _training_image.clipsToBounds=YES;
             _training_image.contentMode=UIViewContentModeScaleAspectFit;
             
             [_Gymtable reloadData];
             
             
         }];
        
        
        
      
        
        if(index_number-i>=0)
        {
            _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-i]objectForKey:@"exercise_title"]];
            
        }
        
        
        _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
        
        if(i<Get_Training_Details.count-index_number)
        {
            _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+i]objectForKey:@"exercise_title"]];
        }
        if(index_number==Get_Training_Details.count-1)
        {
            _Training_Name2.text=Nil;
            [_right_arrow setHidden:YES];
            _Right_arrow_button.userInteractionEnabled=NO;

        }
        
        if ([_Training_Name2.text isEqualToString:@""])
        {
            
            
            [_right_arrow setHidden:YES];
            
            _Right_arrow_button.userInteractionEnabled=NO;
            
            _left_arrow_button.userInteractionEnabled=YES;
            
            index_number=index_number-1;
            
        }

        
    }
    
    
    i=i-1;
}

- (IBAction)playvideo:(id)sender
{
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}


- (IBAction)Previous_Button:(id)sender
{
    Windex = -1;
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
        
        [_custom_keyboard setHidden:NO];
        
        [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
        
        [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
        
    }
                     completion:^(BOOL finished)
     {
         keyboard_status=0;
         
     }];

    
    NSLog(@"...........%d",index_number);
    
    index_number=index_number-1;
    j=j-1;
    
    [_left_arrow setHidden:NO];
    
    _Right_arrow_button.userInteractionEnabled=YES;
    [_right_arrow setHidden:NO];
    
    if (index_number<0)
    {
        
        //        _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
        
        [_left_arrow setHidden:YES];
        
        [_right_arrow setHidden:NO];
        _Right_arrow_button.userInteractionEnabled=YES;
        
        _left_arrow_button.userInteractionEnabled=NO;
        
        
    }
    else
    {
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        
        
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
             {
                 [_finish_btn setImage:nil forState:UIControlStateNormal];
                 
                 [_finish_btn setBackgroundColor:[UIColor grayColor]];
                 [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                 [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 _finish_btn.layer.cornerRadius=3;
                 
                  [_finish_btn setUserInteractionEnabled:NO];
                 
             }
             else
             {
                 [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                 
                  [_finish_btn setUserInteractionEnabled:YES];
                 
                 
             }


             
             NSLog(@"###### Test Mode ###### ... %@",JsonResult);
             
             rips_array=[[NSMutableArray alloc]init];
             rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
             
             training_data=[[NSMutableArray alloc]init];
             training_data=[JsonResult mutableCopy];
             
             _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
             _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
             
             _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
             _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
             
             
             [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
             NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
             [myWebView loadRequest:urlRequest];
             
             _training_image.clipsToBounds=YES;
             _training_image.contentMode=UIViewContentModeScaleAspectFit;
             
             [_Gymtable reloadData];
             
         }];
        
        if(index_number>0)
        {
            _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+j]objectForKey:@"exercise_title"]];
        }
        
        _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
        
        _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-j]objectForKey:@"exercise_title"]];
        
        if(index_number==0)
        {
            _Training_Name.text=Nil;
            [_left_arrow setHidden:YES];
             _left_arrow_button.userInteractionEnabled=NO;
        }
        
    }
    j=j+1;
    //index_number=0;
    
}
- (IBAction)training_edit:(UIButton *)sender
{
    
    if (keyboard_status==0)
    {
        NSLog(@"---- %ld", (long)sender.tag);
        
        Windex=sender.tag;
        
        [_Gymtable reloadData];
        
        
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
            
            [_custom_keyboard setHidden:NO];
            
            [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,89)];
            
            [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
            
        }
                         completion:^(BOOL finished)
         {
             keyboard_status=1;
             
            
             
             
         }];

    }
    else
    {
         [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
            
            [_custom_keyboard setHidden:NO];
             
              [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
            
            [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
            
        }
                         completion:^(BOOL finished)
         {
             keyboard_status=0;
             
              NSLog(@"getting updated sets %lu",(unsigned long)NewString.length);
             
             if (NewString.length>0)
             {
                
                 
                
                 [weight_array removeObjectAtIndex:sender.tag];
                 [weight_array insertObject:NewString atIndex:Windex];
                 NSString *Weight = [weight_array componentsJoinedByString:@","];
                 
                 
                 NSLog(@"Rips---- %@", Rips);
                 
                 NSLog(@"Weight- %@", [[Get_Training_Details objectAtIndex:sender.tag]objectForKey:@"user_program_id"]);
                 
                 JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
                 
                 [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/update_sets_value?user_program_id=%@&client_id=%@&exercise_id=%@&updated_sets_reps=%@&updated_sets_kg=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"],Rips,Weight] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
                  
                  {
                      
                      NSLog(@"Getting edit response...%@",JsonResult);
                      
                     // Rips=nil;
                      
                      
                      
                      /////// ------ ///////
                      
                      if ([_right_arrow isHidden])
                      {

                          NSLog(@"############ _right button >>");
                          
                          Windex = -1;
                          
                          [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
                              
                              [_custom_keyboard setHidden:NO];
                              
                              [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
                              
                              [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
                              
                          }
                                           completion:^(BOOL finished)
                           {
                               keyboard_status=0;
                               
                           }];
                          
                          
                          NSLog(@"...........%d",index_number);
                          
                          index_number=index_number-1;
                          j=j-1;
                          
                          [_left_arrow setHidden:NO];
                          
                          _Right_arrow_button.userInteractionEnabled=YES;
                          [_right_arrow setHidden:NO];
                          
                          if (index_number<0)
                          {
                              
                              //        _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
                              
                              [_left_arrow setHidden:YES];
                              
                              [_right_arrow setHidden:NO];
                              _Right_arrow_button.userInteractionEnabled=YES;
                              
                              _left_arrow_button.userInteractionEnabled=NO;
                              
                              
                          }
                          else
                          {
                              JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
                              
                              
                              [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
                               
                               {
                                   
                                   if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
                                   {
                                       [_finish_btn setImage:nil forState:UIControlStateNormal];
                                       
                                       [_finish_btn setBackgroundColor:[UIColor grayColor]];
                                       [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                                       [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                       _finish_btn.layer.cornerRadius=3;
                                       
                                       [_finish_btn setUserInteractionEnabled:NO];
                                       
                                   }
                                   else
                                   {
                                       [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                                       
                                        [_finish_btn setUserInteractionEnabled:YES];
                                       
                                       
                                   }
                                   
                                   
                                   
                                   NSLog(@"###### Test Mode ###### ... %@",JsonResult);
                                   
                                   rips_array=[[NSMutableArray alloc]init];
                                   rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
                                   
                                   training_data=[[NSMutableArray alloc]init];
                                   training_data=[JsonResult mutableCopy];
                                   
                                   _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
                                   _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                                   
                                   _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
                                   _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                                   
                                   
                                   [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                                   
                                   websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
                                   NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
                                   [myWebView loadRequest:urlRequest];
                                   
                                   _training_image.clipsToBounds=YES;
                                   _training_image.contentMode=UIViewContentModeScaleAspectFit;
                                   
                                   [_Gymtable reloadData];
                                   
                               }];
                              
                              if(index_number>0)
                              {
                                  _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+j]objectForKey:@"exercise_title"]];
                              }
                              
                              _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
                              
                              _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-j]objectForKey:@"exercise_title"]];
                              
                              if(index_number==0)
                              {
                                  _Training_Name.text=Nil;
                                  [_left_arrow setHidden:YES];
                                  _left_arrow_button.userInteractionEnabled=NO;
                              }
                              
                          }
                          j=j+1;
                          //index_number=0;

                      
                          Windex = -1;
                          
                          [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
                              
                              [_custom_keyboard setHidden:NO];
                              
                              [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
                              
                              [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
                              
                          }
                                           completion:^(BOOL finished)
                           {
                               keyboard_status=0;
                               
                           }];
                          
                          
                          NSLog(@"...........%d",index_number);
                          
                          index_number=index_number+1;
                          i=i+1;
                          
                          [_left_arrow setHidden:NO];
                          
                          _left_arrow_button.userInteractionEnabled=YES;
                          
                          
                          if (Get_Training_Details.count==index_number)
                          {
                              
                              
                              [_right_arrow setHidden:YES];
                              
                              _Right_arrow_button.userInteractionEnabled=NO;
                              
                              _left_arrow_button.userInteractionEnabled=YES;
                              
                              index_number=index_number-1;
                              
                          }
                          else
                          {
                              
                              
                              JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
                              
                              
                              [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
                               
                               {
                                   
                                   if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
                                   {
                                       [_finish_btn setImage:nil forState:UIControlStateNormal];
                                       
                                       [_finish_btn setBackgroundColor:[UIColor grayColor]];
                                       [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                                       [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                       _finish_btn.layer.cornerRadius=3;
                                       
                                       [_finish_btn setUserInteractionEnabled:NO];
                                       
                                   }
                                   else
                                   {
                                       [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                                       
                                        [_finish_btn setUserInteractionEnabled:YES];
                                       
                                   }
                                   
                                   
                                   
                                   NSLog(@"###### Test Mode ###### ... %@",JsonResult);
                                   
                                   rips_array=[[NSMutableArray alloc]init];
                                   rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
                                   
                                   training_data=[[NSMutableArray alloc]init];
                                   training_data=[JsonResult mutableCopy];
                                   
                                   _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
                                   _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                                   
                                   _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
                                   _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                                   
                                   
                                   [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                                   
                                   websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
                                   NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
                                   [myWebView loadRequest:urlRequest];
                                   
                                   _training_image.clipsToBounds=YES;
                                   _training_image.contentMode=UIViewContentModeScaleAspectFit;
                                   
                                   [_Gymtable reloadData];
                                   
                                   
                               }];
                              
                              
                              
                              
                              
                              if(index_number-i>=0)
                              {
                                  _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-i]objectForKey:@"exercise_title"]];
                                  
                              }
                              
                              
                              _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
                              
                              if(i<Get_Training_Details.count-index_number)
                              {
                                  _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+i]objectForKey:@"exercise_title"]];
                              }
                              if(index_number==Get_Training_Details.count-1)
                              {
                                  _Training_Name2.text=Nil;
                                  [_right_arrow setHidden:YES];
                                  _Right_arrow_button.userInteractionEnabled=NO;
                                  
                              }
                              
                              if ([_Training_Name2.text isEqualToString:@""])
                              {
                                  
                                  
                                  [_right_arrow setHidden:YES];
                                  
                                  _Right_arrow_button.userInteractionEnabled=NO;
                                  
                                  _left_arrow_button.userInteractionEnabled=YES;
                                  
                                  index_number=index_number-1;
                                  
                              }
                              
                              
                          }
                          
                          
                          i=i-1;

            
                          

                      }
                      else
                      {
                      
                      Windex = -1;
                      
                      [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
                          
                          [_custom_keyboard setHidden:NO];
                          
                          [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
                          
                          [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
                          
                      }
                                       completion:^(BOOL finished)
                       {
                           keyboard_status=0;
                           
                       }];
                      
                      
                      NSLog(@"...........%d",index_number);
                      
                      index_number=index_number+1;
                      i=i+1;
                      
                      [_left_arrow setHidden:NO];
                      
                      _left_arrow_button.userInteractionEnabled=YES;
                      
                      
                      if (Get_Training_Details.count==index_number)
                      {
                          
                          
                          [_right_arrow setHidden:YES];
                          
                          _Right_arrow_button.userInteractionEnabled=NO;
                          
                          _left_arrow_button.userInteractionEnabled=YES;
                          
                          index_number=index_number-1;
                          
                      }
                      else
                      {
                          
                          
                          JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
                          
                          
                          [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
                           
                           {
                               
                               if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
                               {
                                   [_finish_btn setImage:nil forState:UIControlStateNormal];
                                   
                                   [_finish_btn setBackgroundColor:[UIColor grayColor]];
                                   [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                                   [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                   _finish_btn.layer.cornerRadius=3;
                                   
                                   [_finish_btn setUserInteractionEnabled:NO];
                                   
                               }
                               else
                               {
                                   [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                                   
                                    [_finish_btn setUserInteractionEnabled:YES];
                                   
                               }
                               
                               
                               
                               NSLog(@"###### Test Mode ###### ... %@",JsonResult);
                               
                               rips_array=[[NSMutableArray alloc]init];
                               rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
                               
                               training_data=[[NSMutableArray alloc]init];
                               training_data=[JsonResult mutableCopy];
                               
                               _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
                               _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                               
                               _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
                               _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                               
                               
                          //     [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                               
                        //       websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
                               NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
                               [myWebView loadRequest:urlRequest];
                               
                               _training_image.clipsToBounds=YES;
                               _training_image.contentMode=UIViewContentModeScaleAspectFit;
                               
                               [_Gymtable reloadData];
                               
                               
                           }];
                          
                          
                          
                          
                          
                          if(index_number-i>=0)
                          {
                              _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-i]objectForKey:@"exercise_title"]];
                              
                          }
                          
                          
                          _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
                          
                          if(i<Get_Training_Details.count-index_number)
                          {
                              _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+i]objectForKey:@"exercise_title"]];
                          }
                          if(index_number==Get_Training_Details.count-1)
                          {
                              _Training_Name2.text=Nil;
                              [_right_arrow setHidden:YES];
                              _Right_arrow_button.userInteractionEnabled=NO;
                              
                          }
                          
                          if ([_Training_Name2.text isEqualToString:@""])
                          {
                              
                              
                              [_right_arrow setHidden:YES];
                              
                              _Right_arrow_button.userInteractionEnabled=NO;
                              
                              _left_arrow_button.userInteractionEnabled=YES;
                              
                              index_number=index_number-1;
                              
                          }
                          
                          
                      }
                      
                      
                      i=i-1;

                      
                      
                      
                      Windex = -1;
                      
                      [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
                          
                          [_custom_keyboard setHidden:NO];
                          
                          [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
                          
                          [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
                          
                      }
                                       completion:^(BOOL finished)
                       {
                           keyboard_status=0;
                           
                       }];
                      
                      
                      NSLog(@"...........%d",index_number);
                      
                      index_number=index_number-1;
                      j=j-1;
                      
                      [_left_arrow setHidden:NO];
                      
                      _Right_arrow_button.userInteractionEnabled=YES;
                      [_right_arrow setHidden:NO];
                      
                      if (index_number<0)
                      {
                          
                          //        _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
                          
                          [_left_arrow setHidden:YES];
                          
                          [_right_arrow setHidden:NO];
                          _Right_arrow_button.userInteractionEnabled=YES;
                          
                          _left_arrow_button.userInteractionEnabled=NO;
                          
                          
                      }
                      else
                      {
                          JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
                          
                          
                          [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_particular_exercise_details?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
                           
                           {
                               
                               if ([[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"finished"]]isEqualToString:@"TRUE"])
                               {
                                   [_finish_btn setImage:nil forState:UIControlStateNormal];
                                   
                                   [_finish_btn setBackgroundColor:[UIColor grayColor]];
                                   [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
                                   [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                   _finish_btn.layer.cornerRadius=3;
                                   
                                   [_finish_btn setUserInteractionEnabled:NO];
                                   
                               }
                               else
                               {
                                   [_finish_btn setImage:[UIImage imageNamed:@"finishBTN"] forState:UIControlStateNormal];
                                   
                                    [_finish_btn setUserInteractionEnabled:YES];
                                   
                                   
                               }
                               
                               
                               
                               NSLog(@"###### Test Mode ###### ... %@",JsonResult);
                               
                               rips_array=[[NSMutableArray alloc]init];
                               rips_array=[[JsonResult objectForKey:@"exercise_sets"]mutableCopy];
                               
                               training_data=[[NSMutableArray alloc]init];
                               training_data=[JsonResult mutableCopy];
                               
                               _training_description.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_description"]];
                               _training_description.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                               
                               _Training_instruction.text=[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"instruction"]];
                               _Training_instruction.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:15.0f];
                               
                               
                             //  [_training_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                               
                            //   websiteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[JsonResult objectForKey:@"exercise_video"]]];
                           //    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
                         //      [myWebView loadRequest:urlRequest];
                               
                               _training_image.clipsToBounds=YES;
                               _training_image.contentMode=UIViewContentModeScaleAspectFit;
                               
                               [_Gymtable reloadData];
                               
                           }];
                          
                          if(index_number>0)
                          {
                              _Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number+j]objectForKey:@"exercise_title"]];
                          }
                          
                          _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_title"]];
                          
                          _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:index_number-j]objectForKey:@"exercise_title"]];
                          
                          if(index_number==0)
                          {
                              _Training_Name.text=Nil;
                              [_left_arrow setHidden:YES];
                              _left_arrow_button.userInteractionEnabled=NO;
                          }
                          
                      }
                      j=j+1;
                      //index_number=0;

                      }
                      
                      
                  }];
                 
             }
             

             
             
         }];

        
        

    }
    
   
    
    
    
    
//    UIAlertView *Edit_Alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:@"Please Enter Weight Value"
//                                                   delegate:self
//                                          cancelButtonTitle:@"Cancel"
//                                          otherButtonTitles:@"Set", nil];
//    Edit_Alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [Edit_Alert show];
//
    
    

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *Text = [alertView textFieldAtIndex:0].text;
    
        if (Text.length==0)
        {
            
        }
        else
        {
        
            
        }

    }
}

- (IBAction)KCOMA:(id)sender {
}

- (IBAction)KCLR:(id)sender {
}

- (IBAction)keyboard_button_press:(UIButton *)sender
{
    
    
    UILabel *PhoneNumbertextView = (UILabel *)reflectlbl;
    
    NSInteger UibuttonTag =sender.tag;
    
    NSString *PhoneTextFieldText = [PhoneNumbertextView text];
    
    
    
    if (UibuttonTag==196)
    {
        
        NewString = @"";
        
        Windex=-1;
        
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.6 options:0 animations:^{
            
            [_custom_keyboard setHidden:NO];
            
            [_Gymtable setFrame:CGRectMake(_Gymtable.frame.origin.x,_Gymtable.frame.origin.y,_Gymtable.frame.size.width,168)];
            
            [_custom_keyboard setFrame:CGRectMake(_custom_keyboard.frame.origin.x,[UIScreen mainScreen].bounds.size.height+_custom_keyboard.frame.size.height,[UIScreen mainScreen].bounds.size.width,_custom_keyboard.frame.size.height)];
            
            [_Gymtable reloadData];

            
        }
                         completion:^(BOOL finished)
         {
             
             
             }];

        
    }
     else
     {
        
         
       if ([PhoneTextFieldText length]<10)
       {
           
           
            NewString= [PhoneTextFieldText stringByAppendingString:sender.titleLabel.text];
            
        }
       else
       {
            NewString= [PhoneNumbertextView text];
            
        }
    
    }
    
    [PhoneNumbertextView setText:NewString];

    NSLog(@"##########......%@",NewString);
}
@end
