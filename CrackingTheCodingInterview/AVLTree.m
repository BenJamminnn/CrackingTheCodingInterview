//
//  AVLTree.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/23/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import "AVLTree.h"
#import "TreeNode.h"

@implementation AVLTree

#pragma mark - Basic operation Override

- (void)addNode:(TreeNode *)node {
    [super addNode:node];
    [self rebalance];
}

- (void)deleteNodeByValue:(int)value {
    [super deleteNodeByValue:value];
    [self rebalance];
    NSLog(@"%@" , self);
}


#pragma mark - convenience methods

- (BOOL)isSkewedLeft {
    return ![self isSkewedRight];
}

- (BOOL)isSkewedRight {
    return self.root.leftChild.height < self.root.rightChild.height;
}

- (BOOL)isTreeBalanced {
    return [self isSubtreeBalanced:self.root];
}

- (BOOL)isSubtreeBalanced:(TreeNode *)node {
    if(self.height <= 2) {
        return YES;
    }
    //quick and dirty method, does not account for two leaves on opposite sides of the tree.
    int leftHeight = node.leftChild.height;
    int rightHeight = node.rightChild.height;
    return !(abs(leftHeight - rightHeight) > 1);
}



- (TreeNode *)findUnbalancingNode {
    TreeNode *greaterSide = self.root;
    while (greaterSide) {
        TreeNode *parent = greaterSide;
        greaterSide = (greaterSide.leftChild.height > greaterSide.rightChild.height) ? greaterSide.leftChild : greaterSide.rightChild;
        greaterSide.parent = parent;
        if(greaterSide.isLeaf) {
            break;
        }
    }
    return greaterSide.parent.parent;
}

#pragma mark - rotations and balancing
/*
 when the tree is not balanced, we first figure out which subtree has the greater height.
 This allows us to traverse the tree in the correct direction and rotate as needed;
 Balancing done at insert and deletion. Rotation only requires the rotation of the root
*/

- (void)rebalance {

    if([self isTreeBalanced]) {
        return;
    } else {
        if([self isSkewedLeft]) {
            [self rotateRight:self.root];
        } else {
            [self rotateLeft:self.root];
        }
    }
    [self rebalance];
}

- (void)rotateLeft:(TreeNode *)nodeA {
    TreeNode *nodeB = nodeA.rightChild; //ref to nodeB
    TreeNode *nodeBOldLeft = nodeB.leftChild;
    
    if([nodeA isEqual:self.root]) {
        self.root = nodeB;
        self.root.leftChild = nodeA;
        self.root.leftChild.parent = nodeB;
        self.root.leftChild.rightChild = nodeBOldLeft;
    } else {
        TreeNode *tempLeft = nodeB.leftChild;

        TreeNode *tempRoot = nodeA.parent;
        tempRoot.rightChild = nodeB;
        nodeB.leftChild = nodeA;
        tempRoot.rightChild = nodeB;
        nodeA = nodeB;
        nodeB.leftChild.rightChild = nil;
        [self addNode:tempLeft];

    }
}

- (void)rotateRight:(TreeNode *)nodeA {  //node passed in here will be the top of the subtree to be rotated
    TreeNode *nodeB = nodeA.leftChild; //ref to nodeB
    TreeNode *nodeBOldLeft = nodeB.rightChild;
    
    if([nodeA isEqual:self.root]) {
        self.root = nodeB;
        self.root.rightChild = nodeA;
        self.root.rightChild.parent = nodeB;
        self.root.rightChild.leftChild = nodeBOldLeft;
    } else {
        TreeNode *tempRight = nodeB.rightChild;
        TreeNode *tempRoot = nodeA.parent;
        
        tempRoot.rightChild = nodeB;
        nodeB.rightChild = nodeA;
        nodeB.rightChild.leftChild = nil;
        [self addNode:tempRight];
        
        if([self isSkewedLeft]) {
            [self rotateRight:self.root];
        }
        
        if([self isSkewedRight]) {
            [self rotateLeft:self.root];
        }
    }
}


@end
