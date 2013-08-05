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
@synthesize apiHelper,stdResponce,txtRollNumber,txtSemester;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Result App"];
    [self.txtSemester resignFirstResponder];
    [self.txtSemester resignFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@" in  ..textFieldShouldReturn");
    if(textField == txtRollNumber){
        NSLog(@"if(textField == txtFieldFirst){");
        [txtSemester becomeFirstResponder];
    }else if (textField == txtSemester){
        [txtSemester resignFirstResponder];
    }
    
    return YES;
}

-(IBAction)getStudentResult:(id)sender{
//    //getting json string from json file
//    NSStringEncoding encoding;
//    NSString* content;
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"StudentData" ofType:@"JSON"];
//    if(path)
//    {
//        content = [NSString stringWithContentsOfFile:path  usedEncoding:&encoding  error:NULL];
//    }
//    NSLog(@"path is %@",path);
//    if (content)
//    {
//        NSLog(@" content of file is %@",content);
//    }
//    //converting json into dictionary
//    NSData *jsnData = [content dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    id jsonObjectString=[NSJSONSerialization JSONObjectWithData:jsnData options:NSJSONReadingMutableContainers error:&error];
//    if(error!=nil){
//        NSLog(@"%@",[error debugDescription]);
//    }
//    
//    //mapping dictionary to object
//    Student *student=[[Student alloc]init];
//    Result *studentResult=[[Result alloc]init];
//    student.result=studentResult;
//    Subject *sub=[[Subject alloc]init];
//    student.subjects=[NSArray arrayWithObjects:sub, nil];
//    
//    NSDictionary *dict=(NSDictionary *)jsonObjectString;
//    Parser *parser=[[Parser alloc]init];
//    student=[parser dictionaryToObjectMappingForObject:student fromDictionary:dict];
//    
//    //testing for correct parsing
//    NSLog(@"%@",student.name);
//    NSLog(@"%d",[student.subjects count]);
//    NSLog(@"%@",student.result.status);
//    
//    ResultViewController *resultView=[[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
//    resultView.resultStudent=student;
//    [self.navigationController pushViewController:resultView animated:YES];
    NSString *rollNumber=txtRollNumber.text;
    NSString *semester=txtSemester.text;
    NSString *requestString = [NSString stringWithFormat:@"rollNum=%@&sem=%@",rollNumber,semester];
    apiHelper=[[APIHelper alloc]init];
    [apiHelper apiCallWithURL:@"http://localhost:8888/StudentData.JSON" withParameters:requestString withLoadingText:@"Loading" withView:self.view];
    apiHelper.delegate=self;
}

- (void)apiCallWithResponse:(id)response{
    self.stdResponce=response;
    NSLog(@"%@",self.stdResponce);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:NSLocalizedString(@"SUCCESS", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    [alert show];
    //    //mapping dictionary to object
    ModelContext *context=[ModelContext sharedSingletonObject];
        Student *student=[[Student alloc]init];
    NSEntityDescription *resultEntity=[NSEntityDescription entityForName:@"Result" inManagedObjectContext:context.managedObjectContext];
        Result *studentResult=[[Result alloc]initWithEntity:resultEntity insertIntoManagedObjectContext:context.managedObjectContext];
        student.result=studentResult;
    
    NSEntityDescription *subjectEntity=[NSEntityDescription entityForName:@"Subject" inManagedObjectContext:context.managedObjectContext];
    
        Subject *sub=[[Subject alloc]initWithEntity:subjectEntity insertIntoManagedObjectContext:context.managedObjectContext];
    
        student.subjects=[NSSet setWithObjects:sub, nil];
    
        Parser *parser=[[Parser alloc]init];
    student=[parser dictionaryToObjectMappingForObject:student fromDictionary:self.stdResponce];;
    NSLog(@"%@",student.subjects);
    [context insertIntoEntity:@"Student" entityObject:student];
        //testing for correct parsing
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

@end
