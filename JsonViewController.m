//
//  JsonViewController.m
//  Fitness
//
//  Created by Rahul Singha Roy on 04/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "JsonViewController.h"
#import "NetworkBlock.h"
@interface JsonViewController ()<iOSBlocksProtocol>

@end

@implementation JsonViewController
@synthesize Received_URL;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

-(void)GetJsonObjectFromURL:(NSString *)urlname WithSpinner:(UIActivityIndicatorView *)Spinner Withblock:(Urlresponceblock)responce
{
    NSLog(@"Running Url ...... %@",urlname);
    
    NSURL *jsonurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[urlname stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    NSURLRequest *urlrequest=[NSURLRequest requestWithURL:jsonurl];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];
    connection=nil;
    _responce=[responce copy];
}


#pragma NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    JsonData=nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    JsonData=[data mutableCopy];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result=[NSJSONSerialization JSONObjectWithData:JsonData options:kNilOptions error:nil];
    _responce(result,nil);
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    UIAlertView *login_alrt2=[[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Please check your WiFi / 3G" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [login_alrt2 show];
    
    _responce(nil,error);
}

-(NSString *) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter
{
    
    NSLog(@"Main URL --- %@", parameter);
    
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"client_current_image\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    
    NSURLResponse *response = nil;
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    
    NSString *result = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    return result;
    
}
-(NSString *) GlobalDict_image2:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter
{
    
    NSLog(@"Main URL --- %@", parameter);
    
    
    //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"client_goal_image\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }
    
    
    NSURLResponse *response = nil;
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    
    NSString *result = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    return result;
    
}



- (void)didReceiveMemoryWarning
{
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

@end
