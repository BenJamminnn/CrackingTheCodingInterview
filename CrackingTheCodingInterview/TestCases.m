//
//  TestCases.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/22/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//
#import "TreeNode.h"
#import "TestCases.h"
#import "AVLTree.h"
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@implementation TestCases

#pragma mark - example tree

- (NSArray *)treeNodes {
    TreeNode *nodeA = [[TreeNode alloc]initWithValue:20];
    TreeNode *nodeB = [[TreeNode alloc]initWithValue:10];
    TreeNode *nodeC = [[TreeNode alloc]initWithValue:5];
    TreeNode *nodeD = [[TreeNode alloc]initWithValue:1];
    TreeNode *nodeE = [[TreeNode alloc]initWithValue:7];
    TreeNode *nodeF = [[TreeNode alloc]initWithValue:15];
    TreeNode *nodeG = [[TreeNode alloc]initWithValue:12];
    TreeNode *nodeH = [[TreeNode alloc]initWithValue:18];
    TreeNode *nodeI = [[TreeNode alloc]initWithValue:30];
    TreeNode *nodeJ = [[TreeNode alloc]initWithValue:23];
    TreeNode *nodeK = [[TreeNode alloc]initWithValue:32];
    TreeNode *nodeAB = [[TreeNode alloc]initWithValue:35];
    TreeNode *nodeAA = [[TreeNode alloc]initWithValue:40];
    TreeNode *nodeAC = [[TreeNode alloc]initWithValue:27];


    TreeNode *nodeL = [[TreeNode alloc]initWithValue:21];
    return @[nodeA, nodeB, nodeC, nodeD, nodeE, nodeF, nodeG, nodeH, nodeI, nodeJ, nodeAB, nodeAC, nodeAA , nodeK , nodeL];
}

- (BinaryTree *)treeInstance {
    BinaryTree *tree = [BinaryTree new];
    for(TreeNode *node in [self treeNodes]) {
        [tree addNode:node];
    }
    return tree;
}

#pragma mark - basic operations

- (void)testRemovingNodes {
    BinaryTree *tree = [self treeInstance];
    for (NSUInteger i = [[self treeNodes]count] -1; i > 1; i-- ) {
        TreeNode *temp = [[self treeNodes]objectAtIndex:i -1];
        NSLog(@"removing node: %i" , temp.value)
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

- (void)addingNodesAVL {
    AVLTree *tree = [[AVLTree alloc]init];
    [tree addNodes:[self treeNodes]];
    NSLog(@"current tree: %@", tree );
}

- (void)removingNodesAVLTree {
    AVLTree *tree = [[AVLTree alloc]init];
    [tree addNodes:[self treeNodes]];
    NSLog(@"current tree: %@", tree );
    for(TreeNode *node in tree.root.children) {
        [tree deleteNodeByValue:node.value];
        NSLog(@"node removed: %d" , node.value);
        NSLog(@"Tree after node removal: %@" , tree);
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

#pragma mark - testing rotations

- (AVLTree *)exampleRotateRightSimple {
    AVLTree *tree = [AVLTree new];
    TreeNode *nodeA = [[TreeNode alloc]initWithValue:20];
    TreeNode *nodeB = [[TreeNode alloc]initWithValue:10];
    TreeNode *nodeC = [[TreeNode alloc]initWithValue:5];
    TreeNode *nodeD = [[TreeNode alloc]initWithValue:3];

    [tree addNodes:@[nodeA , nodeB, nodeC, nodeD]];
    return tree;

}

- (AVLTree *)exampleRotateRightComplex {
    AVLTree *tree = [self exampleRotateRightSimple];
    TreeNode *nodeA = [[TreeNode alloc]initWithValue:7];
    TreeNode *nodeB = [[TreeNode alloc]initWithValue:12];
    TreeNode *nodeC = [[TreeNode alloc]initWithValue:2];
    [tree addNodes:@[nodeA, nodeB, nodeC]];

    return tree;
}

- (AVLTree *)exampleRotateLeftComplex {
    AVLTree *tree = [self exampleRotateLeftSimple];
    TreeNode *nodeA = [[TreeNode alloc]initWithValue:3];
    TreeNode *nodeB = [[TreeNode alloc]initWithValue:30];
    TreeNode *nodeC = [[TreeNode alloc]initWithValue:8];
    TreeNode *nodeD = [[TreeNode alloc]initWithValue:6];
    TreeNode *nodeE = [[TreeNode alloc]initWithValue:9];

    [tree addNodes:@[nodeA , nodeB, nodeC, nodeD, nodeE]];
    return tree;
}

- (AVLTree *)exampleRotateLeftSimple {
    AVLTree *tree = [AVLTree new];
    TreeNode *nodeA = [[TreeNode alloc]initWithValue:5];
    TreeNode *nodeB = [[TreeNode alloc]initWithValue:10];
    TreeNode *nodeC = [[TreeNode alloc]initWithValue:20];
    TreeNode *nodeD = [[TreeNode alloc]initWithValue:30];

    [tree addNodes:@[nodeA , nodeB , nodeC, nodeD]];
    return tree;
}

- (void)testAllLeftRotations {
    [self testRotateLeftSimple];
    [self testRotateLeftSubtree];
    [self testRotateLeftComplex];
}

- (void)testRotateLeftSubtree {
    AVLTree *tree = [self exampleRotateLeftSimple];
    TreeNode *fourth = [[TreeNode alloc]initWithValue:30];
    [tree addNode:fourth];
    NSLog(@"Tree before rotation of left subtree: %@" , tree);
    [tree rotateLeft:tree.root.rightChild];
    NSLog(@"Tree after rototion of left subtree: %@" , tree);
}

- (void)testRotateLeftSimple {
    AVLTree *tree = [self exampleRotateLeftSimple];
    NSLog(@"tree before rotation: %@" , tree);
    [tree rotateLeft:tree.root];
    NSLog(@"tree after left rotation: %@" , tree);
}

- (void)testRotateLeftComplex {
    AVLTree *tree = [self exampleRotateLeftComplex];
    NSLog(@"tree before rotation: %@" , tree);
    [tree rotateLeft:tree.root];
    NSLog(@"tree after left rotation: %@" , tree);
    
    

}

- (void)testAllRightRotations {
    [self testRotateRightSimple];
    [self testRotateRightSubtree];
    [self testRotateRightComplex];
}

- (void)testRotateRightSimple {
    AVLTree *rotateRightTestCase = [self exampleRotateRightSimple];
    NSLog(@"Current Tree: %@" , rotateRightTestCase);
    [rotateRightTestCase rotateRight:rotateRightTestCase.root];
    NSLog(@"Tree after right rotation: %@" , rotateRightTestCase);
}

- (void)testRotateRightComplex {
    AVLTree *tree = [self exampleRotateRightComplex];
    NSLog(@"Current tree: %@" , tree);
    [tree rotateRight:tree.root];
    NSLog(@"tree after right rotation: %@" , tree);
}

- (void)testRotateRightSubtree {
    AVLTree *tree = [self exampleRotateRightComplex];
    NSLog(@"Current tree: %@" , tree);
    [tree rotateRight:tree.root.leftChild];
    NSLog(@"tree after right rotation: %@" , tree);
}

#pragma mark - examples of AVL trees

- (AVLTree *)skewedRightTree {
    return [self exampleRotateRightSimple];
}

- (AVLTree *)skewedLeftTree {
    return [self exampleRotateLeftSimple];
}

@end

