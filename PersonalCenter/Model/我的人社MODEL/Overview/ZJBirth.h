//
//  ZJBirth.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBirth : NSObject

//aae002	最近一次发放时间
//bmc019	最近一次发放金额


/**
 最近一次发放时间
 */
@property (copy, nonatomic) NSString *aae002;

/**
 最近一次发放金额
 */
@property (copy, nonatomic) NSString *bmc019;
@end
