//
//  Course.h
//  BasicTable
//
//  Created by Ness Bautista on 29/05/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *numberOfLessons;
@end

NS_ASSUME_NONNULL_END
