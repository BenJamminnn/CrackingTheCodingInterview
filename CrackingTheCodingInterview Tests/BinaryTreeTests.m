//
//  BinaryTreeTests.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/29/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryTree.h"
#import "TreeNode.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@interface BinaryTreeTests : XCTestCase

@end

@implementation BinaryTreeTests

- (NSArray *)treeNodes {
    TreeNode *node20 = [[TreeNode alloc]initWithValue:20];
    TreeNode *node10 = [[TreeNode alloc]initWithValue:10];
    TreeNode *node5 = [[TreeNode alloc]initWithValue:5];
    TreeNode *node1 = [[TreeNode alloc]initWithValue:1];
    TreeNode *node7 = [[TreeNode alloc]initWithValue:7];
    TreeNode *node15 = [[TreeNode alloc]initWithValue:15];
    TreeNode *node12 = [[TreeNode alloc]initWithValue:12];
    TreeNode *node18 = [[TreeNode alloc]initWithValue:18];
    TreeNode *node30 = [[TreeNode alloc]initWithValue:30];
    TreeNode *node23 = [[TreeNode alloc]initWithValue:23];
    TreeNode *node32 = [[TreeNode alloc]initWithValue:32];
    TreeNode *node35 = [[TreeNode alloc]initWithValue:35];
    TreeNode *node40 = [[TreeNode alloc]initWithValue:40];
    TreeNode *node27 = [[TreeNode alloc]initWithValue:27];
    TreeNode *node21 = [[TreeNode alloc]initWithValue:21];
    
    return @[node20, node10, node5, node1, node7, node15, node12, node18, node30, node23, node35, node27, node40 , node32, node21];
}

- (BinaryTree *)treeInstance {
    BinaryTree *tree = [BinaryTree new];
    for(TreeNode *node in [self treeNodes]) {
        [tree addNode:node];
    }
    return tree;
}

- (void)testRemovingNodes {
    BinaryTree *tree = [self treeInstance];
    for (NSUInteger i = [[self treeNodes]count] -1; i > 1; i-- ) {
        TreeNode *temp = [[self treeNodes]objectAtIndex:i -1];
        NSLog(@"removing node: %i" , temp.value);
        [tree deleteNodeByValue:temp.value];
        NSLog(@"%@" , tree);
        NSLog(@"Tree Height: %i" , tree.height);
    }
}

- (void)testRemovingNodesTwoChildren {
    BinaryTree *tree = [self treeInstance];
    NSLog(@"%@ removing 10..." , tree);
    [tree deleteNodeByValue:10];
    NSLog(@"%@ removing 15..." , tree);
    [tree deleteNodeByValue:15];
    NSLog(@"%@ removing 5..." , tree);
    [tree deleteNodeByValue:5];
    NSLog(@"%@ removing 30..." , tree);
    [tree deleteNodeByValue:30];
}

- (void)addingNodesBinaryTree {
    BinaryTree *tree = [BinaryTree new];
    for(TreeNode *node in [self treeNodes]) {
        NSLog(@"adding node: %@" , node);
        [tree addNode:node];
        
        NSLog(@"\n%@" , tree);
        NSLog(@"Tree height: %i\n" , tree.height);
    }
}

#pragma mark - DFS and BFS testing

- (void)testDFS {
    NSLog(@"looking for node with value 18");
    TreeNode *node = [[TreeNode alloc]initWithValue:18];
    BinaryTree *tree = [self treeInstance];
    [tree depthFirstSearch:node];
}

- (void)testBFS {
    NSLog(@"looking for node with value 18");
    TreeNode *node = [[TreeNode alloc]initWithValue:18];
    BinaryTree *tree = [self treeInstance];
    [tree breadthFirstSearch:node];
}



#pragma mark - traversal testing

- (void)testPreOrderTraversal {
    NSLog(@"%@" , [self treeInstance]);
    
    BinaryTree *tree = [self treeInstance];
    [tree preOrderTraversal:tree.root];
}

- (void)testPostOrderTraversal {
    NSLog(@"%@" , [self treeInstance]);
    
    BinaryTree *tree = [self treeInstance];
    [tree postOrderTraversal:tree.root];
}

- (void)testLevelOrderTraversal {
    NSLog(@"%@" , [self treeInstance]);
    
    BinaryTree *tree = [self treeInstance];
    [tree levelOrderTraversal:tree.root];
}

- (void)testInOrderTraversal {
    BinaryTree *tree = [self treeInstance];
    
    NSLog(@"%@" , tree);
    
    [tree inOrderTraversal:tree.root];
}


- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddNodes
{
        
}

@end
