//
//  ZJEndowmentModel.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJEndowmentModel : NSObject

//aae140	养老保险类型
//aac063	待遇享受类型
//aae044	退休时所在单位或街道村组
//bac180	退休时间或待遇享受开始年月
//aae019	享受定期待遇金额
@property (copy, nonatomic) NSString *aae140;
@property (copy, nonatomic) NSString *aac063;
@property (copy, nonatomic) NSString *aae044;
@property (copy, nonatomic) NSString *bac180;
@property (copy, nonatomic) NSString *aae019;

@end
