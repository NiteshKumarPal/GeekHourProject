//
//  LoginViewController.m
//  StudentResult
//
//  Created by Webonise on 06/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
  [self.navigationController setNavigationBarHidden:YES animated:YES];   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -Helper methods
// FBSample logic
// main helper method to update the UI to reflect the current state of the session.
- (void)updateView {
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        ViewController *successView=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:successView animated:YES];
    } else {
        // login-needed account UI is shown whenever the session is closed
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Not Logged in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}



- (void)handleAuthError:(NSError *)error{
    NSString *alertMessage, *alertTitle;
    
    if (error.fberrorShouldNotifyUser) {
        // If the SDK has a message for the user, surface it.
        alertTitle = @"Something Went Wrong";
        alertMessage = error.fberrorUserMessage;
    } else if (error.fberrorCategory == FBErrorCategoryUserCancelled) {
        // The user has cancelled a login. You can inspect the error
        // for more context. For this sample, we will simply ignore it.
        NSLog(@"user cancelled login");
    } else {
        // For simplicity, this sample treats other errors blindly.
        alertTitle  = @"Unknown Error";
        alertMessage = @"Error. Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma -Application Login method
-(IBAction)loginApp:(id)sender{
    AppLoginViewController *appLoginViewController=[[AppLoginViewController alloc]initWithNibName:@"AppLoginViewController" bundle:nil];
    [self.navigationController pushViewController:appLoginViewController animated:YES];
    
}

#pragma -facebook Login method
-(IBAction)loginByFacebook:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        
        appDelegate.session = [[FBSession alloc] init];
        
//        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
//                                                         FBSessionState status,
//                                                         NSError *error) {
        [appDelegate.session openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session,FBSessionState status,NSError *error) {

            if(error){
                [self handleAuthError:error];
            }
            
            switch (status) {
                case FBSessionStateOpen:
                    if (!error) {
                        // We have a valid session
                        NSLog(@"User session found");
                        [self updateView];
                    }
                    break;
                case FBSessionStateClosed:
                    NSLog(@"FBSessionStateClosed");
                case FBSessionStateClosedLoginFailed:
                    NSLog(@"FBSessionStateClosedLoginFailed");
                    [FBSession.activeSession closeAndClearTokenInformation];
                    break;
                default:
                    break;
            }
            if (!error) {
                [self updateView];
            }
        }];
        
    }

}

@end
