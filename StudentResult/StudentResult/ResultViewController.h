//
//  ResultViewController.h
//  StudentResult
//
//  Created by Webonise on 04/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
@interface ResultViewController : UIViewController
@property (retain,nonatomic) IBOutlet UILabel *lblName;
@property (retain,nonatomic) IBOutlet UILabel *lblRollNumber;
@property (retain,nonatomic) IBOutlet UILabel *lblSemester;
@property (retain,nonatomic) IBOutlet UILabel *lblCourse;
//@property (retain,nonatomic) IBOutlet UILabel *lblSubject;
//@property (retain,nonatomic) IBOutlet UILabel *lblMark;
@property (retain,nonatomic) IBOutlet UILabel *lblTotal;
@property (retain,nonatomic) IBOutlet UILabel *lblStatus;
@property (retain,nonatomic) Student *resultStudent;
@end
