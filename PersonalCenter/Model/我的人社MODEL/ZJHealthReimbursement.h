//
//  ZJHealthReimbursement.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHealthReimbursement : NSObject
//akb021	医院名称
//ake058	实付日期
//bkc106	二次报销类型
//bae039	基金支付总额
@property (copy, nonatomic) NSString *akb021;
@property (copy, nonatomic) NSString *ake058;
@property (copy, nonatomic) NSString *bkc106;
@property (copy, nonatomic) NSString *bae039;

@end
