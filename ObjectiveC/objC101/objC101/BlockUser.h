//
//  BlockUser.h
//  objC101
//
//  Created by Ness Bautista on 29/05/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockUser : NSObject
+ (BOOL) useBlock: (BOOL (^)(NSString *)) block;
@end

NS_ASSUME_NONNULL_END
