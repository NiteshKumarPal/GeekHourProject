//
//  AppLoginViewController.m
//  AuthAppByFBLogin
//
//  Created by Webonise on 30/07/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "AppLoginViewController.h"
#import "APIHelper.h"
@interface AppLoginViewController ()
@end

@implementation AppLoginViewController
@synthesize txtPassword,txtUserName,btnLogin;

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
    [self setTitle:@"App Authentication"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -textField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
        [txtUserName resignFirstResponder];
        [txtPassword resignFirstResponder];
      return YES;
}

-(IBAction)appLoginAction:(id)sender{
    NSString *userName=[txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password=[txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *requestString = [NSString stringWithFormat:@"username=%@&password=%@",userName,password];
    if([userName isEqualToString:@""]||[password isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Username and Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
    APIHelper *apiHelper=[[APIHelper alloc]init];
    //apiHelper.showProgress=NO;
    [apiHelper apiCallWithURL:APP_URL withParameters:requestString withLoadingText:@"Loading" withView:self.view];
    apiHelper.delegate = self;
    }
}

- (void)apiCallWithResponse:(id)response{
    NSLog(@"%@",response);
    NSString *resp=[response valueForKey:@"responce"];
    if([resp isEqualToString:@"SUCCESS"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Successful Login"delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        ViewController *successView=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:successView animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Username or password incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)apiCallWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Data not saved" delegate:self cancelButtonTitle:@"OK"otherButtonTitles: nil];
    [alert show];
}

@end
