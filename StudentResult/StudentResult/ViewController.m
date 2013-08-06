//
//  ViewController.m
//  StudentResult
//
//  Created by Webonise on 03/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"
#import "Student.h"
#import "Result.h"
#import "Subject.h"
#import "Parser.h"
#import "ModelContext.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize apiHelper,stdResponce,txtRollNumber,txtSemester,btnLogout,btnResult,rollNumber,semester;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.txtSemester resignFirstResponder];
    [self.txtSemester resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -textField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtRollNumber){
        [txtSemester becomeFirstResponder];
    }else if (textField == txtSemester){
        [txtSemester resignFirstResponder];
    }
    
    return YES;
}

#pragma -get Student Result
-(IBAction)getStudentResult:(id)sender{
    rollNumber=txtRollNumber.text;
    semester=txtSemester.text;
    NSString *requestString = [NSString stringWithFormat:@"rollNum=%@&sem=%@",rollNumber,semester];
    apiHelper=[[APIHelper alloc]init];
    [apiHelper apiCallWithURL:@"http://localhost:8888/StudentData.JSON" withParameters:requestString withLoadingText:@"Loading" withView:self.view];
    apiHelper.delegate=self;
}

#pragma -APIHelperDelegate
- (void)apiCallWithResponse:(id)response{
    int arrDictCount=[response count];
    //"name":"Mohit",
    //"rollNumber":"1002",
    NSLog(@"%@",rollNumber);
    NSLog(@"%@",semester);
    int flag=0;
    for (int i=0; i<arrDictCount; i++) {
        NSDictionary *dict=[response objectAtIndex:i];
        if([[dict valueForKey:@"rollNumber"] isEqualToString:self.rollNumber]&&[[dict valueForKey:@"semester"] isEqualToString:self.semester]){
            self.stdResponce=dict;
            NSLog(@"%@",self.stdResponce);
            flag=1;
            break;
        }
    }
        if(!flag){
            NSLog(@"%@",self.stdResponce);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"RollNo and Semester is not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
    
    NSLog(@"%@",self.stdResponce);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"API hit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    //mapping dictionary to object
    
    Student *student=[[Student alloc]init];
    Result *studentResult=[[Result alloc]init];
    student.result=studentResult;
    Subject *sub=[[Subject alloc]init];
    student.subjects=[NSArray arrayWithObjects:sub, nil];
    
    Parser *parser=[[Parser alloc]init];
    student=[parser dictionaryToObjectMappingForObject:student fromDictionary:self.stdResponce];;
    
    
    //testing for correct parsing
    NSLog(@"%@",student.subjects);
    NSLog(@"%@",student.name);
    NSLog(@"%d",[student.subjects count]);
    NSLog(@"%@",student.result.status);
    
    ResultViewController *resultView=[[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
    resultView.resultStudent=student;
    [self.navigationController pushViewController:resultView animated:YES];
    
}
- (void)apiCallWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Data not saved" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    [alert show];
}

#pragma -Logout Method
-(IBAction)logOut:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        [appDelegate.session closeAndClearTokenInformation];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
