//
//  ViewController.h
//  StudentResult
//
//  Created by Webonise on 03/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelper.h"
@interface ViewController : UIViewController<APIHelperDelegate,UITextFieldDelegate>
@property (retain,nonatomic) IBOutlet UITextField *txtRollNumber;
@property (retain,nonatomic) IBOutlet UITextField *txtSemester;
@property (retain,nonatomic) IBOutlet UIButton *btnResult;
@property (retain,nonatomic) IBOutlet UIButton *btnLogout;
@property (retain,nonatomic) APIHelper *apiHelper;
@property (retain,nonatomic) NSDictionary *stdResponce;
-(IBAction)getStudentResult:(id)sender;
-(IBAction)logOut:(id)sender;

@end
