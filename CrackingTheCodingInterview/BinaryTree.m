//
//  BinaryTree.m
//  CrackingTheCodingInterview
//
//  Created by Mac Admin on 8/21/14.
//  Copyright (c) 2014 Ben Gabay. All rights reserved.
//

#import "BinaryTree.h"
#import "TreeNode.h"
#import "Queue.h"
#import "Stack.h"

@interface BinaryTree()
@property (nonatomic, readwrite) NSUInteger numOfNodes;
@end
@implementation BinaryTree

#pragma mark - common operations

- (NSUInteger)numberOfNodes {
    TreeNode *focusNode;
    if(self.root) {
        focusNode = self.root;
    } else {
        NSLog(@"root is nil");
        return 0;
    }
    NSUInteger numOfNodes = 1;
    focusNode.parent = nil;
    Queue *queue = [Queue new];
    [queue enqueue:focusNode];
    while (!queue.isEmpty) {
        TreeNode *nodeTemp = [queue dequeue];
        if(nodeTemp.leftChild) {
            [queue enqueue:nodeTemp.leftChild];
            focusNode = nodeTemp.leftChild;
            focusNode.parent = nodeTemp;
            numOfNodes++;
        }
        
        if(nodeTemp.rightChild) {
            [queue enqueue:nodeTemp.rightChild];
            focusNode = focusNode.rightChild;
            focusNode.parent = nodeTemp;
            numOfNodes++;
        }

    }
    return numOfNodes;
}

- (void)addNode:(TreeNode *)node {
    if(!self.root) {
        self.root = node;
    } else {
        TreeNode *focusNode = self.root;    //we start traversing the tree at the root.
        TreeNode *parent;                   //future parent for the new node
        
        while (YES) {
            parent = focusNode;             //holding a ref to the parent after we set a new val for the focusNode
            
            if(node.value == focusNode.value) { //duplicate value detected. Dont add node.
                NSLog(@"duplicate node detected. node not added");
                return;
            }
            if(node.value < focusNode.value) {      //switch focus to left child
                focusNode = focusNode.leftChild;
                focusNode.parent = parent;
                if(!focusNode) {            //there is no left child of the focusNode, we create one.
                    parent.leftChild = node;
                    node.parent = parent;
                    return;
                }
            } else {                        //same for the right side
                focusNode = focusNode.rightChild;
                focusNode.parent = parent;

                if(!focusNode) {
                    parent.rightChild = node;
                    node.parent = parent;
                    return;
                }
            }
        }
    }
}

- (BOOL)doesContain:(TreeNode *)node {
    
    if(!self.root) return NO;
    
    TreeNode *focusNode = self.root;
    int count = 0;
    while (focusNode.value != node.value && count < self.height) {
        if(node.value < focusNode.value) {
            focusNode = focusNode.leftChild;
        } else {
            focusNode = focusNode.rightChild;
        }
        count++;
    }
    
    return focusNode ? YES : NO;
}

- (TreeNode *)findNodeByValue:(int)value {
    if(!self.root) return nil;
    
    TreeNode *focusNode = self.root;
    int count = 0;
    while (focusNode.value != value && count < self.height) {
        TreeNode *tempParent = focusNode;

        if(value < focusNode.value) {
            focusNode = focusNode.leftChild;
            focusNode.parent = tempParent;

        } else {
            focusNode = focusNode.rightChild;
            focusNode.parent = tempParent;

        }
        count++;
    }
    
    return focusNode;
}

- (void)removeSubtree:(TreeNode *)node {
    if(!self.root) {
        return;
    }
    TreeNode *focusNode = self.root;
    while (focusNode != node) {
        if(node.value < focusNode.value) {
            focusNode = focusNode.leftChild;
        } else {
            focusNode = focusNode.rightChild;
        }
    }
    focusNode = nil;
}

- (void)removeLeaf:(TreeNode *)node {
    if(node.isLeftChild) {
        node.parent.leftChild = nil;
    } else {
        node.parent.rightChild = nil;
    }
    return;
}

- (void)deleteNodeByValue:(int)value {
    if(!self.root) return;
    
    TreeNode *foundNode = [self findNodeByValue:value];
    if(!foundNode) {
        NSLog(@"unable to find node for deletion");
        return;
    }
    
    if(!foundNode.parent && ![foundNode isEqual:self.root]) {
        NSLog(@"this node is not in the binary tree");
        return;
    }

    //simplest case: the node has no children
    if(foundNode.isLeaf) {
        [self removeLeaf:foundNode];
        return;
    }
    
//node to be removed has 1 child. we remove the chain between parent and child, replace it with foundNode's parent
    if(foundNode.hasOneChild) {
        TreeNode *foundNodeChild;
        if(foundNode.rightChild) {
            foundNodeChild = foundNode.rightChild;
        } else {
            foundNodeChild = foundNode.leftChild;
        }
        [self removeLeaf:foundNode];
        [self addNode:foundNodeChild];
        return;
    }
    
    //most complex, deleting node with 2 children, requires rotation of the tree
    if(foundNode.rightChild.isLeaf) {    //if the right child is a leaf, we replace it with the node to be deleted
        TreeNode *foundNodeChild = foundNode.rightChild;
        TreeNode *foundNodeChildSibling = foundNode.leftChild;
        [self removeLeaf:foundNode];
        [self addNode:foundNodeChild];
        [self addNode:foundNodeChildSibling];
        NSLog(@"%@" , self);
        return;
    }
    
   
    //we will replace the found node with the greatest node in its' left subtree
    
    TreeNode *replacementNode = [self findNodeByValue:[[self findGreatestNodeWithinNode:foundNode.leftChild]value]];
    int val = replacementNode.value;
    [self removeLeaf:replacementNode];
    foundNode.value = val;

    
    return;
}

- (void)addNodes:(NSArray *)nodes {
    if([nodes count] < 1) {
        return;
    }
    if([nodes[0] isKindOfClass:[TreeNode class]]) {
        for(TreeNode *node in nodes)  {
            [self addNode:node];
        }
    }
}

//TODO
- (void)replaceNode:(TreeNode *)nodeA withNode:(TreeNode *)nodeB {
    if([self doesContain:nodeA]) {
        if(nodeB.value < nodeA.rightChild.value && nodeB.value > nodeA.leftChild.value) {
            NSLog(@"%@" , self);
    
            nodeB.children = nodeA.children;
            nodeA = nodeB;
            NSLog(@"%@" , self);

            for(TreeNode *node in nodeB.children) {
                [self addNode:node];
            }
            NSLog(@"%@" , self);
        }
    }
}

#pragma mark - common traversals

- (void)levelOrderTraversal:(TreeNode *)node {
    if(self.root) {
        Queue *queue = [Queue new];
        [queue enqueue:self.root];
        while (!queue.isEmpty) {
            TreeNode *node = [queue dequeue];
            if(node.leftChild) {
                [queue enqueue:node.leftChild];
            }
            if(node.rightChild) {
                [queue enqueue:node.rightChild];
            }
            
            NSLog(@"%@", node);
        }
    }
}

- (void)postOrderTraversal:(TreeNode *)node {
    if(node) {
        [self postOrderTraversal:node.leftChild];
        [self postOrderTraversal:node.rightChild];
        
        NSLog(@"%@" , node);
    }
}

- (void)preOrderTraversal:(TreeNode *)node {
    if(node) {
        NSLog(@"%@" , node);
        [self preOrderTraversal:node.leftChild];
        [self preOrderTraversal:node.rightChild];
    }
}


- (void)inOrderTraversal:(TreeNode *)node {
    if(node) {
        [self inOrderTraversal:node.leftChild];
        NSLog(@"%@" , node);
        [self inOrderTraversal:node.rightChild];
    }
}

#pragma mark - convenience methods

- (TreeNode *)findGreatestNodeWithinNode:(TreeNode *)node {
    TreeNode *focusNode = node;
    
    while (focusNode.rightChild) {
        focusNode = focusNode.rightChild;
    }
    return focusNode;
}

- (TreeNode *)findLeastNodeWithinNode:(TreeNode *)node {
    TreeNode *focusNode = node;
    while (focusNode.leftChild) {
        focusNode = focusNode.leftChild;
    }
    return focusNode;
}
#pragma mark - DFS and BFS
- (void)depthFirstSearch:(TreeNode *)node {
    TreeNode *focusNode;
    if(self.root) {
        focusNode = self.root;
    } else {
        NSLog(@"root is nil");
        return;
    }
    
    focusNode.parent = nil;
    Stack *stackerooni = [Stack new];
    [stackerooni push:focusNode];
    while (![stackerooni isEmpty]) {
        TreeNode *nodeTemp = [stackerooni pop];
        if(nodeTemp.leftChild) {
            focusNode = nodeTemp.leftChild;
            focusNode.parent = nodeTemp;
            [stackerooni push:focusNode];
        }
        
        if(nodeTemp.rightChild) {
            focusNode = nodeTemp.rightChild;
            focusNode.parent = nodeTemp;
            [stackerooni push:focusNode];
        }
        
        if([nodeTemp isEqual:node]) {
            NSLog(@"node found! %@" , node);
            NSLog(@"node's parent: %@" , node.parent);
            return;
        }
    }
    NSLog(@"node not found");
}

- (void)breadthFirstSearch:(TreeNode *)node {
    TreeNode *focusNode;
    if(self.root) {
        focusNode = self.root;
    } else {
        NSLog(@"root is nil");
        return;
    }
    
    focusNode.parent = nil;
    Queue *queue = [Queue new];
    [queue enqueue:focusNode];
    while (!queue.isEmpty) {
        TreeNode *nodeTemp = [queue dequeue];
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
        
        if([nodeTemp isEqual:node]) {
            NSLog(@"node found! %@" , node);
            return;
        }
    }
    NSLog(@"node not found");
}




- (NSString *)valueLayerWithNumberOfValues:(int)num {
    NSString *description = @"";
    NSArray *arr = @[(self.root ? self.root : @"-"),
                     (self.root.leftChild ? self.root.leftChild : @"-"),
                     (self.root.rightChild ? self.root.rightChild : @"-"),
                     (self.root.leftChild.leftChild ? self.root.leftChild.leftChild: @"-"),
                     (self.root.leftChild.rightChild ? self.root.leftChild.rightChild : @"-"),
                     (self.root.rightChild.leftChild ? self.root.rightChild.leftChild : @"-"),
                     (self.root.rightChild.rightChild ? self.root.rightChild.rightChild : @"-"),
                     (self.root.leftChild.leftChild.leftChild ? self.root.leftChild.leftChild.leftChild : @"-"),
                     (self.root.leftChild.leftChild.rightChild ? self.root.leftChild.leftChild.rightChild : @"-"),
                     (self.root.leftChild.rightChild.leftChild ? self.root.leftChild.rightChild.leftChild : @"-"),
                     (self.root.leftChild.rightChild.rightChild ? self.root.leftChild.rightChild.rightChild : @"-"),
                     (self.root.rightChild.leftChild.leftChild ? self.root.rightChild.leftChild.leftChild : @"-"),
                     (self.root.rightChild.leftChild.rightChild ? self.root.rightChild.leftChild.rightChild : @"-"),
                     (self.root.rightChild.rightChild.leftChild ? self.root.rightChild.rightChild.leftChild : @"-"),
                     (self.root.rightChild.rightChild.rightChild ? self.root.rightChild.rightChild.rightChild : @"-")];
    
    

    switch (num) {
        case 0:
            description = [NSString stringWithFormat:@"                         %@                       ", arr[0]];
            break;
        case 1:
            description = [NSString stringWithFormat:@"               %@                    %@                " ,  arr[1] , arr[2]];
            break;
        case 2:
            description = [NSString stringWithFormat:@"          %@        %@            %@          %@           " , arr[3], arr[4] , arr[5] , arr[6]];
            break;
        case 3:
            description = [NSString stringWithFormat:@"      %@      %@  %@   %@       %@     %@      %@    %@" , arr[7] , arr[8] , arr[9] , arr[10] , arr[11] , arr[12], arr[13] , arr[14]];
            break;
        default:
            
            break;
    }
    return description;
}

- (NSArray *)middleLayers {
    return @[[NSString stringWithFormat:@"                  /              \\                  "],
             [NSString stringWithFormat:@"           /        \\            /         \\         "],
             [NSString stringWithFormat:@"        /   \\    /   \\       /    \\       /  \\        "]
             ];
}

- (NSString *)description {
    
    NSArray *mid = [self middleLayers];
    
    NSMutableArray *arr = [NSMutableArray new];
    for(int i = 0; i < 4; i++) {
        [arr addObject:[self valueLayerWithNumberOfValues:i]];
        if(i < 3) {
            [arr addObject:mid[i]];

        }
        
    }
    NSString *description = @"";
    for(int i = 0; i < arr.count; i++) {
        NSLog(@"%@" , arr[i]);
    }
    return description;
}

- (int)height {
    if(self.root) {
        return self.root.height;
    }
    return 0;
}

@end
