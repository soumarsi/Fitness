//
//  StartProgressViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface StartProgressViewController : UIViewController<UIAlertViewDelegate>
{
    UIView *Over_layer;
    
    NSMutableArray *training_data,*rips_array;
    
    int index_number;
    
    NSString *loggedin_userID;
    //MPMoviePlayerController *moviePlayerController;
    
    UIWebView *myWebView;
    
    NSURL *websiteUrl;
    
    
    UIAlertView *finish_alrt;
    
    NSString *Rips;
    
    NSMutableArray *weight_array;
    
    NSInteger Windex;
    
    BOOL keyboard_status;
    
    NSString *keyboard_text;
    
    UILabel *reflectlbl;
    
    NSString *NewString;;
}
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) IBOutlet UIView *footerbase;
- (IBAction)backTOprogress:(id)sender;
- (IBAction)MoreDetails:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *more_detailsview;
- (IBAction)Hide_Details:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *details_view;
@property (strong, nonatomic) IBOutlet UITableView *Gymtable;
- (IBAction)Finished_button:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *finish_btn;

@property (nonatomic,strong) NSMutableArray *Get_Training_Details;

@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailimg;

@property (strong, nonatomic) IBOutlet UILabel *Training_Name;

@property (weak, nonatomic) IBOutlet UILabel *Training_Name2;

@property (weak, nonatomic) IBOutlet UILabel *Training_NameHead;

@property (strong, nonatomic) IBOutlet UITextView *training_description;

@property (strong, nonatomic) IBOutlet UIImageView *training_image;

@property (strong, nonatomic) IBOutlet UITextView *Training_instruction;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)Next_Button:(id)sender;
- (IBAction)Previous_Button:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *right_arrow;
@property (strong, nonatomic) IBOutlet UIImageView *left_arrow;
@property (strong, nonatomic) IBOutlet UIButton *Right_arrow_button;
@property (strong, nonatomic) IBOutlet UIButton *left_arrow_button;
@property (weak, nonatomic) IBOutlet UIView *border_view;

- (IBAction)training_edit:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *custom_keyboard;


- (IBAction)KCOMA:(id)sender;
- (IBAction)KCLR:(id)sender;

- (IBAction)keyboard_button_press:(UIButton *)sender;







@end
