//
//  ZJIndustrialModel.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJIndustrialModel : NSObject
//    ext001	定期伤残津贴
//    ext002	定期护理费
//    aae044	最近一次发生工伤所在单位
//    ext003	最近一次医疗报销费金额
//    ext004	最近一次领取伤残补助金金额

@property (copy, nonatomic) NSString *ext001;
@property (copy, nonatomic) NSString *ext002;
@property (copy, nonatomic) NSString *aae044;
@property (copy, nonatomic) NSString *ext003;
@property (copy, nonatomic) NSString *ext004;

@end
