//
//  ZJAuthenticationCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 16/9/6.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJAuthenticationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *authLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
