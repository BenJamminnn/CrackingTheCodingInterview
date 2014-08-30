//
//  Queue.h
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/22/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

- (void)enqueue:(id)obj;
- (id)dequeue;
- (id)peek;
- (BOOL)isEmpty;
- (void)clear;
- (NSArray *)allObjects;

@end
