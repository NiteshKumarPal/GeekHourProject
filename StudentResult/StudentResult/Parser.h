//
//  Parser.h
//  ObjectMapping
//
//  Created by Webonise on 02/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject
-(id)dictionaryToObjectMappingForObject:(id)obj fromDictionary:(NSDictionary*)dict;
@end
