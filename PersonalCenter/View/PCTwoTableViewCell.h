//
//  PCTwoTableViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/8/22.
//  Copyright © 2016年 Aigean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCTwoTableViewCell : UITableViewCell
@property (nonatomic, copy)NSMutableArray *itemDataArr;
@property (weak, nonatomic) UIViewController * pc2Controller;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
