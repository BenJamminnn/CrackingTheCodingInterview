//
//  TreeNode.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/21/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import "TreeNode.h"
#import "Stack.h"
#import "Queue.h"
@interface TreeNode()
@property (nonatomic, readwrite) int height;
@end
@implementation TreeNode

- (instancetype)init {
    if(self = [super init])  {
        self.value = -1;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name andValue:(int)value {
    if (self = [super init]) {
        self.value = value;
        self.name = name;
    }
    return self;
}

- (instancetype)initWithValue:(int)value {
    if(self = [super init]) {
        self.value = value;
    }
    return self;
}

- (BOOL)isValueEqualTo:(TreeNode *)node {
    return self.value == node.value;
}

- (BOOL)isNodeEqualTo:(TreeNode *)node {
    return (self.name == node.name && self.value == node.value);
}

- (BOOL)isLeaf {
    return (!self.leftChild && !self.rightChild);
}

- (BOOL)isLeftChild {
    return self.value < self.parent.value;
}

- (BOOL)isRightChild {
    return self.value > self.parent.value;
}

- (BOOL)hasOneChild {
    if(self.leftChild && self.rightChild) {
        return NO;
    }
    
    if(self.isLeaf) {
        return NO;
    }
    
    return YES;
}



- (int)height {
    
    int lefth = self.leftChild.height;
    int righth = self.rightChild.height;
    
    if(lefth > righth) {
        return lefth + 1;
    } else {
        return righth +1;
    }
}

- (NSString *)description  {
    if(!self) {
        return @"00";
    }
    if(self.value < 0) {
        return [NSString stringWithFormat:@"00"];
    }
    return [NSString stringWithFormat:@"%d" , self.value];
}

- (NSArray *)children {
    NSMutableArray *children = [NSMutableArray new];
    TreeNode *focusNode = self;

    
    focusNode.parent = nil;
    Queue *queue = [Queue new];
    [queue enqueue:focusNode];
    NSUInteger count = 0;
    while (!queue.isEmpty) {
        TreeNode *nodeTemp = [queue dequeue];
        if(count != 0) {
            [children addObject:nodeTemp];

        }
        if(nodeTemp.leftChild) {
            [queue enqueue:nodeTemp.leftChild];
            focusNode = nodeTemp.leftChild;
            focusNode.parent = nodeTemp;
        }
        
        if(nodeTemp.rightChild) {
            [queue enqueue:nodeTemp.rightChild];
            focusNode = focusNode.rightChild;
            focusNode.parent = nodeTemp;
        }
        count++;
    }
    return children;
}

- (BOOL)isEqual:(id)object {
    TreeNode *node = (TreeNode *)object;
    return self.value == node.value;
}

- (id)copy {
    TreeNode *node = [[TreeNode alloc]initWithValue:self.value];
    return node;
}
@end
