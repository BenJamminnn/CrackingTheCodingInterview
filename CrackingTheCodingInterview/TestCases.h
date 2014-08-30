//
//  TestCases.h
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/22/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVLTree;

@interface TestCases : NSObject
//basic operations
- (void)addingNodesBinaryTree;
- (void)addingNodesAVL;
- (void)removingNodesAVLTree;
- (void)testRemovingNodes;
- (void)testRemovingNodesTwoChildren;

//search algos
- (void)testDFS;
- (void)testBFS;

//traversals
- (void)testPreOrderTraversal;
- (void)testPostOrderTraversal;
- (void)testLevelOrderTraversal;
- (void)testInOrderTraversal;

//AVL Tree tests
- (void)testRotateRightSimple;
- (void)testRotateRightSubtree;
- (void)testRotateRightComplex;
- (void)testAllRightRotations;

- (void)testAllLeftRotations;
- (void)testRotateLeftSimple;
- (void)testRotateLeftSubtree;
- (void)testRotateLeftComplex;

//AVL tree examples
- (AVLTree *)skewedRightTree;
- (AVLTree *)skewedLeftTree;

@end
