//
//  ChatViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import <AVFoundation/AVFoundation.h>
@interface ChatViewController : UIViewController<HPGrowingTextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
     UIImageView *containerView;
    HPGrowingTextView *textView;
    
    UIImageView *editicon;
    
    NSMutableArray *chat_Array,*chat_Array2;
    UITableView *chat_table;
    
    
    IBOutlet UIImageView *topbar;
    
    NSString *loggedin_userID;
    
    BOOL scroll_indicator;
    
    NSInteger Start_Point;
    
    UIView *spinnview;
    UIActivityIndicatorView *spinn;
    
    AVAudioPlayer *player;
    
}
- (IBAction)BackTOmessage:(id)sender;
- (IBAction)View_Profile:(id)sender;

@property (nonatomic,assign)NSString *trainerID;

@end
