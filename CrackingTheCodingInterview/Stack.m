//
//  Stack.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/22/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import "Stack.h"
@interface Stack()
@property (strong, nonatomic) NSMutableArray *internalList;
@end
@implementation Stack


- (id)init {
    if(self = [super init]) {
        self.internalList = [NSMutableArray new];
    }
    return self;
}

- (void)push:(id)obj {
    [self.internalList addObject:obj];
}

- (id)pop {
    id obj = [self.internalList lastObject];
    [self.internalList removeLastObject];
    return obj;
}

- (id)peek {
    return [[self.internalList lastObject] copy];
}

- (void)clear {
    self.internalList = [NSMutableArray new];
}

- (NSArray *)allObjects {
    return [self.internalList copy];
}

- (BOOL)isEmpty {
    return (self.internalList.count < 1);
}
@end
