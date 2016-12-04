//
//  ZJHealthRegisterHeaderCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/2.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJHealthRegisterHeaderCell : UITableViewCell


@property (strong, nonatomic)UILabel * firstLabel;
@property (strong, nonatomic)UILabel * secondLabel;
@property (strong, nonatomic)UILabel * thirdLabel;
@property (strong, nonatomic)UILabel * fourthLabel;
@property (strong, nonatomic)UILabel * fifthLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
