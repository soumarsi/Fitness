//
//  FooterClass.h
//  Fitness
//
//  Created by Rahul Singha Roy on 26/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol footerdelegate<NSObject>
@optional
-(void)pushmethod:(UIButton *)sender;
-(void)ButtonTap;
@end
@interface FooterClass : UIView
- (IBAction)calender:(UIButton *)sender;
- (IBAction)bookAppo:(id)sender;
- (IBAction)progress:(id)sender;
- (IBAction)message:(id)sender;

-(void)TapCheck:(int)Buttontag;
@property (weak, nonatomic) IBOutlet UIImageView *red_dot;


@property (strong, nonatomic) IBOutlet UIButton *Calender1;
@property (strong, nonatomic) IBOutlet UILabel *Calender2;
@property (strong, nonatomic) IBOutlet UIButton *Appo1;

@property (strong, nonatomic) IBOutlet UILabel *Appo2;

@property (strong, nonatomic) IBOutlet UIButton *Progress1;
@property (strong, nonatomic) IBOutlet UILabel *Progress2;

@property (strong, nonatomic) IBOutlet UIButton *Messege1;
@property (strong, nonatomic) IBOutlet UILabel *Messege2;


@property(assign)id<footerdelegate>Delegate;

@end
