//
//  ZJMessageModel.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/4.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJMessageModel : NSObject

//businessId:147079226100002,
//contentId:0,
//messageId:147079226100021,
//messageLevel:1,
//title:公务员招考,
//description:<null>,
//lastTime:20161009 180514,
//messageType:1,
//statusId:0
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *statusId;
@property (copy, nonatomic) NSString *lastTime;
@property (copy, nonatomic) NSString *messageId;
//@property (copy, nonatomic) NSString *description;

@end
