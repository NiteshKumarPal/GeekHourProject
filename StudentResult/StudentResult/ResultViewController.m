//
//  ResultViewController.m
//  StudentResult
//
//  Created by Webonise on 04/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "ResultViewController.h"
#import "Subject.h"
@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize lblName,lblCourse,lblRollNumber,lblSemester,lblStatus,lblTotal,resultStudent;
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
    [self setTitle:@"Student Result"];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    if(resultStudent){
    lblName.text=resultStudent.name;
    lblRollNumber.text=resultStudent.rollNumber;
    lblSemester.text=resultStudent.semester;
    lblCourse.text=resultStudent.course;
    lblTotal.text=[resultStudent.result.total stringValue];
    lblStatus.text=resultStudent.result.status;
  
    int heightSpace=179;
    for(int i=0;i<[resultStudent.subjects count];i++){
        heightSpace=(30+heightSpace);
    UILabel *lblsubjectName=[[UILabel alloc]initWithFrame:CGRectMake(27, heightSpace, 126, 21)];
        NSArray *subArr=[NSArray arrayWithObject:resultStudent.subjects];
        Subject *sub=[subArr objectAtIndex:i];
        lblsubjectName.text=sub.subject;
        [[self view] addSubview:lblsubjectName];
    UILabel *lblMarks=[[UILabel alloc]initWithFrame:CGRectMake(180, heightSpace, 126, 21)];
        lblMarks.text=[sub.mark stringValue];
        [[self view] addSubview:lblMarks];
    }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
