//
//  ZJCard.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJCard : NSObject

//aac003	姓名
//aae135	社会保障号码
//baz805	人员识别号
//bac200	照片

/** 姓名 */
@property (copy, nonatomic) NSString *aac003;
/** 社会保障号码 */
@property (copy, nonatomic) NSString *aae135;
/** 人员识别号 */
@property (copy, nonatomic) NSString *baz805;
/** 照片 */
@property (copy, nonatomic) NSString *bac200;
@end
