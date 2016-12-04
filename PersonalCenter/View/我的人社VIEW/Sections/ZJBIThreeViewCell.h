//
//  ZJBIThreeViewCell.h
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBIThreeViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountOne;

@property (weak, nonatomic) IBOutlet UILabel *accountTwo;



- (void)setCellData:(NSDictionary *)dic;

@end
