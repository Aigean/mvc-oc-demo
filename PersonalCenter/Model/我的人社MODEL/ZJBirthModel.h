//
//  ZJBirthModel.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBirthModel : NSObject
//aae044	参保单位名称
//amc026	生育类别
//amc020	生育日期
//akb021	生育所在医院名称
//bmc013	生育医疗费
//amc030	生育津贴
//bme008	产前检查费
//bmc014	一次性营养费

@property (copy, nonatomic) NSString *aae044;
@property (copy, nonatomic) NSString *amc026;
@property (copy, nonatomic) NSString *amc020;
@property (copy, nonatomic) NSString *akb021;
@property (copy, nonatomic) NSString *bmc013;
@property (copy, nonatomic) NSString *amc030;
@property (copy, nonatomic) NSString *bme008;
@property (copy, nonatomic) NSString *bmc014;


@end
