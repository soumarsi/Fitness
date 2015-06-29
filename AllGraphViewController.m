//
//  AllGraphViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 17/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "AllGraphViewController.h"
#import "OVGraphView.h"
#import "OVGraphViewPoint.h"
#import "PTGraphViewController.h"
@interface AllGraphViewController ()

@end

@implementation AllGraphViewController
@synthesize Get_data;

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//    
//}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSLog(@"Graph Data....%@",Get_data);

    
    [UIView transitionWithView:self.view duration:0.8 options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        
                      //  self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
                        
                    }
                    completion:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Get_data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cellid";
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    UIScrollView *graph_scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.height,250)];
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
          graph_scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.height+270,250);
        
         [graph_scroll setContentOffset:CGPointMake(280, 0)];
    }
    else
    {
          graph_scroll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.height+240, 250);
        
         [graph_scroll setContentOffset:CGPointMake(250, 0)];
    }
    
  
    [cell addSubview:graph_scroll];
    
   
    
    graph_scroll.showsHorizontalScrollIndicator=NO;
    
    UIView *graph_base=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.height,250)];
    [graph_scroll addSubview:graph_base];
    
    graph_base.userInteractionEnabled=YES;
    
    UILabel *graphTitle=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+50,[UIScreen mainScreen].bounds.origin.y+5,150,28)];
    graphTitle.textColor=[UIColor darkGrayColor];
    graphTitle.text=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:indexPath.row]objectForKey:@"graph_for"]];
    graphTitle.font=[UIFont fontWithName:@"TitilliumWeb-Regular" size:20];
    graphTitle.backgroundColor=[UIColor clearColor];
    [cell addSubview:graphTitle];
    
    
    NSLog(@"########...%@",[[[[Get_data objectAtIndex:0] objectForKey:@"points"]objectAtIndex:0]objectForKey:@"x_axis_point"]);
    
    if (Get_data.count==0)
    {
        
    }
    else
    {
        
        
        
        NSString *point1=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:0]objectForKey:@"x_axis_point"]];
        if ([point1 isEqualToString:@"00"])
        {
            point1 =@"";
            
        }
        else
        {
            point1 = [point1 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point2=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:1]objectForKey:@"x_axis_point"]];
        
        if ([point2 isEqualToString:@"00"])
        {
            point2 =@"";
        }
        else
        {
            point2 = [point2 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point3=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:2]objectForKey:@"x_axis_point"]];
        
        if ([point3 isEqualToString:@"00"])
        {
            point3 =@"";
        }
        else
        {
            point3 = [point3 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point4=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:3]objectForKey:@"x_axis_point"]];
        
        if ([point4 isEqualToString:@"00"])
        {
            point4 =@"";
            
        }
        else
        {
            point4 = [point4 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point5=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:4]objectForKey:@"x_axis_point"]];
        if ([point5 isEqualToString:@"00"])
        {
            point5 =@"";
        }
        else
        {
            point5 = [point5 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point6=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:5]objectForKey:@"x_axis_point"]];
        if ([point6 isEqualToString:@"00"])
        {
            point6 =@"";
        }
        else
        {
            point6 = [point6 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point7=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:6]objectForKey:@"x_axis_point"]];
        
        if ([point7 isEqualToString:@"00"])
        {
            point7 =@"";
        }
        else
        {
            point7 = [point7 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point8=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:7]objectForKey:@"x_axis_point"]];
        if ([point8 isEqualToString:@"00"])
        {
            point8 =@"";
        }
        else
        {
            point8 = [point8 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point9=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:8]objectForKey:@"x_axis_point"]];
        if ([point9 isEqualToString:@"00"])
        {
            point9 =@"";
        }
        else
        {
            point9 = [point9 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSString *point10=[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:9]objectForKey:@"x_axis_point"]];
        if ([point10 isEqualToString:@"00"])
        {
            point10 =@"";
        }
        else
        {
            point10 = [point10 substringWithRange:NSMakeRange(5,5)];
        }
        
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber1 = [f numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:0]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f1 = [[NSNumberFormatter alloc] init];
        [f1 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber2 = [f1 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:1]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
        [f2 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber3 = [f2 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:2]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f3 = [[NSNumberFormatter alloc] init];
        [f3 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber4 = [f3 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:3]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f4 = [[NSNumberFormatter alloc] init];
        [f4 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber5 = [f4 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:4]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f5 = [[NSNumberFormatter alloc] init];
        [f5 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber6 = [f5 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:5]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f6 = [[NSNumberFormatter alloc] init];
        [f6 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber7 = [f6 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:6]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f7 = [[NSNumberFormatter alloc] init];
        [f7 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber8 = [f7 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:7]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f8 = [[NSNumberFormatter alloc] init];
        [f8 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber9 = [f8 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:8]objectForKey:@"y_axis_point"]]];
        
        NSNumberFormatter * f9 = [[NSNumberFormatter alloc] init];
        [f9 setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber10 = [f9 numberFromString:[NSString stringWithFormat:@"%@",[[[[Get_data objectAtIndex:indexPath.row] objectForKey:@"points"]objectAtIndex:9]objectForKey:@"y_axis_point"]]];
        
        
        
        OVGraphView *graphview=[[OVGraphView alloc]initWithFrame:CGRectMake(0,0, graph_base.frame.size.width, graph_base.frame.size.height) ContentSize:CGSizeMake(graph_base.frame.size.width, graph_base.frame.size.height)];
        
        [graph_base addSubview:graphview];
        
     //   [graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:point1 YValue:myNumber1],[[OVGraphViewPoint alloc]initWithXLabel:point2 YValue:myNumber2 ],[[OVGraphViewPoint alloc]initWithXLabel:point3 YValue:myNumber3 ],[[OVGraphViewPoint alloc]initWithXLabel:point4 YValue:myNumber4],[[OVGraphViewPoint alloc]initWithXLabel:point5 YValue:myNumber5 ],[[OVGraphViewPoint alloc]initWithXLabel:point6 YValue:myNumber5 ],[[OVGraphViewPoint alloc]initWithXLabel:point6 YValue:myNumber6],[[OVGraphViewPoint alloc]initWithXLabel:point7 YValue:myNumber7 ],[[OVGraphViewPoint alloc]initWithXLabel:point8 YValue:myNumber8 ],[[OVGraphViewPoint alloc]initWithXLabel:point9 YValue:myNumber9],[[OVGraphViewPoint alloc]initWithXLabel:point10 YValue:myNumber10]]];
        
        
 [graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:point10 YValue:myNumber10],[[OVGraphViewPoint alloc]initWithXLabel:point9 YValue:myNumber9 ],[[OVGraphViewPoint alloc]initWithXLabel:point8 YValue:myNumber8 ],[[OVGraphViewPoint alloc]initWithXLabel:point7 YValue:myNumber7],[[OVGraphViewPoint alloc]initWithXLabel:point5 YValue:myNumber6 ],[[OVGraphViewPoint alloc]initWithXLabel:point6 YValue:myNumber6 ],[[OVGraphViewPoint alloc]initWithXLabel:point5 YValue:myNumber5],[[OVGraphViewPoint alloc]initWithXLabel:point4 YValue:myNumber4 ],[[OVGraphViewPoint alloc]initWithXLabel:point3 YValue:myNumber3 ],[[OVGraphViewPoint alloc]initWithXLabel:point2 YValue:myNumber2],[[OVGraphViewPoint alloc]initWithXLabel:point1 YValue:myNumber1]]];

        
    }
    
    cell.userInteractionEnabled=YES;
    
    cell.selectionStyle=NO;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"^^^^^^^^^^^^^^^");
//    NSMutableArray *Grap_data_array=[[NSMutableArray alloc]init];
//    Grap_data_array=[[Get_data objectAtIndex:indexPath.row]objectForKey:@"points"];
//    
//    PTGraphViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"GraphPage"];
//    obj.Get_data=Grap_data_array;
//    obj.get_unit=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:indexPath.row] objectForKey:@"measure_unit"]];
//    obj.get_graph_id=[NSString stringWithFormat:@"%@",[[Get_data objectAtIndex:indexPath.row] objectForKey:@"id"]];
//    [self.navigationController pushViewController:obj animated:NO];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_button:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
