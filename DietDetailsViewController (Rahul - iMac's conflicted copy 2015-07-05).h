//
//  DietDetailsViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 28/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietDetailsViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *footerbase;
- (IBAction)BackTOdiet:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *Diet_Scroll;
@property (strong, nonatomic) IBOutlet UITextView *diet_details;


@property (strong, nonatomic) IBOutlet UIImageView *diet_image;

@property (strong, nonatomic) IBOutlet UILabel *diet_title;
@property (strong, nonatomic) IBOutlet UITextView *diet_description;

@property (nonatomic,assign) NSString *diet_id;
@property (nonatomic,assign) NSString *Custom_diet_id;

@end
