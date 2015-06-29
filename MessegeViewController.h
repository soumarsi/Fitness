//
//  MessegeViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 27/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessegeTableViewCell.h"
#import "FooterClass.h"
@interface MessegeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *Message_Details_array;
}
@property (strong, nonatomic) IBOutlet UITableView *messegeTable;
@property (strong, nonatomic) IBOutlet UIView *footerbase;

@end
