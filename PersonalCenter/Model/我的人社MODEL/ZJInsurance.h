//
//  ZJInsurance.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJInsurance : NSObject
//aae140	险种名称
//aaa042	单位缴费比例
//aaa041	个人缴费比例

@property (copy, nonatomic) NSString *aae140;
@property (copy, nonatomic) NSString *aaa042;
@property (copy, nonatomic) NSString *aaa041;
@end
