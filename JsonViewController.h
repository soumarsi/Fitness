//
//  JsonViewController.h
//  Fitness
//
//  Created by Rahul Singha Roy on 04/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkBlock.h"
#import "GlobalClass.pch"
@interface JsonViewController : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

{
     NSMutableData *JsonData;
    Urlresponceblock _responce;
}

@property(nonatomic,retain)NSString *Received_URL;

-(void)GetJsonObjectFromURL:(NSString *)urlname WithSpinner:(UIActivityIndicatorView *)Spinner Withblock:(Urlresponceblock)responce;

-(NSString *) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter;

-(NSString *) GlobalDict_image2:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter;


@end
