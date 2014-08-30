//
//  Queue.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/22/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import "Queue.h"

@interface Queue()
@property (strong, nonatomic) NSMutableArray *internalList;
@end

@implementation Queue

- (id)init {
    if(self = [super init]) {
        self.internalList = [NSMutableArray new];
    }
    return self;
}

- (void)enqueue:(id)obj {
    [self.internalList addObject:obj];
}

- (id)dequeue {
    id obj = [self.internalList firstObject];
    [self.internalList removeObjectAtIndex:0];
    return obj;
}

- (id)peek {
    return [[self.internalList firstObject] copy];
}

- (BOOL)isEmpty {
    return self.internalList.count == 0;
}

- (void)clear {
    self.internalList = [NSMutableArray new];
}

- (NSArray *)allObjects {
    return [self.internalList copy];
}
@end
