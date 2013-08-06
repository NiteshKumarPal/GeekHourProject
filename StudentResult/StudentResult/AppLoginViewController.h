//
//  AppLoginViewController.h
//  AuthAppByFBLogin
//
//  Created by Webonise on 30/07/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelper.h"
@interface AppLoginViewController : UIViewController<APIHelperDelegate,UITextFieldDelegate>
@property(retain,nonatomic) IBOutlet UITextField *txtUserName;
@property(retain,nonatomic) IBOutlet UITextField *txtPassword;
@property(retain,nonatomic) IBOutlet UIButton *btnLogin;

-(IBAction)appLoginAction:(id)sender;

@end
