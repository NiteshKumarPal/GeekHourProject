//
//  Parser.m
//  ObjectMapping
//
//  Created by Webonise on 02/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "Parser.h"
#import <objc/runtime.h>
@implementation Parser
-(id)dictionaryToObjectMappingForObject:(id)object fromDictionary:(NSDictionary*)dict
{
    
    unsigned count,testCount;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSLog(@"present key:-%@",key);
        NSLog(@"%@",[object valueForKey:key]);
        if([[object valueForKey:key] isKindOfClass:[NSObject class]]){
            id test1Obj=[object valueForKey:key];
            objc_property_t *testProperties=class_copyPropertyList([test1Obj class], &testCount);
            //for composite objects
            if(testCount>1){
                test1Obj=[self dictionaryToObjectMappingForObject:test1Obj fromDictionary:[dict objectForKey:key]];
                [object setValue:test1Obj forKey:key];
                continue;
            }
            
            //for an object which is an array
            if([[object valueForKey:key] isKindOfClass:[NSArray class]]||[[object valueForKey:key] isKindOfClass:[NSSet class]]){
                
                id  test2Obj =[object valueForKey:key];
                
                NSArray *testDictArr=[dict objectForKey:key];
                unsigned arrCount=[testDictArr count];
                NSMutableArray *objectArr=[[NSMutableArray alloc]initWithCapacity:arrCount];
                
                Class modelClass;
                if([[object valueForKey:key] isKindOfClass:[NSSet class]]){
                    NSArray *modelArr=[NSArray arrayWithObject:test2Obj];
                    modelClass=[[modelArr objectAtIndex:0] class];
                }else{
                    modelClass=[[test2Obj objectAtIndex:0] class];
                }
                
                for(int i = 0 ;i < arrCount ; i++){
                    id tempobj=[[modelClass alloc]init];
                    id obj=[self dictionaryToObjectMappingForObject:tempobj fromDictionary:[testDictArr objectAtIndex:i]];
                    [objectArr addObject:obj];
                }
                
                [object setValue:objectArr forKey:key];
                continue;
            }
            
        }
        
        [object setValue:[dict valueForKey:key] forKey:key];
    }
    
    return object;
}

@end
