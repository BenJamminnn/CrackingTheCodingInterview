//
//  AVLTree.h
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/23/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import "BinaryTree.h"

@interface AVLTree : BinaryTree

#warning exposed only for testing
- (void)rotateLeft:(TreeNode *)nodeA;
- (void)rotateRight:(TreeNode *)nodeA;
@end
