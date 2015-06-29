//
//  PTGraphViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 22/04/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVGraphView.h"
#import "OVGraphViewPoint.h"
@interface PTGraphViewController : UIViewController<UIPickerViewDelegate>
{
    int weight;
    NSString *date_pick_date;
}
- (IBAction)BackBTN:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *GraphBase;
- (IBAction)ADD_measurement:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *Black_Layer;
@property (strong, nonatomic) IBOutlet UIView *Add_Base;
@property (strong, nonatomic) IBOutlet UIDatePicker *Datepick;
- (IBAction)CancelADDPOP:(id)sender;
- (IBAction)DoneADDpop:(id)sender;

@property(nonatomic,strong)NSMutableArray *Get_data;

@property (weak, nonatomic) IBOutlet UILabel *goal_value;
@property (weak, nonatomic) IBOutlet UILabel *goal_unit;

@property (weak, nonatomic) IBOutlet UILabel *deadline;

@property(nonatomic,strong)NSString *get_unit;

@property (weak, nonatomic) IBOutlet UIView *graph_line;

@property (weak, nonatomic) IBOutlet UILabel *user_weight;

@property (nonatomic,strong)NSString *get_graph_id;
- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *set_value;

@end
