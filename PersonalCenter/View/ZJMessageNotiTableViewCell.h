//
//  ZJMessageNotiTableViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/10/12.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMessageModel.h"
@interface ZJMessageNotiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (strong, nonatomic) ZJMessageModel *messageModel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
