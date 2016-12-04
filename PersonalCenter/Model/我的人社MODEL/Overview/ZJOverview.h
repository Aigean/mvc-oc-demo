//
//  ZJOverview.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJCard.h"
#import "ZJHealth.h"
#import "ZJEndowment.h"
#import "ZJIndustrial.h"
#import "ZJRedundancy.h"
#import "ZJBirth.h"

@interface ZJOverview : NSObject
@property (strong, nonatomic) ZJCard *card;
@property (strong, nonatomic) ZJHealth *health;
@property (strong, nonatomic) ZJBirth *birth;
@property (strong, nonatomic) ZJEndowment *endowment;
@property (strong, nonatomic) ZJIndustrial *industrial;
@property (strong, nonatomic) ZJRedundancy *redundancy;
@end
