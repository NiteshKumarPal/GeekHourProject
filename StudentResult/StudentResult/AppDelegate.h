//
//  AppDelegate.h
//  StudentResult
//
//  Created by Webonise on 03/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) ViewController *viewController;

@end
