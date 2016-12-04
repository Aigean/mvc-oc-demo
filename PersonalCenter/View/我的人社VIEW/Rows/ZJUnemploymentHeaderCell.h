//
//  ZJUnemploymentHeaderCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/3.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJUnemploymentHeaderCell : UITableViewCell

@property (strong, nonatomic)UILabel * firstLabel;
@property (strong, nonatomic)UILabel * secondLabel;
@property (strong, nonatomic)UILabel * thirdLabel;
@property (strong, nonatomic)UILabel * fourthLabel;
@property (strong, nonatomic)UILabel * fifthLabel;
@property (strong, nonatomic)UILabel * sixthLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
