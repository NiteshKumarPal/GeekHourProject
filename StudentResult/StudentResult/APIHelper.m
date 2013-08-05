//
//  APIHelper.m
//  Assignment_NSURLconnection
//
//  Created by Webonise on 17/07/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper
@synthesize bufferData;
@synthesize delegate;
@synthesize connection;
@synthesize progress;
@synthesize showProgress;

-(id)init{
    showProgress=YES;
    return [super init];
}

- (void)apiCallWithURL:(NSString *)url withParameters:(NSString *)parameterString withLoadingText:(NSString *)text withView:(UIView *)view{
    //show loading
    if(showProgress){
        [self showLoadingWithLabel:text withView:view];
    }
    
    NSLog(@"in helper class");
    if(parameterString){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[parameterString dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:@"POST"];
        [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:postData];
        
        self.connection=[NSURLConnection connectionWithRequest:request delegate:self];
        if(self.connection){
            self.bufferData=[[NSMutableData alloc] init];
            [self.connection start];
        }else{
            NSLog(@"Connection failed");
        }
        
        
    }else{
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        self.connection=[NSURLConnection connectionWithRequest:request delegate:self];
        
        if(self.connection){
            self.bufferData=[[NSMutableData alloc] init];
            [self.connection start];
        }else{
            NSLog(@"Connection failed");
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self.bufferData setLength:0];
    NSLog(@"in didReceiveResponse");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.bufferData appendData:data];
    NSLog(@"in didReceiveData");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    id jsonDictionary=[NSJSONSerialization JSONObjectWithData:self.bufferData options:0 error:nil];
    //hide loading
    if(showProgress){
        [progress hide:YES];
    }
    [delegate apiCallWithResponse:jsonDictionary];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Failed");
    [delegate apiCallWithError:error];
}


- (void)showLoadingWithLabel:(NSString *)loadingMsg withView:(UIView *)view{
    progress = [MBProgressHUD showHUDAddedTo:view animated:NO];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.labelText = loadingMsg;
}
@end
