//
//  ProgressViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSString *loggedin_userID;
    
    NSMutableArray *image_data_array;
    
    UIImageView *user_photos;
    
    UIView *overlayview;
    
    UIScrollView *photoscroll;
    
    NSMutableArray *tableviewData1,*tableviewData2;
    
    UIImage *chosenImage;
    
    BOOL image_switcher;
    
    UIActivityIndicatorView *spinn;
    UIView *spinnview;
    
    UIButton *crosbtn;
    
    NSMutableArray *goal_data;
}
@property (strong, nonatomic) IBOutlet UIView *footerbase;
@property (strong, nonatomic) IBOutlet UITableView *progressTable;
@property (strong, nonatomic) IBOutlet UIScrollView *Progress_Scroll;

@property (weak, nonatomic) IBOutlet UIImageView *current_user_image;

@property (weak, nonatomic) IBOutlet UILabel *current_data_lbl;
@property (weak, nonatomic) IBOutlet UIImageView *goal_images;

- (IBAction)show_current_images:(id)sender;

- (IBAction)all_graph_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *client_profile_image;
@property (weak, nonatomic) IBOutlet UILabel *client_name;
@property (weak, nonatomic) IBOutlet UILabel *client_height;
@property (weak, nonatomic) IBOutlet UILabel *client_weight;
@property (weak, nonatomic) IBOutlet UILabel *client_age;

- (IBAction)current_image_upload:(id)sender;
- (IBAction)goal_image_upload:(id)sender;

- (IBAction)view_goal_image:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *all_graph_button;


@end
