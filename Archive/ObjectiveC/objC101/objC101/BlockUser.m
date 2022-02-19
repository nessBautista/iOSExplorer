//
//  BlockUser.m
//  objC101
//
//  Created by Ness Bautista on 29/05/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

#import "BlockUser.h"

@implementation BlockUser
+ (BOOL) useBlock: (BOOL (^)(NSString *)) block{
    NSLog(@"From BlockUser");
    block(@"THe parameter");
    return YES;
}
@end
