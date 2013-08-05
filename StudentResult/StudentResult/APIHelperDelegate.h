//
//  APIHelperDelegate.h
//  Assignment_NSURLconnection
//
//  Created by Webonise on 17/07/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIHelperDelegate <NSObject>
@required
- (void)apiCallWithResponse:(id)response;
- (void)apiCallWithError:(NSError *)error;
@end
