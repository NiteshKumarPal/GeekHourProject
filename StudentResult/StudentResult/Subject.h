//
//  Subject.h
//  StudentResult
//
//  Created by Webonise on 04/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSManagedObject
@property (retain,nonatomic) NSString *subject;
@property (retain,nonatomic) NSNumber *mark;
@end
