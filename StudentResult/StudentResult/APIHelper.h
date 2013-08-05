//
//  APIHelper.h
//  Assignment_NSURLconnection
//
//  Created by Webonise on 17/07/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIHelperDelegate.h"
#import "MBProgressHUD.h"

@interface APIHelper : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,retain) NSURLConnection *connection;
@property (nonatomic,retain) NSMutableData *bufferData;
@property (nonatomic,retain) id<APIHelperDelegate> delegate;
@property (nonatomic,retain) MBProgressHUD *progress;
@property bool showProgress;

- (void)apiCallWithURL:(NSString *)url withParameters:(NSString *)parameterString withLoadingText:(NSString *)text withView:(UIView *)view;
@end
