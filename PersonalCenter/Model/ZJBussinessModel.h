//
//  ZJBussinessModel.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/9/29.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBussinessModel : NSObject
/** 总页数 */
@property (copy, nonatomic) NSNumber *totalPage;
/** 总条数 */
@property (copy, nonatomic) NSNumber *totalCount;
/** 每条页数 */
@property (copy, nonatomic) NSNumber *pageSize;
/** 当前页数 */
@property (copy, nonatomic) NSNumber *pageNum;


/** 办件编号 */
@property (copy, nonatomic) NSString *businessId;
/** 事项名称 */
@property (copy, nonatomic) NSString *menuName;
/** 是否办结 */
@property (copy, nonatomic) NSNumber *finishFlag;
/** 是否已评价 */
@property (copy, nonatomic) NSNumber *evaluateFlag;
/** 办理时间 */
@property (copy, nonatomic) NSString *handleTime;
/** 办理状态 */
@property (copy, nonatomic) NSString *statusName;
/** 最后处理时间 */
@property (copy, nonatomic) NSString *lastTime;
@end
