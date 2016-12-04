//
//  ZJBIThreeViewCell.m
//  ZhenjiangRenshe
//
//  Created by 周毅 on 2016/11/1.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "ZJBIThreeViewCell.h"

@implementation ZJBIThreeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NSDictionary *)dic{
    self.iconImage.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    self.titleLabel.text = [dic objectForKey:@"title"];
    //    self.account.text = [dic objectForKey:@"account"];
    //    self.time.text = [dic objectForKey:@"time"];
}

@end
