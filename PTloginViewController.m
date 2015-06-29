//
//  PTloginViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 08/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PTloginViewController.h"
#import "JsonViewController.h"
@interface PTloginViewController ()

@end

@implementation PTloginViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Remember_Status=@"Y";
    [_rememberbox setImage:[UIImage imageNamed:@"checkonBox"] forState:UIControlStateNormal];
    
    UIColor *whiteColor=[UIColor whiteColor];
    
    _email.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:whiteColor}];
    
     _password.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:whiteColor}];
    
    
    
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

- (IBAction)login:(id)sender
{
    
    
    
    if ([_email.text isEqualToString:@""])
    {
        
        UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Email can not be blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [loginAlert show];
        
    }
    else if (![ self NSStringIsValidEmail:_email.text])
    {

        UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Not a valid email !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [loginAlert show];
    }
    else if ([_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
    {
        
        UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Email can not be blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [loginAlert show];
        return;
        
    }

    else if ([_password.text isEqualToString:@""])
    {
        UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password can not be blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [loginAlert show];

    }
    else if ([_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1)
    {
        
        UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password can not be blank" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [loginAlert show];
        return;
        
    }

    else
    {
        
        
        [_email resignFirstResponder];
        [_password resignFirstResponder];
        
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.5 initialSpringVelocity:1.0 options:0 animations:^{
            
            [_Login_Base setFrame:CGRectMake(0,0,_Login_Base.frame.size.width,_Login_Base.frame.size.height)];
            
            
        } completion:^(BOOL finished) {
            
        }];
        

        
        
        
        black_base_view=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        black_base_view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
        [self.view addSubview:black_base_view];
        
        spinn=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinn.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);

        [spinn startAnimating];
        [self.view addSubview:spinn];
     
        
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *DToken = [standardUserDefaults stringForKey:@"deviceToken"];

        UIAlertView *token_alrt=[[UIAlertView alloc]initWithTitle:@"Device Token" message:DToken delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        
        [token_alrt show];
        
        
    JsonViewController *jsonOBJ=[[JsonViewController alloc]init];
    [jsonOBJ GetJsonObjectFromURL:[NSString stringWithFormat:@"%@login/verify_app_login?email=%@&password=%@&remember_me=%@&device_token=%@",App_Domain_Url,_email.text,_password.text,Remember_Status,DToken] WithSpinner:nil Withblock:^(id JsonResult, NSError *error)
     
    {
        
        NSLog(@"Server_Data...%@",JsonResult);
        
        if ([[JsonResult objectForKey:@"response"] isEqualToString:@"success"])
        {

            
            [[NSUserDefaults standardUserDefaults]setObject:Remember_Status forKey:@"Remember_Status"];
            [[NSUserDefaults standardUserDefaults]synchronize];
                
           
            [[NSUserDefaults standardUserDefaults]setObject:[JsonResult objectForKey:@"site_user_id"] forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        
            
            [black_base_view removeFromSuperview];
            [spinn removeFromSuperview];
            
            [_email resignFirstResponder];
            [_password resignFirstResponder];
            
            
       PTloginViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"calenderPage"];
       [self.navigationController pushViewController:obj animated:NO];

            
            
        }
        else
        {
            UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"You are not a valid user" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [loginAlert show];
            
            [_email resignFirstResponder];
            [_password resignFirstResponder];
            
            [black_base_view removeFromSuperview];
            [spinn removeFromSuperview];

        }
    
        
    }];
    
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        [_Login_Base setFrame:CGRectMake(_Login_Base.frame.origin.x,self.view.frame.origin.y-110,_Login_Base.frame.size.width,_Login_Base.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.5 initialSpringVelocity:1.0 options:0 animations:^{
        
         [_Login_Base setFrame:CGRectMake(_Login_Base.frame.origin.x,_Login_Base.frame.origin.y+110,_Login_Base.frame.size.width,_Login_Base.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];

    return YES;
}

- (IBAction)rememberbox_btn:(id)sender
{
    if ([Remember_Status isEqual:@"Y"])
    {
        [_rememberbox setImage:[UIImage imageNamed:@"ckeckboxOff"] forState:UIControlStateNormal];
        
        Remember_Status=@"N";
    }
    else
    {
       [_rememberbox setImage:[UIImage imageNamed:@"checkonBox"] forState:UIControlStateNormal];
        
        Remember_Status=@"Y";
    }
    
    
}

- (IBAction)remenberme_btn:(id)sender
{
    if ([Remember_Status isEqual:@"Y"])
    {
        [_rememberbox setImage:[UIImage imageNamed:@"ckeckboxOff"] forState:UIControlStateNormal];
        
        Remember_Status=@"N";
    }
    else
    {
        [_rememberbox setImage:[UIImage imageNamed:@"checkonBox"] forState:UIControlStateNormal];
        
        Remember_Status=@"Y";
    }

}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
