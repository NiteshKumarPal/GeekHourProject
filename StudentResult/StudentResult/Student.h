//
//  Student.h
//  StudentResult
//
//  Created by Webonise on 03/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"
@interface Student : NSObject
@property (retain,nonatomic) NSString *name;
@property (retain,nonatomic) NSString *rollNumber;
@property (retain,nonatomic) NSString *semester;
@property (retain,nonatomic) NSString *course;
@property (retain,nonatomic) NSMutableSet *subjects;
@property (retain,nonatomic) Result *result;
@end
