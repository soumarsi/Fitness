//
//  ChatViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ChatViewController.h"
#import "JsonViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileViewController.h"
@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize trainerID;

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    scroll_indicator=1;
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        chat_table=[[UITableView alloc]initWithFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-140)];
        chat_table.delegate=self;
        chat_table.dataSource=self;
        chat_table.showsVerticalScrollIndicator=NO;
        chat_table.backgroundColor=[UIColor clearColor];
        chat_table.separatorStyle=NO;
        [self.view addSubview:chat_table];

    }
    else
    {
        chat_table=[[UITableView alloc]initWithFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-110)];
        chat_table.delegate=self;
        chat_table.dataSource=self;
        chat_table.showsVerticalScrollIndicator=NO;
        chat_table.backgroundColor=[UIColor clearColor];
        chat_table.separatorStyle=NO;
        [self.view addSubview:chat_table];

    }

    
    // Chat Text Field //
    containerView = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-44,[UIScreen mainScreen].bounds.size.width, 40)];
    containerView.userInteractionEnabled=YES;
    containerView.backgroundColor=[UIColor whiteColor];
    
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(4,8, containerView.frame.size.width-10,25)];
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    textView.returnKeyType = UIReturnKeyDefault;
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.layer.cornerRadius=8;
    textView.layer.borderWidth=1.0f;
    textView.layer.borderColor=[UIColor grayColor].CGColor;
    textView.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.02];
    textView.placeholder=@"    Write a message...";
    textView.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:containerView];
    
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    [containerView addSubview:textView];
    
    
    editicon=[[UIImageView alloc]initWithFrame:CGRectMake(9,10,26/2,26/2)];
    editicon.image=[UIImage imageNamed:@"editbtn"];
    [textView addSubview:editicon];
    
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    NSLog(@"Getting User ID.....%@",trainerID);
    
    // Getting Chat Data //
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    loggedin_userID = [standardUserDefaults stringForKey:@"user_id"];
    
   
    chat_Array2=[[NSMutableArray alloc]init];
    
    Start_Point=0;
    
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
        
        [spinnview setHidden:NO];

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
        
        [spinnview setHidden:NO];

    }
    
   

    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@dashboard/get_user_respective_messages?user_id=%@&logged_in_user=%@&start=%ld",App_Domain_Url,trainerID,loggedin_userID,(long)Start_Point] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         
         
         NSMutableArray *data_array=[[NSMutableArray alloc]init];
         data_array=[JsonResult mutableCopy];
         
        if (!data_array.count==0)
        {
           
             chat_Array=[[NSMutableArray alloc]init];
            chat_Array =[JsonResult objectForKey:@"all_message"];
            
            chat_Array2 = [[chat_Array arrayByAddingObjectsFromArray:chat_Array2]mutableCopy];
            
            NSLog(@"Server_Data##01...%@",chat_Array);
            
            [chat_table reloadData];
            
            //[chat_table reloadData];
            NSIndexPath* ip = [NSIndexPath indexPathForRow:chat_Array.count-1 inSection:0];
            [chat_table scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
            [spinnview setHidden:YES];


        }
         else
         {
             
         }
         
         
         
     }];
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceiveNotification:) name:@"DataEdited" object:nil];
    
   
    
    
}
- (void)playMusic
{
    NSLog(@"playingg.....");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sounds-874-gets-in-the-way" ofType:@"mp3"];
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:path];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player play];
}
-(void)ReceiveNotification:(NSNotification *) notification
{
    [self playMusic];
      NSDictionary *message = [notification object];
    
    if ([trainerID isEqualToString:[NSString stringWithFormat:@"%@",[message objectForKey:@"sent_by"]]])
    {
        
        [chat_table removeFromSuperview];
        [self viewDidLoad];
        

    }

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chat_Array2 count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    
    
    
    
    
    
    UIFont *font1 = [UIFont fontWithName:@"TitilliumWeb-Regular" size:17];
    
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[chat_Array2 objectAtIndex:indexPath.row]objectForKey:@"message"]] attributes: arialDict];
    
    
    
    CGRect rect;
    
    
    
    rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    
    
    
    UIImageView *profileimage=[[UIImageView alloc]init];//WithFrame:CGRectMake(270,40,40, 40)];
    
    profileimage.layer.cornerRadius=20;
    
    profileimage.clipsToBounds=YES;
    
    profileimage.contentMode=UIViewContentModeScaleAspectFill;
    
    cell.selectionStyle=NO;
    
    [cell addSubview:profileimage];
    
    
    
    
    
    UIView *chat_background=[[UIView alloc]init];//WithFrame:CGRectMake(48,5,220,rect.size.height+40)];
    
    [cell addSubview:chat_background];
    
    
    
    
    
    
    
    UILabel *chat_lable=[[UILabel alloc]init];//WithFrame:CGRectMake(6,4,195,rect.size.height+35)];
    
    chat_lable.backgroundColor=[UIColor clearColor];
    
    chat_lable.numberOfLines=0;
    
    chat_lable.clipsToBounds = YES;
    
    chat_lable.textColor=[UIColor whiteColor];
    
    chat_lable.textAlignment=NSTextAlignmentLeft;
    
    chat_lable.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:16];
    
    chat_lable.attributedText  = aAttrString1;
    
    [chat_background addSubview:chat_lable];
    
    
    
    UIImageView *cornerimage = [[UIImageView alloc]init];
    
    [cornerimage setImage:[UIImage imageNamed:@"cornerimage"]];
    
    [cell addSubview:cornerimage];
    
    
    
    if ([[[chat_Array2 objectAtIndex:indexPath.row]objectForKey:@"sent_by"]isEqualToString:loggedin_userID])
        
    {
        
        
        
        chat_background.backgroundColor = [UIColor colorWithRed:(36.0f / 255.0f) green:(168.0f / 255.0f) blue:(240.0f / 255.0f) alpha:1.0f];
        
        chat_background.frame=CGRectMake(self.view.frame.origin.x+7, 3, self.view.frame.size.width-85 , rect.size.height+45);
        
        cornerimage.frame = CGRectMake(chat_background.frame.origin.x+chat_background.frame.size.width, 3, 25 , rect.size.height+45);
        
        profileimage.frame = CGRectMake(self.view.frame.size.width-55, rect.size.height+50-45, 40, 40);
        
        chat_lable.frame = CGRectMake(chat_background.frame.origin.x+4, chat_background.frame.origin.y+4, chat_background.frame.size.width-8, chat_background.frame.size.height-8);
        
        
        
        UIBezierPath *maskPath;
        
        maskPath = [UIBezierPath bezierPathWithRoundedRect:chat_background.bounds
                    
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                    
                                               cornerRadii:CGSizeMake(10.0, 10.0)];
        
        
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = self.view.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        chat_background.layer.mask = maskLayer;
        
        
        
    }
    
    else
        
    {
        
        
        
        
        
        [profileimage setFrame:CGRectMake(5,rect.size.height+50-45,40, 40)];
        
        chat_lable.textColor=[UIColor blackColor];
        
        chat_background.layer.cornerRadius = 10.0f;
        
        chat_background.backgroundColor = [UIColor colorWithRed:(233.0f / 255.0f) green:(242.0f / 255.0f) blue:(247.0f / 255.0f) alpha:1.0f];
        
        chat_background.frame=CGRectMake(profileimage.frame.origin.x+profileimage.frame.size.width+7, 3, self.view.frame.size.width-65 , rect.size.height+45);
        
        chat_lable.frame = CGRectMake(7, chat_background.frame.origin.y+4, chat_background.frame.size.width-8, chat_background.frame.size.height-8);
        
        
        
        
        
    }
    
    
    
    [profileimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[chat_Array2 objectAtIndex:indexPath.row]objectForKey:@"sender_image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    
    
    
    
    if (chat_table.contentOffset.y<0)
        
    {
        
        [spinnview setHidden:NO];
        
        
        
        
        
        Start_Point=Start_Point+10;
        
        
        
        JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
        
        [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@dashboard/get_user_respective_messages?user_id=%@&logged_in_user=%@&start=%ld",App_Domain_Url,trainerID,loggedin_userID,(long)Start_Point] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
         
         
         
         {
             
             
             
             NSMutableArray *data_array=[[NSMutableArray alloc]init];
             
             data_array=[JsonResult mutableCopy];
             
             
             
             if (!data_array.count==0)
                 
             {
                 
                 
                 
                 chat_Array=[[NSMutableArray alloc]init];
                 
                 chat_Array =[JsonResult objectForKey:@"all_message"];
                 
                 
                 
                 if (!chat_Array.count==0)
                     
                 {
                     
                     chat_Array2 = [[chat_Array arrayByAddingObjectsFromArray:chat_Array2]mutableCopy];
                     
                     NSLog(@"Server_Data...%@",chat_Array);
                     
                     
                     
                     [chat_table reloadData];
                     
                     
                     
                     [spinnview setHidden:YES];
                     
                     
                     
                     
                     
                 }
                 
                 else
                     
                 {
                     
                     // No More Data To Load
                     
                     
                     
                     [spinnview removeFromSuperview];
                     
                     
                     
                 }
                 
                 
                 
                 
                 
                 
                 
             }
             
             else
                 
             {
                 
                 
                 
                 [spinnview setHidden:YES];
                 
                 
                 
                 
                 
                 
                 
             }
             
             
             
             
             
             
             
         }];
        
        
        
    }
    
    
    
    
    
    
    
    
    
    return cell;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font1 = [UIFont fontWithName:@"TitilliumWeb-Regular" size:17];
    
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[chat_Array2 objectAtIndex:indexPath.row]objectForKey:@"message"]] attributes: arialDict];
    
    
    
    CGRect rect;
    
    
    
    rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    
    
    
    return rect.size.height + 55;
}
- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        
        [chat_table setFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,305)];
    }
    else
    {
        
        [chat_table setFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,220)];
        
    }

    
    
    NSIndexPath* ip = [NSIndexPath indexPathForRow:chat_Array.count-1 inSection:0];
    [chat_table scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    

    
    
    [growingTextView becomeFirstResponder];
    
    [editicon setHidden:YES];
    NSLog(@"Hit !");
}
//- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (text.length==0)
//    {
//        [editicon setHidden:NO];
//    }
//    else
//    {
//        [editicon setHidden:YES];
//    }
//    
//    return YES;
//}
-(void)setUpTextFieldforIphone
{
    
    
}

-(void) keyboardWillShow:(NSNotification *)note
{
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
   
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height+5);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    containerView.frame = containerFrame;
   
    [UIView commitAnimations];
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        
        [chat_table setFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,100)];
    }
    else
    {
        
        [chat_table setFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,220)];
        
    }
    
//    NSIndexPath* ip = [NSIndexPath indexPathForRow:chat_Array.count-1 inSection:0];
//    [chat_table scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];


}

-(void) keyboardWillHide:(NSNotification *)note
{
     [chat_table setFrame:CGRectMake(0,topbar.frame.size.height,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-110)];
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height-5;

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    containerView.frame = containerFrame;

    [UIView commitAnimations];
    
 

}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
   
        
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
        
    NSLog(@"on");
    
    NSLog(@"Getting Height ..... %f",height);
}
- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    if (growingTextView.text.length==0)
    {
        [growingTextView resignFirstResponder];
        [editicon setHidden:NO];
    }
}
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    
    NSString *chat_Text=[textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (chat_Text.length==0)
    {
        
    }
    else
    {
    
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@dashboard/send_message_through_app?sent_to=%@&sent_by=%@&message=%@",App_Domain_Url,trainerID,loggedin_userID,chat_Text] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
     {
         NSLog(@"Adding....");
         
         [chat_table removeFromSuperview];
         [textView removeFromSuperview];
         
         Start_Point=0;
         
         [self viewDidLoad];
         
      
         
     }];

    }
    return YES;
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

- (IBAction)BackTOmessage:(id)sender
{
    [self POPViewController];
}

- (IBAction)View_Profile:(id)sender
{
    
ProfileViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile_Page"];
    
    newView.Chat_userId=trainerID;
    [self PushViewController:newView WithAnimation:kCAMediaTimingFunctionEaseOut];
    
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

-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.01f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}






@end
