//
//  BinaryTree.h
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/21/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TreeNode;

@interface BinaryTree : NSObject
@property (nonatomic, readonly) NSUInteger numberOfNodes;
@property (nonatomic, strong) TreeNode *root;
@property (nonatomic, readonly) int height;

- (TreeNode *)findNodeByValue:(int)value;

- (void)addNode:(TreeNode *)node;

- (void)addNodes:(NSArray *)nodes;

- (void)deleteNodeByValue:(int)value;

- (BOOL)doesContain:(TreeNode *)node;

- (TreeNode *)findGreatestNodeWithinNode:(TreeNode *)node;

- (TreeNode *)findLeastNodeWithinNode:(TreeNode *)node;

//traversals
- (void)levelOrderTraversal:(TreeNode *)node;
- (void)inOrderTraversal:(TreeNode *)node;
- (void)postOrderTraversal:(TreeNode *)node;
- (void)preOrderTraversal:(TreeNode *)node;

//BFS & DFS
- (void)depthFirstSearch:(TreeNode *)node;
- (void)breadthFirstSearch:(TreeNode *)node;



@end
