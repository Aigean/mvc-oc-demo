//
//  ZJInsuranceTableViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJInsurance.h"
@interface ZJInsuranceTableViewCell : UITableViewCell

@property (strong, nonatomic)UILabel * firstLabel;
@property (strong, nonatomic)UILabel * secondLabel;
@property (strong, nonatomic)UILabel * thirdLabel;

@property (strong, nonatomic)ZJInsurance * model;
//@property (strong, nonatomic)UILabel * fourthLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
