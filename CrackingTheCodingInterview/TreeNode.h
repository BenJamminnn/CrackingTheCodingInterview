//
//  TreeNode.h
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/21/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject
@property (strong, nonatomic) TreeNode *leftChild;
@property (strong, nonatomic) TreeNode *rightChild;
@property (strong, nonatomic) TreeNode *parent;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) int value;
@property (nonatomic, readonly) int height;
@property (nonatomic, strong) NSArray *children;


- (instancetype)initWithName:(NSString *)name andValue:(int)value;
- (instancetype)initWithValue:(int)value;
- (BOOL)isNodeEqualTo:(TreeNode *)node;
- (BOOL)isValueEqualTo:(TreeNode *)node;
- (BOOL)isLeaf;
- (BOOL)isRightChild;
- (BOOL)isLeftChild;
- (BOOL)hasOneChild;

@end
