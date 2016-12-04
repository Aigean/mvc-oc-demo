//
//  ZJDetailTableViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/12.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJDetailTableViewCell : UITableViewCell
@property (strong, nonatomic)UILabel * firstLabel;
@property (strong, nonatomic)UILabel * secondLabel;
@property (strong, nonatomic)UILabel * thirdLabel;
@property (strong, nonatomic)UILabel * fourthLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
