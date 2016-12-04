//
//  ZJHandleTableViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/24.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBussinessModel.h"

@interface ZJHandleTableViewCell : UITableViewCell
// 事件编号
@property (weak, nonatomic) IBOutlet UILabel *serviceNumber;
// 办理状态
@property (weak, nonatomic) IBOutlet UILabel *status;
// 事项名称
@property (weak, nonatomic) IBOutlet UILabel *menuName;
// 最后处理时间
@property (weak, nonatomic) IBOutlet UILabel *lastTime;
// 顶部线条
@property (weak, nonatomic) IBOutlet UIView *lineView;
// 右击提示图片
@property (weak, nonatomic) IBOutlet UIImageView *accessory;

@property (strong, nonatomic) ZJBussinessModel *model;


@property (strong, nonatomic) NSString *navTitle;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
