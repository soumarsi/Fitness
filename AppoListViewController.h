//
//  AppoListViewController.h
//  Fitness
//
//  Created by ios on 11/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonViewController.h"

@interface AppoListViewController : UIViewController
{
    NSMutableArray *appo_data;
}
@property (weak, nonatomic) IBOutlet UITableView *tabview;
@property (weak, nonatomic) IBOutlet UIView *FooterBase;
@property (weak, nonatomic) IBOutlet UILabel *appo_date;

@end
