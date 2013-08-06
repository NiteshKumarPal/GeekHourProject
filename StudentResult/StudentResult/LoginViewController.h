//
//  LoginViewController.h
//  StudentResult
//
//  Created by Webonise on 06/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (retain,nonatomic) IBOutlet UIButton *btnLoginApplication;
@property (retain,nonatomic) IBOutlet UIButton *btnLoginFacebook;
-(IBAction)loginApp:(id)sender;
-(IBAction)loginByFacebook:(id)sender;

@end
