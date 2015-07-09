//
//  FooterClass.m
//  Fitness
//
//  Created by Rahul Singha Roy on 26/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "FooterClass.h"

@implementation FooterClass
@synthesize Delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"Footer" owner:self options:nil]objectAtIndex:0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceiveNotification:) name:@"DataEdited" object:nil];
    

    }
    return self;
}
-(void)ReceiveNotification:(NSNotification *) notification
{
    [_red_dot setHidden:NO];
}

- (IBAction)calender:(UIButton *)sender
{
    
    if ([Delegate respondsToSelector:@selector(pushmethod:)])
    {
       
    [Delegate pushmethod:sender];

    }
}

-(void)TapCheck:(int)Buttontag
{
    if (Buttontag==1)
    {
        [_Calender1 setSelected:YES];
        _Calender2.textColor=[UIColor colorWithRed:(36.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
    }
    else if (Buttontag==2)
    {
        [_Appo1 setSelected:YES];
        _Appo2.textColor=[UIColor colorWithRed:(36.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];

    }
    else if (Buttontag==3)
    {
        [_Progress1 setSelected:YES];
        _Progress2.textColor=[UIColor colorWithRed:(36.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
        
    }
    else if (Buttontag==4)
    {
        [_Messege1 setSelected:YES];
        _Messege2.textColor=[UIColor colorWithRed:(36.0f/255.0f) green:(168.0f/255.0f) blue:(240.0f/255.0f) alpha:1];
        
    }
    else
    {
        [_Calender1 setSelected:NO];
        [_Appo1 setSelected:NO];
    }
}

- (IBAction)bookAppo:(id)sender
{
    
}

- (IBAction)progress:(id)sender
{
    
}

- (IBAction)message:(id)sender
{
    
}
@end
