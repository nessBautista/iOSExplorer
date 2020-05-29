//
//  main.m
//  objC101
//
//  Created by Ness Bautista on 28/05/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockUser.h"

void doSomethingWithTheBlock(void (^theBlock)(NSString *)){
    theBlock(@"Hello from block");
}

void doit(void (^theBlock)(NSString *)){
    theBlock(@"do it");
}

void useBlockReturningArray(NSMutableArray * (^theBlock)(NSString *)){
    NSMutableArray *a = theBlock(@"Element for array");
    NSLog(@"%lu",(unsigned long)a.count);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        void (^myBlock)(NSString *);
        myBlock=^(NSString *x){
            NSLog(@"%@",x);
        };
        doSomethingWithTheBlock(myBlock);
        
        //block declarations
        //IN line declaration
        void (^inlineBlock)(NSString *) = ^(NSString *x){NSLog(@"%@",x);};
        
        //a block with no paramaters
        void (^otherBlock) (void) = ^{
            NSLog(@"This blogs doesn't receive parameters");
        };
        
        //A block that is being passed directly to a function
        doit(^(NSString *x) {
            NSLog(@"Live definition. %@", x);
        });
        
        //Block with a return value: MutableArray
        NSMutableArray *(^blockName)(NSString *) = ^(NSString *x){
            NSLog(@"Using parameter string: %@", x);
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects: &x count:1];
            return array;
        };
        useBlockReturningArray(blockName);
        
        //Using a block with an objective C method
        [BlockUser useBlock:^BOOL(NSString *x) {
            NSLog(@"From main.....%@",x);
            return YES;
        }];
    }
    return 0;
}
