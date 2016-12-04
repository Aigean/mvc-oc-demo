//
//  ZJHealthVisit.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHealthVisit : NSObject
//akb021	医院名称
//akc194	结算时间
//aka078	就诊类别
//akc264	总消费金额

@property (copy, nonatomic) NSString *akb021;
@property (copy, nonatomic) NSString *akc194;
@property (copy, nonatomic) NSString *aka078;
@property (copy, nonatomic) NSString *akc264;

@end
