//
//  profilecell.h
//  Fitness
//
//  Created by Rahul Singha Roy on 25/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profilecell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cell_title1;
@property (strong, nonatomic) IBOutlet UILabel *cell_title2;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cellback;
@property (strong, nonatomic) IBOutlet UIView *Cellbackview;

@end
