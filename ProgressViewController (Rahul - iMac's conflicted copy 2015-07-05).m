//
//  ProgressViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ProgressViewController.h"
#import "FooterClass.h"
#import "ProgressTableViewCell.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
#import "PTGraphViewController.h"
#import "AllGraphViewController.h"
@interface ProgressViewController ()<footerdelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProgressViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_Progress_Scroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,555)];
    
    
    _progressTable.delegate=self;
    _progressTable.dataSource=self;
    
    FooterClass *foot=[[FooterClass alloc]init];
    [foot TapCheck:3];
    foot.Delegate=self;
    foot.frame=CGRectMake(0,0,_footerbase.frame.size.width,_footerbase.frame.size.height);
    [_footerbase addSubview:foot];

    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_client_images?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         
         NSMutableArray *data_check=[[NSMutableArray alloc]init];
         data_check=[JsonResult mutableCopy];
         
         if (!data_check.count==0)
         {
         
         image_data_array=[[NSMutableArray alloc]init];
         image_data_array=[[JsonResult objectForKey:@"current_images" ]mutableCopy];
             
        goal_data=[[NSMutableArray alloc]init];
        goal_data=[[JsonResult objectForKey:@"goal_image"]mutableCopy];
         
        // NSLog(@"### Test Mode......%@",goal_data);
         
         
  [_current_user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[image_data_array objectAtIndex:0]objectForKey:@"image_thumbnail"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             

  [_goal_images sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[goal_data objectAtIndex:0]objectForKey:@"image_thumbnail"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
             
             
    _current_data_lbl.text=[[image_data_array objectAtIndex:0]objectForKey:@"uploaded_date"];
             
             
             
             
             JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
             [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_client_details?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
              
              {
                  
                  NSMutableDictionary *Client_data=[[NSMutableDictionary alloc]init];
                  Client_data=[JsonResult mutableCopy];
                  
                  if (!Client_data.count==0)
                  {
                      
                      
                     // NSLog(@"### Test Mode......%@",Client_data);
                      
    _client_profile_image.clipsToBounds=YES;
    _client_profile_image.layer.cornerRadius=(_client_profile_image.frame.size.width)/2;
    _client_profile_image.contentMode=UIViewContentModeScaleAspectFill;
                      
    [_client_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Client_data objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                      
    NSString *weight_string=[NSString stringWithFormat:@"%@",[Client_data objectForKey:@"weight"]];
    weight_string =[weight_string stringByReplacingOccurrencesOfString:@".00" withString:@""];
                      
                      
    NSString *height_string=[NSString stringWithFormat:@"%@",[Client_data objectForKey:@"weight"]];
    height_string =[height_string stringByReplacingOccurrencesOfString:@".00" withString:@""];
                      
     
        _client_name.text=[NSString stringWithFormat:@"%@",[Client_data objectForKey:@"name"]];
                      
        _client_weight.text=weight_string;
    
        _client_height.text=height_string;
              
                      
       
                      
                      
        NSString *Client_Dob_p1=[NSString stringWithFormat:@"%@",[Client_data objectForKey:@"date_of_birth"]];
         
    if ([Client_Dob_p1 isEqualToString:@""])
    {
        
    }
    else
    {
        NSArray *Client_Dob_p2 = [Client_Dob_p1 componentsSeparatedByString:@"-"];
        
        NSString *Client_Dob_p3=[NSString stringWithFormat:@"%@",[Client_Dob_p2 objectAtIndex:0]];
        
        NSInteger Client_Dob_p4 = [Client_Dob_p3 intValue];
        
        //--
        
        if (Client_Dob_p4==0000)
        {
            
        }
        else
        {
            NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
            
            [dateformate setDateFormat:@"YYYY-MM-dd"];
            
            NSString *date_String=[dateformate stringFromDate:[NSDate date]];
            
            
            NSArray *date2 = [date_String componentsSeparatedByString:@"-"];
            
            NSString *date3=[NSString stringWithFormat:@"%@",[date2 objectAtIndex:0]];
            
            NSInteger date4 = [date3 intValue];
            
            
            //--
            
            
            _client_age.text=[NSString stringWithFormat:@"%ld",date4-Client_Dob_p4];
            
            
            
             JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
            [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/all_graphs?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
             
             {
               NSMutableArray *data_check=[[NSMutableArray alloc]init];
                 data_check=[JsonResult mutableCopy];
                 
                 if (data_check.count==0)
                 {
                     
                 }
                 else
                 {
                     tableviewData1=[[NSMutableArray alloc]init];
                     tableviewData1=[[JsonResult objectForKey:@"all_graphs"]mutableCopy];
                     
                     
                     for (int i=0;i<tableviewData1.count;i++)
                     {
                         tableviewData2=[[NSMutableArray alloc]init];
                         tableviewData2=[[tableviewData1 objectAtIndex:i]objectForKey:@"points"];
                     }
                     
                     
                     NSLog(@"### Table_View Data123 ... %@",tableviewData1);
                     
                     [_progressTable reloadData];
                 }
                 
                
                 
                 
             }];


        }
        
          }
        
       
                      
                  }
                  else
                  {
                      
                  }
                  
              }];

             
             
             
         }
         else
         {
             
         }
         
         
      
         
     }];
         
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        spinnview=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+161, [UIScreen mainScreen].bounds.origin.y+200,50,50)];
        spinnview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.7];
        spinnview.layer.cornerRadius=8;
        [self.view addSubview:spinnview];
        
        spinn=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinn.frame=CGRectMake(0,0,50,50);
        [spinn startAnimating];
        [spinnview addSubview:spinn];
        
        [spinnview setHidden:YES];
    }
    else
    {
        spinnview=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+135, [UIScreen mainScreen].bounds.origin.y+190,50,50)];
        spinnview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.7];
        spinnview.layer.cornerRadius=8;
        [self.view addSubview:spinnview];
        
        spinn=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinn.frame=CGRectMake(0,0,50,50);
        [spinn startAnimating];
        [spinnview addSubview:spinn];
        
        [spinnview setHidden:YES];
    }
 
   
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableviewData1 count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cellid";
    ProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                 forIndexPath:indexPath];
    
    
    cell.type_name.text=[NSString stringWithFormat:@"%@",[[tableviewData1 objectAtIndex:indexPath.row]objectForKey:@"graph_for"]];
    
    cell.goal_value.text=[NSString stringWithFormat:@"%@",[[[[tableviewData1 objectAtIndex:indexPath.row]objectForKey:@"points"] objectAtIndex:0] objectForKey:@"y_axis_point"]];
    
    cell.deadline.text=[NSString stringWithFormat:@"%@",[[[[tableviewData1 objectAtIndex:indexPath.row]objectForKey:@"points"] objectAtIndex:0] objectForKey:@"x_axis_point"]];
    
    cell.unit.text=[NSString stringWithFormat:@"%@",[[tableviewData1 objectAtIndex:indexPath.row]objectForKey:@"measure_unit"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableviewData1.count==0)
    {
        
    }
    else
    {
        NSMutableArray *Grap_data_array=[[NSMutableArray alloc]init];
        Grap_data_array=[[tableviewData1 objectAtIndex:indexPath.row]objectForKey:@"points"];
        
       // NSLog(@"Testing Graph Data...%@",tableviewData1);
        
        PTGraphViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"GraphPage"];
        obj.Get_data=Grap_data_array;
        obj.get_unit=[NSString stringWithFormat:@"%@",[[tableviewData1 objectAtIndex:indexPath.row] objectForKey:@"measure_unit"]];
        obj.get_graph_id=[NSString stringWithFormat:@"%@",[[tableviewData1 objectAtIndex:indexPath.row] objectForKey:@"id"]];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseOut];

    }
    
   
}

-(void)pushmethod:(UIButton *)sender
{
    if (sender.tag==4)
    {
        ProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"msgpage"];
         [self.navigationController pushViewController:obj animated:NO];
    }
    else if (sender.tag==1)
    {
        ProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
         [self.navigationController pushViewController:obj animated:NO];


    }
    else if (sender.tag==3)
    {
       // [self performSegueWithIdentifier:@"progressPage" sender:sender];
    }
    else if (sender.tag==2)
    {
        ProgressViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"appoPage"];
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

- (IBAction)show_current_images:(id)sender
{
   
    
    overlayview=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    overlayview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.9];
    overlayview.userInteractionEnabled=YES;
    [self.view addSubview:overlayview];
    
    crosbtn=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60,[UIScreen mainScreen].bounds.origin.y+60,40,40)];
    [crosbtn setImage:[UIImage imageNamed:@"photo_cross"] forState:UIControlStateNormal];
    [self.view addSubview:crosbtn];
    
    [crosbtn addTarget:self action:@selector(photo_close) forControlEvents:UIControlEventTouchUpInside];
    
    photoscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    
    photoscroll.backgroundColor=[UIColor clearColor];
    photoscroll.pagingEnabled=YES;
    [photoscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*image_data_array.count,[UIScreen mainScreen].bounds.size.height)];
    photoscroll.showsHorizontalScrollIndicator=NO;
    [overlayview addSubview:photoscroll];
    
    
    int x=0;
    
    for (int p=0;p<image_data_array.count; p++)
    {
        user_photos=[[UIImageView alloc]initWithFrame:CGRectMake(x,([UIScreen mainScreen].bounds.size.height/2)-100,[UIScreen mainScreen].bounds.size.width, 200)];
        
    [user_photos sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[image_data_array objectAtIndex:p]objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        [photoscroll addSubview:user_photos];
        
        user_photos.contentMode=UIViewContentModeScaleAspectFill;
        
        x=x+[UIScreen mainScreen].bounds.size.width;
        
        
        
          }
    
//    UISwipeGestureRecognizer *photo_Swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(photo_close)];
//    user_photos.userInteractionEnabled=YES;
//    photoscroll.userInteractionEnabled=YES;
//    photo_Swipe.direction=UISwipeGestureRecognizerDirectionUp;
//    [self.view addGestureRecognizer:photo_Swipe];

}

- (IBAction)all_graph_action:(id)sender
{
    
    AllGraphViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AllGraph"];
    obj.Get_data=tableviewData1;
    [self.navigationController pushViewController:obj animated:NO];
}


-(void)photo_close
{
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
      
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            
            photoscroll.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3/2 animations:^{
                
                photoscroll.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3/2 animations:^{
                    photoscroll.transform = CGAffineTransformIdentity;
                    
                }];
            }];
        }];
        
        overlayview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.4];
                
    } completion:^(BOOL finished) {
       
            
            [overlayview removeFromSuperview];
            [crosbtn removeFromSuperview];
    

    }];
    
    
}
- (IBAction)current_image_upload:(id)sender
{
    
    image_switcher=0;
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [sheet showInView:self.view];
    
//    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        
//    {
//        type = UIImagePickerControllerSourceTypeCamera;
//    }
//    
//    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.allowsEditing = YES;
//    picker.delegate   = self;
//    picker.sourceType = type;
//    
//    [self presentViewController:picker animated:YES completion:nil];
    
    
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if(buttonIndex==actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        if(buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            type = UIImagePickerControllerSourceTypeCamera;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}


- (IBAction)goal_image_upload:(id)sender
{
    image_switcher=1;
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [sheet showInView:self.view];
    

}

- (IBAction)view_goal_image:(id)sender
{
    
    overlayview=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    overlayview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.9];
    overlayview.userInteractionEnabled=YES;
    [self.view addSubview:overlayview];
    
    crosbtn=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60,[UIScreen mainScreen].bounds.origin.y+60,40,40)];
    [crosbtn setImage:[UIImage imageNamed:@"photo_cross"] forState:UIControlStateNormal];
    [self.view addSubview:crosbtn];
    
    [crosbtn addTarget:self action:@selector(photo_close) forControlEvents:UIControlEventTouchUpInside];
    
    photoscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    
    photoscroll.backgroundColor=[UIColor clearColor];
    photoscroll.pagingEnabled=YES;
    [photoscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*goal_data.count,[UIScreen mainScreen].bounds.size.height)];
    photoscroll.showsHorizontalScrollIndicator=NO;
    [overlayview addSubview:photoscroll];
    
    
    int x=0;
    
    
        user_photos=[[UIImageView alloc]initWithFrame:CGRectMake(x,([UIScreen mainScreen].bounds.size.height/2)-100,[UIScreen mainScreen].bounds.size.width, 200)];
        
    [user_photos sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[goal_data objectAtIndex:0]objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        [photoscroll addSubview:user_photos];
        
        user_photos.contentMode=UIViewContentModeScaleAspectFill;
        
        x=x+[UIScreen mainScreen].bounds.size.width;
        
    
  
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    
    chosenImage = info[UIImagePickerControllerEditedImage];
    
    [spinnview setHidden:NO];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    
        
     
    
        if (image_switcher==0)
        {
            
            NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(chosenImage, 1.0f)];
            
            JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
            
            NSString *urlString=[NSString stringWithFormat:@"%@app_control/client_current_image_upload?client_id=%@",App_Domain_Url,loggedin_userID];
            
            NSString *str=[jsonOBJ GlobalDict_image:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Globalstr_image:@"array" globalimage:data];
            
            
            NSLog(@"current image...%@",str);
            
            [spinnview setHidden:YES];
            
        }
        else
        {
            
            
            NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(chosenImage, 1.0f)];
            
            JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
            
            NSString *urlString=[NSString stringWithFormat:@"%@app_control/client_goal_image_upload?client_id=%@",App_Domain_Url,loggedin_userID];
            
            NSString *str=[jsonOBJ GlobalDict_image2:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Globalstr_image:@"array" globalimage:data];
            
            
            NSLog(@"goal image...%@",str);
            
            [spinnview setHidden:YES];
        }
        
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@app_control/get_client_images?client_id=%@",App_Domain_Url,loggedin_userID] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         {
             
             NSMutableArray *data_check=[[NSMutableArray alloc]init];
             data_check=[JsonResult mutableCopy];
             
             if (!data_check.count==0)
             {
                 
                 image_data_array=[[NSMutableArray alloc]init];
                 image_data_array=[[JsonResult objectForKey:@"current_images" ]mutableCopy];
                 
                 goal_data=[[NSMutableArray alloc]init];
                 goal_data=[[JsonResult objectForKey:@"goal_image"]mutableCopy];
                 
                                   
                 
                 [_current_user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[image_data_array objectAtIndex:0]objectForKey:@"image_thumbnail"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                 
                 
                 [_goal_images sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[goal_data objectAtIndex:0]objectForKey:@"image_thumbnail"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                 
                 
                 _current_data_lbl.text=[[image_data_array objectAtIndex:0]objectForKey:@"uploaded_date"];
                 
                 
                [spinnview setHidden:YES];
                 
                 
                 
             }
             else
             {
                 [spinnview setHidden:YES];
             }
             
             
             [spinnview setHidden:YES];
             
             chosenImage=nil;
             
             
         }];
        
        
        
        

    
    
    }];
    
    
}


@end
