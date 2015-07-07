//
//  AllGraphViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 17/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllGraphViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIView *GraphBase;
@property (strong, nonatomic) IBOutlet UIView *Black_Layer;
@property (strong, nonatomic) IBOutlet UIView *Add_Base;
@property (strong, nonatomic) IBOutlet UIDatePicker *Datepick;
@property(nonatomic,strong)NSMutableArray *Get_data;
- (IBAction)back_button:(id)sender;
@end
