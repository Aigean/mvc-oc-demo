//
//  ZJBasicInfo.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBasicInfo : NSObject
//aac004	性别
//aac006	出生日期
//aac163	国籍
//aac005	民族
//aae005	电话
//aae006	家庭住址

@property (copy, nonatomic) NSString *aac004;
@property (copy, nonatomic) NSString *aac006;
@property (copy, nonatomic) NSString *aac163;
@property (copy, nonatomic) NSString *aac005;
@property (copy, nonatomic) NSString *aae005;
@property (copy, nonatomic) NSString *aae006;


@end
