//
//  Stack.h
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/22/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

- (void)push:(id)obj;
- (id)pop;
- (id)peek;
- (void)clear;
- (NSArray *)allObjects;
- (BOOL)isEmpty;
@end
