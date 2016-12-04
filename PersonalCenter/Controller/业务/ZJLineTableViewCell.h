//
//  ZJLineTableViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/9.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHistoryModel.h"

@interface ZJLineTableViewCell : UITableViewCell

@property (strong, nonatomic) ZJHistoryModel *model;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
