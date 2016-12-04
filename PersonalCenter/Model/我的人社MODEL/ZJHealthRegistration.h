//
//  ZJHealthRegistration.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHealthRegistration : NSObject
//aka083	登记类型
//akb021	登记医院
//aae030	起始日期
//aae031	结束日期
//aae100	有效标志
@property (copy, nonatomic)NSString *aka083;
@property (copy, nonatomic)NSString *akb021;
@property (copy, nonatomic)NSString *aae030;
@property (copy, nonatomic)NSString *aae031;
@property (copy, nonatomic)NSString *aae100;

@end
