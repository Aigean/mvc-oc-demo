//
//  ZJUserInfoModel.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/9/22.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJUserInfoModel : NSObject
/** 用户编号 */
@property (copy, nonatomic) NSString *userId;
/** 姓名 */
@property (copy, nonatomic) NSString *name;
/** 社会保障号 */
@property (copy, nonatomic) NSString *idCard;
/** 省人员识别号 */
@property (copy, nonatomic) NSString *personId;
/** 手机号 */
@property (copy, nonatomic) NSString *phone;
/** 手机认证标识，0是未认证，1是已认证 */
@property (copy, nonatomic) NSString *phoneFlag;
/** 邮箱 */
@property (copy, nonatomic) NSString *mail;
/** 邮箱认证标识，0是未认证，1是已认证 */
@property (copy, nonatomic) NSString *mailFlag;
/** 实名认证标识，0是未认证，1是已认证 */
@property (copy, nonatomic) NSString *identityFlag;
/** 护照 */
@property (copy, nonatomic) NSString *passport;
/** 照片 */
@property (copy, nonatomic) NSString *photo;
/** 照片类型 */
@property (copy, nonatomic) NSString *photoType;
/** 地址 */
@property (copy, nonatomic) NSString *address;

@end
