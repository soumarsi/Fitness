//
//  PTloginViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 08/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTloginViewController : UIViewController<UITextFieldDelegate>
{
    NSString *Remember_Status;
    UIView *black_base_view;
    UIActivityIndicatorView *spinn;
}
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)rememberbox_btn:(id)sender;
- (IBAction)remenberme_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *rememberbox;
@property (strong, nonatomic) IBOutlet UIView *Login_Base;

@end
