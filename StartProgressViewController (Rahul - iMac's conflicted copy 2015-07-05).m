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
- (void)viewDidLoad {
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
    websiteUrl = [NSURL URLWithString:@"https://exorlive.com/video/?ex=825"];
    
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
             
             
             //[_spinner stopAnimating];
             //_spinner.hidden=YES;
             
             
             
             _training_image.clipsToBounds=YES;
             _training_image.contentMode=UIViewContentModeScaleAspectFit;
             
             [_Gymtable reloadData];
             
         }];
        
        
        
        /// Updating UI
        
        //_Training_Name.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:0]objectForKey:@"exercise_title"]];
        
        _Training_NameHead.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:0]objectForKey:@"exercise_title"]];
        
        _Training_Name2.text=[NSString stringWithFormat:@"%@",[[Get_Training_Details objectAtIndex:1]objectForKey:@"exercise_title"]];
        
        
        
    }
    else
    {
        [_right_arrow setHidden:YES];
        
        _Right_arrow_button.userInteractionEnabled=NO;
        _left_arrow_button.userInteractionEnabled=NO;
        
        UIAlertView *No_Data=[[UIAlertView alloc]initWithTitle:@"" message:@"You gotta ask your personal trainer for some workouts! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [No_Data show];
    }
    
    
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
    
    
    cell.reps_count.text=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"reps"]];
    
    cell.weight.text=[NSString stringWithFormat:@"%@",[[rips_array objectAtIndex:indexPath.row]objectForKey:@"kg"]];
    
    
    cell.selectionStyle=NO;
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{

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
    
  
    finish_alrt=[[UIAlertView alloc]initWithTitle:_Training_NameHead.text message:@"Finish The Current Training ?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"FINISH", nil];
    finish_alrt.tag=011;
    [finish_alrt show];
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==011)
    {
        if (buttonIndex==1)
        {
            
            [_finish_btn setImage:nil forState:UIControlStateNormal];
            
            [_finish_btn setBackgroundColor:[UIColor grayColor]];
            [_finish_btn setTitle:@"Finished" forState:UIControlStateNormal];
            [_finish_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _finish_btn.layer.cornerRadius=3;
            
            
            JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
            
            
            [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/update_finish_status?user_program_id=%@&client_id=%@&exercise_id=%@",App_Domain_Url,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"user_program_id"],loggedin_userID,[[Get_Training_Details objectAtIndex:index_number]objectForKey:@"exercise_id"]] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
             
             {
                 
                 
             }];

        }
        else
        {
            
        }
        
    }
}
- (IBAction)Next_Button:(id)sender
{
    
    NSLog(@"...........%d",index_number);
    
    index_number=index_number+1;
    i=i+1;
    
    [_left_arrow setHidden:NO];
    //[_Training_Name2 setHidden:YES];
    //[_Training_Name2 setHidden:YES];      //DEBARUN
    
    
    
    
    //    if(flag==1)
    //    {
    //        [_Training_Name setHidden:NO];
    //        [_Training_Name2 setHidden:YES];
    //        [_Training_Name3 setHidden:NO];
    //    }
    
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
        }
        
    }
    i=i-1;
}

- (IBAction)playvideo:(id)sender
{
    //    MPMoviePlayerController *moviePlayer;
    //    NSURL *url = [NSURL URLWithString:
    //                  @"https://exorlive.com/video/?ex=825"];//write your URL
    //
    //    moviePlayer =  [[MPMoviePlayerController alloc]
    //                     initWithContentURL:url];
    //    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    //    moviePlayer.shouldAutoplay = YES;
    //    [self.view addSubview:moviePlayer.view];
    //    [moviePlayer setFullscreen:YES animated:NO];
    
    //MPMoviePlayerController *moviePlayerController;
    
    
    
    
    //NSURL *fileURL = [NSURL URLWithString:@"https://exorlive.com/video/?ex=825"];
    //    NSURL *fileURL = [NSURL URLWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    //
    //    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(moviePlayBackDidFinish:)
    //                                                 name:MPMoviePlayerPlaybackDidFinishNotification
    //                                               object:_moviePlayer];
    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    //    _moviePlayer.shouldAutoplay = YES;
    //    [self.view addSubview:_moviePlayer.view];
    //    _moviePlayer.fullscreen = YES;
    //    [_moviePlayer play];
    
    
    //////////////////web view/////////////////////
    
    
    //    UIWebView *myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,30,320,200)];
    //    NSURL *websiteUrl = [NSURL URLWithString:@"https://exorlive.com/video/?ex=825"];
    //    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    //    [myWebView loadRequest:urlRequest];
    //    [self.view addSubview:myWebView];
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
    
    NSLog(@"...........%d",index_number);
    
    index_number=index_number-1;
    j=j-1;
    
    [_left_arrow setHidden:NO];
    
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
        }
        
    }
    j=j+1;
    //index_number=0;
    
}
@end
