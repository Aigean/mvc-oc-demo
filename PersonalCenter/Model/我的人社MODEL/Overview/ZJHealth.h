//
//  ZJHealth.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHealth : NSObject
//@"bac013":@"971.16",
//@"bac014":@"0"

/**
 bac013	一级账户余额
 */
@property (copy, nonatomic) NSString *bac013;
/**
 bac014	二级账户余额
 */
@property (copy, nonatomic) NSString *bac014;
@end
